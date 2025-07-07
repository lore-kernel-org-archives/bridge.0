Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B3E227EB9
	for <bridge@lists.linux.dev>; Mon,  7 Jul 2025 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906982; cv=none; b=mfwi5lcUSRNIxuMp1mLqBLucKa/+EyCDdLmyqOVW544YqHfDsNOCK+oJndd5gR4RwUe/5Jjpq46wfUN/IjrtZLjVsnZHJn3LNeA2J62Z8isAEisM7HhfH/MK+2qdMpDVuVx/AB/uP+MM4n0w6sGPXsJ0zgHNkmBw8pdLMbFyOL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906982; c=relaxed/simple;
	bh=2qpWdHuWmXVbwdu0z0dszit3gKd+4ot0FUdDS48fSgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MppshHmWUOlCjZUM70nG6o0gkjk1oEEE1EAM/xkKEKL6Dmc+6iLYBaPx7NA3uwfMOvD4l76UBCMWJb1OluAPvywmj+gzTrs2k/Gz+dWGHV4p+HwxU6qt5zJOn3JmtY2VD1MhNKmuyUXY56sLhsVVIM11T5VBBO33AIlYkit1HaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c60yny3Y; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c60yny3Y"
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e7b4ba530feso2775183276.1
        for <bridge@lists.linux.dev>; Mon, 07 Jul 2025 09:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751906980; x=1752511780; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u1xOWZOyoPm540GobFdkxEMray8IVt4E7vfdVGtWbcI=;
        b=c60yny3Y1YgV2L1UpjI2zHBkVKPLivl6JvNxPPlbIARnu0K7oaXWViZxsWIZRour2l
         XbHD37nJFsBsJ5PSMN3Axj7/Nj6WugZn8dWBi1AsZ46VxBXcpUza8d+cJ2uWeovZLhmg
         g031J5wIsYVVd46uwk/bIW2daurb0Kbdb41/Iz1P3wVbatulBJTnWOAq80NToNOVkc4o
         QESxzaGFfy/cKtd69LTyI6bQWiyYjp5viZ//qr8SCqZmxTrfIM0UcowbpM18UvfiaPtw
         d96h26tcphR/wFzshxit4aL4HdVhnt57LNN9dsik6xE5jwVwiMq792mtaCOSqqcDfaKd
         iLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751906980; x=1752511780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1xOWZOyoPm540GobFdkxEMray8IVt4E7vfdVGtWbcI=;
        b=JIxeKvOxqOlhmt6jp6cxa0O8Ft04slTTOgwPJHkIIk8YOPgL9YHf1F0mrOv6oErtmK
         mn4xuZ62elMedOmY78CBvOZpkvEZj6+LXsyLg3lPlxglKVdmK5XnEpvJe7czaw8gXfmN
         1FHS77tbWzT9xfUpDj1R8+V3aJEcSjA4od9kycyuYPF7ghiD0dbSY1n8aL91i/AwXjKo
         cJvOyGK9Y8WhJvnwD85u4WNGQtgsmC4lHO1p8Psq4f64Odej47mdZj0Zov5O+S9Dpf92
         yBTm+1FUA8vP2StclRVkTwwKUqG/aOW6eOAFF1PSCMZ9KQXF/8y94SbIWJtnkSsO0Pwt
         yRgg==
X-Forwarded-Encrypted: i=1; AJvYcCVEdxaG2yddcOpOvZAwKDCX36klgn5Z6Cmz+C3Ut6+efXrnizmEvmyzT6NoCXTDVXv5g2QDRI4=@lists.linux.dev
X-Gm-Message-State: AOJu0YwzMzHIFkEysiX5fzjfIS3qBtUn6asL513EkEHa6t6w0sq6Dt7O
	EYab1S4WQkwUaQW350z9V1cBExi9D7i7eFbzYfdscXIe2V5DRsMxl/tv
X-Gm-Gg: ASbGnctG8tFbBWl38wqCotyxm2hFTUZ0yToPgLsvWWQh22L/2U8TNAxMoHMGxDayC0o
	o1JBOvkAqau0CqQeea1vjmrBejVHQd3Hp7MEW+61q5o7ddrSa0d3moYvzYXY8cXTrehm6TzcIq4
	7RoO/Lzt9gBbH7FBxhWREkSmh1Qv2tG99QwCoclU0FVGN72jbmZGWXWLqJ0BO6YlbqVyZXK1gSN
	PHQ3kOBAn6l1My5L08PUt5IG9b8bFb/Bj48ux3hpvvm+FSPi+CtEimS8+aLvkpPYuF/WxR48+vx
	0WANIx8bHv2o7oUpkLfTbobhd5hkXD5V0Qwc2djeznko1gR0Pg6IMhQTsi1PFomUWOioTHSUoQl
	PkIuaCbfW
X-Google-Smtp-Source: AGHT+IEb39Z0BOySPnuTvXs3SmBQemC+SyqVyRj1OliqOspcPBmsWCNbNxGyQ9B5BaQfJESFgNSDTw==
X-Received: by 2002:a05:690c:6082:b0:70e:2c7f:2ed4 with SMTP id 00721157ae682-71668b45afamr187921317b3.0.1751906979843;
        Mon, 07 Jul 2025 09:49:39 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71665b12c7dsm17204217b3.93.2025.07.07.09.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 09:49:39 -0700 (PDT)
Message-ID: <4998a14e-f755-44a2-b5c3-f966056acb1d@gmail.com>
Date: Mon, 7 Jul 2025 12:49:39 -0400
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: Do not offload IGMP/MLD messages
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
 Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250701193639.836027-1-Joseph.Huang@garmin.com>
 <20250707130052.wwd7e6fenp7imvy7@skbuf>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <20250707130052.wwd7e6fenp7imvy7@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/7/2025 9:00 AM, Vladimir Oltean wrote:
> Hi Joseph,
> 
> On Tue, Jul 01, 2025 at 03:36:38PM -0400, Joseph Huang wrote:
>> Do not offload IGMP/MLD messages as it could lead to IGMP/MLD Reports
>> being unintentionally flooded to Hosts. Instead, let the bridge decide
>> where to send these IGMP/MLD messages.
>> 
>> Fixes: 472111920f1c ("net: bridge: switchdev: allow the TX data plane forwarding to be offloaded")
>> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
>> ---
>>  net/bridge/br_switchdev.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
>> index 95d7355a0407..757c34bf5931 100644
>> --- a/net/bridge/br_switchdev.c
>> +++ b/net/bridge/br_switchdev.c
>> @@ -18,7 +18,8 @@ static bool nbp_switchdev_can_offload_tx_fwd(const struct net_bridge_port *p,
>>                 return false;
>> 
>>         return (p->flags & BR_TX_FWD_OFFLOAD) &&
>> -              (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom);
>> +              (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom) &&
>> +              !br_multicast_igmp_type(skb);
>>  }
>> 
>>  bool br_switchdev_frame_uses_tx_fwd_offload(struct sk_buff *skb)
>> --
>> 2.49.0
>>
> 
> Can you please incorporate the extra clarifications made to Tobias in
> the commit message? They provide valuable background.

Will do.

> 
> Also, keeping in mind I have no experience with IGMP/MLD snooping:
> aren't there IGMP/MLD messages which should be delivered to all hosts?
> Are you looking for BR_INPUT_SKB_CB_MROUTERS_ONLY(skb) as a substitute
> to br_multicast_igmp_type() instead?
> 

Yes, there are messages which should be delivered to all hosts, but if 
we offload these messages, we're at the mercy of the multicast_flood 
setting on each port and whether or not 224.0.0.1/ff02::1 are "known" 
multicast groups. (There's a discrepancy between the bridge and DSA 
subsystem on how 224.0.0.1/ff02::1 groups are handled.)

Group Specific Queries might be the only ones which are safe to offload 
regardless of what multicast_flood setting is, but I don't think the 
bridge has a flag specifically for those.

Thanks,
Joseph
