Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153EA65BC0
	for <bridge@lists.linux.dev>; Sun, 18 Feb 2024 21:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708292844; cv=none; b=MKncGrFrZAr12B1gS8cvCoheIY1zNN/Co/OZ+/9OPDpFjP/dRlG27x3Wq5WXhD69kn7R8OvEYhQlvMn9rWTIhP+ecdJ5RMjMV6VwmM30cySLWHexNO+pzxLFhttkxoDqaLuaUTqk5vNUZq8IUrCygbgBhxJebaYINmhm+6iOToQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708292844; c=relaxed/simple;
	bh=He296CGuCmElTiY1KTWvPzuztsoIaHP2KjB4JkUw2Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ioi260F44trRg2u7kVIZM3fLOS9rnqNzSa+NSayuurIEjtvoty2BHSHmz2O+o7YIdCrwuMI1RMLL6wDKZUf/27T121F6NkMSgYTDFKJz7q+GPlTS1zA0KPrZtp4UaH0SCdE1F/WeUtVw36DK7A95VpjY3Z0KzCQHUWS1/00BQwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJLhka24; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJLhka24"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so3080257a12.1
        for <bridge@lists.linux.dev>; Sun, 18 Feb 2024 13:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708292842; x=1708897642; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2h7w3PICpgc66DOd0GBlKCF5dayhoEba8xQNx0hBJWY=;
        b=NJLhka244+pO46MinekIkwa5mgVjtAjUDGo2zn5GG6DjJab4X9IwIQkl2V48QIYPvs
         XgpnnC0HGYTXxPrpT8TeN8kd6IQTMX4GrGiHN/THY/GCy4NAVWQY9oaTisQnWZ1fEa6x
         px/rlyw2ZmDJwDUbuqVm72mYV5mZWf+QaClswFOL5B2DvJrn1TS4My5hsOHx9P1MLdFI
         p/b1nwCYL8+XgmNLqx+u35HFBZ08yc7hsuvmRxIPtwn2s789/fPoAelBH0tqe6di07jT
         Z/qtD6HbhD6/UhvqykB7XVQ9tSRCPG5YW7Qx1JnrVm1FhMNvMyv4iIc8RuOHOrvho99n
         oPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708292842; x=1708897642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2h7w3PICpgc66DOd0GBlKCF5dayhoEba8xQNx0hBJWY=;
        b=QA4PgtWgmmTLRKl0agaAV/n1fY+pZ192MalQxs4rMGxyu2S3CT+KSbHsUp9jTQKewi
         JvVHILzwIgsid6SgOt7wIN+bx88aYK90aeYJ1g30UKNpcuIEPWepbki0/bu87WuIDwkt
         VM96QRdT9A45VYOitBN92s773BvjVtdDCyGT/Og3EZ1Lqlbitt1RjYr0hTihNNxX+02D
         YlyCUvVhwBJ2wgpjP1EbVgI3w9sAQzMqChm28/w6chVJAFdN/4wmz2zpKEKhyNEABpbC
         XctYJbhtIKz0DWNSyh3p+11BEAmHgqfz2gVwfnPNpY5zx+ZQHpIWWBGW1QNF3/jB0lYz
         Bl/g==
X-Forwarded-Encrypted: i=1; AJvYcCWVGKjBxOhAZpOiE4ISl7YqSLa85GvH+I+Bpt3vQ+5YNRlszq6EKJhOSTYV2rIb3UfXr6iNkYftoaoQLCHoWl9Ygp3Frcwl
X-Gm-Message-State: AOJu0YyyXdJLMFDjlsG0TITSrsB/Phv4FvdYCQU2mvIWfJgq++NTZ+iA
	UnUrZsPURruUx0Jp21eTPgYbvymui74bBShu0OwQDKoNXRNo/qlT
X-Google-Smtp-Source: AGHT+IHHsrNNaqhzpWEb7ZSZlMvmO/EGN3DdEK1PReUEdPvWQ75O4Nwi52lCklFmN/BpftZW2qDLAw==
X-Received: by 2002:a17:902:76ca:b0:1d9:b739:a5aa with SMTP id j10-20020a17090276ca00b001d9b739a5aamr9080407plt.42.1708292842210;
        Sun, 18 Feb 2024 13:47:22 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:ba1:b1a2:78a5:4a29:e334? ([2600:8802:b00:ba1:b1a2:78a5:4a29:e334])
        by smtp.gmail.com with ESMTPSA id lb14-20020a170902fa4e00b001d9558689cfsm3107629plb.111.2024.02.18.13.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 13:47:20 -0800 (PST)
Message-ID: <ce36b9ac-6a32-4b97-98e5-dde72ef2b99b@gmail.com>
Date: Sun, 18 Feb 2024 13:46:37 -0800
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] net: dsa: constify the struct device_type usage
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 Oliver Neukum <oneukum@suse.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, Roopa Prabhu <roopa@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Loic Poulain <loic.poulain@linaro.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
 linux-ppp@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
 <20240217-device_cleanup-net-v1-2-1eb31fb689f7@marliere.net>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240217-device_cleanup-net-v1-2-1eb31fb689f7@marliere.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/17/2024 12:13 PM, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the dsa_type
> variable to be a constant structure as well, placing it into read-only
> memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
