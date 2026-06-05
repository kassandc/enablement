#Use df to get root volume info
df -h / | awk 'NR==1 {print "filesystem,size,used,avail,use%,mounted on"} NR==2 {print $1","$2","$3","$4","$5","$6}'
