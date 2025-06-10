Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0599528FFF6
	for <bridge@lists.linux-foundation.org>; Tue, 10 Jun 2025 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558118; cv=none; b=njcGbS0jIQJZsMsztdKfeRidYELKEq0E7WE8JSFR6UM9ExUrv37QN07z1pK75nN3JpuYO6vvaY+1W+tw5saXpiGBlDDRzNmO2YCUQaPELBNmK3LvMvo9fuUtcoPqsEMEfzyyn/iHzJX9KoMs8vKo5TutcYnXY3kDEAv+CjbedCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558118; c=relaxed/simple;
	bh=pGkjcw6YDzKi2PtQFF1DybqZsg9nWYh5T4MBtqVpx5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDF3ik96ibjZm0y0gEHmaE0OdRJzV/iVdQ2vu2FhcT9+70th/5u/e+VI0nO9x8oznvJN25h1v7WmalrBmsRED8bic6KQELZdQCBH0Hnk8rwp8r7PRuRFGNtL/Xe9V+nOetUbI1hgIaXxas7tXYpTplefc7E47/d/ogXfm7yZ4wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=vBR2061R; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="vBR2061R"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7188840139
	for <bridge@lists.linux-foundation.org>; Tue, 10 Jun 2025 12:21:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LoGPnYm9GCt5 for <bridge@lists.linux-foundation.org>;
 Tue, 10 Jun 2025 12:21:56 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::235; helo=mail-lj1-x235.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BF08540123
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF08540123
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=vBR2061R
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BF08540123
	for <bridge@lists.linux-foundation.org>; Tue, 10 Jun 2025 12:21:55 +0000 (UTC)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-30f30200b51so46915371fa.3
        for <bridge@lists.linux-foundation.org>; Tue, 10 Jun 2025 05:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749558113; x=1750162913; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wkr8NlzrT7q+6KLISKYLjBRPxrJzkpjNvX6605AbOkg=;
        b=vBR2061RKWpfRc5CRJYxrd+GjdQwVFXeU3u3tRuBHuy7YT4Db+z+U0wasCNLPbZxw3
         I9gqgz12NLkDb2nduvhj3G3MXJUUWAzQGUu+eUIZhm8bnZWidE2veJkH4zqkP2l+oRbW
         cn1oAU6o++/OoOK2id55tIyTtxynYza8hXVgoDtS99ey7sGHG3FYteuCQo779hjw9Pa7
         KXQb5kqjzB2Bum6eYUsgMn9exMQHG1idneq8y4x4BIFBYF3Bafohmz/GD/QfhJ+9lfXL
         WowRv2CdGv54bKA5EAHJJDF6o2Z+5RiaWvxegkE+PDQ644wSopfdyKmSsSd9EAMyfNBO
         Su+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749558113; x=1750162913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wkr8NlzrT7q+6KLISKYLjBRPxrJzkpjNvX6605AbOkg=;
        b=f2ZDAh3W0D6JFIoJpd2ZZmfpfFq1FnocXq0Oo++kMGgwkXgXT2jmSXlKrE1motyt1T
         VQGFEnPHM0Y/cE2AvFTujzLdjTTY/FMGOA0yxFObShvNTCo9YT+KkKtvOZrpIzLFUDVc
         nnxkQEa4mf6d+wK0mQqbKBYAa1ZrQikGfWrQ82CtIE+EQpgU3Xjs7MEdUjm/QmbbKwDJ
         JB0RCp9c0rUqOklXR5SVFTW3iaTmCG0y5RajfvcdqoxgHEnXMkotlt6yXkl1HN+3FOOm
         V/70xECGRxLTk39K/Z7QDO8SFZzE7kmIqIuLzs07NSX5F17Aw89yiATEzK7mE2GxdPP+
         0r7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHXZ77KJfuAbehG/PHLUUJCsOGI1CGmHcYjxxqTV+BD/C6xQLv7xNw+uRGXOJKZq2EhNtaaL0=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yzk9iBZRmnymfh234oj1AwkL8Hy/Hyswrzajaj+/ULgslC/V8O7
	RYStXWT5oRQfU/y7gFvjjKgiMbeM1rSt9a/RryCem22dqv7qlqTnZiVsScwi4hEjQE8=
X-Gm-Gg: ASbGnctV/rhnRMt6xIrgUSw5yaNgA47vVhMlQ2UFOsBnAx0hmGKhzoyFYuJueK4LTh0
	sGPFM4shwPwFNPfPwLtXo/imn25HnLPZbU9tkpDLH+0Hx4nTSctDFr2dLMPlhBciaHtzYmGcllG
	rOgyZ03FQ3JXwLUmKzuHdzGLb3bRCa/SOO1pW4yBY2c0MKMwyYMsQEsiHzwYf/g0niduXsK47bN
	jqApj88E9M4ixQaXxAFFfeOR3BKi9kkgpl+Sd7+6M+WrYoecS7fspB0I1QVGPyI/J0gHyPg0tbz
	gXXJkrDeRz+tp662o41nDPRMtYvz6VnaIjGN152E37UJJugsDw/D441waxZlHE+QoYBxXAI7pQr
	Sl9lGLNnezFkPEO5k5hcg6WzIXsFaqEM=
X-Google-Smtp-Source: AGHT+IEgwRAVIyE6nLzZ0225oh2wo8Bpgx3Maq6YW9HopN0ZkGH0l2d9dudPlx3GX8xSOSGIfI4g+g==
X-Received: by 2002:a2e:be9c:0:b0:32a:6502:df45 with SMTP id 38308e7fff4ca-32adfe900c4mr41634491fa.40.1749558113312;
        Tue, 10 Jun 2025 05:21:53 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32ae1ccfc48sm14389601fa.95.2025.06.10.05.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 05:21:52 -0700 (PDT)
Message-ID: <23d87175-9212-49f6-b4fd-2d5ba251c085@blackwall.org>
Date: Tue, 10 Jun 2025 15:21:51 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 4/4] ip: iplink_bridge: Support bridge
 VLAN stats in `ip stats'
To: Petr Machata <petrm@nvidia.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org
References: <cover.1749484902.git.petrm@nvidia.com>
 <c0d97a28464afeb3c123f73b656e5e5532893726.1749484902.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <c0d97a28464afeb3c123f73b656e5e5532893726.1749484902.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 19:05, Petr Machata wrote:
> Add support for displaying bridge VLAN statistics in `ip stats'.
> Reuse the existing `bridge vlan' display and JSON format:
> 
>   # ip stats show dev v2 group xstats_slave subgroup bridge suite vlan
>   2: v2: group xstats_slave subgroup bridge suite vlan
>                     10
>                       RX: 3376 bytes 50 packets
>                       TX: 2824 bytes 44 packets
> 
>                     20
>                       RX: 684 bytes 7 packets
>                       TX: 0 bytes 0 packets
> 
>   # ip -j -p stats show dev v2 group xstats_slave subgroup bridge suite vlan
>   [ {
>           "ifindex": 2,
>           "ifname": "v2",
>           "group": "xstats_slave",
>           "subgroup": "bridge",
>           "suite": "vlan",
>           "vlans": [ {
>                   "vid": 10,
>                   "rx_bytes": 3376,
>                   "rx_packets": 50,
>                   "tx_bytes": 2824,
>                   "tx_packets": 44
>               },{
>                   "vid": 20,
>                   "rx_bytes": 684,
>                   "rx_packets": 7,
>                   "tx_bytes": 0,
>                   "tx_packets": 0
>               } ]
>       } ]
> 
> Similarly for the master stats:
> 
>   # ip stats show dev br1 group xstats subgroup bridge suite vlan
>   211: br1: group xstats subgroup bridge suite vlan
>                     10
>                       RX: 3376 bytes 50 packets
>                       TX: 2824 bytes 44 packets
> 
>                     20
>                       RX: 684 bytes 7 packets
>                       TX: 0 bytes 0 packets
> 
>   # ip -j -p stats show dev br1 group xstats subgroup bridge suite vlan
>   [ {
>           "ifindex": 211,
>           "ifname": "br1",
>           "group": "xstats",
>           "subgroup": "bridge",
>           "suite": "vlan",
>           "vlans": [ {
>                   "vid": 10,
>                   "flags": [ ],
>                   "rx_bytes": 3376,
>                   "rx_packets": 50,
>                   "tx_bytes": 2824,
>                   "tx_packets": 44
>               },{
>                   "vid": 20,
>                   "flags": [ ],
>                   "rx_bytes": 684,
>                   "rx_packets": 7,
>                   "tx_bytes": 0,
>                   "tx_packets": 0
>               } ]
>       } ]
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
> 
> Notes:
>      v2:
>      - Add the master stats as well.
> 
>   ip/iplink_bridge.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

