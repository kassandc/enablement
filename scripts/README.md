Lab — Bash pipeline

Write `scripts/disk_report.sh`: uses `df`, filters root volume, prints CSV line to stdout; `chmod +x`; run from repo root; document usage in `scripts/README.md`.


k8s@KASSANDC01 .../enablement on  main > df -h / | awk 'NR==1 {print "filesystem,size,used,avail,use%,mounted on"} NR==
2 {print $1","$2","$3","$4","$5","$6}'
filesystem,size,used,avail,use%,mounted on
/dev/sdd,1007G,15G,942G,2%,/

k8s@KASSANDC01 .../enablement on  main > mkdir scripts

k8s@KASSANDC01 .../enablement on  main > cd scripts/

k8s@KASSANDC01 .../enablement/scripts on  main > vi disk_report.sh

k8s@KASSANDC01 .../enablement/scripts on  main [?] > vi disk_report.sh

k8s@KASSANDC01 .../enablement/scripts on  main [?] > chmod +x disk_report.sh

k8s@KASSANDC01 .../enablement/scripts on  main [?] > ./disk_report.sh
filesystem,size,used,avail,use%,mounted on
/dev/sdd,1007G,15G,942G,2%,/


Lab — Python JSON helper

Write `tools/jsonpick.py` that reads stdin JSON, prints one field (arg), exits non-zero on error. Add two sample invocations in README.

k8s@KASSANDC01 .../enablement on  main [?] > mkdir tools

k8s@KASSANDC01 .../enablement on  main [?] > cd tools

k8s@KASSANDC01 .../enablement/tools on  main > vi jsonpick.py

k8s@KASSANDC01 .../enablement/tools on  main [?] > chmod +x jsonpick.py

k8s@KASSANDC01 .../enablement/tools on  main [?] > echo '{"name":"Kassandra","gender":"Female","Occupation":"IT"}' | ./
jsonpick.py gender name
Female
Kassandra

k8s@KASSANDC01 .../enablement/tools on  main [?] > echo '{"name":"Kassandra","gender":"Female","Occupation":"IT"}' | ./jsonpick.py gender name occupation
Female
Kassandra

[0 |❌1 ] => ❌ERROR k8s@KASSANDC01 .../enablement/tools on  main [?] > echo '{"name":"Kassandra","gender":"Female","Occupation":"IT"}' | ./jsonpick.py gender name Occupation
Female
Kassandra
IT
