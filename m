Message-ID: <4B1AA695.2090009@free.fr>
Date: Sat, 05 Dec 2009 19:29:41 +0100
From: =?UTF-8?B?Tmljb2xhcyBkZSBQZXNsb8O8YW4=?=
 <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <aa3710a80912050411k43417309r9989f7df0eed1010@mail.gmail.com>
In-Reply-To: <aa3710a80912050411k43417309r9989f7df0eed1010@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
> 
> few weeks ago I asked question that was probably not interesting for you.

I don't know for the other readers of this mailing list, but even after reading both posts twice, I 
still don't understand what you are trying to do.

This might be the reason why you didn't received any answer for your first post.

Please, do not only focus on you setup, but also describe the expected effects.

	Nicolas.

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
> 
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
> 
> I've lost big amount of time trying to make this working...so please 
> make sure i dont lost even more :))
> 
> Thanks
> Radim
> 
