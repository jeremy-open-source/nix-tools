
exit 1

ADAPTER=enx00249b790340
WIFI=wlp5s0


echo "1" > /proc/sys/net/ipv4/ip_forward
sudo iptables -A FORWARD -i enx00249b790340 -o wlp5s0 -j ACCEPT
sudo iptables -A FORWARD -i wlp5s0 -o enx00249b790340 -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -t nat -A POSTROUTING -o wlp5s0 -j MASQUERADE

#sudo iptables -A FORWARD -i eth0 -o wifi0 -j ACCEPT
#sudo iptables -A FORWARD -i wifi0 -o eth0 -m state --state ESTABLISHED,RELATED -j ACCEPT
#sudo iptables -t nat -A POSTROUTING -o wifi0 -j MASQUERADE
