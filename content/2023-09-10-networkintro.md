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
  - TCP/IP 是如何运作的？假设A--> B
    - A sent a sync to B
    - B sent a ack and sequence back to A
    - A sent a ack and sequence to B
    - The connection has established!!
    - B sent a seq and dataset to A
    - A sent ACK to B
    - B sent Fin and sequence to A
    - A sent Fin and sequence to B
    - The connection has closed!!
    ![](Pasted%20image%2020230910223212.png)
    - There are many labels on every process， it could be found in wireshark.
- ip是如何划分的？子网掩码的作用是什么？
  - 
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
  - [plantegg - tcpip](https://plantegg.github.io/2017/06/02/%E5%B0%B1%E6%98%AF%E8%A6%81%E4%BD%A0%E6%87%82TCP--%E8%BF%9E%E6%8E%A5%E5%92%8C%E6%8F%A1%E6%89%8B/)


# DNS

` dig @ip domain`
` nslookup domain`


# Reference
- [Networking tutorial](https://www.youtube.com/playlist?list=PLowKtXNTBypH19whXTVoG3oKSuOcw_XeW)