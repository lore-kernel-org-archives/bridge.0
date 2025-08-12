Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2012E9755
	for <bridge@lists.linux-foundation.org>; Tue, 12 Aug 2025 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987279; cv=none; b=KbQCKiPCAmmgW3CS1SFUaAKpcrnX2CVlh4y3mOPHpQPP3eIxPaxu1AIzQkxDMknGYUN7dCJ1NaioPtdRXqV4t+hkIQWA9TuZkBxRvgtlbixj0cknclWII2zDJqkAdVEry103mEoccVyy3u7Tmll/YwlFFuI4m5k18nvHWKEoGBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987279; c=relaxed/simple;
	bh=PXnGwUuF24xOhbEFOMK21d4w06vFXybiFXeF2Ah/w4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WRTYqb0NTL0/7DNGsL2UD95Ho+/mg6k232j/S066TktouMQxxzfbYFDrAm9pAnG72324ha4Ci5whLs1IxPe+mzgkvfmzh6mPAa8oCXd9svVRDb0ZM7NoRHOB7LGGqla/rnraPhDlWZPnq6I/VWAUFiWiwab2yOwQc4Tj5fkYrZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=dD1wmi/B; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="dD1wmi/B"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8BADC6135F
	for <bridge@lists.linux-foundation.org>; Tue, 12 Aug 2025 08:27:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SAY6zAsY0JRV for <bridge@lists.linux-foundation.org>;
 Tue, 12 Aug 2025 08:27:55 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1A2DE611FE
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A2DE611FE
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=dD1wmi/B
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1A2DE611FE
	for <bridge@lists.linux-foundation.org>; Tue, 12 Aug 2025 08:27:54 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-af95b919093so767352566b.2
        for <bridge@lists.linux-foundation.org>; Tue, 12 Aug 2025 01:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1754987273; x=1755592073; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+inNV5L+26/jdh8SQHKHh0W+Rujj2zhiV+GcfqL4CjE=;
        b=dD1wmi/Bk4BNsm/uoxUCAPNsnITBBoCMviWBeDpw1NJkldzemzoSbDGhoX3nGWeGcX
         zZA0H7n6zjreZp1/MskHrx9JUkDOFh11ZYorL8oijIOoGQVhL8Ckvp1ADCbWPb2rj43U
         tkeo3KzireYyPxV8onrowb264bJdKjBxyiiKExNRgFfB+KUdDB3wBPhL605jtL1XnKmh
         CYa1qZ4ezhmWQkcHga6kvDyIm3tN17DSB4EJ+rZHBBBkPspqlFt2NRD15LvNmNobHwlo
         OPFXocPOFdEyKWXdHpqIn0pO1Bp2FBMbcS0PojYcd1gLbrYdOs9rVj9c/PPPJCJoaUb1
         hL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987273; x=1755592073;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+inNV5L+26/jdh8SQHKHh0W+Rujj2zhiV+GcfqL4CjE=;
        b=k0cV4rsb3WLpeiNwkA1zaYUkId8oJ7HjWLepszeP1OOtoh1W38cW8ZfnLNJ0zg9HU5
         VIaiusj8MNTm0vC1zUBb0q8lG06I+YADwfVbz5Mp9APMwDrO97/x9sXMUj5KyXh7FetM
         fZ+sWhTRihXI+84eKWW7z5IHavEbIDyYLbxmPoj6HrgWlsK8m/bITOKiUs5xaz9s1NFH
         uFACFecZHA/miUpOt5q9pEXoBlLFHeBkiQfft1ijwh6H1obPOjwXnx4wMpUf62hZ9HLq
         j3YSE22LCxLiZOWKer8l8d2r9vMcW9pcXfoyMIkjcP2UgO1Qp6n478QY1vY1mwPsncPZ
         ijaA==
X-Forwarded-Encrypted: i=1; AJvYcCUxtAFUvMPVZXNasokOUU0Qtc6GVpv43vV3yaqKDqx6ZYdAh9q7B8WjkAaxoAmA1Cg931YDXgY=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxEFuRwYHfxCe3Sq3KSBkkBkkiLi10QS+mKUojESdpjONZm+IVY
	1hHTArdztPP4hZXYQgkPHXDIOGV3lyvCkCwX5vNwPo7HHCDL6Tg5m5uWNROWXyaBc24=
X-Gm-Gg: ASbGncvyqa+85N1um/BKvnn1annyCkjilLYuRSbCSbzPXKoXSFbd1sbQf0/kSa5KG+p
	qF3TWyT1U4nm4bpcomMTbs86XmDoq47v/KttoWOnvHwJOYxnfy2f6/ACkUWogMGnENi8Aa5pwSC
	tZ+e3bpzGiU0D/6clGSUV+7/VjAR8VxjCTqk3qcEzJBbLmq3QD4z+d9bMNKgRE2kmII/lnlAcge
	vg3z7nIDrtOX+0rDgTrVOB78FUn+772cC4kpA0lssO5XMW5fQVCTpfJcj2bOtMvxVk/zciR9gfp
	B8svZeXWNcF6uB+Sz0hEa87x0uTlZW4JrVwcj7GHgLfgyy4MzQdv8g4kC7eAnP/lsbgt7iLan/z
	SpqV0jZrVZYtzYRNw5Us6zsBJ5Z5aE5/hfpeX0gA=
X-Google-Smtp-Source: AGHT+IHiODXSXqVSNlXTPQ0+KmwM7lX/U2trNNPVHoBVYZOtB9bVUuVfmYGU4RbFOrj0nX/NiG1amA==
X-Received: by 2002:a17:907:9721:b0:ae3:bb0a:1ccd with SMTP id a640c23a62f3a-afa1dfa9174mr222098166b.26.1754987272989;
        Tue, 12 Aug 2025 01:27:52 -0700 (PDT)
Received: from [100.115.92.205] ([109.160.72.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a24062esm2160802366b.126.2025.08.12.01.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 01:27:52 -0700 (PDT)
Message-ID: <3e84e2ea-2b11-4e3d-99e9-4c6ecabe3bc4@blackwall.org>
Date: Tue, 12 Aug 2025 11:27:50 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] bridge: Redirect to backup port when port is
 administratively down
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, petrm@nvidia.com, horms@kernel.org
References: <20250812080213.325298-1-idosch@nvidia.com>
 <20250812080213.325298-2-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250812080213.325298-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 11:02, Ido Schimmel wrote:
> If a backup port is configured for a bridge port, the bridge will
> redirect known unicast traffic towards the backup port when the primary
> port is administratively up but without a carrier. This is useful, for
> example, in MLAG configurations where a system is connected to two
> switches and there is a peer link between both switches. The peer link
> serves as the backup port in case one of the switches loses its
> connection to the multi-homed system.
> 
> In order to avoid flooding when the primary port loses its carrier, the
> bridge does not flush dynamic FDB entries pointing to the port upon STP
> disablement, if the port has a backup port.
> 
> The above means that known unicast traffic destined to the primary port
> will be blackholed when the port is put administratively down, until the
> FDB entries pointing to it are aged-out.
> 
> Given that the current behavior is quite weird and unlikely to be
> depended on by anyone, amend the bridge to redirect to the backup port
> also when the primary port is administratively down and not only when it
> does not have a carrier.
> 

hehe I did ask that question long time ago while adding support for backup ports,
at the time wasn't needed for the MLAG case :-)

> The change is motivated by a report from a user who expected traffic to
> be redirected to the backup port when the primary port was put
> administratively down while debugging a network issue.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_forward.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index 29097e984b4f..870bdf2e082c 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -148,7 +148,8 @@ void br_forward(const struct net_bridge_port *to,
>   		goto out;
>   
>   	/* redirect to backup link if the destination port is down */
> -	if (rcu_access_pointer(to->backup_port) && !netif_carrier_ok(to->dev)) {
> +	if (rcu_access_pointer(to->backup_port) &&
> +	    (!netif_carrier_ok(to->dev) || !netif_running(to->dev))) {
>   		struct net_bridge_port *backup_port;
>   
>   		backup_port = rcu_dereference(to->backup_port);

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

