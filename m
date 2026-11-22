Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795343023;
	b=47XzGB78H3hFO7yZb9O1Qq5lDSZW35P2mycoexm0yKbY7Zq8bbV3sRsyHvuZ5pAYW+sZ
	 9L52QTHcmvWv4/WNju/Z2T+2k4uzQw8ISsHkzqYWNyJuDXOwq8uX8MnxwrKg+hbADTtuy
	 AdzVwlA4TNPrjCL0onUkd94rRzKAW0VScWuzWJkgLL0zUiX1uE1/gqfodHuaN8rojUmI8
	 NnG808X1PR1oUhmHZTcG8+NsmOzh/GaL69yYW8R2CU8SdzEjPI62Ua/vRqei6NHtH49CU
	 S+b6o6nzMqih47WPsu7J+iesQWRL5dKmiIKAZlH2qEVvroCFtJmcgrcy80KkBsXDBNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795343023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Z5ElRnK1KcmWQzg796qjdcPFsrWyUv4vErbWyV6jKEg=;
	b=gUroY9J6QA/e1JHzgr2lVSbCmmAaugX3W8VH8U4ydnpFKEvzVML8/ATn+sN5xeS0oLrq
	 4dv/XHzhGkvmX91LG3AbxhX+1gn6ewuHGGhXgDX5R7ZFwsiHzbwwHFS6ljzdMdy9LE7Tc
	 E4gGQwH9JOZB4cLDlxqaKxczrlcUYke+LWBbSuVx4wV8w21mtR6ASanYW9E+5hu8OaLav
	 HXnzxiVaICuTJE7Omsu8PxcN8fa57eYdCXDsMiLFqsXqZcWY1FdTA4pOK6hXhd6kk0shM
	 ElNu+9flaiEgHsVhNTqZoBDof67h4SziTYxUsObzSGJjJ+raeWAwuCMBcX4ywMU8vpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=jfOfzOOW;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2B0606A32A
	for <bridge@lists.linux.dev>; Sun, 22 Nov 2026 10:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B2B0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=jfOfzOOW
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso22270735e9.3
        for <bridge@lists.linux.dev>; Sun, 22 Nov 2026 02:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795343021; x=1795947821; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z5ElRnK1KcmWQzg796qjdcPFsrWyUv4vErbWyV6jKEg=;
        b=jfOfzOOWUP/ohzThLTFJ/JkqJLt2Jrdc6Isgnq+iWFq8WPok0EeK0+I/Vfmf3Bip3R
         R7S5rgRNWnl5V2QWcWfITI4YgMeLqh330GstZJtpKgAkJBh0/JYTLv1UfZWmPRToNL1L
         V913UQ//Ou87IDW9BIhs/6V36h6cTFrgo6u4vSCaVcxhdmli151IGQlC7thSrnChtkT+
         n4m5l29IpQJSrdZBh7+uMLcIui4SvKq51vA9QcF6Cbwa2M+pjSuG+UCKmUukjZdqaLX+
         axDwrJyuFVPDXFQybkgyniA1XvCgB5OyIKr2AlTjaU+Q9h/0OkSTeewKAlZ02tOAqtr6
         XPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795343021; x=1795947821;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z5ElRnK1KcmWQzg796qjdcPFsrWyUv4vErbWyV6jKEg=;
        b=Xl0xOE0G79Mo1j31pzcn186FjjhiCK1Z8z292ez3Oj7LtBdWGJEqfo54i55KsheHeD
         9N6iOo5ILuxUTaBlyVfpeXHyBom1+24/F7RpOZNz9ocv1YVm+GNPWmHJE3FH/wI57pIv
         14OB8M55YnBy/Jwef7c11cSoafiGDchHSQkGZaqmTQK83XSF8VWB1iTHFLqfIM9Z7uzD
         nQZIeCRpK6znYxp6oxYaK/P+LJYpnMCeUMgoGYynoA32Br0MOkD6Sa9CFUuhR4R499ve
         m/r9YAP1HN4865Nzkcsqr/5QmtmNJlrhz26RYxIqfu52jCpDbU20AE12gzWw127iDjtQ
         /R1w==
X-Forwarded-Encrypted: i=1; AL+hErHBWSbIsradE9sYJXOT6XqLuw5PSPnijZlWIm/5b6pLI2SAXtgk2Brpw958wAzRDxokIxeLe/U=@lists.linux.dev
X-Gm-Message-State: APuU4Z9IT/cDopcmlSttix/H7haINIwL7rE+RCI0mYaLb07u8+ifnq69
	Ukpt3iozHLGcElULP2k2bHhI7OPfHSHhGfW8NoZiolGo+RCbPmNux9cU0hP0tEkCzVAAhDEJ74x
	4bVehoHftDg==
X-Gm-Gg: AZFdTZfiiej6qpUcj42krWGRmIpOXlpmC8vwDK9uKJPdbojbbZympo4WhsPRpkq38/k
	R0xaudAJuHlNO3fO78QHjpnKM6wkqMBScJAqujZe3PEv9DxS3iNcbwLr75U5DnadxcGzVkRxLf3
	+fXKUPiIHgEncZ9GRQmadF5YGeTG8106KkHmFsasAYlR0P8/w9eFVurNdcawWGMyyWi5/htvqqv
	m2ngXfB8Z7lfdOMPDVm/vTsIgxeB9Jh5QFQL0jgmgQOvOwO9wFmohiSGIMffr16OfTewdmr2S52
	ANC2SrI1rb8K7GE2tYZVWIJwvm370BnWvxkUJLHCfjcEj6V9F2L1O7FpW+xgHydLTrVHkan/3EV
	gz1Wnu80mktt96fGkOCTEEm+TFOkewaRjXYGziD7o2bbdHhnRA64kDqx+7CtN1Fg5SPJYNJ6QeQ
	i6JMv4gbn4ATvL37YQDcWg9yIt+OqNqeQXXJs03dmZUDROkkZXUKymodYq0iMkpOLVZ4bDrry3k
	pxXpe4XvnPdOzpbwymB4on0UtyI1Q19EFC4HuhKy3MS4Y966Sx1o9ISzagULhqbJG5jYzrnkgwS
	ORrJRsEVKuH481usBjvJwkEdTrR+pnlYu0a7tNDRIGlgwNsqvTnJ93wjMUY=
X-Received: by 2002:a05:600c:37c9:b0:4a4:4d57:8487 with SMTP id 5b1f17b1804b1-4bb887fe7f7mr158409615e9.5.1795343021420;
        Sun, 22 Nov 2026 02:23:41 -0800 (PST)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm163162455e9.2.2026.11.22.02.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 02:23:40 -0800 (PST)
Message-ID: <60766188-3c81-4d05-b684-811136c26f91@blackwall.org>
Date: Sun, 22 Nov 2026 12:23:39 +0200
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
Subject: Re: [PATCH net 2/2] selftests: bridge_mdb: Test failed source list
 replace
Content-Language: en-US, bg
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, willemb@google.com, horms@kernel.org,
 dsahern@kernel.org, shuah@kernel.org, bridge@lists.linux.dev,
 linux-kselftest@vger.kernel.org, kyuwoncho18@gmail.com
References: <20261122072504.2623702-1-idosch@nvidia.com>
 <20261122072504.2623702-2-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261122072504.2623702-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/11/2026 09:25, Ido Schimmel wrote:
> Add a test case for the issues that were fixed in "bridge: mcast: Fix
> source list rollback on failure". Check that a failed replace of a
> (*, G) entry does not change its source list, with one of the existing
> sources specified twice and a new source.
> 
> Output without the fix:
> 
>   # ./bridge_mdb.sh
>   [...]
>   TEST: IPv4 (*, G) port group entries configuration tests            [FAIL]
>           (S, G) entry for source 192.0.2.1 deleted after failed replace
>   TEST: IPv6 (*, G) port group entries configuration tests            [FAIL]
>           (S, G) entry for source 2001:db8:1::1 deleted after failed replace
>   [...]
> 
> Output with the fix:
> 
>   # ./bridge_mdb.sh
>   [...]
>   TEST: IPv4 (*, G) port group entries configuration tests            [ OK ]
>   TEST: IPv6 (*, G) port group entries configuration tests            [ OK ]
>   [...]
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   .../selftests/net/forwarding/bridge_mdb.sh    | 23 +++++++++++++++++--
>   1 file changed, 21 insertions(+), 2 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

