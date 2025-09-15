Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592192D46AF
	for <bridge@lists.linux.dev>; Mon, 15 Sep 2025 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976083; cv=none; b=Qif8Cz/gmZqMtS7knLR47tEH48U+QE/x1d4SXjnWni/GLhnk5lxCRrusFuya1/rBYybn1vudsmZ/ZmeAV3avdilZ+xmmiz5d3E4XTDQ2H0H9AKV5eqDEAtdP5DpK9sGRiDajGJq2AvjoZcr8ScQa8S2/K1kgpIo98us1rf3B4RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976083; c=relaxed/simple;
	bh=/FpEkskje8VzgmQKrHZ28YlaYp7XOkF/46P2Reawgcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/ZlAQBWlAawDXtQ7OVkcnapGLekA9yBOQIDp1cuw6cHy3oqy6EUjmlrG9RZ5/2eUphaqgxtnyIKXfv/iee5u2QebYhlbJsb3K0s8SpmOnexLOM+7W4pf4QsmEoGRh0dsRyKOoHnFt01KniGWQi8DBxYLDIL9QXFpSNFy6+36kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQM+DGwc; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQM+DGwc"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-7341b13f2dcso11972837b3.3
        for <bridge@lists.linux.dev>; Mon, 15 Sep 2025 15:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757976081; x=1758580881; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SASXu10pDfkgCCS289Wyjl4zMwympeKKk54Tf2B/jKk=;
        b=EQM+DGwcLpUDgH4TfZE02BXSGACOrcBm5YLb/dm2TpIapU7rM2xrET9uK6TZVEao26
         XbKyT5wcT5NrMCx86OWknY7cZhZj1hwHUHjfMi7DffPMQd9ohwRm8I5Q93cfzlydZfl2
         vTW3BKiZIinBy12hTqLhgYCaNNhKc1VyuK4saMrdetisH10xuXbG9x+lnOdCRxZ67Zxp
         aTmFjh8lGvOre+mi7QU/He+kRmoToYvjJk1WuVXb2rdxIx5tMCJfGtR7oXZcCds7ifoR
         1KVBRiczayjgHNMFGB2myZ2SJ1RtPkBxq40Gx/4zKPZ49fn3LZ5mjRceJql9FhEGyd60
         95rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757976081; x=1758580881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SASXu10pDfkgCCS289Wyjl4zMwympeKKk54Tf2B/jKk=;
        b=lh3ndD0dKQl/Vt+lJGuetvmafE4wQMLA/lSObWV5fb88/ygeMxY0SEVQRpP4MSWj+A
         Yw8RMrNNBo3V8V6sxjQqdndOcDLar/jiEiEA6fIhHakRsABQwGy0c0y0diw/uh705rmm
         +ow541qaSSflIapSpTqBSHYBhWb/NTU+AO9SG8ssFS5o6vQdBer2PicHMJoahgYnm8R+
         p+yArzoEOsevSleyWX5WeJqxLmsrUFQiDXkAuxyJ5h5tGpRyLNrO7XdX1EBxbr/UuB2J
         cvMdSHnxgG2m1iKzHXqVLDxnTaCbAoIuY9qHILMC0Nn4hJ6/vX/DyD9WaqGASum0s5Ll
         F/Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVRj3tlKOjsgJ3YA/HB1xQM6Zgz1fAAsn8CHW4n2I2EGmcHaM393UziiS2ByCd+bCa3nLZ6/ys=@lists.linux.dev
X-Gm-Message-State: AOJu0YxahiwSEiaYSZR0jYVilZQYYExMz40lJojD8muUJQ6mGiWLYr6z
	CEnlLHUOcqCLXzixIZ9zZ6vTdiwriSSjQASA8TGILdeJuCa+n2rihkr2
X-Gm-Gg: ASbGncuVonkhgTaDTlfGRoGNnq9pIZGecBq7CE0MnKHkAf0zEtaDBvMyrALOoU05cbJ
	T0Phb+AKeJlyxhprN9ycIWcDRz/cmMLpUHELp926xrFPMsqyJb2k1rFHjm8zC2VxFSwHnA3AV6l
	7RpoRYQaZre7gciss97J/k3569ouEGhDPod6l11fmz9BJd0lr51JDgJLUBaPUFooeLVB7uSqXY+
	4lTAOKCFhnd3UWbkHUxY92UcoFU1QYcleZRup0MXsH76AVs20k19Zzw6PBazlTipHpejozlrGy8
	/6JhEP0L7Tl2YdMz4U4byz3uxo1yaABXt7HsCooo6Pcm3HxWhYvue1lbqK6cmQ0BFrfayzjpFFg
	VLXpa+fsKvww/q4SI1F/03L5aaDk/Gbr6qkw5g88ouHYFNIfZz24JKXAk+fwSEw==
X-Google-Smtp-Source: AGHT+IFKVDiqyeLRRwAZpNsUiXjihQklNAwRtRpOrO3aDhyURhUxOWyVrNC2ovqPRD+l0SvqAcUU4Q==
X-Received: by 2002:a05:690c:680c:b0:721:64ec:bc64 with SMTP id 00721157ae682-730650e0742mr139176837b3.35.1757976080933;
        Mon, 15 Sep 2025 15:41:20 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f791a35bcsm34972157b3.39.2025.09.15.15.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 15:41:20 -0700 (PDT)
Message-ID: <be567dd9-fe5d-499d-960d-c7b45f242343@gmail.com>
Date: Mon, 15 Sep 2025 18:41:19 -0400
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: Trigger host query on v6 addr valid
To: Ido Schimmel <idosch@nvidia.com>, Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Nikolay Aleksandrov <razor@blackwall.org>, David Ahern <dsahern@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250912223937.1363559-1-Joseph.Huang@garmin.com>
 <aMW2lvRboW_oPyyP@shredder>
Content-Language: en-US
From: "Huang, Joseph" <joseph.huang.at.garmin@gmail.com>
In-Reply-To: <aMW2lvRboW_oPyyP@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/13/2025 2:23 PM, Ido Schimmel wrote:
 > On Fri, Sep 12, 2025 at 06:39:30PM -0400, Joseph Huang wrote:
 >> Trigger the bridge to (re)start sending out Queries to the Host once
 >> IPv6 address becomes valid.
 >>
 >> In current implementation, once the bridge (interface) is brought up,
 >> the bridge will start trying to send v4 and v6 Queries to the Host
 >> immediately. However, at that time most likely the IPv6 address of
 >> the bridge interface is not valid yet, and thus the send (actually
 >> the alloc) operation will fail. So the first v6 Startup Query is
 >> always missed.
 >>
 >> This caused a ripple effect on the timing of Querier Election. In
 >> current implementation, :: always wins the election. In order for
 >> the "real" election to take place, the bridge would have to first
 >> select itself (this happens when a v6 Query is successfully sent
 >> to the Host), and then do the real address comparison when the next
 >> Query is received. In worst cast scenario, the bridge would have to
 >> wait for [Startup Query Interval] seconds (for the second Query to
 >> be sent to the Host) plus [Query Interval] seconds (for the real
 >> Querier to send the next Query) before it can recognize the real
 >> Querier.
 >>
 >> This patch adds a new notification NETDEV_NEWADDR when IPv6 address
 >> becomes valid. When the bridge receives the notification, it will
 >> restart the Startup Queries (much like how the bridge handles port
 >> NETDEV_CHANGE events today).
 >>
 >> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
 >> ---
 >>   include/linux/netdevice.h |  1 +
 >>   net/bridge/br.c           |  5 +++++
 >>   net/bridge/br_multicast.c | 16 ++++++++++++++++
 >>   net/bridge/br_private.h   |  1 +
 >>   net/core/dev.c            | 10 +++++-----
 >>   net/ipv6/addrconf.c       |  3 +++
 >>   6 files changed, 31 insertions(+), 5 deletions(-)
 >
 > A few comments:
 >
 > 1. The confidentiality footer needs to be removed.
 >
 > 2. Patches targeted at net need to have a Fixes tag. If you cannot
 > identify a commit before which this worked correctly (i.e., it's not a
 > regression), then target the patch at net-next instead.
 >
 > 3. The commit message needs to describe the user visible changes. My
 > understanding is as follows: When the bridge is brought administratively
 > up it will try to send a General Query which requires an IPv6 link-local
 > address to be configured on the bridge device. Because of DAD, such an
 > address might not exist right away, which means that the first General
 > Query will be sent after "mcast_startup_query_interval" seconds.
 >
 > During this time the bridge will be unaware of multicast listeners that
 > joined before the creation of the bridge. Therefore, the bridge will
 > either unnecessarily flood multicast traffic to all the bridge ports or
 > just to those marked as router ports.
 >
 > The patch aims to reduce this time period and send a General Query as
 > soon as the bridge is assigned an IPv6 link-local address.
 >
 > 4. Use imperative mood:
 > 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
 >
 > 5. There is already a notification chain that notifies about addition /
 > deletion of IPv6 addresses. See register_inet6addr_notifier().
 >

It seems that inet6addr_notifier_call_chain() can be called when the 
address is still tentative, which means br_ip6_multicast_alloc_query() 
is still going to fail (br_ip6_multicast_alloc_query() calls 
ipv6_dev_get_saddr(), which calls __ipv6_dev_get_saddr(), which does not 
consider tentative source addresses).

What the bridge needs really is a notification after DAD is completed, 
but I couldn't find such notification. Or did you mean reusing the same 
notification inet6addr_notifier_call_chain() but with a new event after 
DAD is completed?

Thanks,
Joseph


