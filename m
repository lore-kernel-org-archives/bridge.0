Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; bh=tcbdVWnYrdAx272RY3vQ0GdPUTfXQ
	5Bz1PF6x3ZUdj0=; b=S8yDN1c3Ol7X5c4YGOvEk3Ke5VUNgKbPPvxv3bjzkTKen
	usdWqFSRz3YrybJ3uwdqj1rpJqxyEpnXTmc3f6OlsL66veR41PrzD2XwcBA0UhTM
	OxgQsiMLqhU0Vg7N8wNfiYVVFM32ar2jbo0Yjhe89FHdL5J9pEA/xtbf4PYY3yFM
	WgRmusxQdPEioCg7cd3fh8Zcb3Lv/adIQB9Gw5Snj0dLsKr6jjzmFApDk+qf+JHG
	Ne3N20YZxb/jgrgrxSVNhzOZsuRHXRDOs4Xv4NtnkLycA/eSRK2Eg5tnWSRmU0jp
	BtZ4pCZRjh30XNWsuj1pDIXtjFyw9EkBVGSaLAopQ==
Date: Wed, 26 Sep 2018 16:30:14 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20180926133014.GA31563@splinter>
References: <20180926121802.27851-1-nikolay@cumulusnetworks.com>
	<20180926121802.27851-10-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926121802.27851-10-nikolay@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net-next 9/9] net: bridge: pack net_bridge
	better
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

On Wed, Sep 26, 2018 at 03:18:02PM +0300, Nikolay Aleksandrov wrote:
> Further reduce the size of net_bridge with 8 bytes and reduce the number of
> holes in it:
>  Before: holes: 5, sum holes: 15
>  After: holes: 2, sum holes: 3
> 
> Also as a bonus we get offload_fwd_mark in the first cache line and remove
> the need to pull the last cache line of net_bridge just for that member in
> fast path (should_deliver -> nbp_switchdev_allowed_egress).

But nbp_switchdev_allowed_egress() compares with 'offload_fwd_mark' from
'net_bridge_port', not 'net_bridge'...
