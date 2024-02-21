Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E49196
	for <bridge@lists.linux.dev>; Wed, 21 Feb 2024 00:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708474065; cv=none; b=M+emFhtHUVPEirOZimgY2irNzJwJHZy5uu6NYZPg3wMB2TZ0Qddvg0ZsRKD08Z9Ul8a1sjeic3VU3rAzr4eZsLONArtQhvwD3ObFonLSMEl9gfeP9pUlRqjan9ThJBspKLWEHyHXCgHqctisla9FO/wPy1YkInNWESvKDNZmma4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708474065; c=relaxed/simple;
	bh=iXE6+R8ASa+RDcoAvHrDmlfm6SXejlgM5QbL0gV5rQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M3YOGkXQmIwG4I7699FjzD35BqwheZXdbXf/3GcR2CwJs8RyyAxTtvqEkEMMm3yw6qy2dnbsFroh4a5INn3an4S0jXLqUwrBoNcXnvSBU2c9rCNq+5WWlcspwaJASy6Td4LNHjCslosf/ZsWLsmIcLQFQSbnmCyCLjxg50fvv7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acPvA/iw; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acPvA/iw"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33d36736d4eso2276083f8f.1
        for <bridge@lists.linux.dev>; Tue, 20 Feb 2024 16:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708474062; x=1709078862; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lJEzqI5ur+SbBoa1SbqduYIKj5d2G64DD1tgTxLxA/Q=;
        b=acPvA/iw02dHgA/g0dlG7vJVn7qO5BhbKXQPuOMI1YGod7Ud7kkiOO7/EiBHvwNufK
         XM0/QOJsxfbsqkoX+ecIHJxMxF1e+KecvVnfTaOzm/9qtyO480vy/x/EpwwzTQsN2pkt
         pqsenAT1Kk5/I/COrFSBKbHicpK61mBjAl5dwv/JDK7SJTEIL8eVcIXyXiXBgfx6cIT2
         UtXHWa08B2xOuSzsyhxRzNflTiZ3XQlJa2c9GMZ2WdyoTYN3jjzyX7/pKVmiPmdVoDRB
         Xg9sBjbirdRqLbjQsp6opDEp6GyIjF+v++IB59wwYu/DHpsoXQ+kCzeeYQJ6v7QRZle5
         VNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708474062; x=1709078862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lJEzqI5ur+SbBoa1SbqduYIKj5d2G64DD1tgTxLxA/Q=;
        b=xJW0jiqTLm1iiv39NWfqyR6+M123tcRtb6U2keXeMLdXj03X/CnKRYsS+GjH4z1CES
         eBI3zUJC075XTe/E4hEzx0+m/81hdpv68ydxoj60lAQdIA7Yn3CdQ09vJd+noZWGAaeV
         UvaGqMgRA/BaG95grA7toBCLkwHEygCYG8Npkj9bcyaFI7VqgQE9qAM9Bwdqff3CfZAY
         fVFJdVGT5e5LI4R45nuVfvC8ApBBZbIkxx2Hhk/6w5b1/cs+KsjuBg0S10lnSUidGVSM
         E63aGblI9SIt6GKcRnHeHSDYJnebJsl5rKUl5x3puUuJh/XvK4ezPWrl1UruGWg/oEOo
         lmFg==
X-Forwarded-Encrypted: i=1; AJvYcCV9beHXMgB1I79JqooeYtFVqIpMssO2hylNazMH4U/neJuXsX8vA/FTFY3o0Gc+dA/5F13j6ee3C7QTkVXCDho7zOvKA20a
X-Gm-Message-State: AOJu0Ywb5Zx6FYhyyA8kmN1H+tQuFsFqd+mSTD+Lk5CfNTnvaiJfc5yn
	h0yLe6qYfMejOQSzDtT61FJNQbFfNT3RSX02htq4Ot8LnaOE2k+I
X-Google-Smtp-Source: AGHT+IEjN/4x8lMxmDXugNXlFWRbk0nwkpz+fRchEALt1xd2cYaKzfO49MmZPW8WXFfsgYFsCm3SEA==
X-Received: by 2002:adf:f6c8:0:b0:33d:714b:f3bb with SMTP id y8-20020adff6c8000000b0033d714bf3bbmr1560887wrp.26.1708474061669;
        Tue, 20 Feb 2024 16:07:41 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id bs17-20020a056000071100b0033d47c6073esm9134362wrb.12.2024.02.20.16.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 16:07:41 -0800 (PST)
Message-ID: <07fb65c9-109d-4dfb-ae60-c4a1ce99876f@gmail.com>
Date: Wed, 21 Feb 2024 02:07:42 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] net: wwan: core: constify the struct device_type
 usage
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 Oliver Neukum <oneukum@suse.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, Roopa Prabhu <roopa@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Loic Poulain <loic.poulain@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
 linux-ppp@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
 <20240217-device_cleanup-net-v1-11-1eb31fb689f7@marliere.net>
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20240217-device_cleanup-net-v1-11-1eb31fb689f7@marliere.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.02.2024 22:13, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the wwan_type
> variable to be a constant structure as well, placing it into read-only
> memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
