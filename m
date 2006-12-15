Date: Fri, 15 Dec 2006 15:32:13 +0100
From: Ion Alberdi <ialberdi@laas.fr>
Message-ID: <20061215143213.GB17538@laas.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] Virtual network and bridges
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hi everybody !

I'll try to explain first what I would like to do with the functionalities of tap and bridge interfaces, qemu, some isos(I used slax(slackware live cd))
and the forwarding mechanisms of the Linux kernel.

I'd like to simulate such a network:
        Internet        
          | 
   (eth0:@public address) 
         * host *
          |
         br0 (@192.168.0.254)
          |
    tap0      ...                  NETWORK 192.168.0.0/24
     |              
    qemu_nic1(@192.168.0.5)
  * QEMU1 *
    qemu_nic2@(192.168.1.254)
     |
    tap1
          |
         br1                      NETWORK 192.168.1.0/24
          |
    tap2    ....
     |
    qemu_nic3@(192.168.1.5)
   * QEMU 2*
	
(I hope this picture has been properly displayed on your mail clients...)

To do that I created the two bridges  added tap0 to br0,  tap1 and tap2 to br1, put routing tables:
on * host*:
Destination           Gateway           Genmask         Flags Metric Ref    Use Iface
192.168.0.0             *               255.255.255.0    U     0      0        0 br0
192.168.1.0           192.168.0.5       255.255.255.0    UG    0      0        0 br0
<public_add_network>      *           <public_add_mac>   U     0      0        0 eth0
default               gateway            0.0.0.0         UG    0      0        0 eth0

on * QEMU 1*:
Destination           Gateway           Genmask         Flags Metric Ref    Use Iface
192.168.0.0            *                255.255.255.0   U      0      0       0 eth0
192.168.1.0            *                255.255.255.0   U      0      0       0 eth1 
loopback               *                255.0.0.0       U      0      0       0 lo
default               192.168.0.254     0.0.0.0         UG     0      0       0 eth0

on *QEMU 2*:
Destination           Gateway           Genmask         Flags Metric Ref    Use Iface
192.168.0.0            *                255.255.255.0   U      0      0       0 eth0
loopback               *                255.0.0.0       U      0      0       0 lo
default               192.168.0.254       0.0.0.0         UG     0      0       0 eth0

I put 1 to /proc/sys/net/ip4/ip_forward to QEMU 1 and QEMU 2 and host, and here are the results I have:
I can ping all the computers from all the hosts.

Then I wanted to give internet access to everybody, so I added the rule:
iptables -A POSTROUTING -o eth0 -j SNAT --to-source <public_internet_address>.

The results: QEMU1 can access the net but not QEMU2, apparently netfilter doesn't want to 
SNAT packets coming from QEMU2.(the packets are sent (from what I saw in tcpdump), with
the source address 192.168.1.5 to the internet).

So I investigated the problem and after adding some printks in the netfilter code I saw that in syslog(after ping ing google from QEMU1 and QEMU2):

Dec 15 13:26:52 localhost kernel: *ipt_do_table* treating 192.168.0.5
Dec 15 13:26:52 localhost kernel: *ipt_do_table* interfaces in:br0,out:
Dec 15 13:26:52 localhost kernel: *ipt_do_table* treating 192.168.0.5
Dec 15 13:26:52 localhost kernel: *ipt_do_table* interfaces in:br0,out:eth0
Dec 15 13:26:52 localhost kernel: *ipt_do_table* treating 192.168.0.5
Dec 15 13:26:52 localhost kernel: *ipt_do_table* interfaces in:,out:eth0
Dec 15 13:26:52 localhost kernel: *ipt_do_table* we are applying the target SNAT
Dec 15 13:26:52 localhost kernel: *ipt_snat_target* hooknum:4 source:192.168.0.5
Dec 15 13:26:52 localhost kernel: *ipt_snat_target* from interface:<NULL> to interface:eth0
Dec 15 13:26:52 localhost kernel: *manip_pkt* changing packet 192.168.0.5 into 140.93.64.76
...
Dec 15 13:31:47 localhost kernel: *ipt_do_table* treating 192.168.1.5
Dec 15 13:31:47 localhost kernel: *ipt_do_table* interfaces in:br1,out:
Dec 15 13:31:47 localhost kernel: *ipt_do_table* treating 192.168.1.5
Dec 15 13:31:47 localhost kernel: *ipt_do_table* interfaces in:br1,out:br1
Dec 15 13:31:47 localhost kernel: *ipt_do_table* treating 192.168.1.5
Dec 15 13:31:47 localhost kernel: *ipt_do_table* interfaces in:,out:br1
Dec 15 13:31:47 localhost kernel: *ipt_do_table* treating 192.168.1.5
Dec 15 13:31:47 localhost kernel: *ipt_do_table* interfaces in:br0,out:eth0
...

So aparently, from QEMU2, the packets don't pass to the state "interfaces in:null,out:eth0", which seems to be the state
that netfilter matches with "-o eth0", and so the packet isn't natted.

I would like to know if there is a reason why packets from QEMU2 don't pass in this state, whereas they are with QEMU1, 
and of course I would like to know all the dumb things I have done implementing this architecture :-D.

Anyway big thanks to all the contributors of bridge and tun/tap devices, 
for having added this functionnality to the linux kernel, after this problem is solved, it will 
be perfect for what I want to do :-D. 

Best regards.



-- 
Ion Alberdi
LAAS/CNRS - Groupe OLC
Email: ialberdi[at]laas.fr
