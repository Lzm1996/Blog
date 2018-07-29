---
title: spring-boot配置devtools实现热部署
date: 2018-07-29 17:17:25
toc: true
tags:
    - spring-boot
---
spring-boot配置devtools实现热部署
<!-- more -->

## 什么是热部署？

应用启动后会把编译好的Class文件加载的虚拟机中，正常情况下在项目修改了源文件是需要全部重新编译并重新加载（需要重启应用）。而热部署就是监听Class文件的变动，只把发生修改的Class重新加载，而不需要重启应用，使得开发变得简便。
在SpringBoot中启用热部署是非常简单的一件事，spring为开发者提供了一个名为spring-boot-devtools的模块来使SpringBoot应用支持热部署，提高开发者的开发效率，无需手动重启SpringBoot应用。
我们只需要把这个工具引入到工程里就OK了

### devtools的原理

深层原理是使用了两个ClassLoader，一个Classloader加载那些不会改变的类（第三方Jar包），另一个ClassLoader加载会更改的类，称为restart ClassLoader,这样在有代码更改的时候，原来的restart ClassLoader 被丢弃，重新创建一个restart ClassLoader，由于需要加载的类相比较少，所以实现了较快的重启时间。
使用需要在pom.xml中添加以下的配置：
``` xml
<dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-devtools</artifactId>
        <optional>true</optional>
</dependency>
```
>（1）devtools可以实现页面热部署（即页面修改后会立即生效，这个可以直接在application.properties文件中配置spring.thymeleaf.cache=false或者spring.freemarker.cache=false来实现），实现类文件热部署（类文件修改后不会立即生效），实现对属性文件的热部署。即devtools会监听classpath下的文件变动，并且会立即重启应用（发生在保存时机），注意：因为其采用的虚拟机机制，该项重启是很快的
>（2）配置了后在修改java文件后也就支持了热启动，不过这种方式是属于项目重启（速度比较快的项目重启），会清空session中的值，也就是如果有用户登陆的话，项目重启后需要重新登陆。默认情况下，/META-INF/maven，/META-INF/resources，/resources，/static，/templates，/public这些文件夹下的文件修改不会使应用重启，但是会重新加载（devtools内嵌了一个LiveReload server，当资源发生改变时，浏览器刷新）。

## devtools的配置
在application.properties中配置spring.devtools.restart.enabled=false，此时restart类加载器还会初始化，但不会监视文件更新。
在SprintApplication.run之前调用System.setProperty(“spring.devtools.restart.enabled”, “false”);可以完全关闭重启支持，配置内容：
```
# 热部署生效
spring.devtools.restart.enabled: true
# 根据你使用的视图设置，如果使用thymeleaf则设置为spring.thymeleaf.cache=false
spring.freemarker.cache=false
#设置重启的目录，根据需要设置
#spring.devtools.restart.additional-paths: src/main/java
#classpath目录下的WEB-INF文件夹内容修改不重启，根据需要设置
#spring.devtools.restart.exclude: WEB-INF/**
```
## IDEA配置

当我们修改了Java类后，IDEA默认是不自动编译的，而spring-boot-devtools又是监测classpath下的文件发生变化才会重启应用，所以需要设置IDEA的自动编译：
File-Settings-Compiler-Build Project automatically

![tu](http://p6us0enhg.bkt.clouddn.com/18-4-19/97133874.jpg)

