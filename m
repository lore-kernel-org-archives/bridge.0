Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SRxeP6JYxXwcDjXxRxvxSG10sfRbRAVNy5e7o8L+Unw=;
 b=KsOWuxi/0PxjefEDm2r60M34w2W3ctdF5MBaULRIuvo6rhK0YoWJZj+U5/8+/uv5s4
 ErvO0UGhCWUiaucHXjJpvBjVsayTBHFlJYPo6SQrM0qQ0ahSEbrt7Se40GXfjuciL19a
 d7pRk9mcFYR4FzDhOsAN1JPANFUe8IAt516e1/tROV/n0ayZpsqmdQLCsEHqsFCtychZ
 DHS617nxrIwyen6l4ouJb/y/VG0CJxx3tJoJRYB2lOxAA2aArXDqweuDKXJsMRDxWHFA
 j7ASJ6M3gY6C+WSyRS8jDr2mAJu4lF/xPkCRgcPodYzewwZPTIroV2uI1jv9F3W1D/Bk
 VUSg==
Date: Fri, 22 Nov 2019 15:21:37 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20191122152137.33f9f9d7@hermes.lan>
In-Reply-To: <20191122230742.1515752-1-vivien.didelot@gmail.com>
References: <20191122230742.1515752-1-vivien.didelot@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: add STP stat counters
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vivien Didelot <vivien.didelot@gmail.com>
Cc: f.fainelli@gmail.com, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>

On Fri, 22 Nov 2019 18:07:42 -0500
Vivien Didelot <vivien.didelot@gmail.com> wrote:

> This adds rx_bpdu, tx_bpdu, rx_tcn, tx_tcn, transition_blk,
> transition_fwd stat counters to the bridge ports, along with sysfs
> statistics nodes under a "statistics" directory of the "brport" entry,
> providing useful information for STP, for example:
> 
>     # cat /sys/class/net/lan0/brport/statistics/tx_bpdu
>     26
>     # cat /sys/class/net/lan5/brport/statistics/transition_fwd
>     3
> 
> At the same time, make BRPORT_ATTR define a non-const attribute as
> this is required by the attribute group structure.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@gmail.com>

Please don't add more sysfs stuff. put it in netlink.

> ---
>  net/bridge/br_private.h  |  8 ++++++++
>  net/bridge/br_stp.c      |  8 ++++++++
>  net/bridge/br_stp_bpdu.c |  4 ++++
>  net/bridge/br_sysfs_if.c | 35 ++++++++++++++++++++++++++++++++++-
>  4 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 36b0367ca1e0..360d8030e3b2 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -283,6 +283,14 @@ struct net_bridge_port {
>  #endif
>  	u16				group_fwd_mask;
>  	u16				backup_redirected_cnt;
> +
> +	/* Statistics */
> +	atomic_long_t			rx_bpdu;
> +	atomic_long_t			tx_bpdu;
> +	atomic_long_t			rx_tcn;
> +	atomic_long_t			tx_tcn;
> +	atomic_long_t			transition_blk;
> +	atomic_long_t			transition_fwd;
>  };
>  

There is no these need to be atomic.
Atomic is expensive.

