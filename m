Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25488592E
	for <bridge@lists.linux.dev>; Thu,  4 Apr 2024 20:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712263423; cv=none; b=L61ZMbTmsx6PB1Yg1KN4wNma7+H1AaFPrwyUVxMKcLOmDSVFY5QQziAL8MjwappVhMlTV2ZdDbCk8764feIuA1+Uta3BJKbm6s1ZeN2P/Gve8iocGr6H9Dz0dgwvAVlpTxvDuRetyAue/HuCsrDXL/9QaycWf1QAT5AQIPcRXgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712263423; c=relaxed/simple;
	bh=oJzU1DchjJ7xBagvA/BSZcE6n68phH2iAnsMriy52xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hx2Bfig2uWjUW022yHcoRHalzFCpyEXcv9Qb1gFaLFDZNQRiOouZWxHxCxEZCIFeOl5A2JqQDeDSw1kJMP/qEPyNztGa8qYApwwJN+iVosjFnYbLwSSWkmc4qXNtUf0vlvtVRdc7ieob1Giudp0vgAvWmmbw0NKHXZ9eazIuT1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBQ90V9f; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBQ90V9f"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-6150670d372so15970947b3.1
        for <bridge@lists.linux.dev>; Thu, 04 Apr 2024 13:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712263421; x=1712868221; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OKmfpV6KrJ0i98Wh/0eskG0hyAllvgPjh1mOsK1t4hU=;
        b=XBQ90V9fx+N9Am6y+uiNIH1y0KsGPEnXAWEhI120KdRSu3rvnR4fQLWNLoEKXFYTiB
         4m9SMo0LveQys2VB8FwwJ70uAwMWtU/WQ1Hy0Z7UARWSkj3doi/Xu1Esl0Q57HOedsoo
         tAV2njwCFVnmaEx5A3sYosVoLEDlW0K2mcQaWvHfYhrIKR7H0tZOwrAfX6bQJy3uFD+p
         AEOxxIR+uEjS48xcZG8T9fXVG1PHDG5Vr8WFJrlzBYIw3Vbbu+xdPNYDGvhe4cZ9EeUZ
         NPXxTYIpgpD4zKEFE41qaxTjulrKBYLdfgF+C26awDVI/pKXOFnOQqalltHeWV5nkZSx
         b69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712263421; x=1712868221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKmfpV6KrJ0i98Wh/0eskG0hyAllvgPjh1mOsK1t4hU=;
        b=xM5vvWsh9mnWXK6OQNz902tul+i9Xwg38pRCLcCbgAj+SyX69Ztat+blWOEvAtvZNI
         mLyHJX03I0Fj4nz8PoeVATu9lJcOAO/GgYoJWIseRMurTTh9mhBtvotvr3TuW6/33BXb
         aKKDvrS8cH86cOVE+3wBez2KvzcoIl4asdMdy/2Rf82B5hEZ4AthXswL4oo+YBNo8eO+
         2NpSRONIZdrEjqUBqZZsrmGcVMKtqS/9XWypTvEJeo9jBiSTFCoG74u64KgyhMbJRxjA
         vZE5iowRCsRq9jHZaVQzGM0XNLDHzEqUUnL4SOHeK/u6Hx3MN3c+a8PWbnpppwSUgePF
         699w==
X-Forwarded-Encrypted: i=1; AJvYcCWTA9J+0mowOkz0un5JQt4O15bGInL2uoS4WM0kutXJjtMkJ19OIRhe0mdhcR/RromDAa2xuchAmEUqNgZr/vzJIShSno6P
X-Gm-Message-State: AOJu0YyU3oS5yXQj51795b0AEyPy4QF3FoEczcg3K+IpzbY7akBSWvsZ
	5C89SeaZBhznfc22JqsZFSTdIaCf5BOiFuFXJaNuCYXqaHWjjzO7
X-Google-Smtp-Source: AGHT+IGDgKuMAKhqUpXoM3ovArMEGP+ceyMkb2rh8iiSQhZCVHS7jAbeIre6Po29dMVGSorIXuhCzQ==
X-Received: by 2002:a0d:ca01:0:b0:615:1ba3:5732 with SMTP id m1-20020a0dca01000000b006151ba35732mr3527710ywd.11.1712263420902;
        Thu, 04 Apr 2024 13:43:40 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id if3-20020a05690c690300b0061511220f16sm45006ywb.92.2024.04.04.13.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 13:43:39 -0700 (PDT)
Message-ID: <b5f79571-b4a8-4f21-8dc8-e1aa11056a5d@gmail.com>
Date: Thu, 4 Apr 2024 16:43:38 -0400
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 07/10] net: dsa: mv88e6xxx: Track bridge mdb
 objects
To: Vladimir Oltean <olteanv@gmail.com>,
 Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <20240402001137.2980589-8-Joseph.Huang@garmin.com>
 <20240402122343.a7o5narxsctrkaoo@skbuf>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <20240402122343.a7o5narxsctrkaoo@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vladimir,

On 4/2/2024 8:23 AM, Vladimir Oltean wrote:
> Can you comment on the feasibility/infeasibility of Tobias' proposal of:
> "The bridge could just provide some MDB iterator to save us from having
> to cache all the configured groups."?
> https://lore.kernel.org/netdev/87sg31n04a.fsf@waldekranz.com/
> 
> What is done here will have to be scaled to many drivers - potentially
> all existing DSA ones, as far as I'm aware.
> 

I thought about implementing an MDB iterator as suggested by Tobias, but 
I'm a bit concerned about the coherence of these MDB objects. In theory, 
when the device driver is trying to act on an event, the source of the 
trigger may have changed its state in the bridge already. If, upon 
receiving an event in the device driver, we iterate over what the bridge 
has at that instant, the differences between the worlds as seen by the 
bridge and the device driver might lead to some unexpected results. 
However, if we cache the MDB objects in the device driver, at least the 
order in which the events took place will be coherent and at any give 
time the state of the MDB objects in the device driver can be guaranteed 
to be sane. This is also the approach the prestera device driver took.

Thanks,
Joseph
