Return-Path: <dsahern@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=G8NpVJHV6XTeInBWMRdwvp9yp0ay3o9iHO0+lBUDJ/k=;
 b=HGTsLQm4pbK0efQSfWDR/Ipv150Dfu4DvyKt9PYcCWambCrVXtT+xRx9LT2VBy+wCw
 wi5vixOPh4rqvWZ8RtFMAu2vw3bW5BnNG3AFsIT4d74u1A3yqpKfsTQO7MAAnw0W9z4A
 okDV6abRz9G5U0glsOth4Fr3qAiLDUkaUSF37KzOIScH4sl02ItMEJKYfqiexdgYv6YK
 ZyxvJoOzvK8C3SW1tsbdsS/DcrBqU6SmqtAqEpl8ytJ0i1fPGSqmn94z0IDzx5sd5kpc
 pZzwYrtWXwFLmU095Y7qIyPXcqgRKYY6nU+u9gjz01F4PbOGQTdrU4ZwjLJT6CHKpKug
 X6rQ==
References: <20191210212050.1470909-1-vivien.didelot@gmail.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <0e45fd22-c31b-a9c2-bf87-22c16a60aeb4@gmail.com>
Date: Wed, 11 Dec 2019 08:38:17 -0700
MIME-Version: 1.0
In-Reply-To: <20191210212050.1470909-1-vivien.didelot@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2] net: bridge: add STP xstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vivien Didelot <vivien.didelot@gmail.com>, "David S. Miller" <davem@davemloft.net>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org

On 12/10/19 2:20 PM, Vivien Didelot wrote:
> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
> index 1b3c2b643a02..e7f2bb782006 100644
> --- a/include/uapi/linux/if_bridge.h
> +++ b/include/uapi/linux/if_bridge.h
> @@ -156,6 +156,15 @@ struct bridge_vlan_xstats {
>  	__u32 pad2;
>  };
>  
> +struct bridge_stp_xstats {
> +	__u64 transition_blk;
> +	__u64 transition_fwd;
> +	__u64 rx_bpdu;
> +	__u64 tx_bpdu;
> +	__u64 rx_tcn;
> +	__u64 tx_tcn;
> +};
> +
>  /* Bridge multicast database attributes
>   * [MDBA_MDB] = {
>   *     [MDBA_MDB_ENTRY] = {
> @@ -261,6 +270,7 @@ enum {
>  	BRIDGE_XSTATS_UNSPEC,
>  	BRIDGE_XSTATS_VLAN,
>  	BRIDGE_XSTATS_MCAST,
> +	BRIDGE_XSTATS_STP,
>  	BRIDGE_XSTATS_PAD,
>  	__BRIDGE_XSTATS_MAX
>  };

Shouldn't the new entry be appended to the end - after BRIDGE_XSTATS_PAD

