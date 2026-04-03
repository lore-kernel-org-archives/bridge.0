Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8593C5550
	for <bridge@lists.linux.dev>; Fri,  3 Apr 2026 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775228353; cv=none; b=NBEivCEvWy2mJ4bGedKs5ks50Y+6QAbcFU2VSiKV3TLnrEfRkrzOAOTp+UdMqJlrIrDIp0O/VeY6RUJl+fYzH0haKWT9BQDIJexX5gBhsFH8x32iObt1czACjSzw4XJEWY9JLBAU7CTByZpe5x+Mhq0EJAfbx0k9uBEw82K3cyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775228353; c=relaxed/simple;
	bh=Xbc4Ra681nc48aNuM3ATdRJApIcuteTB0BIdE8dIwPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6cdxXrQJifurRbU2XM2dX/lw1CMVRrZQraaGm/pmuGniqbjc5Iqm7GkfVdngfgYeeGwaFpunh9iD5fuo42EERjJi+KLd3rVOEnlyBphRmz8UUiP5ddyz3C8bzOIfnGbgrdK2Ziwn2rwIinBRFA5MWPPeDHt0cGFQMlpKsqxNMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=NYJxPhOe; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="NYJxPhOe"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so1150477f8f.3
        for <bridge@lists.linux.dev>; Fri, 03 Apr 2026 07:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1775228349; x=1775833149; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kGPv9Bco5NsmxbV6+XT6L0Y0xbtKDX3C4wt1tJqNE8Q=;
        b=NYJxPhOeuAO5Tub0uXv9aZ5RPR8qdf2KpqXowvjkhCoAybaESOEtA8Qfk809kOY+T0
         pwFfewioCfngcZVg8BhMvlWvRzBzfljLWnrI2/5SOTv/PbHdvV/h0LSLeuGiPJQF/J8i
         v4meRUbpozMt83hQAylxHsn0VaUwhz9oiHyN+6fvKljLJ8CB9gp8ZTU9OCGM9MH8jojA
         7jOXqipUX0f6dC1aY51DUdR103JB0rF4C8gHGOgTxPOltYkZ8bmZEQ3akk0Q2ceR4Y70
         vMPkQmiKcxCJiHXDrE9EgOWMBWt16JfvuJ/OcKzVRZWCB5mEhCpulGQ1p6Ohli0m4xLQ
         qbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775228349; x=1775833149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kGPv9Bco5NsmxbV6+XT6L0Y0xbtKDX3C4wt1tJqNE8Q=;
        b=tEuWlRpfe4fcznGh7VFPS0b4N+xG4Q7cNgR89JFiz+uFrDNSHFRpwSUaqygLfo64gw
         o4ZUKnQN+ab1b9d0GrCs3y77emGp/mIBZvUtKSgcQCaG5z5ZB7u6ydDEbAtEOemS/Kkg
         eImF+L7WE9dMzydLf4nzrUqj68BVg5cN6EY6LJYHD6o9oVr+OCYDCpn4C4OskuILHFeF
         RrPzi13/V1eGZi+oskFVwYq87svPQISPgQ1XBgucxW+jpjxGfMCzp92zHDrnbMdm0RJ0
         4ND5oUW3YrmcERDOfX+c8ZTCQQotX0kU6ms7E0lxYdpifws7QeaxexWasX3zvQdgwlk2
         D1Vw==
X-Gm-Message-State: AOJu0YyhTGWKEMgwdnOF7Ea2IeVmxD09Xb5q+XUf7Y50uLbyDN9THnIe
	q4DFyiO+wZKj+5nwAgMLotavWZB0j34K5zhZfIHVPo+T5bHCdZzZlYTV67yTWysjM/Q=
X-Gm-Gg: AeBDietbIdUVn0LSA3n13wVntXzlFGM+JGiRI5pceastLaswcaUlog4xgfBSD7ZhN1D
	CfXUyZoEdLdTzqR/Bnrxmp5JPhMR4QTgqqyPP8/tqsPnx25ub/KVdQY8WUgTtfxa+FcPIzK70ea
	j+UYbr1LJZWQrr8R1MqMemCZrqXzc1jDKhw3d/f6osicdEmkVlg19cQxRRxu09bSAUtYXOhQEiw
	kFZc1g1Z0+JGvA7IXAoBAuKaDgTNg+vpkF1lJafbZGlM8KM9SFIbYOszH4ICiKs9Dp21u0ShZJa
	UXSmG2TW0GX0g+P5Dx0mpLYglihu0Vt+aXuJIp/eCJMZ+qH1pIrOQTqS5RkKGJnZS2kVtCFduej
	NkUPm/iHjLgdzHfuEnMJh4ATWfbbbHhCQbTx/07uHhjlmrv52VzBzlfGBiOOstkkByX1cGvEhEA
	NtV6BdvSoRhCrK8cKht3M93IG+P6Cn09p39ncafM6xqP8QZLpChDzIYA==
X-Received: by 2002:a05:6000:4382:b0:43d:60d:944b with SMTP id ffacd0b85a97d-43d292f1452mr5756991f8f.37.1775228348596;
        Fri, 03 Apr 2026 07:59:08 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f1a99sm18426635f8f.32.2026.04.03.07.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 07:59:08 -0700 (PDT)
Message-ID: <98bdaf08-6bff-4ea3-9e74-65b41da1447b@blackwall.org>
Date: Fri, 3 Apr 2026 17:59:06 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bridge: guard local VLAN-0 FDB helpers against NULL
 vlan group
To: Zijing Yin <yzjaurora@gmail.com>, netdev@vger.kernel.org
Cc: bridge@lists.linux.dev, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, petrm@nvidia.com, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260402140153.3925663-1-yzjaurora@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260402140153.3925663-1-yzjaurora@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/04/2026 17:01, Zijing Yin wrote:
> When CONFIG_BRIDGE_VLAN_FILTERING is not set, br_vlan_group() and
> nbp_vlan_group() return NULL (br_private.h stub definitions). The
> BR_BOOLOPT_FDB_LOCAL_VLAN_0 toggle code is compiled unconditionally and
> reaches br_fdb_delete_locals_per_vlan_port() and
> br_fdb_insert_locals_per_vlan_port(), where the NULL vlan group pointer
> is dereferenced via list_for_each_entry(v, &vg->vlan_list, vlist).
> 
> The observed crash is in the delete path, triggered when creating a
> bridge with IFLA_BR_MULTI_BOOLOPT containing BR_BOOLOPT_FDB_LOCAL_VLAN_0
> via RTM_NEWLINK. The insert helper has the same bug pattern.
> 
>    Oops: general protection fault, probably for non-canonical address 0xdffffc0000000056: 0000 [#1] KASAN NOPTI
>    KASAN: null-ptr-deref in range [0x00000000000002b0-0x00000000000002b7]
>    RIP: 0010:br_fdb_delete_locals_per_vlan+0x2b9/0x310
>    Call Trace:
>     br_fdb_toggle_local_vlan_0+0x452/0x4c0
>     br_toggle_fdb_local_vlan_0+0x31/0x80 net/bridge/br.c:276
>     br_boolopt_toggle net/bridge/br.c:313
>     br_boolopt_multi_toggle net/bridge/br.c:364
>     br_changelink net/bridge/br_netlink.c:1542
>     br_dev_newlink net/bridge/br_netlink.c:1575
> 
> Add NULL checks for the vlan group pointer in both helpers, returning
> early when there are no VLANs to iterate. This matches the existing
> pattern used by other bridge FDB functions such as br_fdb_add() and
> br_fdb_delete().
> 
> Fixes: 21446c06b441 ("net: bridge: Introduce UAPI for BR_BOOLOPT_FDB_LOCAL_VLAN_0")
> Signed-off-by: Zijing Yin <yzjaurora@gmail.com>
> ---
> Tested on Linux v7.0-rc5 (upstream tag) with clang 20.1.0, KASAN
> enabled, CONFIG_BRIDGE_VLAN_FILTERING=n.
> 
> Bug independently reproduced with the attached C reproducer
> (repro_br_fdb.c). The crash triggers deterministically on the first
> run with CONFIG_BRIDGE_VLAN_FILTERING=n on a clang-built kernel.
> 
> Exact crash signature from reproduction:
> 
>    Oops: general protection fault, probably for non-canonical address 0xdffffc0000000056: 0000 [#1] KASAN NOPTI
>    KASAN: null-ptr-deref in range [0x00000000000002b0-0x00000000000002b7]
>    RIP: 0010:br_fdb_delete_locals_per_vlan+0x72/0x3f0
>    Call Trace:
>     br_fdb_toggle_local_vlan_0+0x3d/0x1d0
>     br_boolopt_toggle+0xba/0x1a0
>     br_boolopt_multi_toggle+0x129/0x250
>     br_changelink+0x1100/0x1490
>     br_dev_newlink+0x115/0x190
>     rtnl_newlink+0xe15/0x25c0
> 
> Note: gcc 13.3 with the same config optimizes away the NULL dereference
> path (UB elimination), so the crash does not trigger on gcc-built
> kernels. The code is still incorrect regardless of compiler behavior.
> 
> Reproducer (C source): [PASTE_URL_HERE]
> Kernel .config:        [PASTE_URL_HERE]
> 
> To reproduce: compile the C reproducer with `gcc -static -o repro repro.c`,
> run as root on a clang-built kernel. The crash triggers during
> br_dev_newlink() -> br_changelink() when the boolopt toggle reaches
> br_fdb_delete_locals_per_vlan_port() with a NULL vlan group. Note:
> RTM_SETLINK on an existing bridge may not trigger it due to different
> code ordering.
> 
>   net/bridge/br_fdb.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index 0501ffcb8..e2c17f620 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -597,6 +597,9 @@ static void br_fdb_delete_locals_per_vlan_port(struct net_bridge *br,
>   		dev = br->dev;
>   	}
>   
> +	if (!vg)
> +		return;
> +
>   	list_for_each_entry(v, &vg->vlan_list, vlist)
>   		br_fdb_find_delete_local(br, p, dev->dev_addr, v->vid);
>   }
> @@ -630,6 +633,9 @@ static int br_fdb_insert_locals_per_vlan_port(struct net_bridge *br,
>   		dev = br->dev;
>   	}
>   
> +	if (!vg)
> +		return 0;
> +
>   	list_for_each_entry(v, &vg->vlan_list, vlist) {
>   		if (!br_vlan_should_use(v))
>   			continue;

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

