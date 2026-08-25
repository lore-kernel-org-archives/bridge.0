Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3031E3F7877
	for <bridge@lists.linux.dev>; Tue, 25 Aug 2026 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653391; cv=none; b=qXM+bbGUet9a7EZMrBr+Zl39slwRxZy6hvvAFhOZr25ZCd7m50Xo9NBPZGFlGtRFvOZLHG8ihQT+AyZWDeyR/U96iGP4jzQW7reyr8+MK2uG6FAIh7kuap3R0cynetK7AKwz8F8/TuanibPDoL2Y/eWsO4CDDVhLKIlj/32/jTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653391; c=relaxed/simple;
	bh=lqMXD3suOr+sitndCEj6l9BWxP7uFteuQLonBXuJZuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPzzexoq+KnjFR6E5pw6ONEXjmi+qFP+5sz/eVtMj6DRzcrCgh/6v3S7syftNROhofpuN78Ibjuknf1arEzvOn/OZcN1merQ640sssAmZJEfPbnL0PXYzgL29wPSwJYPVSE3v65sTru8OCAx4PPKnYyoN9SCecIpRTX/f47sdjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=QX6lYapU; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="QX6lYapU"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a36982a875so6842473a12.0
        for <bridge@lists.linux.dev>; Tue, 25 Aug 2026 03:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787653388; x=1788258188; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h4FFQMfXNiGpn+c0Ds6FNCWxiddPqnNk/uHSviV3ZIQ=;
        b=QX6lYapUMx1KoucpadPpDyf+sNi8N4WByKAs5lp4CN1oJ/bp9pI8uFPddY7ljf04K4
         GXmAYaiMOdB7oMWNKTal0Av49Q44xN3Uv95BrFihaAYLj4fcqFI7GwOLj4PKT/mqq5Pi
         D3KEArZHiUvC6CZfLYNPJpENgz0TrRut8JOwct7wXSDEkZMLXuKdDoR+zKsvZYMwqofx
         F9YJnor3bQMbjU9OC0vUcVdS7bi/7svcRg/jMUYk29pNYxhGcVx2CymOsuqkT5U3Qb0H
         j6thRidZrOpGbpBHh7UvY+KwP5VyQkp/PTNp/+pnK2C6dUMlVqLUQOu83veb6Zcx3SX+
         yv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787653388; x=1788258188;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h4FFQMfXNiGpn+c0Ds6FNCWxiddPqnNk/uHSviV3ZIQ=;
        b=qfxWsceObATw/O7/Cf8L0vlGxeZ3CSorvuRDKziEjWPZiphP+HghK58cQF+ui2H+hp
         VFMaXK0iXfO61vJIIQTfcYlP7mhJsWkSS/VBp6VZ8Qyd4zPC19EP86sCCT3Z+tMy66EY
         ncAVEUrFqvCEDm/oy9U5blnov3+uLZjfu+uX9FHUDzg0mYH9mK1wnzFghe8FOUYNaodt
         wBcfQfd68RLMQAHqNTxq4fpYwE3PV7TMtIf4MxqN7kmP3TU/ln6AMkVRjCvBvCji8JAV
         PeJNDTFWEw9sbKW2v+Akyv5xcWIoRZPvjnVqu6xFPIX6cCfm1R6GRQ9PidCE6f8BTL0r
         F4Ig==
X-Forwarded-Encrypted: i=1; AHgh+RpbyFiuwNl4VqSsbeamxiBE9OHbAbHhKVTONdvcsPY78mZTxvEaNtwkO0phGNofiWXNyvrFVRU=@lists.linux.dev
X-Gm-Message-State: AFuF++nuZBMRnDtjM49QecK9OKBBLOao4PjHq3S0h+98DrLN9EIIpw91
	Bb0LFS2H0zuZrzOjOn/PxN88L4EsjEFsBAAWLocxmNftVFK/Mlei4ryUzDd5Ln0gPE8=
X-Gm-Gg: AR+sD11OlTxK36dVEP/D2Vn+VrgR9hJmVoaw4WB0PsszPfmoZnEsmgNnswycmfJvHBC
	86KUdBiKB+ct6W5liFhB3ugWLNpHGzGchWU+s3s8qQx5dsmq4w48jyAn9+GtK2wAnQ/lE2rBYXO
	tpYXEjvkNKs9gMP1llsnsZcaKVb1N0N+bs2U5BUKPs9DJe/vz1Df2hhRiw57ta1tvArMCklDTTt
	F94q0/xWPhYbqh6647knEYlMCrnq7cKMDEfjfW37hetXWlJF6v3AvvtNBzDjo/O9U0R7v91orM0
	gYZU5nFiBA/GwrjTYxQSC/xwS5rZhq9R1+asVL5PR4LVTRJfxeBoJsJV+rug8Xv29cyQJfOxq79
	aiqh21FmhjN74ukbWBRMrURNtkS+Jnj/ew8AgPn2JpgpijMFwmwGYTb/uYWZAueBsJGUl0bfaEY
	O/0YgsdvWGBmKvkNz6rfBR8TWQAe/tBifQ3LOdbX7v/2xoZDVXdYkBeaLBB41f1CtokKw/F4sjD
	XKFg4Hjv8RNM1KEjQQ=
X-Received: by 2002:a17:906:fd81:b0:c21:35d0:f43d with SMTP id a640c23a62f3a-c246a6c52c2mr3630062566b.16.1787653388035;
        Tue, 25 Aug 2026 03:23:08 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606a8fasm1880346766b.8.2026.08.25.03.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 03:23:07 -0700 (PDT)
Message-ID: <f2d97d29-e380-4d1b-ae21-f5ea406119c9@blackwall.org>
Date: Tue, 25 Aug 2026 13:23:06 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bridge: mcast: don't truncate the port group walk on
 teardown
Content-Language: en-US, bg
To: Jun Yang <littleddfu@gmail.com>
Cc: Jun Yang <junvyyang@tencent.com>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, stable@vger.kernel.org,
 TencentOS Corvus AI <corvus@tencent.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260812113435.1854275-1-junvyyang@tencent.com>
 <5fddb18f-8ead-4680-ad7d-82123966cfa4@blackwall.org>
 <19b05984-d67c-4c30-aec6-ee8e8be554d9@blackwall.org>
 <20260825101954.3799675-1-junvyyang@tencent.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260825101954.3799675-1-junvyyang@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/08/2026 13:19, Jun Yang wrote:
> On 12/08/2026 15:21, Nikolay Aleksandrov wrote:
>>> +	/* use _rcu to preserve the next pointer because it might be in use */
>>> +	hlist_del_init_rcu(&pg->mglist);
>> Just to be clear - I'd expand the comment to include why it is safe to do
>> so and under what conditions (multicast_lock held)
> 
> Thanks Nik, that is much nicer than the restart/checks dance.
> hlist_del_init_rcu() works - the UAF splat is gone (7.2 + KASAN).
> 
> Before I spin anything: would you like me to send a v2 with your suggestion,
> or will you fold it into the open-coded-list cleanup you mentioned? It is a
> UAF with a Fixes/stable tag, so a minimal v2 now may be the easier backport,
> but I am happy to leave it to your series.
> 
> If you do want the v2, here is the expanded comment I would use:
> 
> 	/* Keep ->next (held under multicast_lock, freed later by the GC work):
> 	 * a port->mglist teardown walk may have latched this node as its next,
> 	 * and deleting other groups of the same port must not truncate it.
> 	 */
> 
> Thanks,
> Jun

Please send v2, I don't know when I'll have time to prepare my changes.
The comment sounds good to me.

Thanks!
