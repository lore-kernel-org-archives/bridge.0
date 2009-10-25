From: Joachim Schiele <js@lastlog.de>
Date: Sun, 25 Oct 2009 02:38:17 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200910250238.17255.js@lastlog.de>
Subject: [Bridge] using a bridge (setting priority eth0 > ath0)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

hello,

what i want to do:
having two computers both equipped with:
lspci
01:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit 
Ethernet (rev 10)
01:0a.0 Ethernet controller: Atheros Communications Inc. AR5212/AR5213 
Multiprotocol MAC/baseband processor (rev 01)

i create two bridges (one on each host)
pc2b ~ # brctl show br0
bridge name     bridge id               STP enabled     interfaces
br0             0000.0040f4a0b037       yes             ath0
                                                        eth0

and then i set all interfaces up using:
ip l set ath0 up
ip l set eth0 up
ip l set br0 up

i put one ath0 interface into master mode and the other ath0 is a normal 
station (client). the connections eth0-eth0 works great, also the ath0-ath0 
link works great (tested with and without bridge).

in general everything works, if i either one of the 4 interfaces down 
(eth0/eth0/ath0/ath0) stp's work creates a working path in no time.

the issue is - the reason i write to this list however:
when all interfaces are up the data always is going over ath0-ath0 instead of 
eth0-eth0. (the wireless lan should be my backup link).

i issues setbridgeprio br0 1 and setbridgeprio br0 10. as well as setpathcost 
with various consistent experiments. say one experiment i set all ath0 
pathcosts to a value 100 all eth0 to 999. 
i don't see any difference when doing the opposite.

any idea? 

dmesg added but i don't see anything special there. there was an error once 
but i think that might have something todo with the routing loop i caused 
(which i resolved with adding setfd with a higher value).

thanks,
joachim schiele





============ pc2 ==============
dmesg
br0: port 2(ath0) entering forwarding state
br0: topology change detected, propagating
br0: port 1(eth0) entering forwarding state
eth0: received packet with  own address as source address
eth0: received packet with  own address as source address
br0: no IPv6 routers present
br0: received tcn bpdu on port 1(eth0)
br0: topology change detected, propagating
br0: port 2(ath0) entering disabled state
br0: port 2(ath0) entering listening state
br0: port 2(ath0) entering learning state
br0: topology change detected, propagating
br0: port 2(ath0) entering forwarding state
ath0: no IPv6 routers present
br0: received tcn bpdu on port 1(eth0)
br0: topology change detected, propagating
br0: port 2(ath0) entering disabled state
br0: port 2(ath0) entering listening state
br0: port 2(ath0) entering learning state
br0: topology change detected, propagating
br0: port 2(ath0) entering forwarding state
ath0: no IPv6 routers present
br0: received tcn bpdu on port 1(eth0)
br0: topology change detected, propagating

ip l
14: ath0: <BROADCAST,MULTICAST,PROMISC,UP,LOWER_UP> mtu 1500 qdisc noqueue 
state UNKNOWN
    link/ether 00:40:f4:a0:b0:37 brd ff:ff:ff:ff:ff:ff
3: eth0: <BROADCAST,MULTICAST,PROMISC,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast 
state UP qlen 1000
    link/ether 00:40:f4:eb:16:45 brd ff:ff:ff:ff:ff:ff

pc2b ~ # brctl show
bridge name     bridge id               STP enabled     interfaces
br0             0000.0040f4a0b037       yes             ath0
                                                        eth0
pc2b ~ # brctl showstp br0
br0
 bridge id              0000.0040f4a0b037
 designated root        0000.0040f4a0b037
 root port                 0                    path cost                  0
 max age                   9.99                 bridge max age             
9.99
 hello time                1.99                 bridge hello time          
1.99
 forward delay             2.99                 bridge forward delay       
2.99
 ageing time               3.99
 hello timer               1.49                 tcn timer                  
0.00
 topology change timer     0.00                 gc timer                   
1.49
 flags


ath0 (2)
 port id                0402                    state                
forwarding
 designated root        0000.0040f4a0b037       path cost                999
 designated bridge      0000.0040f4a0b037       message age timer          
0.00
 designated port        0402                    forward delay timer        
0.00
 designated cost           0                    hold timer                 
0.48
 flags

eth0 (1)
 port id                2801                    state                
forwarding
 designated root        0000.0040f4a0b037       path cost                111
 designated bridge      0000.0040f4a0b037       message age timer          
0.00
 designated port        2801                    forward delay timer        
0.00
 designated cost           0                    hold timer                 
0.48
 flags

arp -e
10.0.0.1                 ether   00:40:f4:a0:b0:00   C                     br0









============ pc6 ==============
ip l
17: ath0: <BROADCAST,MULTICAST,PROMISC,UP,LOWER_UP> mtu 1500 qdisc noqueue 
state UP
    link/ether 00:40:f4:a0:b0:00 brd ff:ff:ff:ff:ff:ff
3: eth0: <BROADCAST,MULTICAST,PROMISC,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast 
state UP qlen 1000
    link/ether 00:40:f4:ec:59:06 brd ff:ff:ff:ff:ff:ff

dmesg
eth0: received packet with  own address as source address
eth0: received packet with  own address as source address
__ratelimit: 9560 callbacks suppressed
eth0: received packet with  own address as source address
eth0: received packet with  own address as source address
eth0: received packet with  own address as source address
eth0: received packet with  own address as source address
eth0: received packet with  own address as source address
eth0: received packet with  own address as source address
eth0: received packet with  own address as source address
eth0: received packet with  own address as source address
eth0: received packet with  own address as source address
eth0: received packet with  own address as source address
br0: port 2(ath0) entering disabled state
__ratelimit: 7851 callbacks suppressed
eth0: received packet with  own address as source address
br0: port 2(ath0) entering listening state
br0: port 2(ath0) entering learning state
br0: topology change detected, sending tcn bpdu
br0: port 2(ath0) entering forwarding state
br0: port 2(ath0) entering disabled state
eth0: received packet with  own address as source address
br0: port 2(ath0) entering listening state
br0: port 2(ath0) entering learning state
br0: topology change detected, sending tcn bpdu
br0: port 2(ath0) entering forwarding state
br0: port 2(ath0) entering disabled state
eth0: received packet with  own address as source address
br0: port 2(ath0) entering listening state
br0: port 2(ath0) entering learning state
br0: topology change detected, sending tcn bpdu
br0: port 2(ath0) entering forwarding state

arp -e
PC2                      ether   00:40:f4:a0:b0:37   C                     br0

pc2b ~ # brctl  show
bridge name     bridge id               STP enabled     interfaces
br0             0000.0040f4a0b037       yes             ath0
                                                        eth0
pc2b ~ # brctl showstp br0
br0
 bridge id              0000.0040f4a0b037
 designated root        0000.0040f4a0b037
 root port                 0                    path cost                  0
 max age                   9.99                 bridge max age             
9.99
 hello time                1.99                 bridge hello time          
1.99
 forward delay             2.99                 bridge forward delay       
2.99
 ageing time               3.99
 hello timer               1.20                 tcn timer                  
0.00
 topology change timer     0.00                 gc timer                   
0.20
 flags


ath0 (2)
 port id                0402                    state                
forwarding
 designated root        0000.0040f4a0b037       path cost                999
 designated bridge      0000.0040f4a0b037       message age timer          
0.00
 designated port        0402                    forward delay timer        
0.00
 designated cost           0                    hold timer                 
0.20
 flags

eth0 (1)
 port id                2801                    state                
forwarding
 designated root        0000.0040f4a0b037       path cost                111
 designated bridge      0000.0040f4a0b037       message age timer          
0.00
 designated port        2801                    forward delay timer        
0.00
 designated cost           0                    hold timer                 
0.20
 flags
