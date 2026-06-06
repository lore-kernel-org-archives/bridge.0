Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645873168EB
	for <bridge@lists.linux.dev>; Sat,  6 Jun 2026 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780734099; cv=none; b=FvnhYOpjeQMnXOaMUTk/u6NyE+84WbVU+Iaui3E8zlA8Luv5X9sPojCrIekcL5HgXj/Kc8SYhFM1qC/tVgoY8NGOHkyoFjHxMYWKqd0H9yRIe9y1xRLs3DqcVJo03g2omzWaw3dBXnaHh0wLXOTvAno9FtYt/YlD45KfK02+WwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780734099; c=relaxed/simple;
	bh=xNsig66RaSc9mwJJKda5AfVrR7MopkMm6DomHG+DJVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BNm3QCuVFyeBazqkXL3KkGxe6lhWUmBaiIQpmne/are0ZXbT8QbCcQvkWtBU7FDnqqgIWD2bE2UNpog/RQA71zyN/1f1auRW3h2LiPf53EIxDKOXh1SiG2T5F3ZI7reBmczNNJF2rDmG1TLfUc55qeKZirn1zquV2mZRVDCgszo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=eU2LwYkc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="eU2LwYkc"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b915ded5so21897845e9.3
        for <bridge@lists.linux.dev>; Sat, 06 Jun 2026 01:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780734096; x=1781338896; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4gMg6KaYvC+cJxi997viIEAJIuy1B+hppRNVQz2bByc=;
        b=eU2LwYkcOlZI+Zm0/LVhKQd2mN3dxDqXA2U+qQCw3A7yMbbZC11pSoLCS1WZDq7TTG
         OTLbkZdIOQw2nK0tfIbL23CVLiqTMw57ZC4Y8048YNegq8sRfPk3embfhpQZp+X8Svzf
         9l4e8PXtqESk6HwlJKFx+iVdVbkcAxgJRO3kNSVS6+q9AP5G843ueZmkQrQHXu5VQMwg
         VQwQnFwxiah6IxVaBLiqTuDJVTkDpgXLdL2ONbKLBUN/LfeXMb/VLUtuxpqZHIFNIOR9
         jjnhZTGSqr/KGdBREALLv5UdIWdpF7nMvikjdn1QF2mG32A3s8LTlWKfqfyr2jCGl07T
         PPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780734096; x=1781338896;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4gMg6KaYvC+cJxi997viIEAJIuy1B+hppRNVQz2bByc=;
        b=mtmgEi5YbfwCi4WuHuGM3angx8mq4o/g9/KR4962VtQPkthNRDUeiv/D+t9tdAVsjq
         mKCOghJASpyb2bM9p4NYBUXmm1DJhWs2KMPJqsk7BmGMyigvbQv/E67iSPn6GSac+TUZ
         55ArMz0mj1A9I6Z6qKmrZlJzLJr7Xe884iC/OSuWulgyGQhYN0ZSic7/0VtPim/MtTF7
         qYNeySIq4Eiwgaue8buYGzmlOJ/xOR/tpsqOg9eX8rNYgbNdzeXiGNepAQGLWiYcBedE
         G/PHebt7xm7/Lod2PnYYWFhnDOhzjgOehLmJ7GNSYBPYCrtXTqS7RTPV+6GeJPvfVadF
         CI+A==
X-Forwarded-Encrypted: i=1; AFNElJ+O9BCQdP9+HPYl/fnt6xcmXUJeXCEb7AChVNI2GwHHNs0SWH5BRX0ik3k2zwbu7Dsa2xFH2Ok=@lists.linux.dev
X-Gm-Message-State: AOJu0YwPrlT4YFPIsaaeFlVA3rE22s5ajQgx0CciQhIxgDuGEXYU17A2
	xpeNQKv+seiVc6OVQklOjivWRiQSv+to7qymFXMnwQ5bQjOCzoAFkLoWhMU4kYchWmY=
X-Gm-Gg: Acq92OHnRycqJ2qHWDuswlPdI44sjc9AtvwOFvar43H7Vp4RvzaXWLfSa8bpmX0ieTK
	Id/TEcKI/Dw6by/wcXZMva0RcZi9DybrPCStAVCSCXzkkWqq/NWigjEUe0QzObbN1I/Eh/45Iuq
	Ddo8ivC3FOorQq4d+DfaaBsbo9eyxcIKVJ2lm5NrhRS14ws0SUzzODUDhuU7eWfmwwBURz+oGq9
	9ug363lq2MjXzfBlrjdWIUz/ek9GseOQd00HamU8DTYRPEgpnV7ctqi6U6tgsbZGHEkIZdzH/6z
	ciYi3wNKyLPNMVWCBZ81MZmaWo3kQ6jX9sKdIehpBDoy7soc3goH2bx09A8gjbAv1WU2k1dDNU9
	cxN/yOmy9tI00uGJNk3kdzJVWf/gX3N+Y2VaZspJF8EStgt7i9lYMg9NY9FqGfmryyzx2zqzNPe
	+L8+fYPmBbCtXLRChOldxlnIjH0t7K339H5NraGcXZ4LVlEB62l9TDtrIvqsSq3dJv
X-Received: by 2002:a05:600c:4e4c:b0:490:bb3e:30b0 with SMTP id 5b1f17b1804b1-490c25b2ab5mr131639785e9.4.1780734095644;
        Sat, 06 Jun 2026 01:21:35 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d4891csm82571075e9.1.2026.06.06.01.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2026 01:21:35 -0700 (PDT)
Message-ID: <a63eed7d-b674-4830-a690-1b55dfdc9a72@blackwall.org>
Date: Sat, 6 Jun 2026 11:21:33 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/6] net: bridge: add 802.1Qat stream
 reservation admission control
Content-Language: en-US, bg
To: Luke Howard <lukeh@padl.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
 linux-kselftest@vger.kernel.org, Max Hunter <max@huntershome.org>,
 Kieran Tyrrell <kieran@sienda.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-3-72be14522e7c@padl.com>
 <537410c3-ff4e-43fd-834e-775cd1bbe89e@blackwall.org>
 <E1253C6D-F6F0-407A-AABF-FCAB57100A1C@padl.com>
 <n2pi7h5nvxg3xvshtcxqeizpukp6hphqa7kodbe7b3ioc3kcq5@n34fgocvaicm>
 <d0e650fb-4011-4d64-9780-a0ddd0ca1cf3@lunn.ch>
 <CCF20D32-6C9F-49DC-9838-592EFB5E88D2@padl.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CCF20D32-6C9F-49DC-9838-592EFB5E88D2@padl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/06/2026 11:02, Luke Howard wrote:
> 
>> So it sounds like you first need to work on the software
>> implementation and expand the simplified version with the features you
>> need. You can then add support to accelerate this by offloading it to
>> the hardware.
> 
> Agreed.
> 
> The definition of Dynamic Reservation Entries in 802.1Q (clause 8.8.7) might support the addition of a new MDB (or even FDB) entry state to the kernel:
> 
> - add MDB_DYNAMIC_RESERVATION (a state, not a flag);
> - the software bridge only _classifies_ packets against  MDB_DYNAMIC_RESERVATION entries, and only when MDB is authoritative. Classification sets dynamic_reservation_hit on tc_skb_ext;
> - dynamic_reservation_hit is visible to the flow dissector so can be used for policy enforcement.
> 

See, saying the bridge has to classify doesn't sound right. Why not do the
classification where such operations are usually done, e.g. tc?
You have to manually designate these entries anyway.

> Advantages:
> 
> - the new MDB state maps well to 802.1Q;
> - minimal changes to bridge;
> - actual policy (reclassify, drop, etc) is left to the user;
> - doesn’t require a new tc-flower entry for each stream DA;
> - entry state maps 1:1 to mv88e6xxx AVB_NRL ATU EntryState.
> 
> Disadvantages:
> 
> - no unicast support, although potentially can be extended (there are some subtleties);
> - mv88e6xxx support would either require rich enough tc-flower support in TCAM, intercepting TCA_FLOWER_DYNAMIC_RESERVATION_HIT and mapping to native AVB admission control, or a per-port devlink parameter (not so nice).
> 
> This is implemented and working with the software bridge, I still haven’t quite figured out the right mapping for mv88e6xxx.
> 
> Luke
> 
> PS. I previously incorrectly asserted that 802.1Q required dropping frames with AVB/SRP PCPs but without valid dynamic reservation entries. 802.1Q discussions priority mapping in clause 6.9.4 for traffic from SRP boundary ports (those not participating in SRP). In practice I think this should all be policy, e.g. you might want to reprioritise valid DSCP traffic from within a SRP domain, or drop instead of reprioritise, etc.

