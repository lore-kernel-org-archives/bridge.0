Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 36E806073E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C63C660739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1682409890; x=1685001890;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NjpvhDlUzs+FH6psAy6L7Qnb3qb5q6XYt4SuREIyvuo=;
 b=x/qDgxFZdquJgvVuoNG+pNaTL92jic7Eanbca1ZdZReiQXlMI29baH3v+qPXuohcdE
 8hYQNWArhq+TV20aJloFcvpsYUDc1XYtq8pfGYawLOvi926U83kZVrTrbSsqMvdDLy+i
 ceaXVI3DYXXHZU7VELiWPuugpCJ5YdGwgyg26U6mnIvYvXy4fIyFYWo0iQiyZVGI3Shs
 4eHSIVH+QJDzjIA0gdjpL/BB2vH/efLph/XpQwgH8rjBDtn9bRGhZRDVLMIzyNpUYzm5
 5kGuCu1Oy7Fy5CgFLy4tmrcik0+O/xEQGk8PTp50586SInTXeIcogLywQJZIdTgD0nhO
 1r+A==
Message-ID: <5ddac447-c268-e559-a8dc-08ae3d124352@blackwall.org>
Date: Tue, 25 Apr 2023 11:04:47 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <ZEZK9AkChoOF3Lys@Laptop-X1> <ZEakbR71vNuLnEFp@shredder>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZEakbR71vNuLnEFp@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [Question] Any plan to write/update the bridge doc?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>, Roopa Prabhu <roopa@nvidia.com>

On 24/04/2023 18:46, Ido Schimmel wrote:
> On Mon, Apr 24, 2023 at 05:25:08PM +0800, Hangbin Liu wrote:
>> Hi,
>>
>> Maybe someone already has asked. The only official Linux bridge document I
>> got is a very ancient wiki page[1] or the ip link man page[2][3]. As there are
>> many bridge stp/vlan/multicast paramegers. Should we add a detailed kernel
>> document about each parameter? The parameter showed in ip link page seems
>> a little brief.
> 
> I suggest improving the man pages instead of adding kernel
> documentation. The man pages are the most up to date resource and
> therefore the one users probably refer to the most. Also, it's already
> quite annoying to patch both "ip-link" and "bridge" man pages when
> adding bridge port options. Adding a third document and making sure all
> three resources are patched would be a nightmare...
> 
>>
>> I'd like to help do this work. But apparently neither my English nor my
>> understanding of the code is good enough. Anyway, if you want, I can help
>> write a draft version first and you (bridge maintainers) keep working on this.
> 
> I can help reviewing man page patches if you want. I'm going to send
> some soon. Will copy you.
> 
>>
>> [1] https://wiki.linuxfoundation.org/networking/bridge
>> [2] https://man7.org/linux/man-pages/man8/bridge.8.html
>> [3] https://man7.org/linux/man-pages/man8/ip-link.8.html
>>
>> Thanks
>> Hangbin

Always +1 for keeping the man pages up-to-date, but I tend to agree with Jakub as well
that it'd be nice to have an in-kernel doc which explains the uapi and potentially
at least some more obscure internals (if not all), we can insist on updating it
for new changes

I'd be happy to help fill such doc, but at the moment I don't have the
time to write the basis for it. As Hangbin nicely offered, I think we can start
there. For a start it'd be nice to make an initial outline of the different sections
and go on filling them from there.

E.g. as a starter something like (feel free to edit):
Introduction
Bridge internals (fdb, timers, MTU handling, fwding decisions, ports, synchronization)
STP (mst, rstp, timers, user-space stp etc)
Multicast (mdb, igmp, eht, vlan-mcast etc)
VLAN (filtering, options, tunnel...)
Switchdev
Netfilter
MRP/CFM (?)
FAQ

Each of these having uapi sections with descriptions. We can include references
to the iproute2 docs for cmd explanations and examples, but in this doc we'll have
the uapi descriptions and maybe some helpful information about internal implementation
that would save future contributors time.

At the very least we can do the uapi part for each section so options are described
and uapi nl attribute structures are explained.

Cheers,
 Nik

