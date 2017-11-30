s/logfile=\/tmp\/supervisord.log/logfile=\/var\/log\/supervisord.log/
s/pidfile=\/tmp\/supervisord.pid/pidfile=\/var\/run\/supervisord.pid/
s/nodaemon=false/nodaemon=true/
s/\;\[include\]/\[include\]/
s/\;files = relative\/directory\/\*.ini/files = \/etc\/supervisor\/conf.d\/\*/
