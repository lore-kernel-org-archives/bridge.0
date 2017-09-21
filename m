Return-Path: <vincent@bernat.im>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bernat.im; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=postfix; bh=h021K7A6v7d4CBOCo/8Xjyd1dnk=; b=YOg
	OnxIXd1JLthDlpKFCKigiMjwqrv+k0t4kColl/ywh6vcfxtPfCsXcE9DElOiDHmN
	3FdgS0qwfW7CkNH4y2H8mJ2TUjShjo6p1n0P8UsSugBV1ymJHd+geKEwBp74Ry+B
	+O9Y11+yswv2MgBTVBMaeKA+marK0M2BUVVjN2gA=
From: Vincent Bernat <vincent@bernat.im>
References: <m3zi9vbrfp.fsf@luffy.cx>
	<20170916141833.28344-1-vincent@bernat.im>
	<20170920.140956.781667692297467325.davem@davemloft.net>
	<16e5566a-909d-ba83-7637-1fb6c93126bc@gmail.com>
	<20170920162140.369bb198@xeon-e3> <87h8vw5pwg.fsf@luffy.cx>
	<CAJieiUgKO-O3YFc3iTQXMmXc287RGgw4FjYhaLn-7+pmA_Fh+g@mail.gmail.com>
In-Reply-To: <CAJieiUgKO-O3YFc3iTQXMmXc287RGgw4FjYhaLn-7+pmA_Fh+g@mail.gmail.com>
	(Roopa Prabhu's message of "Thu, 21 Sep 2017 08:09:28 -0700")
Message-ID: <87vakc3w6j.fsf@luffy.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next v2] bridge: also trigger RTM_NEWLINK
	when interface is released from bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Thu, 21 Sep 2017 15:31:35 -0000
To: Roopa Prabhu <roopa@cumulusnetworks.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>, David Ahern <dsahern@gmail.com>

 =E2=9D=A6 21 septembre 2017 08:09 -0700, Roopa Prabhu <roopa@cumulusnetwor=
ks.com>=C2=A0:

>>> The one concern is that ports added or removed through ioctl should
>>> cause same events as doing the same thing via netlink. Some users use
>>> brctl (ioctl) and others use newer bridge (netlink) API.
>>
>> I'll make a third iteration to have the same notifications when using
>> ioctl() with details in the commit message.
>> --
>
> as long as the ioctl path for bridge port removal is generating a:
> RTM_DELLINK with AF_BRIDGE and
> RTM_NEWLINK with AF_UNSPEC with 'master' removed
>
> we should be good. These are the most important ones.
>
> are there other specific bridge-events missing ?. you might want to
> run `bridge monitor link` also. and un-slaving of a port also triggers
> fdb events which are visible under `bridge monitor fdb`

With the patch, bridge monitor link generates the same event with
ioctl() than with netlink (like for ip monitor link, netlink generates
one extra duplicate event when enslaving).

For bridge monitor fdb, there is a difference. With ioctl(), I don't get
the event for VLAN1:

Deleted ca:18:06:bc:f6:11 dev dummy1 vlan 1 master bridge0 permanent

I suppose this is an expected difference due to the inability to manage
VLAN-aware bridges with ioctl().
--=20
Use the fundamental control flow constructs.
            - The Elements of Programming Style (Kernighan & Plauger)
