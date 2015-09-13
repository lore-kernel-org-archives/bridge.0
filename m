Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:subject:to:references:cc:message-id:date:user-agent
	:mime-version:in-reply-to:content-type:content-transfer-encoding;
	bh=oA8cs2dcP5/D4fHJw3+b1dQiPnjDGv2NsTfNzYGt7fI=;
	b=E1FIJLjDZIeRbDqqeWUBAg4xGKhw0XP6ovrEiqFNk1sPkHeknl40aQlUFuVyK2OUtK
	2BigN9WBYl7mQCiTXvc3J5Q754+MwoIE3XQc13DJ/6KYtlidyCCU+Ei4TQFbhbFPxtVF
	PjALez7M6c6NSkqGWkyARmzdXz1t0phg5d5cM=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
References: <1440549295-3979-1-git-send-email-razor@blackwall.org>
	<20150825.194222.390859854071446877.davem@davemloft.net>
	<E065D3DC-6CBC-4625-8800-5133E21C5483@cumulusnetworks.com>
	<20150825.230641.773630246486190390.davem@davemloft.net>
	<AB16F445-DCA7-437E-B6E1-B70FDC63E55A@cumulusnetworks.com>
	<55DE98AF.8000503@cumulusnetworks.com>
	<2125A434-6529-4D5A-BA6B-9F64C6B7A8C0@cumulusnetworks.com>
	<55DFA1A3.30601@redhat.com>
	<691CF770-DDF3-4AC9-B99C-9640992037C5@cumulusnetworks.com>
	<55E05486.5090500@redhat.com>
	<B05F9EE8-169A-4E9E-8929-24ED64F8EBE9@cumulusnetworks.com>
	<55E106DC.5040802@redhat.com>
Message-ID: <55F578AB.9000705@cumulusnetworks.com>
Date: Sun, 13 Sep 2015 15:22:51 +0200
MIME-Version: 1.0
In-Reply-To: <55E106DC.5040802@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
To: vyasevic@redhat.com
Cc: bridge@lists.linux-foundation.org, netdev@vger.kernel.org, roopa <roopa@cumulusnetworks.com>, wkok@cumulusnetworks.com, David Miller <davem@davemloft.net>

On 08/29/2015 03:11 AM, Vlad Yasevich wrote:
> On 08/28/2015 11:26 AM, Nikolay Aleksandrov wrote:
>>
>>> On Aug 28, 2015, at 5:31 AM, Vlad Yasevich <vyasevic@redhat.com> wrote:
>>>
>>> On 08/27/2015 10:17 PM, Nikolay Aleksandrov wrote:
<<<snip>>>
>>>
>>> I don't remember learning being all that complicated.  The hash only changed under
>>> rtnl when vlans were added/removed.  The nice this is that we wouldn't need
>>> to rebalance, because if the vlan is removed all fdb links get removed too.  They
>>> don't move to another bucket (But that was with static hash.  Need to look at rhash in
>>> more detail).
>>>
>>> If you want, I might still have patches hanging around on my machine that had a hash
>>> table implementation.  I can send them to you.
>>>
>>> -vlad
>>>
>>
>> :-) Okay, I’m putting the crystal ball away. If you could send me these patches it’d be great so
>> I don’t have to start this from scratch.
>>
> 
> So, I forgot that I lost an old disk that had all that code, so I am a bit bummed about
> that.  I did however find the series that got posted.
> http://www.spinics.net/lists/netdev/msg219737.html
> 
> That was the series where I briefly switch from bitmaps to hash and list.
> However, I see that the fdb code that was playing with never got posted...
> 
> Sorry.
> 
> -vlad
> 

So I've been looking into this for some time now and did a basic implementation of vlan handling
using rhashtables, here are some thoughts and a slightly different proposition.
First a few scenarios (the memory footprint is only the extra memory needed for the
vlans):
Current memory footprint for 48 ports & 2000 vlans ~ 50k

1. Bridge with vlan hash with port bitmaps (similar to Vlad's first set)
- On input we have hash lookup + bitmap lookup
- If (r)hashtable is used we need additional list to handle stable list walks which are
needed all over the place from error handling to compressed vlan dumps which actually
need this list to be kept sorted since the already exposed user interfaces need to
be handled without visible changes, but they also allow for per-port vlan compressed
dumping which isn't easy to handle. Mostly the stability issue with rhashtable
is with resizing since these entries change only under rtnl, also we need the sorted
order because of the compressed dump. One alternative way to solve this is to build the
sorted list each time a dump is requested, but again this falls under the workarounds
needed to satisfy current behaviour requirements.
If this is chosen my preference is to have the vlans also in a list which is kept sorted
for the walks, then the compressed request can be satisfied easier.
- memory footprint for 2000 vlans with 48 ports ~ 1.5 MB

2. Bridge with vlan hash, ports with vlan hashes (need a special per-port struct because
of the tagged/untagged case, we basically need per-port per-vlan flags)
- On input we have 1 hash lookup only from the port vlan hash where get a pointer
to the bridge's vlan entry so we get the global vlan context as well as the local
- Same rhashtable handling requirements apply + more complexity & memory due to having
to keep in sync multiple (per-port, per-bridge global) rhashtables
- memory footprint for 2000 vlans with 48 ports ~ 2.6 MB

Up until now I've done partially point 1 to see how much churn it would take and the
basic change is huge. Also the memory footprint increases a lot.
So I'd propose a third option which you may call middle ground between the current
implementation (which is very fast and compact) and points 1 & 2:

What do you think about adding an auxiliary per-vlan global context using rhashtable
which is not used in the ingress/egress decision making ? We can contain it
via either a Kconfig option (so it can be compiled out) or via a dynamic run-time option
so people who would like more features can enabled it on demand and are willing to
trade some performance and memory.
This way we won't have to change most of the current API and won't have to add workarounds
to keep the user-facing behaviour the same, also the syncing is reduced to
a refcount and the memory footprint is kept minimal.
The initial new features I'd like to introduce are per-vlan counters and also per-vlan
flags which at first will be used to enable/disable multicast on a vlan basis.
In terms of performance if this is enabled it is close to point 1 but without the changes
all over the API and more importantly with much less memory footprint.
The memory footprint of this option with 2000 vlans & 48 ports ~ +70k (without the per-cpu
counters, any additional feature will naturally add to this). This is because we don't
have a per-port increase for each vlan added and only keep the global context.

If it's acceptable to take the performance/memory hit and the huge churn, then I can continue
with 1 or 2, but I'm not a big fan of that idea.

Feedback before I go any further on this would be much appreciated.

Thank you,
 Nik
