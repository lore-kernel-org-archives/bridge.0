Message-ID: <4B201D82.3060205@free.fr>
Date: Wed, 09 Dec 2009 22:58:26 +0100
From: =?UTF-8?B?Tmljb2xhcyBkZSBQZXNsb8O8YW4=?=
 <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <aa3710a80912050411k43417309r9989f7df0eed1010@mail.gmail.com>
In-Reply-To: <aa3710a80912050411k43417309r9989f7df0eed1010@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] how bridge interacts with tap ifaces?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Radim Roska <radim.roska@gmail.com>
Cc: bridge@lists.linux-foundation.org

Radim Roska wrote:
> Hi,

Hi Radim,

> few weeks ago I asked question that was probably not interesting for you.
> 
> Now ill put it differently.
> 
> 2 computers - VPC and HOST
> VPC has 2 eth0 and eth1 interfaces (on host tap1 and tap2)
> HOST has 1 tap (tap0)
> 
> HOST has br0 where tap0 and tap1 are bound
> VPC has br0 where eth0 and eth1 are bound
> 
> tap1 has ip
> br0 on VPC has ip

Here is what I understand from your last post:

+----------------HOST-----------------------------+
|                                                 |
|                         ???? --tap0--+          |
|                                      |          |
|                                      |          |
|                                      +--br0     |
| +-----VPC-------------------+        |          |
| |                           |        |          |
| |                  +--eth0--|--tap1--+ ip here  |
| |    ip here  br0--+        |                   |
| |                  +--eth1--|--tap2             |
| |                           |                   |
| +---------------------------+                   |
|                                                 |
+-------------------------------------------------+

Can you confirm ? Please extend and possibly fix this ascii art to include you whole setup.

If this is correct, then, the first possible problem comes from the fact that you should not put an 
ip on a member of a bridge but on the bridge itself. (br0 on HOST, not tap1 on HOST).

Also, can you describe what you plan to do with tap2 on HOST and what process is managing the 
user-space side of tap0 on HOST ? Is it another VM ?

> ping from VPC -> tap1:
> 
> __ratelimit: 32575 callbacks suppressed
> eth0: received packed with own address as source address
> eth0: received packed with own address as source address
> eth0: received packed with own address as source address
> ...
> 
> infinity loop stopped by command to turn on stp on VPC. This blocks eth0 
> -> port connected to bridge on HOST.
> 
> No more problem with loop and VPC can actually ping HOST. Probably using 
> eth1 which is not connected anywhere.
> 
> So I assume that once packet is somewhere on a tap interface in the 
> HOST. Thus its not possible to do little complicated network because all 
> taps create a loop no matter how user connects them in bridges...is that 
> right?

It is possible to do complicated network using VM and tap devices. Several tap devices are not 
leaking between them. But, if your configuration end up with two bridges face to face (one in the VM 
and one in the HOST) with two links between them, then you must enable stp on both bridge, in order 
to allow the bridges to detect and "fix" the loop.

'hope this help.

	Nicolas.

> I've lost big amount of time trying to make this working...so please 
> make sure i dont lost even more :))
> 
> Thanks
> Radim
> 
> 
> 
> On Mon, Nov 23, 2009 at 11:12 PM, Radim Roska <radim.roska@gmail.com 
> <mailto:radim.roska@gmail.com>> wrote:
> 
>     Hello,
> 
>     I have this very uncommon situation :). My diploma thesis will
>     probably be playing with linux kernel in various networks. Currently
>     I have little free time and limited computer resources -> only one
>     laptop :). But I would like to do some profiling of kernel
>     particularly of bridging part. For that i need network.
> 
>     So i have 2 virtual machines VPC1 and VPC2 (running debian)
> 
>     HOST - VPC1 - VPC2
> 
>     VPC1 should act as bridge.
>     HOST: tap0 interface
>     VPC1:
>     eth0 ~ tap1 on host
>     eth1 ~ tap2 on host
>     VPC2:
>     eth0 ~ tap3 on host
> 
>     how to connect it? :) Well tap0 - tap1 is in br0 on host and tap2 +
>     tap3 is on br1.
> 
>     VPC1 than has eth0 and eth1 in bridge also :).
> 
>     I know..it looks strange..but i thought its simplest :).
> 
>     But:
> 
>     1) although VPC2 is connected through br1 that has connection only
>     with tap2=eth1 on VPC1..I can ping anything even when VPC1 has all
>     interfaces down
> 
>     2) i dont see any loop in my "network" but anyway once i turn on
>     br0  without stp on VPC1, i got quite a serious perf problem -
>     little storm i guess:).
>     starting stp solves storm but disables eth0
>     [ 3839.200640] br0: starting userspace STP failed, starting kernel STP
>     [ 3839.201388] br0: topology change detected, sending tcn bpdu
>     [ 3839.202117] br0: port 2(eth0) entering blocking state
> 
>     i does not matter if i have stp on HOST's br0/br1
> 
>     If someone would have time to help me with that I'll be very happy
>     :). Its possible Im trying approach that is doomed to fail because i
>     dont know/understsand something.
> 
>     Cheers,
>     Radim
> 
> 
> 
> 
> -- 
> Radim Roška
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge

