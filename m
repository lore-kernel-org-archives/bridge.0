Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512110;
	b=PLAAtKAE6nPXtdLw+iAVouOpNur76zgtigLxkfzspxCVYs7vrc5VN2TfvYIRCXiiKVse
	 Fk6Y96w8PPJGsiAv2cpe7B4/g0WhwvMnZD5A/ro2yZCHISasIgOJK3cx2XTZakTgjfYUp
	 43kf0hTr3zvKq07ZF8sG9obh784EPIbOxFLglwwETyicWIsst6xLTOXG6YKUNwcWeJ8GS
	 WrpJvMohCvnXIdb6XUpv4OtLQ62qJUBIt41PD0YUfs2dgu+QMkCFrRulu+dlWoSVoTT/J
	 kOywqrdKTqZjZnwnT3tzbluOAakFM2PMsp3vZ/49A/Cim3ylQCfRAcjz/g+QQTCP41g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ywL9EPsHehRIzLitHEixcM3pOk5E4q1NJt9LmnwsW2U=;
	b=to/Z0B6Jst24noUV+WRuCd29kVirFcvO++bpoK0bIxCdfH2gylNQtwt2D2S78tIQ7geu
	 qPfE/m/gzacgnUDvhIQcg0tOuBxSM6V1MFa0qNdNwhrQFbzXSc5dLnvefNOiIiwUIeBX8
	 Jqn4s4/44plN4zCngVFD1NCOlGnkwHVTqAFoe8XlD+oLG/GjOSF+4DkXi3oCOQ//OwAnL
	 y46p6LULvfbdj8ysbRF3eyzCjAYCsQVXOPor1PK2LBppsDz+ZHuhvD5/GhWlRG61uktK2
	 j7NhU5XnBDEjN6GFmRcYvc9J6kqKxSzKXid13XajM+QkFY0bkvYo4mtCH5N/hOKCUZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b="TN/dNB8x";
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EF0606A333
	for <bridge@lists.linux.dev>; Tue, 24 Nov 2026 09:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19EF0606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=TN/dNB8x
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so40269945e9.3
        for <bridge@lists.linux.dev>; Tue, 24 Nov 2026 01:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795512103; x=1796116903; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ywL9EPsHehRIzLitHEixcM3pOk5E4q1NJt9LmnwsW2U=;
        b=TN/dNB8xh4s8OUAd5Dyb4vE+K0Jl9fqR3gG5IXg+iL5aRQBmKvDjOYZNocnX90RYn5
         u9TOr4nYxNgTXtBqKcy7/9onLHNUcysH9KIW84eTLHndxgHsHP8yC8jvFCeydjmX+9bG
         wanpZiWoi5ZhMFBPmSCs90BMrz8fmuJgb/A+c+3OyCdpA8t79qctPUJrtEmYnQjhfCN9
         pA7ZDEzX/NzV9sl704BnFAtGA/QHGl1AI3F4kMpP58K/9x3lDGL4EhYOycREkqDzTwDP
         I8djSvezXaoAOAwppd4Nyk/uKdVPllxLiLwII0FkyKqjQU6kurPDOqyXwsgAu5Y1gMXy
         Ga6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795512103; x=1796116903;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ywL9EPsHehRIzLitHEixcM3pOk5E4q1NJt9LmnwsW2U=;
        b=EgB9r4yMGvdqQA105VNTziDwEj9KdbwwAF5q4Ytrfgtej6yhnPHGj1119/V+YuPv78
         sM5ePCMmKT1pfGrRkvhwcR5NDB8YaGn9BfJVO5icDUQf7+jEJ34SerNrffKiKcqacRnx
         yQX1MPqTRixXDoyAJeiIXXVUXXWPHTOLUxMhJjci4OiuD2KvDdpcFwI+ihHDeC1p5ZC1
         l41PcQ+B32OCTfdsyWac4qIWakWmLocWE6N1y55LViNImUXGOPvjz/Pq4LyR5x/lFgHR
         7bAkn5nBcnHV8EUsI/EwZocGhgF53/FiyFA6Gzz7h9mJZbyyD8CSExXooT8T6DxkaSEZ
         lHvQ==
X-Forwarded-Encrypted: i=1; AL+hErEFnzkCcLmGU3nmjkAEGHEQE1GkFXcd/dGtttO31wo202v2ClvxNsgev9UMv5EWDAib5aqJ70A=@lists.linux.dev
X-Gm-Message-State: APuU4Z/a63DxxiIsz9b9dnfhntczVRXPFDm5YrshnqHP/WP31JS1e3wL
	hBiArqnRtzuL+NRNJc5w87Ko0cC5pcjO91tFoCNoV1xhwH1tWrekYv2DFCASFN1Cv7M=
X-Gm-Gg: AZFdTZcajE6Bo8Qb95xxJMO6//kvIWyaJ6zGAQFRPVT9ye4kqK4FRcg2hc3Y8WBfZoK
	YUf+0auh66IUm8Ioqs3EWBsN+4xr6zV443CYdpZdfZRf2Llzczcxbq3ndfOiU2nLw55My/XIcNB
	Tw0xcr+n3ziGRM/SuoxIIJOYwkS/phRC+QL2Nckfrm2I2fW/D+WqN4NV9uDrPArJSlnagWLJewx
	xlNtt8UoiCad5dilHcqLx7caxTx+9enEaH9/toZbGwYckRCKSe5Z3q1JTfYpxNPevAdJW6RoKLx
	rlESlx4b2BQzk9BlwCUQza4xvWAV3yTBeqbEAcww9olNOHWYkYGgVTVrWxQ+Y6/2hc5VxhbjWGh
	VXC43vL2qoFzGGjFi6jP2mquC41zjMoJ6Sm0RPAIk7UJHSght+LTLxoRDtIiZOYueHV0YheDH51
	I+oKxr+RmMB58shEgDG9d8FkKFL3xIYnPXfeFrb1bUov954XLQZFsRlwfrbKYzipJmQW67gXTmS
	+udtN50YJB8LTATuN3USmOFucahJzTbcDIOYO8peTHPaHWXgYJqvyS6xZTBknuHcZoGBV3r8XaN
	l8hdvBQEiFSV3qVJTKVmPbjbtvWg1XukCY2UqE5KVx4+vPSd9CyJuF4B4mw=
X-Received: by 2002:a05:600c:820c:b0:49c:d019:70c5 with SMTP id 5b1f17b1804b1-4bb887876c0mr311188345e9.0.1795512103403;
        Tue, 24 Nov 2026 01:21:43 -0800 (PST)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a9687sm471537685e9.10.2026.11.24.01.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 01:21:42 -0800 (PST)
Message-ID: <9a0568ae-2f9d-4a25-9d34-65d1e74dc4fd@blackwall.org>
Date: Tue, 24 Nov 2026 11:21:41 +0200
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/2] net: bridge: switchdev state of fdb
 entries made dynamic or roamed
Content-Language: en-US, bg
To: Julius Bairaktaris <julius@bairaktaris.de>,
 Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Vladimir Oltean <olteanv@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>
References: <20261122192118.1204290-1-julius@bairaktaris.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261122192118.1204290-1-julius@bairaktaris.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/11/2026 21:21, Julius Bairaktaris wrote:
> When the user turns an fdb entry that switchdev was told about into one
> added as "master dynamic", the bridge reports neither that change nor
> the entry's later deletion, so drivers keep the entry after the bridge
> dropped it. When the bridge withdraws an entry from a port's driver and
> keeps it, which that change and a learned entry moving to another port
> both do, the entry keeps the offloaded flag, so "bridge fdb show" and
> "bridge fdb flush ... offloaded" treat it as offloaded while nothing
> holds it.
> 
> Patch 1 reports the deletion of such an entry to switchdev before the
> entry becomes one that is not reported, and clears the offloaded flag
> with it. Patch 2 clears the offloaded flag when a learned entry roams,
> right after the deletion is reported to the old port.
> 
> Both were found by an LLM review: patch 1 in a review of the
> series "net: dsa: fix host fdb refcount when an entry roams", patch 2 in
> one of __fdb_update() while patch 1 was reworked after its v1 review.
> 
> Trigger: patch 1, a local user with CAP_NET_ADMIN runs "bridge fdb
> replace <addr> dev <port> master dynamic" (or "... master use") on an
> entry that a switchdev driver offloaded; patch 2, an address learned on
> one bridge port is seen on another, as when a host moves, and the old
> port's driver had offloaded the entry while the new port's does not
> (DSA with assisted learning on the CPU port, entries learned by a
> switch). Shown in QEMU with dsa_loop. Impact: patch 1, the switch keeps
> the entry for the old port after the bridge dropped it; patch 2, a
> wrong "offload" flag in the bridge's view. No crash or memory
> corruption. CVSS 3.1: patch 1 2.3 (AV:L/AC:L/PR:H/UI:N/S:U/C:N/I:L/A:N),
> patch 2 0.0. Until the fix: delete the entry and add it again instead
> of replacing it; the wrong flag of patch 2 goes when the entry ages out.
> 
> In QEMU with KASAN, with dsa_loop given FDB operations and assisted
> learning on the CPU port, and a tc mirred redirect that delivers frames
> to a dsa_loop user port (test-only setup): a static entry on a user
> port replaced by "master dynamic", and an address learned on a veth
> port, which is a host address on the CPU port, replaced by "master
> dynamic" or "master use", are not deleted from the switch and are still
> shown as offloaded without the series, in 3 of 3 boots each. With it,
> each is deleted from the switch and no longer shown as offloaded, in 3
> of 3 boots each. An address learned on the veth port and then on the
> user port is still shown as offloaded with patch 1 alone and not with
> both, in 3 of 3 boots each.
> 
> I used Claude (Anthropic) to help write these patches.
> 
> v2:
> - net-next instead of net, so without the Fixes: tag; the commit that
>    introduced the filter is named in the first paragraph of patch 1
>    (Nikolay).
> - Patch 1 clears the offloaded flag with the withdrawal: a "master
>    static" entry the driver had offloaded kept it after "replace ...
>    master dynamic" deleted the entry from the hardware (Nikolay).
>    br_fdb_offloaded_set() assigns the flag instead of toggling it, so the
>    clear cannot be inverted by a concurrent report.
> - Call br_switchdev_fdb_notify() directly, no helper (Nikolay).
> - Drop the comments in __fdb_update() (Nikolay).
> - New patch 2.
> 
> v1: https://lore.kernel.org/netdev/20261121191638.1724620-1-julius@bairaktaris.de/
> 
> 
> 
> Julius Bairaktaris (2):
>    net: bridge: withdraw the switchdev entry of an fdb entry made dynamic
>    net: bridge: clear the offloaded flag of an fdb entry that roams
> 
>   net/bridge/br_fdb.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> 
> base-commit: eb6d6c80d35449c27471b1874f13066c09a8964d

Hi,
I've been thinking about this and I don't think it really improves the current
situation. The problem is that it introduces new race conditions with the bits.
It fixes one problem and introduces new ones that might be worse.

I'm sorry but I think the fdb flag management (and potentially fdb itself) has
to be designed in a different way to avoid these problems then it will be possible
to fix these issues reliably. I don't think it is worth going after these corner
cases that never worked and risk introducing new race conditions in current fdb
state.

Let's see what others think, too.

Thanks,
  Nik



