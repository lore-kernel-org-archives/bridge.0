Return-Path: <dsahern@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=8nB6UOzgonvSgIT4y+9poBDn/jzEnMha8n1NPzW/YvQ=;
	b=fENZINM7Mxpu4pmIjemj1Ft671AiOSHGKCfYHIezbR7BRrcad7Kt63UyhqN4bHOD/0
	SGtxFM+ZGjcOq6pqFc5CSnnrQ22j1NUyviL7ZCnIeKqAYNlFx9tq5K5eLzYwvKepVzdJ
	dlolAynjEXybnLijnok1Nh0b7P2cl9nnTUfLwL4zjezR99zkDtPbtyV0bzYCdXshj3QY
	TH6BHAvy5283v2TTfrmMKc7bwbObtMq3vWdgU1OGKIWFzI12RrMueopRo42llVlF3gN1
	VaMKjSD7etp/RcVLPV9RB35IAAhLT1FJofVLG5l1T8FQy11QI7aT/ACvSfXfTlVNNPQC
	Mlkg==
References: <20190730112100.18156-1-nikolay@cumulusnetworks.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <4511701d-88c4-a937-2fbc-b557033a24ed@gmail.com>
Date: Tue, 30 Jul 2019 07:58:03 -0600
MIME-Version: 1.0
In-Reply-To: <20190730112100.18156-1-nikolay@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: mcast: don't delete permanent
 entries when fast leave is enabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org
Cc: roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 7/30/19 5:21 AM, Nikolay Aleksandrov wrote:
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 3d8deac2353d..f8cac3702712 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1388,6 +1388,9 @@ br_multicast_leave_group(struct net_bridge *br,
>  			if (!br_port_group_equal(p, port, src))
>  				continue;
>  
> +			if (p->flags & MDB_PG_FLAGS_PERMANENT)
> +				break;
> +
>  			rcu_assign_pointer(*pp, p->next);
>  			hlist_del_init(&p->mglist);
>  			del_timer(&p->timer);

Why 'break' and not 'continue' like you have with
	if (!br_port_group_equal(p, port, src))
