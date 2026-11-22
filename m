Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795343010;
	b=O3NBCbJrH4Cy8UYhis5qfFD8Ym2JS/LgeG+BtpRNrDsoaBtFgucqAR9X6x01fGqmkVjk
	 wDyp9y1uCHJMWwHzBqT5XMV31Pz5o9Ch30ezyLMKl23ScPjqkwtIrrtf8OnyMygsfspw5
	 4ZS2h+hfi5lJNhoQaJvj1DyFJE9ZN3V2cdJa0Ug3VrX+85JZmb7JUQjmLeK2IAFUGnEBO
	 HSrOxr0zGZYzVyKV76O/XOOOnwD7Fmwv0GceKSumafuIDpBFpvdw9sQQZn45MiWJ7qjx4
	 UlEmCvOaYfHgDg6yKXpxhVX95DRbsygW2x8ZtulcjtWcE6fe9094ouwcPkxhTy3mgqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795343010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=DS50kc0yp+XKmRK7kU59nKs7lLs5n+2L5Ptw9GISEyg=;
	b=WdCj+nH0X9VoW6POcVIQd+4duaXq8mBuI5Usl3wS2dEHso1+RWLTIo96IGybiIBwYqNR
	 sVsak2a474Fqr6YvkSFGOjkX5i1ZI24u8di2JGdeGrKHdaRt4ZCKUgcfYnJOfBRSLi078
	 pf0AepUdLsKIA8evA09upESvB3HdkeDzcY5Sa4x6hXwIcwByZVq2y41xq3aH4SbVkUQcG
	 vz2sjhjTECFkheaGckFnrVwp5dxQuf/5NMO31OBlREs3tkYkmhHifPesbwyTiKGOpMceu
	 IH15znygGvTi/xu1ozYMpdtUQ7fP/eYjEdlPGcE2jeftRrqYCqlS6zgfRVf3s81M+BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b="kk/a4re7";
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB5E606A32A
	for <bridge@lists.linux.dev>; Sun, 22 Nov 2026 10:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBB5E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=kk/a4re7
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4a357b1c649so1359433f8f.3
        for <bridge@lists.linux.dev>; Sun, 22 Nov 2026 02:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795343008; x=1795947808; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DS50kc0yp+XKmRK7kU59nKs7lLs5n+2L5Ptw9GISEyg=;
        b=kk/a4re7iNlFFH0J7gA6dl2Jnjo1r3R0xaCDM+zQuBrZD+vxwOWdrmFIvEJ8RoXesp
         /AkHpRjCNbVTLJ8R5cKzCNRJxeiQ04b84cV3y3s9UU2A5MEXwFpevmbqPqB3keV8lq1m
         xM6ZR2ewp46IUQM7CL8jjDtz+rvZqlx3YwCIYU22Rv7FjuqS1MHcs3bZVwYlru+gEiR2
         Fuh4z9DTaHHIClke8HNpyRV9pY/SQmOCvumwh80qJvFGgAnTb50Ib4h2FtdBsG+eLc3q
         qrO6EvuxObWVQgzfZYx/jOEEhu4zrKTES3g7ib1du83XlVS7zMPFdiZPCwE1DFqi1Rii
         ImSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795343008; x=1795947808;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DS50kc0yp+XKmRK7kU59nKs7lLs5n+2L5Ptw9GISEyg=;
        b=uM/RzzIWuuN7HJzTKMglDICtTuMl73iKKuy7shdpLQxP9RhpSN8CPDNWwhZQxPkER3
         W6WtD5B/tlrcEHM9rICFUmwmQ313xWFcYgCMATvh+WfIlYB1Mpj1G4oSth8AoTiFtnhp
         RArKkhx2pnNCE2fHLuTu/vcnmOfk/II9+56mZogdfsa7AKSlzdSjG4NQfurxK9/KPe7o
         w2pWXasKp4Z221AXZ1wHh1YKRwah4+RCxtSl23Thqi7Huu6NjB5R9bWlcfPHjcEVZ4AF
         MLyKn5JyRErkAt7SeULTDD/DA56nHcw/A8j76k6xOUCRkR8zIQes2yNMK5cFxFQqgQZl
         7Wjw==
X-Forwarded-Encrypted: i=1; AL+hErFbfNVQHtWA6uYrixWcQOIgwIhv3umhQNDgH8F0qOTQtq+a2YznU0xz7hT8f7/fZ4uqdBPx+lU=@lists.linux.dev
X-Gm-Message-State: APuU4Z/aWNLIDyoH4iteEzEH2JFZonCV2SJ0gX0I9gcvA5S2wm+rOKrC
	b/R2NzZYGd58XHISnBzp5/VNkrWU7LX8Z80j0s6uWAsnTXnNUH8JuxuiPmcEf4OimbA=
X-Gm-Gg: AZFdTZdujXbCDtmkp5lwIA1xK76vHMWCQPmnL8AJ5eU8Q/MceNFo7HRJGg5Ox5Li2Ay
	hKX1Xem2dUz8BsCkl3Bj9vl5Fb3B1S9gpExSioKZw287pFyC7P3V4kzDDdkQSePUA0jqM54ErJe
	jJEuFLqrpA15VxUo02Uox0f5baJJ1oB7SltxQpD8mbSgFJKxRCmOf2q9wfddHe8h+FAT+GX193t
	P1dws2VbjL5hYdibd0+21cMNh6HjlBnBv+wTmpOZkU+EInm6JcRCNvIrmR63a0hil5jjK/0kgc6
	Ydz5GrRICY2UMZpl7gXMWOJav3KQx+AMQums1/lGDdGohcQjl5MgHcCSs5bGfMPn6FLEtaTlOb4
	/hGucM9LTF/Abu2aKDk82b3z5PnsSWi6n4AobgsikSVOZboAi3SegwaITW7AjDCgOFH6A071Qzm
	31HxZZFgr/9rjSTZi8MC3C9gH0RseO7pYtO8qfZz4hAWzg9+t7QASyWSj4hxXF6GJ9KKJx2Q4fa
	Szwsk1l+9od1eW9yEvETlSVNt5CBnKpQQczwFHwx9Tdr+2J3sTV/Wx6S0fDwOptnyNeWKGkCMFg
	/Lw5CLpONKJPv1x2DB+fM7NUcXgH/MRfwo4DOW3l7OHLjKA8DbdxCkrWfDI=
X-Received: by 2002:a5d:5887:0:b0:4ac:84c:70df with SMTP id ffacd0b85a97d-4ac085bb48dmr15752832f8f.45.1795343007899;
        Sun, 22 Nov 2026 02:23:27 -0800 (PST)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f1b2sm14830205f8f.25.2026.11.22.02.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 02:23:26 -0800 (PST)
Message-ID: <44b34f5f-742f-42eb-be7f-0cd731ff565c@blackwall.org>
Date: Sun, 22 Nov 2026 12:23:25 +0200
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
Subject: Re: [PATCH net 1/2] bridge: mcast: Fix source list rollback on
 failure
Content-Language: en-US, bg
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, willemb@google.com, horms@kernel.org,
 dsahern@kernel.org, shuah@kernel.org, bridge@lists.linux.dev,
 linux-kselftest@vger.kernel.org, kyuwoncho18@gmail.com,
 stable@vger.kernel.org
References: <20261122072504.2623702-1-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261122072504.2623702-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/11/2026 09:25, Ido Schimmel wrote:
> When the bridge fails to add or replace an MDB entry with a source list,
> br_mdb_add_group_srcs() rolls back the operation by looking up and
> deleting the source entries of all the sources that were already
> processed. This is wrong for two reasons.
> 
> First, with NLM_F_REPLACE, a source can appear more than once in the
> source list. Its source entry is deleted when rolling back one
> occurrence and the lookup fails for the other, triggering a
> WARN_ON_ONCE() [1].
> 
> Second, when replacing an existing entry fails, sources from the new
> source list that already existed before the replace are deleted together
> with their (S, G) entries instead of being kept.
> 
> Fix by marking source entries that were created by the current operation
> and only deleting them on failure.
> 
> [1]
> WARNING: net/bridge/br_mdb.c:901 at br_mdb_add_group_srcs+0x310/0x440, CPU#10: repro/304
> [...]
> RIP: 0010:br_mdb_add_group_srcs (net/bridge/br_mdb.c:901 (discriminator 2) net/bridge/br_mdb.c:924 (discriminator 2))
> [...]
> Call Trace:
>   <TASK>
>   br_mdb_add_group_star_g (net/bridge/br_mdb.c:1021)
>   br_mdb_add_group (net/bridge/br_mdb.c:1082)
>   br_mdb_add (net/bridge/br_mdb.c:1097 net/bridge/br_mdb.c:1360)
>   rtnl_mdb_add (net/core/rtnetlink.c:6925)
>   rtnetlink_rcv_msg (net/core/rtnetlink.c:7178)
>   [...]
> 
> Fixes: 61f2183512a7 ("bridge: mcast: Support replacement of MDB port group entries")
> Cc: stable@vger.kernel.org
> Reported-by: Kyuwon Cho <kyuwoncho18@gmail.com>
> Closes: https://lore.kernel.org/netdev/179489219555.3099318.10297266282803881244@gmail.com/
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_mdb.c     | 29 ++++++++++++++---------------
>   net/bridge/br_private.h |  1 +
>   2 files changed, 15 insertions(+), 15 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

