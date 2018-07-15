#!bin/bash

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:$PATH

export JAVA_HOME={{ java_home }}
export PATH=:$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin
export LASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$CLASSPATH



Proname="{{ proname_path }}"
Bin_path="{{ proname_bin_path }}"


if  [ -z "$Proname" ];then
	echo  "Please set Proname...."
	echo  "End..."
	exit
elif [ -z "$Bin_path" ];then
	echo "Please set Bin PATH...."
	echo  "End....."
	exit
fi

#Pid=`ps -ef | grep $Proname | grep  -v grep | awk  '{print $2}'  `

start() 
{
	Pid=`ps -ef | grep $Proname/conf/logging.properties | grep  -v grep | awk  '{print $2}' `
	
	if [  -z $Pid ];then
		cd $Bin_path
		rm  -fr   ../work/* 
		#sh startup.sh
		su  gxy_tomcat  -s  $Bin_path/startup.sh  
		echo "start.....ok"
	else
		echo  "Proname has been run...."
		echo "Proname PID is $Pid"
	fi
}


stop() {
	Pid=`ps -ef | grep $Proname/conf/logging.properties | grep  -v grep | awk  '{print $2}'  `
	if [ -z "$Pid" ];then
		echo "$Proname is not runing... Pid is not found"
	else

		kill  -9  $Pid
		echo "$Proname   has end....."
	fi
	}


restart () {
	stop;
	sleep  3
	start;
	}


status () {
	Status=`ps -ef | grep  -v grep  | grep $Proname/conf/logging.properties`
	if [ -z "$Status" ];then
		echo "$Proname is not runing....."
	else
		echo "$Status"
	fi
	}

case $1 in 
	start )
		start
		;;
	stop  )
		stop
		;;
	restart )
		restart
		;;
	status )
		status
		;;
	*)
		echo "Usage  start|stop|restart|status....."
		;;
esac




