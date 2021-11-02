A=`ps -C nfsd --no-header | wc -l`
if [ $A -eq 0 ];then
        systemctl restart nfs-server.service
        sleep 10
        if [ `ps -C nfsd --no-header| wc -l` -eq 0 ];then
            pkill keepalived
        fi
fi
