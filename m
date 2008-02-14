Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [Bridge] Bridge and iptables
Date: Thu, 14 Feb 2008 14:41:07 +1100
Message-ID: <96CF49BD8B56384395D698BA99007FA32FA10F@exchange.pacwire.local>
From: "Leigh Sharpe" <lsharpe@pacificwireless.com.au>
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Sathyan M <sathym@gmail.com>, bridge@lists.linux-foundation.org

Bridged traffic is not seen by iptables. You need ebtables instead. 

Regards,
             Leigh
 
Leigh Sharpe
Network Systems Engineer
Pacific Wireless
Ph +61 3 9584 8966
Mob 0408 009 502
Helpdesk 1300 300 616
email lsharpe@pacificwireless.com.au
web www.pacificwireless.com.au
 

-----Original Message-----
From: bridge-bounces@lists.linux-foundation.org
[mailto:bridge-bounces@lists.linux-foundation.org] On Behalf Of Sathyan
M
Sent: Wednesday, 13 February 2008 5:20 PM
To: bridge@lists.linux-foundation.org
Subject: [Bridge] Bridge and iptables

Hi,

I am using linux kernle-2.6.15, iptables-1.4 and bridge-utils-1.4.
Everything intslled without any issue and i am able to enable the
bridge and traffic is also flowing without any issue.

But i did not see any traffic on the iptables forward chain due to
which i am not able to control the traffic.

Do i requie enable anything more to make the traffic pass through
iptables forward chain.

Please look into the configuration
ip addr
1: lo: <LOOPBACK> mtu 16436 qdisc noqueue
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: tunl0: <NOARP> mtu 1480 qdisc noop
    link/ipip 0.0.0.0 brd 0.0.0.0
3: gre0: <NOARP> mtu 1476 qdisc noop
    link/gre 0.0.0.0 brd 0.0.0.0
10: eth0: <BROADCAST,MULTICAST,PROMISC,UP> mtu 1500 qdisc pfifo_fast
qlen 1000
    link/ether 00:07:d9:0d:67:5a brd ff:ff:ff:ff:ff:ff
11: eth1: <BROADCAST,MULTICAST,PROMISC,UP> mtu 1500 qdisc pfifo_fast
qlen 1000
    link/ether 00:07:d9:0d:67:03 brd ff:ff:ff:ff:ff:ff
12: br0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue
    link/ether 00:07:d9:0d:67:03 brd ff:ff:ff:ff:ff:ff
    inet 10.10.5.2/24 brd 10.10.5.255 scope global br0

iptables -L -nvx
Chain INPUT (policy ACCEPT 4484 packets, 330543 bytes)
    pkts      bytes target     prot opt in     out     source
     destination

Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
    pkts      bytes target     prot opt in     out     source
     destination

Chain OUTPUT (policy ACCEPT 4105 packets, 2046064 bytes)
    pkts      bytes target     prot opt in     out     source
     destination
_______________________________________________
Bridge mailing list
Bridge@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/bridge

