Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730499;
	b=azVK0sE7l/piAtCYHKJd6aYgnAFUqdZCUC2spPs8ptVsoU4U2aT7NSVrDnc6uP7OQac9
	 LJQqxdC8dqqcx5dtSkvhxXnqCNRK1TY8VSG7fWOH3iNjI4SejL+hxNxHdnhOZx5CbJ7W4
	 VAtLdozznhQJu7noZX1g0le9rTCdUTZSxx7dwdIFGTN96uYbGiGGiwRtBwCCzg8/uOCKP
	 rBUk+8jGPRXiUXf+u/wUvhbLmu+0LuxiZMtBGsDQDUZWbQi2R885vrYxOnYYrWfapjO31
	 QlAkdtljOiB7l2mLiRIu3emqVFLXV3rsh2gJ4d25kpiXgoIcprmeLgtjl3UFdHCTSIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=bW4zFchgwCd38Gn97uqR7GAWxBtqtJfDJkTR9LdNPNU=;
	b=Qx4zgAEFYT/DC53IFGiFoOBFfQy//XjtIjwBjssGcLR/JYY4KEOrkx+rRLbtvUVpyO7a
	 J2cf35lt1asTSUENletGg5R7LMfmRBPCUcRSOD7+/7fEQwBpYypnswShIUSZ2viTrFsQn
	 5rFC4BK+4/+/iEGdvE24PlA8WwJxlqz3Z5YGX5CRvx84+DrhCZI9+yR4bk1uaaLdg/jlF
	 XQ8vXm/r4b9MnvpQBZiGXB8qZYsU+yR4qZtk3TYOSYRVjhNFanByCIue1d0DoDooG5eGg
	 BBQ6HVVwD+ih1AHiy4eb6mG+Fu0/M49HVMpTpyWJ8HeXbbDfv4CLRmNwoC5pbUkJavg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=jsdjTbDa;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D21E606A31B
	for <bridge@lists.linux.dev>; Tue,  3 Nov 2026 18:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D21E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=jsdjTbDa
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso36145635e9.1
        for <bridge@lists.linux.dev>; Tue, 03 Nov 2026 10:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1793730497; x=1794335297; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bW4zFchgwCd38Gn97uqR7GAWxBtqtJfDJkTR9LdNPNU=;
        b=jsdjTbDazskwFZIse45rvUzXiNRWucms/0LKEqxm5EusvNBIkAH+dsAcR+8dKt9oAh
         2Xi34Fmarj/2Tdb/ZaniwmyENWQhTYCTN613S91cuLEHJczECqKfnP/OvVPY1bRrdxPp
         hJas+9IvpuP34OZujg7ma4QYwWektCyw1iviI1cadEa3M1JXqtR03TDgoADMA1qPJO38
         rTogacYRgsTTKXKLx9/GR20B4+lMDdbLsOKw/MfNbVGM4pQLJzrQKquaZWJZUA3nxzr4
         WQAKxzI2OAEgitt04RIzKWcQpLbKGfhZIo9ebh/n3yB+wSeIlH6WhVlHd/n7Rw//zPVt
         M9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793730497; x=1794335297;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bW4zFchgwCd38Gn97uqR7GAWxBtqtJfDJkTR9LdNPNU=;
        b=MpXlFWBMUc0/1PiYbI/6wIjOLvqqSnsdHV2PbK5FPEPCMiuRrr7HXoN3ip2YnlRNVs
         ECWk6+vRJrgBja0WW9RiGRXYmbPOst1aV1hLMLx1rgiYDJu5/MxbXByG+AxtwqLhx50O
         VHlfRJ+9xT+W2ZM5VJ4GY04YT1PwzJ54rCL//oaNwRUVQ9zQ3un5NTJP7zN8TYsWN5/Z
         U95RF5AS32V2/nX5ngFLoc09Zb1XI3Amn8jU0QkX6sot6odjmWIaSJY3uI8X0OZSmUlQ
         l0Hf7T+RJifV56mSxJVnoObYbSY7wILomtrpH3DDEVtFcAKMwN+YX0P9xe3u+rNyjvXr
         3Mjg==
X-Forwarded-Encrypted: i=1; AKwUvBzChEC7+bcdx8qCgjzzcVlZxH0foPfFEo6T4xg6G866wr3c6Z4MJVbZulEQ4IUY/TRfpgOawYw=@lists.linux.dev
X-Gm-Message-State: APuU4Z+f5djzWMKQfIBjLb//D9pTYQSLrQrohWO//jrr0MuUhP1xpJT/
	8853alMwyv/mx7rsP1K9WUnk2y4FfKiS4mDcuF4cCIyre378EQiDqDNiByirpUENxKs=
X-Gm-Gg: AYBFou1Zu5H86L27o5wuNzij6fDqps3z7s/0AY/M9LK79UwY16zPv880eEvahRlnout
	DhaXK/6qyAbUyAl4VoK7s1OC86wc0C/1LxVgSstcj5DoD2pB0vMOveoSDMeKO8YewTOPjWUoeAl
	hiPyu/iSAjhXk+k329iHAw/j+Ox/ygb2bYhBqKcJwXrXuSRI4iu5HjExDZ9NrdDlzvYY1x7AhNQ
	ccuNdfEexTLlBo+omlyLZugtPViuRNub0rMpQ3/uIfN5een0NMJpASmDdDJqOWVyEl96i5ccaO7
	iXc9b4mF/hsLPNWWQL0bLNal1KZ+T12taVSueR/FPY0urEjU7rTTpABUhSateUmuFksEM/UQ5DI
	v5ANmflXuTPqV+MAVF9jh/d20dq8aF3ndgEVTziuazYhShuTLZ9usQMprPsA2orKvaBHa9kyDFy
	isdyUy9c8ak+9BZI2CugE3PAK7I5vOOTfD/+CXkZ7KaLFnLfGMpwM2ykHL91ycWAO8NqzxiJ+v8
	+dgmAYUmT+GWqSu/HcufneZPMVmhPVtw7ADI5eRA5hlWKnivWR6TlApRTqdg/uXZbUfX0OriXz6
	vq191V5fiPEKYCZpq5QEK7bSJInjEEaGnV1vsbCXZ/wbOOLy0AdjmTmkAw==
X-Received: by 2002:a05:600c:3484:b0:4b3:6900:280c with SMTP id 5b1f17b1804b1-4b36def42b9mr49914725e9.19.1793730496518;
        Tue, 03 Nov 2026 10:28:16 -0800 (PST)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8c6e9sm26640902f8f.43.2026.11.03.10.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 10:28:15 -0800 (PST)
Message-ID: <1bace3e3-b3a3-4a8c-8d2c-6df29fb96d21@blackwall.org>
Date: Tue, 3 Nov 2026 20:28:14 +0200
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
Subject: Re: [PATCH net] net: bridge: use one headroom snapshot for ND replies
Content-Language: en-US, bg
To: Jun Yang <juny24602@gmail.com>, idosch@nvidia.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, roopa@cumulusnetworks.com,
 bridge@lists.linux.dev, netdev@vger.kernel.org,
 Jun Yang <junvyyang@tencent.com>, stable@kernel.org,
 TencentOS Corvus AI <corvus@tencent.com>
References: <20261103075439.43644-1-juny24602@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261103075439.43644-1-juny24602@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/11/2026 09:54, Jun Yang wrote:
> From: Jun Yang <junvyyang@tencent.com>
> 
> br_nd_send() calls LL_RESERVED_SPACE(dev) once to size the reply skb and
> again to reserve its headroom. When a port requiring more headroom is
> added to the bridge, br_add_if() can increase dev->needed_headroom
> between the two calls. The reserved headroom can then exceed the space
> accounted for by alloc_skb().
> 
> Take one headroom snapshot and use it for both the allocation size and
> skb_reserve().
> 
> Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
> Cc: stable@kernel.org
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Assisted-by: tencentos-corvus-ai:hy4-preview
> Signed-off-by: Jun Yang <junvyyang@tencent.com>
> ---
> A KASAN reproducer for this issue is available if requested.
> 
>   net/bridge/br_arp_nd_proxy.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

