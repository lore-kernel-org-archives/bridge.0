Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46E238C2AF
	for <bridge@lists.linux.dev>; Wed, 25 Mar 2026 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774424802; cv=none; b=TNyaALIj3sH4WgQsnTSbdOcE/yjge3jvbDTNemp0aAmmkzcpeeBf3hSAN3L/gSjcN94xwAvBhi2fulm5fPZn2VkCfXAPauam6TZdsQxluhO0BvujNwXYOsih1DDsA8uvCRasFnrJNZ6nYJGO/se6drJbD1WUXLqsQsmqvJderDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774424802; c=relaxed/simple;
	bh=dZYOh4XrYy5rxi9XVMMD1JfT9YZNj3TOU35ZtYGqb1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VNQXXZE25u7b7yKr3anw9uOFwg5Egn2qOR8v8mUpNYRV0yc0fdMLT5udArMpFuGuxxreJrzkJSX1X7XNh4MxlcUH8QuucSpr3jcKeDwCqq5ytqIWFtjNFi1mSiaauxIn1i5R1HH2MjB6okNKnvX/UO7DUUxYhlC/3LcSpLjbp88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Pt7prajv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Pt7prajv"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fe655187so59365335e9.2
        for <bridge@lists.linux.dev>; Wed, 25 Mar 2026 00:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774424794; x=1775029594; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iXYQ+HYt37DNeCQ0SFHpfNm2D/xmqdQlJV/hZeJHWhc=;
        b=Pt7prajvvV/GEJFIMW8QDYQKNQcMrUzgjNgesHr1kjbxwrhNSQO8vE+nAo8P+o1HFh
         K4JzlnPlx18xkRm3TUazTii0LBObjEUk313ZhlnIXUWO84AUhEmf+nWjOSBK6TqFUPqs
         IgLgE907F7dfyfdBbOeGJw81/j61QG9wn7WMbMsLDjJ/rL5qFHkO/bJ9+QDe6S1beoWD
         ZPfa6FMyzDd9HzWBEuNaadQ/or4MtOt6uFNZtYEGnTzAKEZHys+LsEqfJuwRoGKrswbJ
         nXAqLFKPp7bYRwSGt5bBVjTNo2OtWmt5TNphCkfyCumXVMfspzzWF7j+stIXwY+ih6Tf
         C/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774424794; x=1775029594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXYQ+HYt37DNeCQ0SFHpfNm2D/xmqdQlJV/hZeJHWhc=;
        b=XUv4FJbPThgWYoHIBEudKuBxsYAwxutgwyLs3sv4RpBBO+OEachYagRqwlhE8ORWwM
         g5UiZP8fnlKN93z9rv8jhjy+mcXmfNIIGDrKvwZxLfgBaYuzzIX4X+20OwLZzcUzabEs
         fVIhaKWkROwg+C9lrAIRyVXtPMxFLNWe0QygMQAtlFDAZlFgdROv9vhHbO9xKiju7tHv
         xj0ZMEno4GPjS0cdJaUA4SBQoZcQRobvmmz4LhtYqQ+6i1r6wuMdpFcNbdYWvWI1Itdh
         6Rkgln5rHINEhF8CfaN+EfvVGqahpuZHRIh22HXiT0MdAsAfUpsPguCW64cGzSBdVmhq
         052w==
X-Gm-Message-State: AOJu0YxyzjCSmHyOq1hjaodC4ouZvs+O44cW7XTRMD2MkcCViqlL1fie
	HU2WLUkX6e0A8OdcXk/KphMIJO3sSN003v1c9nva8094+8KSga3Nca+CrAjzYfzfbNopC6eMKM6
	NxRV7
X-Gm-Gg: ATEYQzxRhSDWRiRcCDPcD3Bgw4PTEr8bk6CpvFuTyJJRIDR1ajim27QcAHld8Px9X+8
	OHP1HzX9d3Y01AXiKM1cp6lEN/qQP2KJnf8NS2c3IAl8n8vY0Y3EpESkHt1zhd0DkGRFzOnW8PJ
	amXsEJEl2gS80GhI7Ow41vPgP2UqgmB3YrOZmssuWZfrN+8n4oKdceEUeo6QVfU98IL+qy9J0LC
	+IdQY3A1+01r2Q/tdlBcgO1zgt3ETykvAF9HCVJSW10pepycDikwDiFodqYwpo0Vf1WXur2jEYx
	0bSoxdxEkNYe1JyXBAqTwXjSchv39ljpkz7fkUjhxjhN/gAzKgQyLXBHpTr30MQdpE2R+BIcWib
	3pAP9IAgq0YVpql+S8A+Ba8luVJvTa0FAeApmsPlxr387JVaUk0KXNXHwV8p0QWIdyBmaH5wtNE
	PwUIBwauC6cTqmjeFDUOM7eSkiTHXLibrsMsn5lqaUKYBjuD0/iagOYQ==
X-Received: by 2002:a05:600c:1f8e:b0:485:4006:960c with SMTP id 5b1f17b1804b1-4871605aa53mr35214235e9.16.1774424794227;
        Wed, 25 Mar 2026 00:46:34 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116c086dsm118615395e9.8.2026.03.25.00.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 00:46:33 -0700 (PDT)
Message-ID: <34a996fd-acfd-49c7-ac76-81ae12573029@blackwall.org>
Date: Wed, 25 Mar 2026 09:46:32 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: bridge: add stp_mode attribute for STP
 mode selection
To: Andy Roulin <aroulin@nvidia.com>, netdev@vger.kernel.org
Cc: bridge@lists.linux.dev, Ido Schimmel <idosch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260324184942.2828691-1-aroulin@nvidia.com>
 <20260324184942.2828691-2-aroulin@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260324184942.2828691-2-aroulin@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/03/2026 20:49, Andy Roulin wrote:
> The bridge-stp usermode helper is currently restricted to the initial
> network namespace, preventing userspace STP daemons (e.g. mstpd) from
> operating on bridges in other network namespaces. Since commit
> ff62198553e4 ("bridge: Only call /sbin/bridge-stp for the initial
> network namespace"), bridges in non-init namespaces silently fall back
> to kernel STP with no way to use userspace STP.
> 
> Add a new bridge attribute IFLA_BR_STP_MODE that allows explicit
> per-bridge control over STP mode selection:
> 
>    BR_STP_MODE_AUTO (default) - Existing behavior: invoke the
>      /sbin/bridge-stp helper in init_net only; fall back to kernel STP
>      if it fails or in non-init namespaces.
> 
>    BR_STP_MODE_USER - Directly enable userspace STP (BR_USER_STP)
>      without invoking the helper. Works in any network namespace. The
>      caller is responsible for registering the bridge with the STP
>      daemon after enabling STP.
> 
>    BR_STP_MODE_KERNEL - Directly enable kernel STP (BR_KERNEL_STP)
>      without invoking the helper.
> 
> The mode can only be changed while STP is disabled (-EBUSY otherwise).
> IFLA_BR_STP_MODE is processed before IFLA_BR_STP_STATE in
> br_changelink(), so both can be set atomically in a single netlink
> message.
> 
> This eliminates the need for call_usermodehelper() in user/kernel
> modes, addressing the security concerns discussed in the thread at
> https://lore.kernel.org/netdev/565B7F7D.80208@nod.at/ and providing
> a cleaner alternative to extending the helper into namespaces.
> 
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Andy Roulin <aroulin@nvidia.com>
> ---
>   include/uapi/linux/if_link.h | 40 ++++++++++++++++++++++++++++++++++++
>   net/bridge/br_device.c       |  1 +
>   net/bridge/br_netlink.c      | 18 +++++++++++++++-
>   net/bridge/br_private.h      |  1 +
>   net/bridge/br_stp_if.c       | 17 ++++++++-------
>   5 files changed, 69 insertions(+), 8 deletions(-)
> 
[snip]
>   #ifdef CONFIG_BRIDGE_VLAN_FILTERING
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 6dbca845e625d..e4bb9c3f28726 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -540,6 +540,7 @@ struct net_bridge {
>   		BR_KERNEL_STP,		/* old STP in kernel */
>   		BR_USER_STP,		/* new RSTP in userspace */
>   	} stp_enabled;
> +	u32				stp_mode;
>   
>   	struct net_bridge_mcast		multicast_ctx;
>   
[snip]

Not critical but there's a 4 byte hole in the same cache line betwen root_port
and max_age, if you move stp_mode there we get:

/* size: 1728, cachelines: 27, members: 53 */
/* sum members: 1722, holes: 2, sum holes: 6 */

vs

/* size: 1736, cachelines: 28, members: 53 */
/* sum members: 1722, holes: 4, sum holes: 14 */



