Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=A2XRvmIGWanU6agmUD34Iq+Pjvv83gF45WqzLE6lxsk=;
	b=AKWe2Qpd09z4Br3F2mTCr4lQmiRJP2gHNLCazrO2fzI/sLV9/htF9iHCARJkPnDCTL
	isnxSj3fB7jX0BcXkfPim/UoNgyCivSpAZjBzG6G4Thmgt+MtqXEaJK18b2FV8Nh9ke9
	H/Ep8XKWegOPcBbCHCOPEGkzprbyPzhQpf+44=
References: <1467051048-32604-1-git-send-email-nikolay@cumulusnetworks.com>
	<20160628110321.GA3221@otheros>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <5772673F.8010808@cumulusnetworks.com>
Date: Tue, 28 Jun 2016 14:02:07 +0200
MIME-Version: 1.0
In-Reply-To: <20160628110321.GA3221@otheros>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: add support for IGMP/MLD
 stats and export them via netlink
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 28/06/16 13:03, Linus Lüssing wrote:
> On Mon, Jun 27, 2016 at 08:10:48PM +0200, Nikolay Aleksandrov via Bridge wrote:
>> These are invaluable when monitoring or debugging complex multicast setups
>> with bridges.
> 
> Indeed! Great patch :). Especially if people are unable to provide
> pcap files for debugging (due to whatever reason). Hopefully that
> will help with bugzilla ticket #99081, too...
> 
> I know it might not quite fit into your current patch, which simply
> stores the ICMPv6 and IGMP type in the bridge private skb->cb, but
> do you think you could count and export the following two more
> things, too:
> 
> * MLDv1 vs. MLDv2 querier (and IGMP accordingly)
> * Number of (potential) MLD/IGMP parse errors
>   (e.g. beginning of br_multicast_ipv{4,6}_rcv():
>    http://lxr.free-electrons.com/source/net/bridge/br_multicast.c?v=4.5#L1588 and
>    http://lxr.free-electrons.com/source/net/bridge/br_multicast.c?v=4.5#L1634)
> 
> The former would help to know how the network is expected to
> behave (for instance whether you should see MLDv2 reports at all or
> whether / how much report suppression to expect).
> 
> The latter would help to spot either potential IGMP/MLD parsing bugs in
> the bridge or malformed IGMP/MLD messages send by someone else.
> 
> 
> Ideally, there would be per port counters again for the overall
> IPv4/IPv6 multicast traffic. That would help for multicast streams
> for instance, to easily see whether multicast counters increase
> rapidly on the ports you would expect them to. And whether snooping
> is working in general for such streames, without needing to check
> each port individually via tcpdump, for instance.
> 
> 
> Just some thoughts, would love to hear what you think about them.
> 
> Regards, Linus
> 

Hi Linus,
I think these are all reasonable and helpful things to export in addition. I will
definitely look into extending the stats with them. If this patch is accepted as-is
I'll just do it as a follow-up.

Thanks for the good suggestions!

Cheers,
 Nik

