Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE86D4AC151
	for <bridge@lists.linux.dev>; Wed,  2 Sep 2026 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369734; cv=none; b=W1vU6Gk20CjIyuuckBwKe6AX/eNLFAtUwut3oJJy82fXPMQGWiD6UJ4OamRUSW8cpVQcgs9kKPF/A5JKc1I4KxQDr5bRkqLzznJX47nFb5Wwg0TX1n/wVH/izdMEb0SCNMroiahyRLNBbAcIihUQKTvu1l+RPcaVbCt7UW6e870=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369734; c=relaxed/simple;
	bh=Q5DK1G97KTMlUErFw1CUNFPSTqbW4BDX8xhS3lMwgEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fuh4Hyv0nwwPaWFxS9vxXWUs5YwYnTkE8y/TLAF6wZl+DqTYtGgkyyG4k2wta2h7Aczbk67jCBpnlwGRLbcS5IsZwG8XHLrNBSGpR0hEBTvq3UO3Xig23HqzIyREyQ7lFoOuSZq+kbpCcR5qc1b89VgJa2lv9RZ5nyxwTZTrR3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=JNmsUSsj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="JNmsUSsj"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso10539115e9.1
        for <bridge@lists.linux.dev>; Wed, 02 Sep 2026 10:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788369730; x=1788974530; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O3/eSEpY/gP/GSNY8aB6oKR8wAN8w8cFh3G1lwGQkJI=;
        b=JNmsUSsjS4/6+vklf8jb3V3gdPYr9PZs9DO8QiMK+D1lyC3abQZ1H9o6q+NndRt4lk
         cN0w0Eb0eUOZhxMpnFTbFgHaz9toK9XTjfU/ObWqjKVVldsPX+ivpzDwMziue7pdCl+k
         7xcTk2AAFqWYekWtd1papE0gNNqahZcmTmF9FGr8JThO/89mLYNhGKzxfZQEWKHW8qtP
         +kWxYBZKI6iGGgvNXnzNMmOeLwQsFoYDehsj6S3Uhy76fp/NHckUCEdGZUZFweEPSuCZ
         y/L2dBaWvYB3qPs3yinVrd+3/BE7n9ogjUBj94esPTHWlbsixxU/q2GPexanu+NWZswI
         erQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788369730; x=1788974530;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O3/eSEpY/gP/GSNY8aB6oKR8wAN8w8cFh3G1lwGQkJI=;
        b=tNleP22UBccn2FzsaVosm2pUyI75dodNMRuJ4EI3xVUvgB8ZkPzagPPo28rspUsdCB
         jsmEUi1QFI9jH8csquB9jDfkqrrf9iw8rzKDT91lMT70vP2H2AhJcjEJXztnLOAwcA1i
         o2tOOwXcBgHHnkfxd0uYsxnrxXvl80U55NCCEO+zhJvWlHJmOZcN8P2oZSS1u0yhwM+Z
         zN4HKYSwL1kONagzGrzuG2qp7B2qBZqkC8ZswpLEM305KM7OIBtRpmlmKN9lAHx1miR5
         EVXenJPjlLhEIMszasu8PgwDBAPJGa68TPw8HX1aAjCzVRaWzbwqCFXvIcY5pNQ96rjc
         qksg==
X-Forwarded-Encrypted: i=1; AHgh+RqM3qkc+bUEXr47ZRhvV7gIk4HYlR7F3OEdw+PTPw68zqQsUdi4n6dkkNAZIcKM9sMmB11iCbA=@lists.linux.dev
X-Gm-Message-State: AFuF++k74msDzzWI9zYXG2nvfinqcRhm535Zg92VvLcLS49D8cJ6vjBO
	A4WgTOWVhxaJNObXuIPanZZ28BxCzAstgL7OpxbzbXnUjQ1J/dyocqYBAEHE4xlZcxc=
X-Gm-Gg: AR+sD11dlUy/otqeMtnaWjsKrl+KHmFzYPnsn+wd6T50d/DoUN09nNQtGW348x3mdFb
	bEfB2wNHl1k1yxIlf0FXIQFewEWixAqNSCgVNRkbtXSr7V3VF6MyLaNXXL14ekzLPYlB8QDw0bO
	gGv9PcSjFPCHPNN8TdMHapX/ZKWVp6QTTWkD0Wnbe7JzbnpXR2JlQIr5yRCc0xZgQgk2lo9tgbx
	4mb+Ko1bkV2uM96EXy5QzzmmB2hb/hVvzuEenqyKnl/cg1YQfM9BHUxqKmtLdy2xbyqo5No478p
	4SmnjxAsGsDiHel436/HoAA93fGFW3uUthcrHgV9mVBewEocpglYCJGpscZhbDFcGL34J+h++OO
	LXGg8DXRPDLbAUwKJHJGzTtHgBO/4ascjmYlGf03oRacu95BP2MIUQFBMlTbH3WJ/MPiqc5d3Vq
	c3dGMJ4dcy+9yAPw61M6nrz2wCvoZGu+Hznv2IizxafYZVAt0APpqeOrcvV1UiKol8SJqtjzzpA
	UX9v/G9fFlfpxx9ZtQ=
X-Received: by 2002:a05:600c:4e8f:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49ce57f5647mr97861815e9.1.1788369729740;
        Wed, 02 Sep 2026 10:22:09 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60bae6sm6684765e9.9.2026.09.02.10.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 10:22:08 -0700 (PDT)
Message-ID: <239e8a53-fb02-4021-8f74-6c232e9c9b6f@blackwall.org>
Date: Wed, 2 Sep 2026 20:22:07 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/9] net: bridge: vlan: minor cleanups and
 annotations
Content-Language: en-US, bg
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bridge@lists.linux.dev
References: <20260901120721.747908-1-razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260901120721.747908-1-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/09/2026 15:07, Nikolay Aleksandrov wrote:
> Hi,
> In preparation for a complete vlan fast-path re-work, this set cleans up
> a few minor things - removing legacy code barriers that don't help,
>                       annotating lockless accesses and using proper helpers.
> No functional changes are intended. Sashiko will find many pre-existing
> problems, none of them are related to this set. I will try to fix
> everything pre-existing separately in -net, there will probably be a few
> critical items. So if there are missed places to annotate, or if there're
> actual functional changes, these obviously should be addressed in this set.
> 
> Thanks,
>   Nik
> 
> Nikolay Aleksandrov (9):
>    net: bridge: vlan: drop legacy memory barriers
>    net: bridge: vlan: annotate lockless pvid use
>    net: bridge: mst: use br_get_pvid helper
>    net: bridge: vlan: annotate lockless vlan flags use
>    net: bridge: vlan: annotate lockless use of private flags
>    net: bridge: vlan: annotate lockless use of num_vlans
>    net: bridge: vlan: annotate lockless use of msti
>    net: bridge: vlan: add missing tinfo.tunnel_id annotations
>    net: bridge: vlan: use br_vlan_get_state to get vlan state
> 
>   net/bridge/br_arp_nd_proxy.c   |  6 ++++--
>   net/bridge/br_mst.c            | 12 ++++++-----
>   net/bridge/br_multicast.c      | 18 ++++++++++------
>   net/bridge/br_netlink.c        | 10 ++++-----
>   net/bridge/br_netlink_tunnel.c | 12 +++++------
>   net/bridge/br_private.h        | 16 ++++++++------
>   net/bridge/br_vlan.c           | 39 +++++++++++++++++-----------------
>   net/bridge/br_vlan_options.c   |  6 ++++--
>   net/bridge/br_vlan_tunnel.c    |  2 +-
>   9 files changed, 67 insertions(+), 54 deletions(-)
> 

Me and Ido had a chat and he commented that patch 09 is far from done, I missed state
accesses outside of br_vlan.c, silly mistake. Anyway, I'll fix it up and post v2.

Cheers,
  Nik

---
pw-bot: cr
