Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06D3149DE1
	for <bridge@lists.linux.dev>; Tue, 27 Feb 2024 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060570; cv=none; b=Pam2KFf95qx2hj0bEDM1CxzLIoTPz/N1rtGFyhE1LohZ8DaEZWYjkTL49tx3vmQbNNAG+J3PuTPsAlfuz8tV3zyFKa5U+ifNbKkfV2ylr3qeIBT+ZmLQgva6yyMNtGlQ1BF6fThoRqPJwy5hRdWCZe9WTCkoP4u8Eb+sVaDUdVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060570; c=relaxed/simple;
	bh=62mCy06yom5/3xe32ZTRaQKwjk4T0LRNc3FRQaih5po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuVAE9TvqJbo6Ew2vIt1r2pZRTiA5cu5F5B58Hp+1/oQ7qf4+ENxAlqbp3oNTGUnLH9QeSejYASdGSilVHqdeWEA+0UHPQfBBzE9iwyASFl/FC/s4ZppMHaz7od0GYblivz5jSZz0Q/aXT7dimZyd5tnH0YCGw9xI0DvoSXfaUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=XDHU2CWk; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="XDHU2CWk"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso5803702a12.2
        for <bridge@lists.linux.dev>; Tue, 27 Feb 2024 11:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1709060567; x=1709665367; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=945rBYNcoUgKGmowyvDPIGUfUkamx1ovsI5O4nwuIRI=;
        b=XDHU2CWkkSxMbHT2lzcZHu6pSr3ozcMbwF7kWlMSLS4GcP9NzoY4wqrV1LEauKJBLJ
         UR+SG809p3z7Be+Bu6l/0hnJjMRsKtzBkraTSt75sYu879h6+dGxE5yhFh9oLS2tsyL1
         /plDU58Zbjs0Tr0eRKXJl1j9i2sAqEeEnLyui05bJSa6OMP9tNGi5Z4Ed+p3fSi9mG+D
         ynvDbH9jqrNnubbbQ4l8F/BRyI/HGh6qhs9tB4xKdl0Rzd9+/LAf0b1zngg8D4VB4jrY
         6r+L09oVIT7JwliOyV40aYYrfSp1sPkd+06cRZ6OZLLRdPateuazNuESmn8LM27/baFd
         TIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709060567; x=1709665367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=945rBYNcoUgKGmowyvDPIGUfUkamx1ovsI5O4nwuIRI=;
        b=kktn8eWHbqTzy7m7in3c+SrFzliYcvwX9BLuUMp4mXR9ibQmyE/kzV2WdgJfpCL4fT
         ssI5Jgw7lV/Z9iZZGQlEEbPhg+xhZi7Sl/U6QDFC4u6hnIeEVblWqsAGPVcuzDvU3q40
         k7evgb+4zFynOXB7tVRRU9rhawKdji3edAmADiBMn5ERs1ksvvlkoeXwe9bLzw8Vr/2d
         b53oytY41XnG9Lmu2OvzsdAuUpKKgxl6PT+pe9sdL3jC/e+Us2hLjlGD8pGx1NzQCSb9
         XDXuGb1cJln5c9GiPA+HvRSAIYDwqpF/csyT1Np7LePEcarlsvII29mR/UKZ+LTkHtUH
         kZyw==
X-Forwarded-Encrypted: i=1; AJvYcCUfNa4wfuJrH9kw+a3KxwDbcfp8aJe4Pn0Siq/79KWs0q/YG83yfUr7apXk/56UHEwWQ8hfnKD3wbz7VUS6LEuql1ezLcYD
X-Gm-Message-State: AOJu0Yyq1t0QXcxNem0C6mNZOcp5d9nHMFCxADWSHn3BNlwhKvLQdXqb
	ysdLc9wvp3XpZqWa6/C2LCSa6OVh0WdiD4UAX6B+OudSO5Z0U3khAYLFCSEwpjY=
X-Google-Smtp-Source: AGHT+IHwlaf1WNIWALYUt7NSPAriGIGVbEfipxAgr6lBGWMwiTlps9KdmMszSlFOlV6rNFwC7vlCdg==
X-Received: by 2002:a17:906:3488:b0:a43:ccd:a816 with SMTP id g8-20020a170906348800b00a430ccda816mr6234481ejb.31.1709060567415;
        Tue, 27 Feb 2024 11:02:47 -0800 (PST)
Received: from [192.168.0.106] (176.111.183.96.kyiv.volia.net. [176.111.183.96])
        by smtp.gmail.com with ESMTPSA id rf20-20020a1709076a1400b00a43e6c2e107sm91703ejc.189.2024.02.27.11.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 11:02:47 -0800 (PST)
Message-ID: <f8a78ffd-3504-4cad-bbcf-553186f228f0@blackwall.org>
Date: Tue, 27 Feb 2024 21:02:46 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: bridge: Exit if multicast_init_stats
 fails
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, Roopa Prabhu <roopa@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 "open list:ETHERNET BRIDGE" <bridge@lists.linux.dev>
References: <20240227182338.2739884-1-leitao@debian.org>
 <20240227182338.2739884-2-leitao@debian.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240227182338.2739884-2-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 20:23, Breno Leitao wrote:
> If br_multicast_init_stats() fails, there is no need to set lockdep
> classes. Just return from the error path.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   net/bridge/br_device.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index 4f636f7b0555..c366ccc8b3db 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -135,10 +135,11 @@ static int br_dev_init(struct net_device *dev)
>   		br_vlan_flush(br);
>   		br_mdb_hash_fini(br);
>   		br_fdb_hash_fini(br);
> +		return err;
>   	}
>   
>   	netdev_lockdep_set_classes(dev);
> -	return err;
> +	return 0;
>   }
>   
>   static void br_dev_uninit(struct net_device *dev)

Please send them as separate patches next time. These are not related 
and shouldn't be a part of a set.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
