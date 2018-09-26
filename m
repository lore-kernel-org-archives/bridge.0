Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=E/46VoLxX17d+IRpKmJKHqGKysj6VwrpW5XmNPjrqyo=;
	b=Y+lGNe778V5fFrNT6PaYzZYQHSlGWhHf72YeGfgIMHCCeSvJua/bmq11QImz3HGPa4
	9XitS2zdNI5hotxEHbm0VXaO8ujX42BhVRVUEmfOSM1YXClke4Ovm7XEDGyIXO9WtIBQ
	/PoATdWMA9opfk2cwPFxakgP33skSCS4y45u0=
References: <20180926140107.10218-1-nikolay@cumulusnetworks.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <2ab2aeb3-7667-816c-a1cd-97dbe723db33@cumulusnetworks.com>
Date: Wed, 26 Sep 2018 17:04:03 +0300
MIME-Version: 1.0
In-Reply-To: <20180926140107.10218-1-nikolay@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 0/9] net: bridge: convert bool
	options to bits
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: idosch@idosch.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 26/09/18 17:00, Nikolay Aleksandrov wrote:
> Hi,
> A lot of boolean bridge options have been added around the net_bridge
> structure resulting in holes and more importantly different cache lines
> that need to be fetched in the fast path. This set moves all of those
> to bits in a bitfield which resides in a hot cache line thus reducing
> the size of net_bridge, the number of holes and the number of cache
> lines needed for the fast path.
> The set is also sent in preparation for new boolean options to avoid
> spreading them in the structure and making new holes.
> One nice side-effect is that we avoid potential race conditions by using
> the bitops since some of the options were bits being directly set in
> parallel risking hard to debug issues (has_ipv6_addr).
> 
> Before:
>  size: 1184, holes: 8, sum holes: 30
> After:
>  size: 1160, holes: 3, sum holes: 7
> 
> Patch 01 is a trivial style fix
> Patch 02 adds the new options bitfield and converts the vlan boolean
>          options to bits
> Patches 03-08 convert the rest of the boolean options to bits
> Patch 09 re-arranges a few fields in net_bridge to further reduce size
> 
> v2: patch 09: remove the comment about offload_fwd_mark in net_bridge and
>     leave it in the last 4 bytes, thanks to Ido for spotting it

And obviously it's not in the last 4 bytes, but that's fine. That
must've said just: "leave it where it is now".

> 
> Stephen, I've added your reviewed-by in patches 01-08, only removed it
> from patch 09 as the patch has changed.
> 
> Thanks,
>  Nik
> 
