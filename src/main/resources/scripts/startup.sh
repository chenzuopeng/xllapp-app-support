#!/bin/sh

#删除上次执行遗留的signal文件
rm -f signal

#获取安装目录
PRGDIR="`dirname $0`"
cd "$PRGDIR"
appHome="`pwd`"

#虚拟机启动参数
JAVA_OPTS=""

#如果$logsDir指定的目录不存在,则创建之
logsDir="logs"
if [ ! -d $logsDir ]
then
    mkdir $logsDir
fi 

#通过命令行参数设置激活的spring profile.
defaultSpringProfile="production"
if [ $# -gt 0 ]
then
    defaultSpringProfile=$1
fi

#加载环境相关配置
if [ -r "$appHome/setenv.sh" ]; then
   . "$appHome/setenv.sh"
fi

#设置启动类
JAVA_OPTS="$JAVA_OPTS -DstartClass=org.xllapp.app.core.Main"

#设置进程标示,主要为了便于查找到进程
JAVA_OPTS="$JAVA_OPTS -Dprocess.flag=${process.flag}"

#设置默认激活的spring profile
JAVA_OPTS="$JAVA_OPTS -Dspring.profiles.default=$defaultSpringProfile"

java $JAVA_OPTS -jar launcher.jar >> /dev/null &
