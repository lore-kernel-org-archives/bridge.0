Message-ID: <4B23CB4E.7060808@free.fr>
Date: Sat, 12 Dec 2009 17:56:46 +0100
From: =?UTF-8?B?Tmljb2xhcyBkZSBQZXNsb8O8YW4=?=
 <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <aa3710a80912050411k43417309r9989f7df0eed1010@mail.gmail.com>
	<4B201D82.3060205@free.fr>
	<aa3710a80912120723s86eaf30s41c2e730ebb216c7@mail.gmail.com>
In-Reply-To: <aa3710a80912120723s86eaf30s41c2e730ebb216c7@mail.gmail.com>
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

Hi Radim,

> first thanks for your answer :). I'm impressed with your ascii art:).

Art is designed to be impressive ! :-D

> Sorry for my late answer , im currently ill.

> I've completed your ascii art to final scheme I intended to build from
> the first time
> 
> +----------------HOST-----------------------------+
> |                                                 |
> |                     10.0.0.1 --tap0--+          |
> |                                      |          |
> |                                      |          |
> |                                      +--br0     |
> | +-----VPC1------------------+        |          |
> | |                           |        |          |
> | |                  +--eth0--|--tap1--+          |
> | |    ip here  br0--+        |                   |
> | |                  +--eth1--|--tap2--+          |
> | |                           |        |          |
> | +---------------------------+        |          |
> |                                      +--br1     |
> | +-----VPC2------------------+        |          |
> | |                           |        |          |
> | |         10.0.0.2 +--eth0--|--tap3--+          |
> | |                           |                   |
> | +---------------------------+                   |
> +-------------------------------------------------+

If your thesis focus on profiling the bridge code, I would suggest you reduce the number of 
intermediate elements down to the lowest possible level.

 From my point of view, HOST/br0 is not required. You can configure the ip address of HOST/tap0 on 
HOST/tap1 instead and remove HOST/br0 and HOST/tap0.

+----------------HOST-----------------------------+
| +-----VPC1------------------+                   |
| |                           |                   |
| |                  +--eth0--|--tap1-- 10.0.0.1  |
| |    ip here  br0--+        |                   |
| |                  +--eth1--|--tap2--+          |
| |                           |        |          |
| +---------------------------+        |          |
|                                      +--br1     |
| +-----VPC2------------------+        |          |
| |                           |        |          |
| |         10.0.0.2 +--eth0--|--tap3--+          |
| |                           |                   |
| +---------------------------+                   |
+-------------------------------------------------+

Also, the tap devices are not leaking, but there are other potential leaking problems:

Until HOST/br1 know the right port to use to forward packets for a given mac address, it will 
forward the packet to all ports of the bridge. So, packets received from HOST/tap3, targeted at 
10.0.0.1, will be forwarded to HOST/tap2 AND to HOST/br1. If HOST has IP forwarding enabled (see 
/proc/sys/net/ipv4/ip_forward), then it might accept packets for 10.0.0.1 on HOST/br1, even if this 
IP address is setup on a different interface of HOST. You should use tcpdump or wireshark on br1 to 
watch what is received on this interface.

I'don't know if your VM software allow for such things, but the perfect configuration would be a 
"direct" link between VPC1 and VPC2, through a non-HOST network system.

For example, VirtualBox VM software provide such "direct" link, called "internal network".

+----------------HOST-----------------------------+
| +-----VPC1------------------+                   |
| |                           |                   |
| |                  +--eth0--|--tap1-- 10.0.0.1  |
| |    ip here  br0--+        |                   |
| |                  +--eth1--|--+                |
| |                           |  |                |
| +---------------------------+  |                |
|                                |                |
| +-----VPC2------------------+  |                |
| |                           |  |                |
| |         10.0.0.2 +--eth0--|--+                |
| |                           |                   |
| +---------------------------+                   |
+-------------------------------------------------+

And if such a "direct" link feature is available, then the perfect configuration for your test would 
be the following, which would give a totally isolated test environment.

+----------------HOST-----------------------------+
| +-----VPC3------------------+                   |
| |                           |                   |
| |         10.0.0.1 +--eth0--|--+                |
| |                           |  |                |
| +---------------------------+  |                |
|                                |                |
| +-----VPC1------------------+  |                |
| |                           |  |                |
| |                  +--eth0--|--+                |
| |             br0--+        |                   |
| |                  +--eth1--|--+                |
| |                           |  |                |
| +---------------------------+  |                |
|                                |                |
| +-----VPC2------------------+  |                |
| |                           |  |                |
| |         10.0.0.2 +--eth0--|--+                |
| |                           |                   |
| +---------------------------+                   |
+-------------------------------------------------+

With this configuration, you would be able to test the bridge code in a close to transparent way and 
even enhance the numbers of "clients" for the bridge (up to 8, in the case of VirtualBox).

And if stp or rstp is something you would like to play with, you can build two bridges with a loop.

+----------------HOST-------------------------------------------------------+
| +-----VPC3------------------+                                             |
| |                           |                                             |
| |         10.0.0.1 +--eth0--|-------+                                     |
| |                           |       |                                     |
| +---------------------------+       |                                     |
|                                     |                                     |
| +-----VPC1------------------+       |  +-----------VPC4-----------------+ |
| |                           |       |  |                                | |
| |                           |       +--|--eth2--+                       | |
| |                  +--eth0--|----------|--eth1--+                       | |
| |             br0--+        |          |        +--br0                  | |
| |                  +--eth1--|----------|--eth0--+                       | |
| |                  +--eth2--|--+       |                                | |
| |                           |  |       |                                | |
| +---------------------------+  |       +--------------------------------+ |
|                                |                                          |
| +-----VPC2------------------+  |                                          |
| |                           |  |                                          |
| |         10.0.0.2 +--eth0--|--+                                          |
| |                           |                                             |
| +---------------------------+                                             |
+---------------------------------------------------------------------------+

'hope this helps.

	Nicolas.

> I am really not sure now, but I would say there is no loop in there
> :/. But e.g. VPC2 can ping tap0 although VPC1 bridge is not
> configured. Is the problem taht tap0 is used directly? Should I start
> another VPC there ?
> 
> Thank you very much
> 
> Radim
> 
> On Wed, Dec 9, 2009 at 10:58 PM, Nicolas de Pesloüan
> <nicolas.2p.debian@free.fr> wrote:
>> Radim Roska wrote:
>>> Hi,
>> Hi Radim,
>>
>>> few weeks ago I asked question that was probably not interesting for you.
>>>
>>> Now ill put it differently.
>>>
>>> 2 computers - VPC and HOST
>>> VPC has 2 eth0 and eth1 interfaces (on host tap1 and tap2)
>>> HOST has 1 tap (tap0)
>>>
>>> HOST has br0 where tap0 and tap1 are bound
>>> VPC has br0 where eth0 and eth1 are bound
>>>
>>> tap1 has ip
>>> br0 on VPC has ip
>> Here is what I understand from your last post:
>>
>> +----------------HOST-----------------------------+
>> |                                                 |
>> |                         ???? --tap0--+          |
>> |                                      |          |
>> |                                      |          |
>> |                                      +--br0     |
>> | +-----VPC-------------------+        |          |
>> | |                           |        |          |
>> | |                  +--eth0--|--tap1--+ ip here  |
>> | |    ip here  br0--+        |                   |
>> | |                  +--eth1--|--tap2             |
>> | |                           |                   |
>> | +---------------------------+                   |
>> |                                                 |
>> +-------------------------------------------------+
>>
>> Can you confirm ? Please extend and possibly fix this ascii art to include you whole setup.
>>
>> If this is correct, then, the first possible problem comes from the fact that you should not put an ip on a member of a bridge but on the bridge itself. (br0 on HOST, not tap1 on HOST).
>>
>> Also, can you describe what you plan to do with tap2 on HOST and what process is managing the user-space side of tap0 on HOST ? Is it another VM ?
>>
>>> ping from VPC -> tap1:
>>>
>>> __ratelimit: 32575 callbacks suppressed
>>> eth0: received packed with own address as source address
>>> eth0: received packed with own address as source address
>>> eth0: received packed with own address as source address
>>> ...
>>>
>>> infinity loop stopped by command to turn on stp on VPC. This blocks eth0 -> port connected to bridge on HOST.
>>>
>>> No more problem with loop and VPC can actually ping HOST. Probably using eth1 which is not connected anywhere.
>>>
>>> So I assume that once packet is somewhere on a tap interface in the HOST. Thus its not possible to do little complicated network because all taps create a loop no matter how user connects them in bridges...is that right?
>> It is possible to do complicated network using VM and tap devices. Several tap devices are not leaking between them. But, if your configuration end up with two bridges face to face (one in the VM and one in the HOST) with two links between them, then you must enable stp on both bridge, in order to allow the bridges to detect and "fix" the loop.
>>
>> 'hope this help.
>>
>>        Nicolas.
>>
>>> I've lost big amount of time trying to make this working...so please make sure i dont lost even more :))
>>>
>>> Thanks
>>> Radim
>>>
>>>
>>>
>>> On Mon, Nov 23, 2009 at 11:12 PM, Radim Roska <radim.roska@gmail.com <mailto:radim.roska@gmail.com>> wrote:
>>>
>>>    Hello,
>>>
>>>    I have this very uncommon situation :). My diploma thesis will
>>>    probably be playing with linux kernel in various networks. Currently
>>>    I have little free time and limited computer resources -> only one
>>>    laptop :). But I would like to do some profiling of kernel
>>>    particularly of bridging part. For that i need network.
>>>
>>>    So i have 2 virtual machines VPC1 and VPC2 (running debian)
>>>
>>>    HOST - VPC1 - VPC2
>>>
>>>    VPC1 should act as bridge.
>>>    HOST: tap0 interface
>>>    VPC1:
>>>    eth0 ~ tap1 on host
>>>    eth1 ~ tap2 on host
>>>    VPC2:
>>>    eth0 ~ tap3 on host
>>>
>>>    how to connect it? :) Well tap0 - tap1 is in br0 on host and tap2 +
>>>    tap3 is on br1.
>>>
>>>    VPC1 than has eth0 and eth1 in bridge also :).
>>>
>>>    I know..it looks strange..but i thought its simplest :).
>>>
>>>    But:
>>>
>>>    1) although VPC2 is connected through br1 that has connection only
>>>    with tap2=eth1 on VPC1..I can ping anything even when VPC1 has all
>>>    interfaces down
>>>
>>>    2) i dont see any loop in my "network" but anyway once i turn on
>>>    br0  without stp on VPC1, i got quite a serious perf problem -
>>>    little storm i guess:).
>>>    starting stp solves storm but disables eth0
>>>    [ 3839.200640] br0: starting userspace STP failed, starting kernel STP
>>>    [ 3839.201388] br0: topology change detected, sending tcn bpdu
>>>    [ 3839.202117] br0: port 2(eth0) entering blocking state
>>>
>>>    i does not matter if i have stp on HOST's br0/br1
>>>
>>>    If someone would have time to help me with that I'll be very happy
>>>    :). Its possible Im trying approach that is doomed to fail because i
>>>    dont know/understsand something.
>>>
>>>    Cheers,
>>>    Radim
>>>
>>>
>>>
>>>
>>> --
>>> Radim Roška
>>>
>>>
>>> ------------------------------------------------------------------------
>>>
>>> _______________________________________________
>>> Bridge mailing list
>>> Bridge@lists.linux-foundation.org
>>> https://lists.linux-foundation.org/mailman/listinfo/bridge
> 
> 
> 
> --
> Radim Roška

