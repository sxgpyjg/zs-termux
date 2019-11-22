
DEV=eth0

INPUT="-A INPUT"
# INPUT=-t raw -A PREROUTING

ipset create pub-port-set bitmap:port range 0-65535


IP_SET_MAX=$((100 * 1024 * 1024 / 8 / 60 * $IP_DENY_SECOND))

ipset create scanner-ip-set hash:ip \
  timeout $IP_DENY_SECOND \
  maxelem $IP_SET_MAX \
  counters

iptables \
  -N trap-scan

iptables \
  -A trap-scan \
  -m set --match-set scanner-ip-set src \
  -j DROP

iptables \
  -A trap-scan \
  -j SET \
  --add-set scanner-ip-set src

iptables \
  -A trap-scan \
  -j DROP


iptables \
  -i $DEV \
  $INPUT \
  -p tcp --syn \
  -m set ! --match-set pub-port-set dst \
  -j trap-scan

iptables \
  -i $DEV \
  $INPUT \
  -p tcp --syn \
  -m set ! --update-counters \
  --match-set scanner-ip-set src \
  --packets-gt $PORT_SCAN_MAX \
  -j DROP

iptables \
  -i $DEV \
  -A INPUT \
  -p tcp ! --syn \
  -m conntrack ! --ctstate ESTABLISHED,RELATED \
  -j DROP
