---
layout: post
title:  "How does Android dispatch Touchevent?"
date:   2014-10-02 22:17:21 +0800
categories: Android Touch
tags: Android Touch
published: true
toc: true
sidebar: true
about: true
author: david.dong
description: This article discussed the concept of the touch event is dispatched in the Android framework.
keywords: touch event, dispatch
---
Recently, I've been busy with my work and haven't been able to update the blog for a long time. This time, I am going to start a discussion and summarize how Android dispatch Touchevent after received them from the touch screen device.

You may know there are some ways in the android system that can capture `Touch Event`. 

For example, register a component's `setOnTouchListener()` and implements the `onTouchListener` interface by override the `onTouch()` method. 
Else you can change it to `setOnClickListener()` and implements the `onClickListener` interface. Also, you can even override the view's `onTouchEvent()` method directly to capture the Touch Event. 
But have you ever thought about what the difference is among these methods? How does android handle these methods sequentially?

Let's start with some pieces of code. 

{% highlight java %}
public class MainActivity extends AppCompatActivity {

    Button btn;
    String str ="";
    int cnt =0;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        btn = this.findViewById(R.id.button01);

        btn.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View view, MotionEvent motionEvent) {
                cnt++;
                str+= "_onTouch()";
                switch(motionEvent.getAction())
                {
                    case MotionEvent.ACTION_DOWN:
                        str += "_down";
                        break;
                    case MotionEvent.ACTION_UP:
                        str += "_up";
                        break;
                    default:
                        str += "_others";
                        break;
                }
                Log.v("check",str + "_count:" + cnt);
                return false;
            }
        });

        btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                cnt++;
                str+= "_onClick()";
                Log.v("check",str + "_count:" + cnt);
            }
        });
    }
}
{% endhighlight %}
These pieces of code put a button on the activity and register two listeners to capture the Touchevent of the button, that is the click.<br>
Let's see what the result is when the button is clicked. 

{% highlight java %}
_onTouch()_down_count:1
_onTouch()_down_onTouch()_up_count:2
_onTouch()_down_onTouch()_up_onClick()_count:3
{% endhighlight %}
We can see when the button is clicked, the `OnTouchListener()` is triggered twice (for dwon and up) firstly and then the `onClickListener()` is called. <br>
If we change the return value to "true" and re-run this pieces of code. 
{% highlight java %}
btn.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View view, MotionEvent motionEvent) {
                cnt++;
                str+= "_onTouch()";
                switch(motionEvent.getAction())
                {
                    case MotionEvent.ACTION_DOWN:
                        str += "_down";
                        break;
                    case MotionEvent.ACTION_UP:
                        str += "_up";
                        break;
                    default:
                        str += "_others";
                        break;
                }
                Log.v("check",str + "_count:" + cnt);
                return true;
            }
        });
{% endhighlight %}
We see the `onClickListener()` will not be called anymore. 

{% highlight java %}
_onTouch()_down_count:1
_onTouch()_down_onTouch()_up_count:2
{% endhighlight %}
The above code proves that the `OnTouchListener()` has high priority than `onClickListener()` and can block the latter to be executed. 

Next, let track into the Android source code to find the root cause. 

![framework]({{site.cdn_baseurl}}/assets/image/android-touchevent-despatch01.PNG){: .center-image }

As the above pictures showed, in android internal, there are two routes
+ one is from outside to inside, that is from activity - > ViewGroup - > view, call the `dispatchTouchEvent()` method from the outside to the inside, and Android will pass the motion event parameter to the method in turn. The function of `dispatchTouchEvent()` is to deliver touch events. The `dispatchTouchEvent()` is the entrance to deliver touch events every time.
+ another is from inside to outside, that is to call the `onTouchEvent()` method from view - > ViewGroup - > activity, and Android will pass the motion event parameter to the method in turn. The function of `onTouchEvent()` is to handle touch events.

Nex, Let's go into every component to check the details further.

## Activity

**dispatchTouchEvent()**
All touch events generated by touch operations on the UI will first trigger the execution of the `dispatchTouchEvent()` method in the activity.<br> 
The source code is as follows:

{% highlight java %}
public boolean dispatchTouchEvent()(MotionEvent ev) {
    if (ev.getAction() == MotionEvent.ACTION_DOWN) {
        onUserInteraction();
    }
    if (getWindow().superdispatchTouchEvent()(ev)) {
        return true;
    }
    return onTouchEvent()(ev);
}
{% endhighlight %}
Activity first obtains the current window object through the `getWindow ()` method, then calls the `superdispatchTouchEvent()` method of window. In fact, `getWindow()` returns an instance of PhoneWindow type, which will invoke PhoneWindow's `superdispatchTouchEvent()` method.

{% highlight java %}
@Override
public boolean superdispatchTouchEvent()(MotionEvent event) {
    return mDecor.superdispatchTouchEvent()(event);
}
{% endhighlight %}
mDecor is a variable of type decorview in phonewindow. Decorview represents the top-level view of the current window, which can be regarded as the root view. As can be seen from the above code, the `superdispatchTouchEvent()` method of decorview will be executed later.<br/> 
Its source code is as follows:
{% highlight java %}
public boolean superdispatchTouchEvent()(MotionEvent event) {
    return super.dispatchTouchEvent()(event);
}
{% endhighlight %}
In fact, `dectorview` inherits from FrameLayout, so it indirectly inherits from ViewGroup, so it will execute the `dispatchTouchEvent()` method corresponding to its parent class ViewGroup.

The above describes the transfer process of touch event from activity to ViewGroup with the help of `superdispatchTouchEvent()` and `dispatchTouchEvent()` methods. Both methods return a boolean type parameter. If true is returned, it means that the touch event is processed; otherwise, it means that the touch event is not processed. If we look at the source code of the `dispatchTouchEvent()` in the above activity, we will find that if the `superDispatchTouchEvent()` of PhoneWindow returns true, then the `dispatchTouchEvent()` method of activity directly returns true, indicating that the touch event has been processed by the window, so the later `onTouchEvent()` method of activity will not be executed. Only when the window does not handle the touch event, the activity will call the `onTouchEvent()` method to handle the event.

**onTouchEvent()**
The source code of `onTouchEvent()` is as follows
{% highlight java %}
public boolean onTouchEvent()(MotionEvent event) {
    if (mWindow.shouldCloseOnTouch(this, event)) {
        finish();
        return true;
    }
    return false;
}
{% endhighlight %}
Only when the touch event has not been processed by any view or ViewGroup can the activity execute its own `onTouchEvent()` to process the touch event.

## ViewGroup
[source code](https://github.com/aosp-mirror/platform_frameworks_base/blob/android-6.0.0_r23/core/java/android/view/ViewGroup.java#L2077)<br>
**dispatchTouchEvent()**<br>
When the activity receives the touch event, it will call the `dispatchTouchEvent()` method of ViewGroup through `dectorview`.<br>
The `dispatchTouchEvent()` method is the entry point for ViewGroup to process touch events.<br>

A member variable of TouchTarget type mFirstTouchTarget is defined in the ViewGroup, which is used to save the child views that handle touch events in the current ViewGroup.<br>
First of all, the `dispatchTouchEvent()` method will call its own `onIntercepTouchEvent()` method. `onIntercepTouchEvent()` is used to intercept the touch event passed by the ViewGroup to its child view. If the method returns true, it means that the ViewGroup should intercept the touch event; if it returns false, it means that the ViewGroup should not intercept the touch event, and it should pass the touch event to the child view. A boolean type handled variable is defined in the `dispatchTouchEvent()` method to save the return value of the `dispatchTouchEvent()` method. If true, the touch event is processed by the current ViewGroup. Otherwise, it is not processed.

Then, only when `onIntercepTouchEvent()` returns false, the ViewGroup will traverse its child views in turn. It will call `isTransformedTouchPointInView()` method to determine whether the coordinates of the touch event carried by motion event fall within the scope of the child view. If the coordinates of the touch event fall within the scope of the child view, it means that we touch the child view within the current ViewGroup In this way, the ViewGroup will pass the coordinates of the touch event and the subview to the `dispatchTransformedTouchEvent()` method. In this method, the dispatchTouchEvent() method of the subview will be called. Its return value indicates whether the touch event has been handled by the self-view. If the `dispatchTransformedTouchEvent()` returns true, it indicates that the subview has handled the touch event. In this way, the ViewGroup will call `addTouchTarget()` method binds mFirstTouchTarget to the child view, and the variable alreadyDispatchedToNewTouchTarget is also set to true, indicating that a child view has handled the touch event. Once a child view handles the touch event, the ViewGroup will break out of the for loop and no longer traverse other child views.
After the for loop of child view, if no child view handles touch events, mFirstTouchTarget is still null, and ViewGroup will pass null as the child parameter.

In the `dispatchTransformedTouchEvent()` method, the method will call the `super.dispatchTouchEvent()` method. Since ViewGroup inherits from view, this is equivalent to executing the `dispatchTouchEvent()` method in the view class, so it is likely to execute the `onTouchEvent()` method inherited from view by ViewGroup. The return value of `dispatchTransformedTouchEvent()` is used as the value of the local variable handled. The `dispatchTouchEvent()` method in the view class is described in detail below.
After the for loop of a subview, if a subview is found to handle touch events, then the already `dispatchedToNewTouchTarget()` is true, which will set the local variable handled to true, that is, as long as a subview handles touch events, it indicates that the current ViewGroup has also handled touch events, and in this case, the ViewGroup will not call v The `dispatchTouchEvent()` method inherited from the view does not trigger the execution of the `onTouchEvent()` method of the ViewGroup.
**onIntercepTouchEvent()**   
As mentioned earlier, `onIntercepTouchEvent()` is used to intercept the transfer of touch events from ViewGroup to child views. The default implementation in ViewGroup always returns false, which means no interception. We can override this method to implement our own touch event interception logic.

**onTouchEvent()**<BR>
The `onTouchEvent()` of the ViewGroup is inherited from the `onTouchEvent()` method of the view. The ViewGroup has not been overridden. We will introduce the implementation logic of the `onTouchEvent()` method of the view in the following section.

## View
[source code](https://github.com/aosp-mirror/platform_frameworks_base/blob/android-6.0.0_r23/core/java/android/view/View.java)
<br>

**dispatchTouchEvent()**

{% highlight java %}
public boolean dispatchTouchEvent()(MotionEvent event) {
    ......

    boolean result = false;

    ......

    if (onFilterTouchEventForSecurity(event)) {
        //noinspection SimplifiableIfStatement
        ListenerInfo li = mListenerInfo;
        //如果设置了onTouchListener，那么会在此处执行onTouchListener的onTouch方法
        if (li != null && li.monTouchListener != null
                && (mViewFlags & ENABLED_MASK) == ENABLED
                && li.monTouchListener.onTouch(this, event)) {
            //如果onTouchListener的onTouch方法返回true，
            //就表示触摸事件被处理了，result就会设置为true
            result = true;
        }

        //如果触摸事件没有被onTouchListener处理，那么就会执行View的onTouchEvent()方法
        if (!result && onTouchEvent()(event)) {
            //如果onTouchEvent()返回了true，
            //就表示触摸事件被View处理了，result就被设置为了true
            result = true;
        }
    }

    ......

    return result;
}
{% endhighlight %}
`dispatchTouchEvent()` is the entry point for the view to handle touch events. In this method, the view will first check whether it has been set `onTouchListener`. If it has, it will call onTouchListener's `ontouch` method. If it returns true, it indicates that the touch event has been processed, and the result will be set to true. If the touch event is not processed by `onTouchListener`, the `onTouchEvent()` method of view will be executed. If `onTouchEvent()` returns true, it means that the touch event is processed by the view, and the result is set to true.
It can be seen from the above that in the `dispatchTouchEvent()` method, the onTouchListener's `ontouch` method is executed first. Once it returns true, the view's `ontoucheevent` method will not be called. Only when `onTouchListener` does not handle the touch event will the view's `ontoucheevent` method be executed later.

**onTouchEvent()**<br>
`dispatchTouchEvent()` is the entry point for the view to handle touch events. In this method, the view will first check whether it has been set `onTouchListener`. If it has, it will call onTouchListener's `ontouch` method. If it returns true, it indicates that the touch event has been processed, and the result will be set to true. If the touch event is not processed by `onTouchListener`, the `onTouchEvent()` method of view will be executed. If `onTouchEvent()` returns true, it means that the touch event is processed by the view, and the result is set to true.
It can be seen from the above that in the `dispatchTouchEvent()` method, the onTouchListener's `onTouch()` method is executed first. Once it returns true, the view's `onTouchEvent()` method will not be called. Only when `onTouchListener` does not handle the touch event will the view's `onTouchEvent()` method be executed later.


At last, Let's get a summary. `dispatchTouchEvent()` is the entry point for the view to handle touch events. In this method, the view will first check whether it has been set `onTouchListener`. If it has, it will call onTouchListener's `onTouch()` method. If it returns true, it indicates that the touch event has been processed, and the result will be set to true. If the touch event is not processed by `onTouchListener`, the `onTouchEvent()` method of view will be executed. If `onTouchEvent()` returns true, it means that the touch event is processed by the view, and the result is set to true.
It can be seen from the above that in the `dispatchTouchEvent()` method, the onTouchListener's `ontouch` method is executed first. Once it returns true, the view's `onTouchEvent()` method will not be called. Only when `onTouchListener` does not handle the touch event will the view's `onTouchEvent()` method be executed later.
