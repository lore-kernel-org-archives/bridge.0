Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=J5fdy7Wd9FHVlBYpOs7Z6b4FYMlCutBaVHd3ZTvQnx8=;
	b=jcvbyeO2Rb27mNd8+lNcStEOaoRfSBfIecOdeOrvehK1UDI3XXjVpnaSL1Y5VbgW0o
	S43AF7PCzFEJIzJb7T9OY8rvM6899WR8raNH7Q1x+ulDZXGVgvvBio39kalP+YHLuWWX
	9fFavIJ3A1Upf0jJXLMFN6P/tCRtAc+4DZDVsEm0eQ5TDR78H73gh/rbMhAEU6bfxNTg
	grHUKYAFHED5LCNQSvcLQTDqwBygF07HXRgwjJqDJRUw9xXVBvZsDBeKVGK/o94BfIb7
	ZkSAS3k+LQqjoxBxsKIk5YWLFT5xTrWE117kWcnAxP/Mah8wyBd32ATujwmACKDQoKh+
	8NZw==
Date: Wed, 31 Jul 2019 15:53:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20190731155338.15ff34cb@hermes.lan>
In-Reply-To: <20190731224955.10908-1-nikolay@cumulusnetworks.com>
References: <319fda43-195d-2b92-7f62-7e273c084a29@cumulusnetworks.com>
	<20190731224955.10908-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v3] net: bridge: move vlan init/deinit to
 NETDEV_REGISTER/UNREGISTER
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net, michael-dev <michael-dev@fami-braun.de>

  
> -int br_vlan_init(struct net_bridge *br)
> +static int br_vlan_init(struct net_bridge *br)
>  {
>  	struct net_bridge_vlan_group *vg;
>  	int ret = -ENOMEM;
> @@ -1083,6 +1085,8 @@ int br_vlan_init(struct net_bridge *br)
>  	return ret;
>  
>  err_vlan_add:
> +	RCU_INIT_POINTER(br->vlgrp, NULL);
> +	synchronize_rcu();

Calling sychronize_rcu is expensive. And the callback for
notifier is always called with rtnl_head. 

Why not just keep the pointer initialization back in the
code where bridge is created, it was safe there.
