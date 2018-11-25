Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; 
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
	bh=tNdysctSXHOOfdGtjZ+q96+0vBOig/Pi/T3Sc3haYd4=; 
	b=sd1cm83XCcm2Y54UtyUsX9zMzExDAsS9AEGIX4AM5Dfpo0v+oaBiH80eBGvPDamsG/ywaGzKK1UI4sMZvSLmgJZxa6QZ02owp0PWO4v8SE4tE9ZRuVppgIxOVU8aq5OEmXNitJPFNK/kJh9GJpYp9RPCdb6NpRnwhG+8JwDx7CI=;
Date: Sun, 25 Nov 2018 16:45:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20181125154555.GA18663@lunn.ch>
References: <20181124023422.13908-1-nikolay@cumulusnetworks.com>
	<20181124023422.13908-2-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181124023422.13908-2-nikolay@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net-next v2 1/3] net: bridge: add support for
 user-controlled bool options
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On Sat, Nov 24, 2018 at 04:34:20AM +0200, Nikolay Aleksandrov wrote:
> We have been adding many new bridge options, a big number of which are
> boolean but still take up netlink attribute ids and waste space in the skb.
> Recently we discussed learning from link-local packets[1] and decided
> yet another new boolean option will be needed, thus introducing this API
> to save some bridge nl space.
> The API supports changing the value of multiple boolean options at once
> via the br_boolopt_multi struct which has an optmask (which options to
> set, bit per opt) and optval (options' new values). Future boolean
> options will only be added to the br_boolopt_id enum and then will have
> to be handled in br_boolopt_toggle/get. The API will automatically
> add the ability to change and export them via netlink, sysfs can use the
> single boolopt function versions to do the same. The behaviour with
> failing/succeeding is the same as with normal netlink option changing.
> 
> If an option requires mapping to internal kernel flag or needs special
> configuration to be enabled then it should be handled in
> br_boolopt_toggle. It should also be able to retrieve an option's current
> state via br_boolopt_get.
> 
> v2: WARN_ON() on unsupported option as that shouldn't be possible and
>     also will help catch people who add new options without handling
>     them for both set and get. Pass down extack so if an option desires
>     it could set it on error and be more user-friendly.
> 
> [1] https://www.spinics.net/lists/netdev/msg532698.html
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
