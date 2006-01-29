Message-ID: <43DD4637.7090101@artcom.pl>
Date: Sun, 29 Jan 2006 23:48:23 +0100
From: =?UTF-8?B?UGF3ZcWCIFN0YXN6ZXdza2k=?= <pstaszewski@artcom.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Performance problem with linux bridge ... compare kernel
 2.6.13.4 to 2.6.15.1 
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Bridge List <bridge@lists.osdl.org>

With kernel 2.6.13.4 linux bridge with traffic management for 4000users 
and 20.4 MB/s(tx)/22.4 MB/s(rx) data load of CPU is max 50%
With kernel 2.6.15.1 the same linux bridge with the same traffic has 
100% CPU load and in top I have ksoftirqd proccess.



The machine is P4 3.2 GHz with 1GB of ram and 4 NetGear 620 cards


The config is:

/sbin/modprobe acenic link=0x0100,0x0100,0x0100,0x0100 
tx_coal_tick=256,256,256,256 rx_coal_tick=256,256,256,256 
max_rx_desc=512,512,512,512 max_tx_desc=512,512,512,512


/sbin/ifconfig eth0 0.0.0.0 txqueuelen 10000 mtu 1500 up
/sbin/ifconfig eth1 0.0.0.0 txqueuelen 10000 mtu 1500 up
/sbin/ifconfig eth2 0.0.0.0 txqueuelen 10000 mtu 1500 up
/sbin/ifconfig eth3 0.0.0.0 txqueuelen 10000 mtu 1500 up

#To bond0
/sbin/ifconfig eth0 down
/sbin/ifconfig eth2 down

#To bond1
/sbin/ifconfig eth1 down
/sbin/ifconfig eth3 down

modprobe bonding max_bonds=2

ifconfig bond0 0.0.0.0 up

ifenslave-2.6 bond0 eth0 eth2

ifconfig bond1 0.0.0.0 up

ifenslave-2.6 bond1 eth1 eth3


/usr/local/sbin/brctl addbr br999

/sbin/vconfig add bond0 999
/sbin/vconfig add bond1 999
/sbin/ifconfig bond0.999 up
/sbin/ifconfig bond1.999 up

/usr/local/sbin/brctl addif br999 bond0.999
/usr/local/sbin/brctl addif br999 bond1.999
/sbin/ifconfig br999 up


Host has 102 vlans (bridges)
On each vlan interface is traffic management (iproute2 with hashing filters)


