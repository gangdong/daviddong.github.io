---
layout: post
title:  "Install python3.6 on ubuntu16.04"
date:   2019-01-23 23:07:49 +0800
categories: Python
published: true
---
Today I spent some time installing the python3.6 on my ubuntu16.04.
Here is a short note for the process, which might be useful for anyone who want to do the same thing.

The first thing before you start to install the python3.6 is that you need to know which version of pythons are on your system. On ubuntu16.04 you can use below command to check your python version.
```shell
ls /usr/local/lib/
```
For example, before the installation, I have python2.7 and python3.5 on my ubuntu system. They are actually default installed by ubuntu16.04 build.
```shell
david@david-VirtualBox:/$ ls /usr/local/lib/
python2.7  python3.5  
david@david-VirtualBox:/$ 
```
then input `python --version` to check which version python is your default python application. 
```python
python --version
```
If you want to switch to another python version, input below command

```shell
echo alias python=python3 >> ~/.bashrc
source ~/.bashrc
python --version
```
Here I switched my default python version to python3.5.
But python3.5 is still not the right one, what I need is python3.6. To install python3.6, there are usually two methods. one is using `apt-get install`. The command is as below.
```shell
sudo add-apt-repository ppa:jonathonf/python-3.6
sudo apt-get update
sudo apt-get install python3.6
```
Unfortunately it doesn't work on my installation for the PPA has been removed. Therefore I turned to the second way to download the source code and compile, install.
The command as below.
```shell
wget https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tar.xz
xz -d Python-3.6.0.tar.xz
tar -xvf  Python-3.6.0.tar
cd Python-3.6.0
./configure
make
sudo make install
```
Waiting for the installation complete. Then check the python version, if you see the "Python 3.6.x", python3.6 has been installed successfully on your ubuntu16.04.
```python
david@david-VirtualBox:~$ python --version
Python 3.6.0
```
If you don't see the Python3.6.x, instead, you see Python3.5.x or else, which means your system's default python version isn't python3.6. You need to use `update-alternatives --config python` command to switch it to python3.6.<br> 
Like this.
```shell
sudo update-alternatives --list python
sudo update-alternatives --config python
```
If you find below message, represents the alternatives failed to recognize python and you must install python into your alternatives list firstly.
```shell
update-alternatives：error：no alternatives for python
```
install your python by below command.
```shell
sudo update-alternatives --install /usr/bin/python python /home/david/Python-3.6.0 3
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.5 2
sudo update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1 
```
The last character of above each command sets the priority of your pythons on the system. The bigger the higher priority. 
After installment, check again. you will see all your pythons are in the alternatives.
```shell
david@david-VirtualBox:~$ sudo update-alternatives --list python
/home/david/Python-3.6.0
/usr/bin/python2.7
/usr/bin/python3.5
```
Then switch to root user and execute the last command to choose which python you are going to set as default.
```shell
sudo su
update-alternatives --config python
```
If you see below menu, congratulations, just select the one you want.
```
有 3 个候选项可用于替换 python (提供 /usr/bin/python)。

  选择       路径                    优先级  状态
------------------------------------------------------------
* 0            /home/david/Python-3.6.0   3         自动模式
  1            /home/david/Python-3.6.0   3         手动模式
  2            /usr/bin/python2.7         1         手动模式
  3            /usr/bin/python3.5         2         手动模式

要维持当前值[*]请按<回车键>，或者键入选择的编号：
```
We have done all the job for now. Hope this short article is able to give you help if you have the same requirement as me. 
If you have any question, please ask at below comment box.
<br>