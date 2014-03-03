Return-Path: <vyasevich@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=ZOw7UUki8+92qTw0SK76ttx3hN3ifW2ACY26swgXXQ4=;
	b=gKBSZdO6jjPYt8aZ4UWPXgHoqSWOejJSB9XccnqRsoFU9Deeb+nVxPC0TUYT6zvKCF
	HLp2IIgfZFhYMnu5SyFdxs4mJJ+Lx8TswxxlkM+qoc3q9Y+p41rhPYQomk4S7PBqpBWj
	UM4bbKGST5zkb3Nz+frwnlviCgdePsXXZVlnhAbe1yEg5WASLkb4fHKP/9XumU0EcjGL
	/+PrNK4uTwMG3b9LJwInnItaswyBokWrfGsWdbBqBpDHix1z4CIv7o217Dzn3TzyZtD0
	ksUTP9RZL+TChxmlRgrylGkO1wnhO1jVpMa6IEXi1Cd/4MHaPRqPTgkOwxTrGLT+kAgj
	NXdA==
Message-ID: <5314F6D8.2050701@gmail.com>
Date: Mon, 03 Mar 2014 16:40:40 -0500
From: Vlad Yasevich <vyasevich@gmail.com>
MIME-Version: 1.0
References: <1566805413.12693479.1393872931017.JavaMail.zimbra@redhat.com>
	<2107636851.12713862.1393876035292.JavaMail.zimbra@redhat.com>
	<20140303212759.GW5090@Linus-Debian>
In-Reply-To: <20140303212759.GW5090@Linus-Debian>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] bridge is not forwaring ICMP6 neighbor solicitation to
	KVM guest
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?B?TGludXMgTMO8c3Npbmc=?= <linus.luessing@web.de>, Jan Stancek <jstancek@redhat.com>
Cc: netdev@vger.kernel.org, Florian Westphal <fwestpha@redhat.com>, bridge@lists.linux-foundation.org

On 03/03/2014 04:27 PM, Linus Lüssing wrote:
> Hi Jan,
> 
> On Mon, Mar 03, 2014 at 02:47:15PM -0500, Jan Stancek wrote:
>> I'm seeing an issue where bridge (sometimes) stops forwarding ICMP6
>> neighbor solicitation packets to KVM guest and as result KVM guest doesn't
>> respond with neighbor advertisement.
> 
> Hm, okay, that's not supposed to happen.
> 
>> The reason I think this packet is related is because when I send same exact
>> packet I'm often hitting same issue - bridge stops forwarding ICMP6 neigh.
>> solicitation packets to KVM guest.
> 
> Yes, the MLD query is kicking the multicast snooping into gear. If
> there's never a query, then snooping is basically disabled
> (compare: "bridge: disable snooping if there is no querier").
> 
>>
>> My current way to reproduce this is:
>> 0. host B IP / MAC is: 2620:52:0:1040:221:5aff:fe47:931c / 00:21:5a:47:93:1c
>>    guest IP / MAC is: 2620:52:0:1040:5056:ff:fe00:29 / 52:56:00:00:00:29
>> 1. host B is sending neigh solicit packets every 5 seconds with KVM guest IP
>>    using ns6 from ipv6toolkit: http://www.si6networks.com/tools/ipv6toolkit/
>>    with parameters:
>>    --src-address=2620:52:0:1040:221:5aff:fe47:931c --dst-address=ff02::1:ff00:0029
>>    -t 2620:52:0:1040:5056:ff:fe00:29 --link-src-address=00:21:5a:47:93:1c
>>    --source-lla-opt=00:21:5a:47:93:1c --link-dst-address=33:33:ff:00:00:29
>>    tcpdump running on guest can see both solicit and advertisement packets
>> 2. wait ~5 minutes
>> 3. host B sends Multicast Listener Query packet described above
>> 4. tcpdump running on guest is no longer seeing any neigh solicit packets
> 
> Just to clarify, host B is behind eno1 and vnet0 is directly
> connected to the interface of the guest, no additional bridge or
> anything else on top of that, right?
> 
> Would it be possible for you to upload the tcpdumps from host B
> (or if you can't tcpdump on host B, then capturing on eno1)
> and the guest somewhere and saying at which time/packet in the dumps
> it stops working (probably ~10 seconds after the query). Filtering
> for ICMPv6 should be sufficient. 
> 
> What I'm curious about is, whether the guest receives
> the MLD query and responds with an MLD report. I suspect that
> either the bridge doesn't get an MLD report and therefore is
> shutting down the according port or there's a bug in parsing the
> MLD report in the bridge code.
> 

I did notice a minor issue in the bridge code.  The following
code:
       /* Prevent flooding this packet if there is no listener present */
        if (!ipv6_addr_is_ll_all_nodes(&ip6h->daddr))
                BR_INPUT_SKB_CB(skb)->mrouters_only = 1;

        if (ip6h->nexthdr != IPPROTO_HOPOPTS ||
            ip6h->payload_len == 0)
                return 0;

will mark most multicast traffic is mrouters_only.  The two
statement should be probably be reversed.  However, that's shouldn't
cause the reported problem.

-vlad

> 
> Thanks for the detailed report so far!
> 
> Cheers, Linus
> 

