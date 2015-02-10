Return-Path: <g.danti@assyoma.it>
Message-ID: <54DA4E5F.3090800@assyoma.it>
Date: Tue, 10 Feb 2015 19:30:55 +0100
From: Gionatan Danti <g.danti@assyoma.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] VLAN tagged traffic and different behavior on two CentOS
 6.6 boxes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi list,
I have a bridged KVM setup where I would trunk both tagged and untagged 
traffic. In other words, some VMs will reside on the untagged portion, 
while other on the tagged one.

I have two CentOS 6.6 boxes that behave quite differently each other and 
I can not understand why. On both boxes I have:
- an eth0 interface bridged to lanbr0
- an eth0.10 interface bridged to lanbr10

 From what I read here [1] and here [2], to have a working setup I need 
to create an ebtables rules similar to "ebtables -t broute -A BROUTING 
-p 802_1Q -i eth0 -j DROP". On the first system, until I create that 
rules I can not ping the lanbr10 interface (from another system).

But on the second system, after some 20-25 seconds (less if I disable 
STP on the bridge) I can ping the lanbr10 interface even _without_ the 
ebtables rules above.

How that is possibile? Why the second box seems to auto-configure it 
while the first one need the ebtables rule? I hope this is the right list...

Thanks.

[1] http://ebtables.netfilter.org/misc/brnf-faq.html
[2] http://www.rackspace.com/blog/vms-vlans-and-bridges-oh-my-part-2/

Additional informations:

FIRST BOX:
[root@singularity ~]# ifconfig eth0.10 0.0.0.0
[root@singularity ~]# brctl addbr lanbr10
[root@singularity ~]# brctl addif lanbr10 eth0.10
[root@singularity ~]# ifconfig lanbr10 10.0.0.100 netmask 255.255.255.0
[root@singularity ~]# brctl show
bridge name	bridge id		STP enabled	interfaces
dmzbr0		8000.00a0d213ef5d	yes		eth1
							vnet0
							vnet4
							vnet7
lanbr0		8000.002522027e10	yes		eth0
							vnet1
							vnet2
							vnet3
							vnet5
lanbr10		8000.002522027e10	no		eth0.10
virbr0		8000.5254005a0aac	yes		virbr0-nic


SECOND BOX:
[root@kvm-black ~]# brctl addbr lanbr10
[root@kvm-black ~]# brctl addif lanbr10 eth0.10
[root@kvm-black ~]# ifconfig lanbr10 10.0.0.85 netmask 255.255.255.0
[root@kvm-black ~]# brctl show
bridge name	bridge id		STP enabled	interfaces
lanbr		8000.0022196645d4	yes		eth0
lanbr10		8000.0022196645d4	no		eth0.10


-- 
Danti Gionatan
Supporto Tecnico
Assyoma S.r.l. - www.assyoma.it
email: g.danti@assyoma.it - info@assyoma.it
GPG public key ID: FF5F32A8
