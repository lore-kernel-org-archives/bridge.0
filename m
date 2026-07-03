Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE6535E948
	for <bridge@lists.linux.dev>; Fri,  3 Jul 2026 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064066; cv=none; b=Npg2SZ8lRUuziw7TTpuuPmrF6EKiRdtdQ3jtqmY0OryEQGBAjdkORaOYuZIymDCPTAX6JGYMRw6NdMcbuHSDX89HcJHPXjvlI8ht1mIv7chqo26G5nbPEV3CQjekTKXcjHTEWs+vyA9baIZ/SVb+OtHaebp58dhk2VNZdPiPDWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064066; c=relaxed/simple;
	bh=tVn9O9BGVyGOIjguCc/mLQfJqWG2NCeIK+eTfbZbuGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWY7rF3Wg9I+p0ZGz0okWS+Xq0Pd0qrfD4c9FS/VnGzIuqUYgjXdi/ug0NFlXADu8zMf5nf7irP/J6Osp98jgMClSAm3LBzAKtwP5bJebSTsrGyrzFXYYzj7aloz5Tz5A3grb72mEY8vIfJoQxh3Ml/UzKMS/kPHYbQ4t9Zdrww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=nsvfX2Kn; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="nsvfX2Kn"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45fd464d51fso124730f8f.3
        for <bridge@lists.linux.dev>; Fri, 03 Jul 2026 00:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1783064062; x=1783668862; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3hLETDnygn58F8xxBZ3Mcm3EVRjK0eC7Y6SGm1DIAAg=;
        b=nsvfX2KnlILCUZHVjiQhmuTdbTnqZ7YpriTTBES/I9e3mLJnzg7x6CKA6Mla1Bb+Os
         7HCerEpP2ndwtI0C8nYAmktS21+FV+GAq+K3jPuepXH6aFC6SXNOOLx5wK22OgOONt1+
         zG7heAJ1m2e+8FyJ0BP96ZLfQQOpCr2QYbfkHEExSuMxv6qvcxGKDmPlkcIpCQzkn3gJ
         +NJuDcPhfYih9+1t60AHGpIcaoEBs+RcTaQUer41oPVBET25BPflFxwO+fuBhs6B9yek
         cQRd1/Fe9bL7CY16QMqAI7lUzSocViGzofLyA0fiqw+e1nlk7d6n7kDuaazQrP5IDwz3
         MSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783064062; x=1783668862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hLETDnygn58F8xxBZ3Mcm3EVRjK0eC7Y6SGm1DIAAg=;
        b=ml9C54t3UGa5KhX5tAh7No+YyJIArD8b1qWHSSZhiYJQ+8iyfk6YkZ8fVf54zDo70n
         TEIcFXr7fgQepPXs0jjJl4HGELQ0ajH5ABUENo0JVBsPo6TEJiB0nhrz8Qf5zK9QA+Rc
         6BJAsdKQToZjpGyxNNTwqcxUXvDZR/SgQR4zSGwtLKwIMG6i/4lqjIeUnoJ7Tq3tCs+u
         5m6QOY7k+nxQ+Igd5Zh2CD//wVdx5I36b4q74Dl3yr2riMx8QnIvGcopK42QVStlVNoA
         iIG5K9jAb/NaqNghEhDQajW9eHhMY+yzgnEO+NCllgYO7J2OOalIOARlfA7kz8yJfN69
         r0AQ==
X-Forwarded-Encrypted: i=1; AHgh+RqNfKUDr0pcBYMvvc8eAIkoj+g/3TdG3QLawKg4qGgrbwFCYUjghygrATiZOBnXeiDgvUkD78M=@lists.linux.dev
X-Gm-Message-State: AOJu0YznLuQhhI5mBEA8W5KgNWKeT7bEgweZQbrV6ZjN21z8dOAfNabm
	kaIGeVWV93kJmH0vOXo2i9n55gQqp+yCr9FqOoZ9DGDStSNbanY4apZv7qEpcYyUnLw=
X-Gm-Gg: AfdE7cnsOZlZ11IOVnInP7vGqPIVK5sK7IcsKUwtWtYV1cX7WtMCnTOfyiZDqQ8CNgl
	xbkYxiYK7Zm8OKItSTX+atpH2E6sv+3Djag+bHuQZQuR9+sAWjAgaiSFqsHLW1DRHklkKQ0347j
	tVEoYYqD+S/CvOlJhN5A7i50ECJyGb+UCbewc3QL8Ypup6LgIzEJnM+noRWVTBA3Iv67dlGHqcR
	c0Qodc6SEhzFj+vqK1RaGqXTgXiNrPUif4qmB5f0HVypEPI3krCrGUmGsZw3kDyrJIAc60uZ+dz
	8A7KOrqWBK91/g7mcYayua58O7VumtSla+Tj7g3ugrafNuZpQRA55a8tKIcDilrY8g/uSwNXw12
	qrQYhP2ttuz88X+Ggww5rfVWoz968/O9XajECpYW+ui/i8VpVHFnHZ0IOddZitdepdqPoSst2Ql
	JL4vm+n6zEpDw8nDLlXGWko7gdUK/brOBi9TeQEThL34J28KMBZT84uw==
X-Received: by 2002:adf:fa06:0:b0:475:f100:360a with SMTP id ffacd0b85a97d-4775a6d1b39mr10482015f8f.57.1783064061000;
        Fri, 03 Jul 2026 00:34:21 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477db3dbacbsm16180990f8f.4.2026.07.03.00.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 00:34:20 -0700 (PDT)
Message-ID: <45fa2de3-1b56-48b3-a946-ae4c7ea26a22@blackwall.org>
Date: Fri, 3 Jul 2026 10:34:18 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] net: bridge: add BRIDGE_VLAN_INFO_DYNAMIC
 flag
Content-Language: en-US, bg
To: Luke Howard <lukeh@padl.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>,
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>,
 Max Hunter <max@huntershome.org>,
 Christoph Mellauner <christoph.mellauner@joyned.at>,
 Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org,
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260703-vlan-dynamic-entry-v1-1-c2cbb134036c@padl.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260703-vlan-dynamic-entry-v1-1-c2cbb134036c@padl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/07/2026 09:54, Luke Howard wrote:
> Dynamic VLAN entries as specified in IEEE Std 802.1Q-2022,
> Clause 8.8.5. These allow a user-space VLAN registration
> protocol such as MVRP to mark a bridge's VLAN entries as
> dynamic, so they can be distinguished from administratively
> configured static entries.
> 
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Luke Howard <lukeh@padl.com>
> ---
> This patch adds support for Dynamic VLAN Entries, as specified
> in 802.1Q. I have marked it as RFC as a similar patch to add
> support for Dynamic Reservation Entries to the FDB was rejected
> on the argument that the dynamic bit should be stored separately.
> 
> Our MVRP implementation [1] will use this flag if available.
> 
> [1] https://github.com/PADL/OpenSRP

Hi,
Do this tracking entirely in your app, it doesn't bring anything to the
kernel and just adding flags because it is convenient is not acceptable.
These VLANs are the same from kernel POV and this flag doesn't change
anything functionally.
Alternatively perhaps a proto field similar to routes could help you out to
distinguish who installed a VLAN entry, not sure if that would help your
user-space app though, and you'll have to add a new rt proto id that should
get accepted.

Cheers,
  Nik

> ---
>   include/uapi/linux/if_bridge.h |  1 +
>   net/bridge/br_netlink.c        |  6 ++++++
>   net/bridge/br_vlan.c           | 18 ++++++++++++++----
>   3 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
> index 21a700c02ef76..a3abbfe79694b 100644
> --- a/include/uapi/linux/if_bridge.h
> +++ b/include/uapi/linux/if_bridge.h
> @@ -134,6 +134,7 @@ enum {
>   #define BRIDGE_VLAN_INFO_RANGE_END	(1<<4) /* VLAN is end of vlan range */
>   #define BRIDGE_VLAN_INFO_BRENTRY	(1<<5) /* Global bridge VLAN entry */
>   #define BRIDGE_VLAN_INFO_ONLY_OPTS	(1<<6) /* Skip create/delete/flags */
> +#define BRIDGE_VLAN_INFO_DYNAMIC	(1<<7) /* 802.1Q Dynamic VLAN Registration Entry */
>   
>   struct bridge_vlan_info {
>   	__u16 flags;
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index b2cd4e39326d0..90f2e103f53d5 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -388,6 +388,9 @@ static int br_fill_ifvlaninfo_compressed(struct sk_buff *skb,
>   		if (v->flags & BRIDGE_VLAN_INFO_UNTAGGED)
>   			flags |= BRIDGE_VLAN_INFO_UNTAGGED;
>   
> +		if (v->flags & BRIDGE_VLAN_INFO_DYNAMIC)
> +			flags |= BRIDGE_VLAN_INFO_DYNAMIC;
> +
>   		if (vid_range_start == 0) {
>   			goto initvars;
>   		} else if ((v->vid - vid_range_end) == 1 &&
> @@ -440,6 +443,9 @@ static int br_fill_ifvlaninfo(struct sk_buff *skb,
>   		if (v->flags & BRIDGE_VLAN_INFO_UNTAGGED)
>   			vinfo.flags |= BRIDGE_VLAN_INFO_UNTAGGED;
>   
> +		if (v->flags & BRIDGE_VLAN_INFO_DYNAMIC)
> +			vinfo.flags |= BRIDGE_VLAN_INFO_DYNAMIC;
> +
>   		if (nla_put(skb, IFLA_BRIDGE_VLAN_INFO,
>   			    sizeof(vinfo), &vinfo))
>   			goto nla_put_failure;
> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index 5560afcaaca32..e6bc59e3a4c4f 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -54,9 +54,11 @@ static void __vlan_delete_pvid(struct net_bridge_vlan_group *vg, u16 vid)
>   	vg->pvid = 0;
>   }
>   
> -/* Update the BRIDGE_VLAN_INFO_PVID and BRIDGE_VLAN_INFO_UNTAGGED flags of @v.
> - * If @commit is false, return just whether the BRIDGE_VLAN_INFO_PVID and
> - * BRIDGE_VLAN_INFO_UNTAGGED bits of @flags would produce any change onto @v.
> +/* Update the BRIDGE_VLAN_INFO_PVID, BRIDGE_VLAN_INFO_UNTAGGED and
> + * BRIDGE_VLAN_INFO_DYNAMIC flags of @v.
> + * If @commit is false, return just whether the BRIDGE_VLAN_INFO_PVID,
> + * BRIDGE_VLAN_INFO_UNTAGGED and BRIDGE_VLAN_INFO_DYNAMIC bits of @flags
> + * would produce any change onto @v.
>    */
>   static bool __vlan_flags_update(struct net_bridge_vlan *v, u16 flags,
>   				bool commit)
> @@ -71,7 +73,8 @@ static bool __vlan_flags_update(struct net_bridge_vlan *v, u16 flags,
>   
>   	/* check if anything would be changed on commit */
>   	change = !!(flags & BRIDGE_VLAN_INFO_PVID) == !!(vg->pvid != v->vid) ||
> -		 ((flags ^ v->flags) & BRIDGE_VLAN_INFO_UNTAGGED);
> +		 ((flags ^ v->flags) & (BRIDGE_VLAN_INFO_UNTAGGED |
> +					BRIDGE_VLAN_INFO_DYNAMIC));
>   
>   	if (!commit)
>   		goto out;
> @@ -86,6 +89,11 @@ static bool __vlan_flags_update(struct net_bridge_vlan *v, u16 flags,
>   	else
>   		v->flags &= ~BRIDGE_VLAN_INFO_UNTAGGED;
>   
> +	if (flags & BRIDGE_VLAN_INFO_DYNAMIC)
> +		v->flags |= BRIDGE_VLAN_INFO_DYNAMIC;
> +	else
> +		v->flags &= ~BRIDGE_VLAN_INFO_DYNAMIC;
> +
>   out:
>   	return change;
>   }
> @@ -1874,6 +1882,8 @@ static bool br_vlan_fill_vids(struct sk_buff *skb, u16 vid, u16 vid_range,
>   		info.flags |= BRIDGE_VLAN_INFO_UNTAGGED;
>   	if (flags & BRIDGE_VLAN_INFO_PVID)
>   		info.flags |= BRIDGE_VLAN_INFO_PVID;
> +	if (flags & BRIDGE_VLAN_INFO_DYNAMIC)
> +		info.flags |= BRIDGE_VLAN_INFO_DYNAMIC;
>   
>   	if (nla_put(skb, BRIDGE_VLANDB_ENTRY_INFO, sizeof(info), &info))
>   		goto out_err;
> 
> ---
> base-commit: 2bb62a85aff6d4c14a62a476dfabaada3c1cc014
> change-id: 20260703-vlan-dynamic-entry-56a028e8990e
> 
> Best regards,
> --
> Luke Howard <lukeh@padl.com>
> 

