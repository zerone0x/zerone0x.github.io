+++
title = "Network Intro"
description = ""
[extra]
image = "hexcell.png"
+++

网络知识对我来说是云里雾里，既没有相关的实践，也没有相关的编程，最近看到一些网络相关的blog和视频，下定决心来了解下网络的设计构造和应用，也会将自己的总结和思考记录在此，作为存档和分享.

首先是一些问题，主要是分为理论和实践类的，最后还可以加上csapp的socket server的lab.

# 理论
- 为什么网络要分层？网络本身的目的是为了传递信息？传递信息这件事情在某一层分别对应了哪些步骤？
  - 物理层的电流，是可以decode为01的，01之类的信息根据frame layer的flag来截取，拿到真实的信息.
- 网络协议是如何实现的？网络协议是为了实现通信？不同的ip之间是如何连接的？
  - 一台机器给另一个机器发送消息时候，发生了什么？
    - ARP是能找到目的MAC地址，然后进行通讯，通讯信息的稳定可靠主要是TCP/IP的ack的机制.
    - 发送TCP/IP的时候还需要port.
  - TCP/IP 是如何运作的？假设B--> A
    - A sent a sync to B
    - B sent a ack and sequence back to A
    - A sent a ack and sequence to B
    - The connection has established!!
    - B sent a seq and dataset to A
    - A sent ACK to B
    - B sent Fin and sequence to A
    - A sent Fin and sequence to B
    - The connection has closed!!
    ![](https://i.imgur.com/fGX0bY2.png)
    - There are many labels on every process， it could be found in wireshark.

- ip是如何划分的？子网掩码的作用是什么？
- 既然网络是分层的，不同分层的子ip是如何通信的，通过夫ip再找下一层的ip吗？
  - different layers' ips could use arp to broadcast the destination ip, then check the suitable routes to go, by the way, it maybe many routes to it, and it has a **time to live** to avoid the loop.
  
# 实践
- 抓包的内容里面有什么？如何通过抓包来分析网络的协议？通过抓包能做什么？能解决什么问题？
  - The packages tell us what happened in the ping 1232.com. like the detail of the package's trip
  - 有哪些属性是重要的，需要注意的？
    - Like the properties in TCP/IP
- 包是用来分析网络和排错的
- 如何找到自己想要的包？通过哪些属性可以辨别？
- 如何用抓包来学习tcp/ip？
  - [Wireshark网络分析就这么简单](https://book.douban.com/subject/26268767/)
    - 这种书比较实操，比什么csapp好落地理解.
  - [plantegg - tcpip](https://plantegg.github.io/2017/06/02/%E5%B0%B1%E6%98%AF%E8%A6%81%E4%BD%A0%E6%87%82TCP--%E8%BF%9E%E6%8E%A5%E5%92%8C%E6%8F%A1%E6%89%8B/)


## wireshark

wireshark作为抓包的工具，帮助在troubleshot的时候回溯流程。但wireshark怎么用呢？

- 过滤想要的内容
  - 根据问题的已知来定位，filter出相关的协议/端口+ip，还有graph analysis来分析，在每次抓包时用tag和flag来标记...比如：
  
        portmap||mount||nfs 

- 从拿到的结果里，逐步分析每个steps

# TCP/IP

除了3次握手连接和4次握手，还有protocol的各种参数外，还有个**TCP 窗口** 和 **拥塞算法**，也是TCP/IP的重要组成部分.

## MTU

在3次握手时，双方会告诉对方MSS，MSS加上TCP和IP的头部，就是MTU(Maximum Transmission Unit). 

在传输大的网络包的时候，MTU是根据双方里最小的那个作为基准.

## properties of TCP/IP

Seq: 如果收到的包乱序了，可以根据这个来排序和检查丢包，不一定从0开始计数,**接收方回复的Ack号恰好就等于发送方的下一个Seq号**,大体关系是：
  - B的ACK是A的seq+len(A的data)
  - A的seq是等于上面的

## TCP 窗口

网络传输的速度怎么加速？

每次传输更多的数据？TCP 窗口的定义就是**传输过程中最多的数据量**. 一旦超出了，就得等待ACK，然后再传输.

如何计算TCP窗口的大小？


            2 ^ windowsclae * winsize(in tcp header)

## 拥塞算法

导致网络拥塞的因素很多，并且动态变化，所以需要动态的算法来调整窗口的大小，来模拟当下的拥塞点，以达到最大的传输速度.

- slow start

> 在每次都收到ACK后，可以2* MSS的速度来增加窗口的大小

- congestion avoidance

> 往返 + 1 MSS

![](https://i.imgur.com/opOso2M.png)
### 超时重传

超过**一定时间(RTO)**，还没有收到ACK，就会重传.

之后的窗口大小：**丢包总量的1/2**

用wireshark里的expert info可以看到重传的包

### 快速重传

如果收到了>=3个的ACK，就会重传. >=3目的是避免因为乱序导致重传。



# DNS

      dig @ip domain 

      nslookup domain 


# socket server
- [csapp network programming](https://www.youtube.com/watch?v=OynSMXfNtiM&list=PL22J-I2Pi-Gf0s1CGDVtt4vuvlyjLxfem&index=21)

# Reference
- [Networking tutorial](https://www.youtube.com/playlist?list=PLowKtXNTBypH19whXTVoG3oKSuOcw_XeW)