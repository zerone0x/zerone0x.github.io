---
title: "Workofdashboard"
subtitle: ""
date: 2022-07-04T17:09:25+08:00
draft: true
author: ""
authorLink: ""
description: ""
keywords: ""
license: ""
comment: false
weight: 0

tags:
- draft
categories:
- draft

hiddenFromHomePage: false
hiddenFromSearch: false

summary: ""
resources:
- name: featured-image
  src: featured-image.jpg
- name: featured-image-preview
  src: featured-image-preview.jpg

toc:
  enable: true
math:
  enable: false
lightgallery: false
seo:
  images: []

# See details front matter: /theme-documentation-content/#front-matter
---

<!--more-->

dashboard分为最重要的3个部分。1. CI 2. Official 3. Images

## CI

1. CI出问题90%的原因是code error，但如果一个error很久不fix，导致大量job fail，那就得解决。

## Official

1. 每个official类似于正式版本，如果build失败，有可能是各种情况导致，需要根据每种情况来定位问题，通知相应的人。很多时候都是server down。
2. act --> notify

## Images

有几种情况:
1. install 
   1. 如果出现install error
      1. 得排除Storebox的问题
      2. 所以得用相应的image来new 一个instance
      3. 然后用secret的itools 的scret登陆 server
      4. 试一下是否是没有权限
      5. 如果可以打开exe，那就找install team，反之，找storebox team
2. ecs的问题，你首先得确定排除他不是以上问题导致
   1. 可能不是以上，都可以归因到ecs


## qa

1. official的各种name
2. 