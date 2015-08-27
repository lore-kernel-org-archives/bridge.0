Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=content-type:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=SQVE6lAKJPwwph9cq8nVuiVlQMbg6Ybk5Vb3NRyxeIw=;
	b=TOPkr5qDBn82EMmBSNJ5z7qyNjiTujpmotJDcbRuSCdeAGK2euw+jxgpa0jh1W7Wma
	xGRwywix/5iGJcfsD8N7ASCCvzKC8JXE0QO3R87mwcj1ARSwffR7pvVukIu97nc1Cktf
	fvFf1lEQuM+FEnHLi5Lrk68aI6TBfexlZvlMQ=
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
In-Reply-To: <55DE98AF.8000503@cumulusnetworks.com>
Date: Thu, 27 Aug 2015 14:02:05 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <2125A434-6529-4D5A-BA6B-9F64C6B7A8C0@cumulusnetworks.com>
References: <1440549295-3979-1-git-send-email-razor@blackwall.org>
	<20150825.194222.390859854071446877.davem@davemloft.net>
	<E065D3DC-6CBC-4625-8800-5133E21C5483@cumulusnetworks.com>
	<20150825.230641.773630246486190390.davem@davemloft.net>
	<AB16F445-DCA7-437E-B6E1-B70FDC63E55A@cumulusnetworks.com>
	<55DE98AF.8000503@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net-next v2] bridge: vlan: allow to suppress
	local mac install for all vlans
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: roopa <roopa@cumulusnetworks.com>
Cc: vyasevic@redhat.com, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, wkok@cumulusnetworks.com, David Miller <davem@davemloft.net>


> On Aug 26, 2015, at 9:57 PM, roopa <roopa@cumulusnetworks.com> wrote:
>=20
> On 8/26/15, 4:33 AM, Nikolay Aleksandrov wrote:
>>> On Aug 25, 2015, at 11:06 PM, David Miller <davem@davemloft.net> =
wrote:
>>>=20
>>> From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>>> Date: Tue, 25 Aug 2015 22:28:16 -0700
>>>=20
>>>> Certainly, that should be done and I will look into it, but the
>>>> essence of this patch is a bit different. The problem here is not
>>>> the size of the fdb entries, it=E2=80=99s more the number of them - =
having
>>>> 96000 entries (even if they were 1 byte ones) is just way too much
>>>> especially when the fdb hash size is small and static. We could =
work
>>>> on making it dynamic though, but still these type of local entries
>>>> per vlan per port can easily be avoided with this option.
>>> 96000 bits can be stored in 12k.  Get where I'm going with this?
>>>=20
>>> Look at the problem sideways.
>> Oh okay, I misunderstood your previous comment. I=E2=80=99ll look =
into that.
>>=20
> I just wanted to add the other problems we have had with keeping these =
macs (mostly from userspace POV):
> - add/del netlink notification storms
> - and large netlink dumps
>=20
> In addition to in-kernel optimizations, will be nice to have a =
solution that reduces the burden on userspace. That will need a newer =
netlink dump format for fdbs. Considering all the changes needed, =
Nikolays patch seems less intrusive.

Right, we need to take these into account as well. I=E2=80=99ll continue =
the discussion on this (or restart it) because
I looked into using a bitmap for the local entries only and while it =
fixes the scalability issue, it presents
a few new ones which are mostly related to the fact that these entries =
now exist only without a vlan
and if a new mac comes along which matches one of these but is in a =
vlan, the entry will get created
in br_fdb_update() unless we add a second lookup, but that will slow =
down the learning path.
Also this change requires an update of every fdb function that uses the =
vid as a key (every fdb function?!)
because now we can have the mac in two places instead of one which is a =
pretty big churn with lots
of conditionals all over the place and I don=E2=80=99t like it. Adding =
this complexity for the local addresses only
seems like an overkill, so I think to drop this issue for now.
This patch (that works around the initial problem) also has these =
issues.
Note that one way to take care of this in a more straight-forward way =
would be to have each entry
with some sort of a bitmap (like Vlad has tried earlier) and then we can =
combine the paths so most
of these issues disappear, but that will not be easy as was already =
commented earlier. I=E2=80=99ve looked
briefly into doing this with rhashtable so we can keep the memory =
footprint for each entry relatively
small but it still affects the performance and we can have thousands of =
resizes happening.=20

On the notification side if we can fix that, we can actually delete the =
96000 entries without creating a
huge notification storm and do a user-land workaround of the original =
issue, so I=E2=80=99ll look into that next.

Any comments or ideas are very welcome.

Thank you,
 Nik

