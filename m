Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC923D952E
	for <bridge@lists.linux.dev>; Sun, 20 Sep 2026 07:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789887998; cv=none; b=jzVzVC6ELeMZMHKwrK+YYlSA1BSHgl+uBqLF74eLSQEeq+Hah3/cHmyQozjTlUrS8CkgoyOpJMd7+UUfbRzI5PkYx+2RN7OX0aHeN/fIwmBmGTASydA73qCmZPULbnQAeqTLRnI7ele8krGmsvlftS0/cic9rtrbApWgxMobPys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789887998; c=relaxed/simple;
	bh=ZzCkX7Arypynrsn1LakZyXLC86CAYyc5xcn3bjhUjhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmKisrMJZcLffe/EfVtFmpKpfGtzLjJnXNoq+zPms+0vp/UGXUnym8otRcwMnOBm2T1R/WjrEsRf/An97dh0WL1ufo/Yn5bXD1bk/GgWvWt0jETwJ2wla6SQrAeiODg2CenJxeY4Ipbv6HnoC0XE6FAKb0X8Izl60mvHv9vQer4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=WnZYUcTK; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="WnZYUcTK"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso26451985e9.2
        for <bridge@lists.linux.dev>; Sun, 20 Sep 2026 00:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789887995; x=1790492795; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sCbcg84Wkufy21atUPqDKKDB5cQsptTtPpZ9zNWHEmU=;
        b=WnZYUcTKEREf9c2VqvNPJherHVTGTMc4w3/5F3ISIpaC6HjQgVXZV9pjV71+1O4HNv
         4XL1TYvFh7pFvHxqEgZewJG4DqAm2TeSXDppmgTZE5LSJ2xWJ/ndFclK+G4ReGNHgKgA
         XAuXEw3ttKc57LtRnG6jt+vmQGHvY2yMkyRoZxZBiDppeaYuscJViquYLmKm2txQQ/dw
         MXmU3aHxwPVux+SDZ53TAyRRpRKL9Y81EKFJy4zlBHxqsmPa7125U/ssjGAf26pmFUYm
         3T6ewYwsK+gyPGxdOTP6y5TGfVvlHDdoAtrT2HLIp2OIJoaC2gf3+PtW892yciOlBZSm
         BXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789887995; x=1790492795;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sCbcg84Wkufy21atUPqDKKDB5cQsptTtPpZ9zNWHEmU=;
        b=uYon/RQQ1O/0H0fZXjaqaOq1fjmzEvk0ckSisD9Km4/ZLIMYkT7kuga9I9J6t9BveX
         FlEPX+VuR8iKyNdJ6QdJWRFaRoCkY+hES7s2W9EmgeNdllkz9AmzTDSmtGDnxuhyyTCw
         bOXxHzPNKoY0yZPtetXtgsunWt/qhZnKsNclXLyCCBfB37UMmDB16mC0uWCSLu8L3KBA
         aBRO4Jau5+mpRDuypgWDFlp+Runk+czbvloEIP1obJOG+oG8ck+gDfr6VL4OEt4nbkR0
         ZuMALl9M8KQ8b8hCJN93PzFbuOj5Go0AISSurjkzyxjzICGGqgtSk5hGuPuoqE6Ro778
         1mJQ==
X-Gm-Message-State: AFuF++kG5wW2thW7ukWCtrZA//pmZe3n7cw2wS9xFp6JuDVhuyalMeGg
	0D1xLlUvUGmPfRd8sEPrVEHyDs0bxmCfIgSB30UmnIAaVtHu1rVbDvAra2tZlMAtVEA=
X-Gm-Gg: AYBFou3GhfPKTJ3jqmvzdE/ds9RhNTJAn+bvSx4YppMyERFpjIvU5j+Rs4Oi2BlQP6h
	TSadr5vhytJ3Pzc38mWIuzAalyocTeYJiLfJDIRQG6US6IsJCwh74zM3Rof4yXpBOZNFY05PmLG
	zN5LYgRN8/QP8RY6/9wwqf4cKdP+L/m6wL07aTNU9pdYw9dHdPi69iHIUD4E7uonsCzyyjdMt4D
	uoDSLqpCMBAgINgow+TeYVYB0pVTSjIqYlnISOZwqsPqxuoDCezn/WvJ58EnQobDpJxdoLSA7R7
	4slQdavSGjWGDg5Ldwmgn4mW3GUZIMyCi6+lU18jWvIBmoDwDrj9SdwX8sEB4aAhSMLMd9xE2lU
	aB0nw+szNBZ1CPsHfU9vSttGqAiSsgLSIyT8jkrq5kjFASdefdIwmuPsZGiDpu/nwurgwigFqSg
	ZlpULYuuDShEOaQMvGA+DSlYKQlv3B88LRZNtyF0Iq73xx3g1p3qfgVs6mvr1Q8YvZ5e6Hm/60b
	HwETB/26ktW/W7VvxBqWp1vZ162ZA==
X-Received: by 2002:a05:600c:1c20:b0:49f:bd3c:bc1c with SMTP id 5b1f17b1804b1-49fc5739f3bmr106841865e9.23.1789887995037;
        Sun, 20 Sep 2026 00:06:35 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd10273fsm129717115e9.7.2026.09.20.00.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2026 00:06:34 -0700 (PDT)
Message-ID: <ed1de95e-e112-4076-93f0-6f7668e657ad@blackwall.org>
Date: Sun, 20 Sep 2026 10:06:32 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: bridge: fail link info that does not
 fit in a netlink attribute
Content-Language: en-US, bg
To: Artem Lytkin <iprintercanon@gmail.com>, netdev@vger.kernel.org
Cc: bridge@lists.linux.dev, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, kuniyu@google.com, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, ajit.khaparde@broadcom.com,
 sriharsha.basavapatna@broadcom.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 oss-drivers@corigine.com, wintera@linux.ibm.com, aswin@linux.ibm.com,
 linux-s390@vger.kernel.org
References: <20260919134333.49379-1-iprintercanon@gmail.com>
 <20260919134333.49379-3-iprintercanon@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260919134333.49379-3-iprintercanon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/09/2026 16:43, Artem Lytkin wrote:
> nla_len is a u16, and a port with enough VLANs, tunnels or MST entries
> makes the IFLA_AF_SPEC nest wrap, so userspace reads garbage. Same for
> the inner MST and CFM nests.
> 
> Use nla_nest_end_safe() for all three and return -E2BIG with an extack
> on overflow. Dumps end with that error, notifications go through
> rtnl_set_sk_err() so listeners resync.
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
> ---
>   net/bridge/br_netlink.c | 25 +++++++++++++++++--------
>   1 file changed, 17 insertions(+), 8 deletions(-)
> 

You can add specific extack messages to the different dumping parts of br_fill_ifinfo
so the user can identify exactly which one doesn't fit and get a more accurate error.
More below...

> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 855a46aec3a89..fbd91b86d4268 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -459,7 +459,7 @@ static int br_fill_ifinfo(struct sk_buff *skb,
>   			  const struct net_bridge_port *port,
>   			  u32 pid, u32 seq, int event, unsigned int flags,
>   			  u32 filter_mask, const struct net_device *dev,
> -			  bool getlink)
> +			  bool getlink, struct netlink_ext_ack *extack)
>   {
>   	u8 operstate = netif_running(dev) ? READ_ONCE(dev->operstate) :
>   					    IF_OPER_DOWN;
> @@ -588,7 +588,8 @@ static int br_fill_ifinfo(struct sk_buff *skb,
>   				goto nla_put_failure;
>   		}
>   

Before these you can call if (nla_nest_end_safe(skb, af) < 0) { }
in the vlan block and set a vlan-specific extack error message, in fact
you can do that after vlan info is dumped, then after vlan tunnels are dumped
and set specific messages depending on which one didn't fit.

nla_nest_end_safe updates nla_len but you can still append attributes
after it has been called

Then you have MRP, you can do the same there and so on.

> -		nla_nest_end(skb, cfm_nest);
> +		if (nla_nest_end_safe(skb, cfm_nest) < 0)
> +			goto nla_nest_too_large;

This can set its own extack err message, e.g.
CFM information exceeds the netlink attribute size limit

>   	}
>   
>   	if ((filter_mask & RTEXT_FILTER_MST) &&
> @@ -608,20 +609,27 @@ static int br_fill_ifinfo(struct sk_buff *skb,
>   		if (err)
>   			goto nla_put_failure;
>   
> -		nla_nest_end(skb, mst_nest);
> +		if (nla_nest_end_safe(skb, mst_nest) < 0)
> +			goto nla_nest_too_large;

Same here but with MST

>   	}
>   
>   done:
>   	if (af) {
> -		if (nlmsg_get_pos(skb) - (void *)af > nla_attr_size(0))
> -			nla_nest_end(skb, af);
> -		else
> +		if (nla_nest_end_safe(skb, af) < 0)
> +			goto nla_nest_too_large;
> +		if (!nla_len(af))
>   			nla_nest_cancel(skb, af);
>   	}
>   
>   	nlmsg_end(skb, nlh);
>   	return 0;
>   
> +nla_nest_too_large:
> +	NL_SET_ERR_MSG_MOD(extack,
> +			   "AF_SPEC info too large, use per-object dumps (e.g. RTM_GETVLAN)");

Just make sure here to use NL_SET_ERR_MSG_WEAK_MOD() so extack doesn't get overwritten

> +	nlmsg_cancel(skb, nlh);
> +	return -E2BIG;
> +
>   nla_put_failure:
>   	nlmsg_cancel(skb, nlh);
>   	return -EMSGSIZE;
> @@ -654,7 +662,8 @@ void br_info_notify(int event, const struct net_bridge *br,
>   	if (skb == NULL)
>   		goto errout;
>   
> -	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false);
> +	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false,
> +			     NULL);
>   	if (err < 0) {
>   		/* -EMSGSIZE implies BUG in br_nlmsg_size() */
>   		WARN_ON(err == -EMSGSIZE);
> @@ -693,7 +702,7 @@ int br_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   		return 0;
>   
>   	return br_fill_ifinfo(skb, port, pid, seq, RTM_NEWLINK, nlflags,
> -			      filter_mask, dev, true);
> +			      filter_mask, dev, true, extack);
>   }
>   
>   static int br_vlan_info(struct net_bridge *br, struct net_bridge_port *p,

