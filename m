Message-Id: <200501291536.j0TFabFU035757@inesrv3.ine.cuhk.edu.hk>
Date: Sat, 29 Jan 2005 23:36:36 +0800 (HKT)
From: "Peter S F Luk" <isfluk@ine.cuhk.edu.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Bridge] bridge psudeo vlan interface problem
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org
Cc: Peter S F Luk <isfluk@ine.cuhk.edu.hk>

Dear all,

I'm do some experiment of vlan bridging with Linux Fedore core 3 with a 3com 3c905 NIC

The config is as below:

vlan 3             vlan 4

        +-------+
eth0.3  |Linux  | eth0.4
--------|       |----
        +-------+


and I would like to bridge b/w vlan 3 and 4 using the fc3 linux box. Gateway :
192.168.1.254 is located at vlan3

The 3c905 NIC is connected to a trunk port of a cisco 2950 switch.

The command is used is :

#modprobe 8021Q
#vconfig add eth0 3
#vconfig add eth0 4
#brctl addbr br0
#brctl addif br0 eth0.3
#brctl addif br0 eth0.4
#ifconfig br0 192.168.1.1 netmask 255.255.255.0 up

There's no error but the bridge doesn't work. Hosts in vlan 4 can't communicate with hosts in vlan 3 and vice vera. The bridge can't ping the default gw either.

Can any one give adivse if this can be done or not ??

[PS: I have tried with 2 NICs and each connected to a vlan and the brdige work without any problem)

Thanks a lot.

Rgds.
Peter 
