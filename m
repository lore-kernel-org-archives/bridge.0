Date: Mon, 30 Apr 2007 06:23:03 -0700 (PDT)
From: Sebastian Tabarce <blue_moon_ro@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-605168112-1177939383=:73484"
Content-Transfer-Encoding: 8bit
Message-ID: <283783.73484.qm@web36510.mail.mud.yahoo.com>
Subject: [Bridge] Linux Bridge + NAT + firewall
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--0-605168112-1177939383=:73484
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello everybody!

I'm trying to setup at home a linux router for me and my 3 friends. Basically I had some spare network cards around and that is why I have not bought a switch or a router. Also all of us are rarely at home at the same time so bandwidth will not be a problem. And I thought it would be fun to try to make this work in linux. However, I've hit a dead end.

This is my problem:
- I have a spare computer running CentOS 5 (RHEL 5 clone) with 5 network cards
- we have an internet connection via a cable modem. The cable modem is linked at eth4 to the above computer that will be setup as router.
- all the computers in the house are linked to the same above computer to eth0...eth3.
I did the following:
- I'm using dhclient to obtain an IP for eth4 via DHCP. The internet connection works on this computer, I am able to navigate, etc. I had to spoof the MAC address of eth4 since the MAC of one of the other computers was registered at our ISP. (Yes, I could have exchanged the network cards, if it wouldn't have been a laptop....)
- I used bridge-utils to configure a bridge composed of eth0...eth3

my rc.local:

#create bridge

brctl addbr br0
brctl stp br0 off
brctl addif br0 eth0
....
brctl addif br0 eth3
ifconfig eth0 0.0.0.0
...
ifconfig eth3 0.0.0.0
ifconfig br0 192.168.0.1 netmask 255.255.255.0 up

#spoof MAC and get DHCP IP addres on eth4
ifconfig eth4 down
ifconfig eth4 hw ehter addr xx:xx:xx:xx:xx:xx:xx:xx
ifconfig eth4 up
dhclient eth4

#iptables 
 iptables -t nat -A POSTROUTING -o eth4 -j MASQUERADE
iptables -A INPUT -i eth4 -o br0 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -i eth0 -o eth4 -j ACCEPT  

- the other computers also have IPs in the 192.168.0.xxx range with 192.168.0.1 set as gateway and DNS and are running Windows and linux.

My question is how do I masquerade all  4 computers linked to br0 and make them connect to the internet using my cable modem connection on eth4?
I tried using iptables but could not obtained so far a result. IP forwarding is enabled in /etc/sysctl.conf.
I'm thinking of refining afterwards the rules to have a true firewall, but first I need a working NAT.....

Thanks a lot,
Sebastian

       
---------------------------------
Ahhh...imagining that irresistible "new car" smell?
 Check outnew cars at Yahoo! Autos.
--0-605168112-1177939383=:73484
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello everybody!<br><br>I'm trying to setup at home a linux router for me and my 3 friends. Basically I had some spare network cards around and that is why I have not bought a switch or a router. Also all of us are rarely at home at the same time so bandwidth will not be a problem. And I thought it would be fun to try to make this work in linux. However, I've hit a dead end.<br><br>This is my problem:<br>- I have a spare computer running CentOS 5 (RHEL 5 clone) with 5 network cards<br>- we have an internet connection via a cable modem. The cable modem is linked at eth4 to the above computer that will be setup as router.<br>- all the computers in the house are linked to the same above computer to eth0...eth3.<br>I did the following:<br>- I'm using dhclient to obtain an IP for eth4 via DHCP. The internet connection works on this computer, I am able to navigate, etc. I had to spoof the MAC address of eth4 since the MAC of one of the other computers was registered at our ISP.
 (Yes, I could have exchanged the network cards, if it wouldn't have been a laptop....)<br>- I used bridge-utils to configure a bridge composed of eth0...eth3<br><br>my rc.local:<br><br>#create bridge<br><br>brctl addbr br0<br>brctl stp br0 off<br><span style="font-family: monospace;"></span>brctl addif br0 eth0<br>....<br>brctl addif br0 eth3<br>ifconfig eth0 0.0.0.0<br>...<br>ifconfig eth3 0.0.0.0<br>ifconfig br0 192.168.0.1 netmask 255.255.255.0 up<br><br>#spoof MAC and get DHCP IP addres on eth4<br>ifconfig eth4 down<br>ifconfig eth4 hw ehter addr xx:xx:xx:xx:xx:xx:xx:xx<br>ifconfig eth4 up<br>dhclient eth4<br><br>#iptables <br> iptables&nbsp;-t&nbsp;nat&nbsp;-A&nbsp;POSTROUTING&nbsp;-o eth4 -j&nbsp;MASQUERADE<br>iptables&nbsp;-A&nbsp;INPUT&nbsp;-i eth4 -o br0 -m&nbsp;state --state ESTABLISHED,RELATED&nbsp;-j&nbsp;ACCEPT<br>iptables&nbsp;-A&nbsp;FORWARD&nbsp;-i eth0&nbsp;-o eth4 -j&nbsp;ACCEPT&nbsp; <br><br>- the other computers also have IPs in the 192.168.0.xxx range
 with 192.168.0.1 set as gateway and DNS and are running Windows and linux.<br><br>My question is how do I masquerade all&nbsp; 4 computers linked to br0 and make them connect to the internet using my cable modem connection on eth4?<br>I tried using iptables but could not obtained so far a result. IP forwarding is enabled in /etc/sysctl.conf.<br>I'm thinking of refining afterwards the rules to have a true firewall, but first I need a working NAT.....<br><br>Thanks a lot,<br>Sebastian<br><p>&#32;



      <hr size=1>Ahhh...imagining that irresistible "new car" smell?<br> Check out
<a href="http://us.rd.yahoo.com/evt=48245/*http://autos.yahoo.com/new_cars.html;_ylc=X3oDMTE1YW1jcXJ2BF9TAzk3MTA3MDc2BHNlYwNtYWlsdGFncwRzbGsDbmV3LWNhcnM-">new cars at Yahoo! Autos.</a>

--0-605168112-1177939383=:73484--
