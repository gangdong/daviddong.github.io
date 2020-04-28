---
layout: post
title:  "浅谈触摸屏充电器噪声要求及测量方法"
date:   2013-12-15 23:01:16 +0800
categories: Touch
published: true
---
触摸屏在高噪声环境下的性能是当前移动电子设备特别是智能手机设计人员面临的巨大挑战之一。而在这些噪声当中，充电器噪声是被广泛涉及和对触摸屏影响最大的噪声源。这种噪声通过USB充电器物理耦合至传感器进而被TOUCH IC所采集。它可以造成触摸的精度或线性度下降、产生误触，严重的会造成触摸屏变得无响应。本文结合我在工作中的一些经验来介绍一下触摸屏设计中的对噪声相关的要求，测量方法以及一些降噪的方法。

## 概述
当前业界广泛应用的标准是TOUCH IC 能够在40V Vpp 充电器噪声的环境下检测到微库仑级别的电荷变化。<br>
如图所示，一个大噪声的充电器可以将共模噪声注入到触摸屏系统中。

![touch-noise-system](https://gangdong.github.io/daviddong.github.io/assets/image/touch-noise-system.png)

## 触摸屏电源输入端的要求

通常来说充电器噪声的幅度大小和频谱分布对于触摸屏IC的工作情况有较大的影响。因此对于任何触控IC 来说，对噪声的幅度和频谱分布都会有要求。

首先对于充电器共模噪声幅度的要求是其要低于一定的阈值 （根据IC的噪声抑制能力不同，阈值会有不同）; 同时不同频带的噪声的阈值有较大区别。
另外对于共模噪声的频谱的要求是 在和电容屏触控IC 的使用频带重合的频带内, 具有一定宽度的干净频带。

以上两个方面的条件必须同时得到满足, 才达到电源引脚的输入共模噪声要求. 如果某充电器只满足第一方面的要求不满足第二方面的要求, 即噪声幅度峰峰值没有超标, 但在IC 工作可选有效频段范围内不存在干净区域, 则该充电器不达标; 如果某充电器只满足第二方面的要求但不满足第一方面的要求, 即在IC 可选有效频段范围内存在符合条件的干净区域, 但噪声的幅度超标, 这样的充电器也不达标。在电网环境较差的情况下, 充电器的输出噪声可能会明显大过该充电器在普通市电网环境下的噪声。

为了规范充电器噪声的标准，许多 OEM 厂商联合起来创建了 EN 规范，这些规范对充电器在任何频率下发出的最大噪声水平进行了限定。请参见EN 62684-2010 和 EN 301489-34v1.1.1。

![touch-noise-en-spec](https://gangdong.github.io/daviddong.github.io/assets/image/touch-noise-en-spec.png)

规范中规定在1k Hz到10k Hz 频谱范围内，充电器噪声的峰峰值不应该大于 1V Vpp。在高于10k Hz 的频谱范围，充电器输出的噪声的峰峰值应该随着频率的升高按指数级降低。需要指出的是该规范较为严格，目前市场上多数的充电器都没有严格按照该规范的要求设计，从而造成输出的噪声远远大于规范的要求。
目前主流的触控IC厂家内部要求IC 在1k  Hz – 400k Hz的工作频段下能够抗住至少40V Vpp的充电器噪声。例如CYPRESS 可以满足95v Vpp 以上的抗噪要求，ATMEL的Maxcharger 技术可以在某些频段上实现最大240v Vpp噪声下的良好工作。

## 充电器噪声的测量方法

充电器的噪声属于共模噪声，噪声源会造成系统GND的浮动，从而产生一个 Vpp-noise大小的电压偏差。

![touch-noise-model](https://gangdong.github.io/daviddong.github.io/assets/image/touch-noise-model.png)

基于以上模型，可以按照如下步骤测量充电器耦合进系统的噪声。

1. 把充电器接上设备, 让充电器处于负载工作状态。
2. 示波器调到FFT分析窗口。
3. 示波器/频谱分析仪的探头的正极与待测设备的直流GND 相连; 探头的负极不要和待测设备相连, 可以和示波器/频谱分析仪的大地相连。
4. 确保示波器的GND和大地相连。
![touch-noise-measurement](https://gangdong.github.io/daviddong.github.io/assets/image/touch-noise-measurement.png)

## 对触摸屏设计的一些要求

除了触控IC本身的抗噪声能力外，触碰传感器的设计对于系统抗噪声的性能也息息相关。当前的投射电容传感器设计由TX （发射极）和RX（检测极）构成。通过检测TX和RX之间形成的耦合电容上的电荷变化来感知物体的触碰。检测电荷的变化只有微库仑级别，其中RX线由于是信号检测线所以对于耦合进来的噪声尤其敏感。

通常要考虑RX ITO 的面积和线阻抗对抗噪声的影响。

理想的设计是RX 线要有较小的线阻抗来保证较小的充电时间，从而避免在充电期间导入过多的噪声信号。同时也要保证RX线要有小的面积，来减少噪声的引入。我们知道，ITO线的阻抗和其宽度相关，相同的ITO材料越宽的走线其线阻抗也越低。因此在设计时要平衡好阻抗和图形的关系。
好在现在各家触控IC厂都有自己的设计规范在保证达到最好的抗噪性能。

下面是两个触控IC厂家对于触摸屏设计的一些规范。

厂家1 对于ITO阻抗的要求
![touch-noise-ito](https://gangdong.github.io/daviddong.github.io/assets/image/touch-noise-ito-res.png)

不建议使用菱形图案的屏体图案设计, 因为该设计较宽的RX面积一般难以达到抗噪声的性能要求。
*注RX电阻包括了ITO 电阻+走线 (如金属走线) 电阻. 对于尺寸较大的屏(如7’’及7’’以上的TP), RX 单边走线难以
达到<10K Ohm 的要求, 强烈建议RX 通道采用双边走线的方式。

厂家2 对于 ITO 图案的改进 
对传统的diamond图案做了改进，减少了RX的宽度。
![touch-noise-pattern](https://gangdong.github.io/daviddong.github.io/assets/image/touch-noise-ito-pattern.png)

## TOUCH IC 的降噪方法

现在主流的触控IC供应商都研发了各家的降噪算法，像ATMEL Maxcharger 和CYPRESS Charger Armor 等。

通常这些方法都采用提高前端模拟电路的信躁比和后端各种滤波算法的应用。

1. 前端模拟电路信躁比
信噪比是触摸屏控制器的性能指标，现在已经作为行业标准被大家接受。
在电容式触摸屏中的信躁比定义为触摸的信号和叠加在信号之上的噪声信号的峰峰值之间的比值。信号就是加上测量到的手指电容后的实际电容的变化量。手指电容取决于传感器覆盖物厚度、手指大小，DUT到地的寄生电容，以及传感器模式。噪声成分依赖于内部控制器噪声和外部噪声源。
![touch-noise-snr](https://gangdong.github.io/daviddong.github.io/assets/image/touch-noise-snr.png)
由于触摸控制 IC 模拟端得到的原始信噪比与触摸屏的驱动电压成正比，因此可以期望采用高驱动电压 (TX)的方式来提高系统的信噪比。
一般的触摸屏控制器是以设备电压2.7v来驱动触摸屏，为了提高驱动电压ATMEL设计了内部电压泵可以采用DOUBLE驱动模式，从而将驱动电压提高到7v左右。而赛普拉斯的 Gen4同样采用 2.7 V 的模拟电源，但实际上以 10 V 的电压驱动触摸屏。Gen4 控制器内部集成了电荷泵和 10v 晶体管，这使得它们能够实现 3.7 倍于其他任何芯片的原始信噪比。
需要注意的是高的驱动电压同样会导致系统功耗的增加，在某些场合下会对其他电路如LCD电路等产生干扰。这些在设计时都需要仔细考虑。
值得一提的是ATMEL独有的DUAL-X 双线驱动扫描模式，能够在不提高驱动电压的模式下将SNR提高到原来的1.6倍。

2. 后端处理
一旦获取信号后，就可以采用中值滤波或其他更先进的非线性滤波等典型技术来进一步提高信噪比，但这将以牺牲刷新率为代价。ATMEL的maXTouch IC 就采用了中值滤波的算法，在系统处于大噪声耦合的环境下用户可以选择使用该滤波器，代价是刷新率会降到正常时的1/3。
但是在某些场合下如果设备需处理的带内噪声很大时，即使采用滤波算法也很难得到干净的信号值，这时一些特殊的方法会派上用场。例如ATMEL maXTouch的自适应跳频技术是解决触摸屏中的充电器噪声问题的另一项关键技术。他能够结合背景噪声的测量扫描动态的调整其扫描驱动 (Tx) 频率并调整其ADC采样的个数来抑制噪声。

## 总结
随着智能手机的广泛普及，电容触摸屏得到了越来越多的应用，同时对其抗噪的能力也提出了更大的挑战。当前的趋势是要求TOUCH IC具有更快的对噪声作出反应的能力，在不增加过多成本的前提下能实现更小的功率消耗同时不会过多的降低系统的报点率。尽管在整个嵌入式系统中，电容触摸屏实现了一些最先进的功能，包括FIR 滤波器，高级非线性滤波方法、内置抗噪声硬件、跳频功能或其他方法等。但是但抗噪声能力的提升仍然具有很大的提升空间。各家TOUCH IC厂家也在积极的研发创新，新的降噪算法会不断出现。
<br>
<!-- Gitalk 评论 start  -->
<!-- Link Gitalk 的支持文件  -->
<link rel="stylesheet" href="https://unpkg.com/gitalk/dist/gitalk.css">
<script src="https://unpkg.com/gitalk/dist/gitalk.min.js"></script>
<div id="gitalk-container"></div>
<script type="text/javascript">
   var gitalk = new Gitalk({
   // gitalk的主要参数
   clientID: '5e24fc307693a6df3bc5',
   clientSecret: '28c9c17e1174c705c42e9bdc92f87cadcc4ec8b8',
   repo: 'daviddong.github.io',
   owner: 'gangdong',
   admin: ['gangdong'],
   id: 'touch/2013/12/15/Touch-noise.html',
   title: 'comments'
    });
   gitalk.render('gitalk-container');
</script>
<!-- Gitalk end -->

<br><br><br>
<font size="2" color="#aaa">作者：David Dong<br></font>
<font size="2" color="#aaa">来源：https://gangdong.github.io/daviddong.github.io/touch/2013/12/15/Touch-noise.html</font>
<font size="2" color="#aaa">转载请注明出处。</font>
<span id="busuanzi_container_page_pv" ></span><font size="2" color="#aaa">
本文总阅读量</font><font size="2" color="#aaa"><span id="busuanzi_value_page_pv"></font></span><font size="2" color="#aaa">次</font>