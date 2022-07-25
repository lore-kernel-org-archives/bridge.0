Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA0F4610A2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 476A360D5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=upMEmh+I6YGZG6c6EtpIGF8esGPJ+kf2J+SaVLbY2I8=;
 b=rEUkYjeXEtLqLitKufIF/+JMoLRGiStjaP6GGVJDdi4iNhj4M4CLvV/6xyNL9CzwvA
 5TRAs6YiDwKzOvASRhb89b+nR7JmZ+BgTSaM05KIS5vfNmj8V7i3CXf2IekscTvmwTMR
 8baikAG3zAEHoeIecgcQSyy6WkhaJLrtan6jx1eM6ZUBRKnIsMtcst7ZHpc18g1FGs/j
 rJfwdCECRKN4PAka0+bnscS8zRR/9PJes1X0CprM30757PFrin3tH0sNkeF7AV1zD4wo
 FMb9pwNeqCR9yVeYI6bfTzU6El+c7DOw2dK68ZqIIt4vUdUWv1h8A1jEjAcmE5M8UPDm
 dbyg==
Message-ID: <fdc3a288-c342-1c6d-4cf0-640bbfd44f56@blackwall.org>
Date: Mon, 25 Jul 2022 10:43:00 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220725001236.95062-1-bpoirier@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220725001236.95062-1-bpoirier@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: Do not send empty IFLA_AF_SPEC
	attribute
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Benjamin Poirier <bpoirier@nvidia.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, Henrik Bjoernlund <henrik.bjoernlund@microchip.com>, bridge@lists.linux-foundation.org, Horatiu Vultur <horatiu.vultur@microchip.com>, Roopa Prabhu <roopa@nvidia.com>

On 25/07/2022 03:12, Benjamin Poirier wrote:
> After commit b6c02ef54913 ("bridge: Netlink interface fix."),
> br_fill_ifinfo() started to send an empty IFLA_AF_SPEC attribute when a
> bridge vlan dump is requested but an interface does not have any vlans
> configured.
> 
> iproute2 ignores such an empty attribute since commit b262a9becbcb
> ("bridge: Fix output with empty vlan lists") but older iproute2 versions as
> well as other utilities have their output changed by the cited kernel
> commit, resulting in failed test cases. Regardless, emitting an empty
> attribute is pointless and inefficient.
> 
> Avoid this change by canceling the attribute if no AF_SPEC data was added.
> 
> Fixes: b6c02ef54913 ("bridge: Netlink interface fix.")
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
> ---
>  net/bridge/br_netlink.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index bb01776d2d88..c96509c442a5 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -589,9 +589,13 @@ static int br_fill_ifinfo(struct sk_buff *skb,
>  	}
>  
>  done:
> +	if (af) {
> +		if (nlmsg_get_pos(skb) - (void *)af > nla_attr_size(0))
> +			nla_nest_end(skb, af);
> +		else
> +			nla_nest_cancel(skb, af);
> +	}
>  
> -	if (af)
> -		nla_nest_end(skb, af);
>  	nlmsg_end(skb, nlh);
>  	return 0;
>  

br_fill_ifinfo has been a mess, at some point we have to refactor it.

Anyway, thanks for the patch:
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

