Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0C34A4F01
	for <bridge@lists.linux.dev>; Mon, 21 Sep 2026 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000082; cv=none; b=s2qLUvDyVPx1GiFw65t9JdK/WZbsw2zeXc59lmIeRX0SqZO1qP3gvFAn6FhFr8k9zuJ/EdKog4tDRqEiX7rk45h9CDOHLJnv8nPC7HwAL2QO35QjVVb1fTun2dn2xClAyYLvol/J/2/l7/CxsiwpJfxgFiM1OchBSTDn1Cb0AyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000082; c=relaxed/simple;
	bh=A3lMAoHzvdrIRHmu0U9O1DHYioyKBVDwytLfoEf9Ugk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjeS3cpYIRgSFGV8UrXQh9Ozrz07uS8iAFylj9nbPOlDPJ5q6cb18Gy8mjwrKycFNSIUXA36A6gBz/nM6NVjxJjk7Kmk8sezn71NMm0y3DSMQKy/SVLmAuYQSJxNjJA95q7r9BQSJRa/FaHStIJo9u7sPwU+I5WllTZp3n/R+8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=A82UDoCI; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="A82UDoCI"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e620fa473so18091145e9.1
        for <bridge@lists.linux.dev>; Mon, 21 Sep 2026 07:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790000078; x=1790604878; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+gnaVA0UVg6a41pLazpe1rvpHFpADsMibbWOKFLPcI8=;
        b=A82UDoCIltGv/5ZC/9qSF97RypLU0C4ZFQOM8CRcjypxPVAwp6a00q728399jQsQSO
         Rcm5EtWVSEy7/TU741TT5xku9usAgPgrl43j1vN1k8DLauEL3bEw+S6Brxu2gSPQf6Bb
         FBv5f9at0pCbHzdC7s11xYXilTEZLcK0FLcureCcrw23udc9oGmTqkR+4oG3kHz5xnFp
         Onkriegfc4+2OaynkI29dtkwynps/tdj9ENZWztp2noQ+eyOc1Bd8GOzXiBSs0E6NiwQ
         gCa9azLgfP/Gg6c2odwpaEQmDF/Ov5V2O5GfE5hUidDPYTiyyDjLBaDds+yEbQA910pL
         eU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790000078; x=1790604878;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+gnaVA0UVg6a41pLazpe1rvpHFpADsMibbWOKFLPcI8=;
        b=yEDedov3UqdamSer/dqifbK3RujtvpD+upBcMARKxCkIJHooFhYrOz/OyM9m+uQptL
         AlrBpMo200cUmQqb5tk0EsUlsfWpx6eLtdmHXZRR0kYlUmcYnP5B2rrFX83VcYn/SRmE
         lo8/MCg3oP3WNHEL+4dJjXUZyUffE8SUTYGULUfnGs5nLmYfkkJ/yoy9ran0Bsx/OzPS
         od6ccnmg+PtgKrkh4rvyd1ddbRmVbjZufAmcwrpA4397DiMjm35zifZBKj4xxEU9riQ8
         9Fbv/gC4bcUKPQV45cy51ywZVUUH6ahbf384aex+jUpRurkDk3YdGk26AdBKxWtx4Zjp
         LVdw==
X-Forwarded-Encrypted: i=1; AKwUvBw4h9PTDKbozlxS8f7NXj9qH7Ia9Ebr4TZCNnl/mGsHCN+2/Ett2N1Xq4Sv2UrxMpnXy212AW4=@lists.linux.dev
X-Gm-Message-State: AFuF++k0D74Mkl7b2bvrF5Eac9Vbuu4FOivF6zWuTfHvhBcAVnic8NY+
	vopWQtHXEVnesjTSegTPgS6EHdf5ZHgXgakHHaO2DmnX602nFmKdi+dfv5IRfqc4+wA=
X-Gm-Gg: AYBFou22TcV3cjUN8GHQ7UC+00BdFwXY+U3Om1jMdyxvVLmeASG+KVomE4gR3kojHJB
	oWBT4SN5Gw2ec/2CCILXcvjZ802XNj769nuQ8nCLW4zi912Yc2s9pzN894J3dW8XxW9wcAIFXr2
	qVltuw/N0Gnx9eEJO7ZlqIfee84tkZAFBvfp0SgfQXsx5mvEcSOjy1unu411KBvcMXp2GsY2lP/
	mgc+D7324lPfHZwAqVSNF//ejnN+CtYirb+mhG02Z2rGZtxnyv2XP88rOJTSxVdqoNyZFKuPmyJ
	MZg0XwSEGJlO3YqvtkcKEdbwGH75sEBdG0KVVVB8Fe1Z1Fp4rRWE/Kgmn6juMNlmxy6S0Pm7Z1a
	BWkEHBJeYY7aAXBEUWLmTw/iRuWkKGYtKQNXNMfLNoNkV/lmwOhik6a0nnCn4nPzJQgTS90tIZj
	+vXD/LxjssVL0ZqEf9OVml38i7eGnKxIqJa/XoPRz1sgSE7Q6k7ZD+Y2BVj0LkuOWVbWVhMTk52
	fc6FzVeYAtYzvktl5ARH6IXv9VrjA==
X-Received: by 2002:a05:600c:3b8e:b0:49f:bc43:9e96 with SMTP id 5b1f17b1804b1-49fc57144aamr194759525e9.8.1790000078224;
        Mon, 21 Sep 2026 07:14:38 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-487244229d5sm24216068f8f.2.2026.09.21.07.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 07:14:37 -0700 (PDT)
Message-ID: <ab670ef7-7650-4a39-9871-b5182725beb1@blackwall.org>
Date: Mon, 21 Sep 2026 17:14:35 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: mdb: restart port group walk after
 deletion
Content-Language: en-US, bg
To: Fourie Zhang <littleddfu@gmail.com>, netdev@vger.kernel.org
Cc: TencentOS Corvus AI <corvus@tencent.com>, stable@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Petr Machata <petrm@nvidia.com>, bridge@lists.linux.dev
References: <20260920110852.60293-1-fouriezhang@tencent.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260920110852.60293-1-fouriezhang@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/09/2026 14:08, Fourie Zhang wrote:
> br_mdb_flush_pgs() keeps a pointer-to-pointer cursor while walking
> mp->ports. br_multicast_del_pg() can re-enter the same MDB entry through
> br_multicast_sg_del_exclude_ports() and unlink other port groups. If the
> cursor points into one of those groups, the next iteration dereferences a
> stale cursor and can leave mp->ports pointing at freed memory.
> 
> A following RTM_GETMDB exposes the dangling pointer:
> 
>    BUG: KASAN: slab-use-after-free in br_mdb_dump
>    Read of size 8
>      br_mdb_dump
>      rtnl_mdb_dump
>      rtnl_dumpit
>      netlink_dump
> 
> Reset the cursor to mp->ports after every deletion. The deletion removes at
> least the selected group, so the restarted walk always makes progress.
> 
> Fixes: a6acb535afb2 ("bridge: mdb: Add MDB bulk deletion support")
> Cc: stable@vger.kernel.org
> Assisted-by: tencentos-corvus-ai:hy4-preview
> Signed-off-by: Fourie Zhang <fouriezhang@tencent.com>
> ---
> A reproducer for this issue is available if requested.
> 
>   net/bridge/br_mdb.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index e0c7020b1..a01bd280c 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -1523,6 +1523,8 @@ static void br_mdb_flush_pgs(struct net_bridge *br,
>   		}
>   
>   		br_multicast_del_pg(mp, p, pp);
> +		/* br_multicast_del_pg() can remove other groups from this list. */
> +		pp = &mp->ports;
>   	}
>   }
>   

Yeah, this seems like the simplest fix for stable. I will post my conversion to
standard list primitives and will remove these issues altogether with it in
net-next.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

