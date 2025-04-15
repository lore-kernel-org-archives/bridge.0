Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C30294A05
	for <bridge@lists.linux.dev>; Tue, 15 Apr 2025 11:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744718220; cv=none; b=ZjqJqXFYk7GXubOK3bMoemYibZCGc78KlB7f0pVLClgN7SAm2o9GI+36b2pyB3cjM+pjpoS9uRKppIoGqz+DpnqIPO7oyaby5rJ8OPpRPHjhSTUyr2Vm+AS0dycyWRiewvwspi8ACmlumK+rJBYoOqG4LVb9Br95ZglUgUFNdAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744718220; c=relaxed/simple;
	bh=5yAVcJxOQv8Rb2mbuiu+g6eZAVL0C1KLbuq44NaNCdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HtxAVsMRlrZ93FDAdbw6iao6oxrkV/kKvmL4im/Te2YIrbKQ9GekmhfQpsw/uZLNOICpOa1fDcwRgPn+EShNBr2grkqxQVurHKVuhhCnShKwKMU4EHCMkytR1rghVUFC2g4ZD7OLHd4f27a5Mvg/nmbGS/nhm+V7pPYdPaSgN3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=07GISxyU; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="07GISxyU"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39c14016868so5006648f8f.1
        for <bridge@lists.linux.dev>; Tue, 15 Apr 2025 04:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1744718217; x=1745323017; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N6dtMTXpeA9yP99GdbhluhOJP06ddUlIw3w6Qn/m58Y=;
        b=07GISxyUzwYMOhyAtlhZzu8H5d5OSsJHdmMqQkXhSay+5Ak5eNerEv538YBEAPTd21
         Zz5V9gJND7krThlpDhsKoeSKBBX+Z45vUA1Qbi/yVP9R9vUOXadolQ3RtKLcv1xkCKwH
         dRsWm3FZ270R4lralfJuT80A/71YMeR8xqvkY215ZxW2zpEPgR2YnkxDOTV1iNB0Nu71
         ZT56M8LE9nteOEbqfg8DQQmZRIHmhzGZrrQoXQitVuDqfQo+P/iXHIybCn9fK3fdjvBF
         ARFWg+vkVk9/tzWuAZG9YqkRYnHWsVrYJe3iYSKwAecfe8ud2s/Fz8JpmYsMPZQ8T8WA
         ySnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744718217; x=1745323017;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N6dtMTXpeA9yP99GdbhluhOJP06ddUlIw3w6Qn/m58Y=;
        b=AF/XFxj89MEyihRG4S7qrFyfUiTDZRBL13PgjV4LuDikmw6fv83e/3IxkvmeV/8W4v
         at5GbS8kLTeskkyscWEVeelzLdsRRmUNYAYQKz3UcUDj0x93t+0VeUL7IaAznw5aChJ4
         1pwS7IzcWATQfyiXeeBQfzXf6jFvnBK4LBnypngISPO812Abn1iyRPfQ6XDpnGWKpCs0
         TYk5nHRNUimK0bjkA/DZ4S1QBkRGYf9OF6jdgRHf2WSqulZV69z+np5y3ZnJuQrTVZFd
         VYDAmqqrL+b+LZ+VHAtU+F01ogfobUUg6RsWJRYMg1OEV0ZVE64eQ0CSwQTcl95CgixM
         yz4g==
X-Gm-Message-State: AOJu0Yw0iK4U3d9g4E9isZKJmxo8Dx6y7LO8goG/ze4wwSbg+RN02qui
	8PcbtP4/iy2I5aNeXRO+J5H4eh1d1wswPdTXy8jIDuTJnrvT/iMRdAMEf10PWnnPTYQW5bZ7RR7
	Z
X-Gm-Gg: ASbGncv2VPW8MRia2AiAFFlkduXB0STIaYDX9ermoPrg98mrGCPmPdQfPWwRcp/xryG
	myIvP8vQmS8Cj6nZa0wLfyi9QNNF/CpWAK91x8NGNXwfSFrX5c+9q2eJ6cnu8dkmqRZnNFFBW2V
	m2BCdfeXbZuUmWbJ8MzRPt0L17jEArhK1v5ML42qhRM3cn9PQrtu8zp6j3JMUdqEM9crMoZGymr
	N9p2VVJ6vhHoGC6Jjnb06y+l5Cea2p9VUzOPM4BW09ndVDQX7qHNHWV7IyaJpbhSC407xDbRIKr
	XZUEVV7+HP/w37rRp0ZLGCIuEJoQE6M9ElBXssw4I069b0HpcwSxpntf50+LMe/OZ6FcuWwG
X-Google-Smtp-Source: AGHT+IFZ/8IzbGBjcCVDGk5eFuHy/8wS8TTEduyN66eJhFjsuFGZWnxgT2nwXvJ2IN9En6IOyhPwOg==
X-Received: by 2002:a05:6000:1848:b0:39a:c8a8:4fdc with SMTP id ffacd0b85a97d-39ea520372fmr14180025f8f.16.1744718216162;
        Tue, 15 Apr 2025 04:56:56 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae979620sm14185229f8f.52.2025.04.15.04.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 04:56:55 -0700 (PDT)
Message-ID: <76b303cb-0912-41f9-885a-9c4c045a6a51@blackwall.org>
Date: Tue, 15 Apr 2025 14:56:54 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: bridge: switchdev: do not notify new
 brentries as changed
To: Jonas Gorski <jonas.gorski@gmail.com>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250414200020.192715-1-jonas.gorski@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250414200020.192715-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 23:00, Jonas Gorski wrote:
> When adding a bridge vlan that is pvid or untagged after the vlan has
> already been added to any other switchdev backed port, the vlan change
> will be propagated as changed, since the flags change.
> 
> This causes the vlan to not be added to the hardware for DSA switches,
> since the DSA handler ignores any vlans for the CPU or DSA ports that
> are changed.
> 
> E.g. the following order of operations would work:
> 
> $ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 0
> $ ip link set lan1 master swbridge
> $ bridge vlan add dev swbridge vid 1 pvid untagged self
> $ bridge vlan add dev lan1 vid 1 pvid untagged
> 
> but this order would break:
> 
> $ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 0
> $ ip link set lan1 master swbridge
> $ bridge vlan add dev lan1 vid 1 pvid untagged
> $ bridge vlan add dev swbridge vid 1 pvid untagged self
> 
> Additionally, the vlan on the bridge itself would become undeletable:
> 
> $ bridge vlan
> port              vlan-id
> lan1              1 PVID Egress Untagged
> swbridge          1 PVID Egress Untagged
> $ bridge vlan del dev swbridge vid 1 self
> $ bridge vlan
> port              vlan-id
> lan1              1 PVID Egress Untagged
> swbridge          1 Egress Untagged
> 
> since the vlan was never added to DSA's vlan list, so deleting it will
> cause an error, causing the bridge code to not remove it.
> 
> Fix this by checking if flags changed only for vlans that are already
> brentry and pass changed as false for those that become brentries, as
> these are a new vlan (member) from the switchdev point of view.
> 
> Since *changed is set to true for becomes_brentry = true regardless of
> would_change's value, this will not change any rtnetlink notification
> delivery, just the value passed on to switchdev in vlan->changed.
> 
> Fixes: 8d23a54f5bee ("net: bridge: switchdev: differentiate new VLANs from changed ones")
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
> Changelog v1 -> v2:
> - dropped the second patch always notifying dsa drivers on brentry changes
> - dropped the cover letter, as its overkill for one patch and it mostly
>   reiterated what is already written in here
> - fixed the example in the commit message to use vlan_default_pvid 0
> - fix thinko brake -> break
> - extended the changelog to include the assurance that rtnetlink
>   notifications should not be affected
> 
>  net/bridge/br_vlan.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

