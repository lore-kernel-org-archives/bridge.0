Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27062236455
	for <bridge@lists.linux.dev>; Thu,  6 Feb 2025 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852765; cv=none; b=smJONGgLBI1nWeiF77U2SlIsNHW6/JEKwPQTD9mSHCKMiIW2uhJhFzOof1g2bPKHleHnTNfVTVGdAU0y5Eb9v/9yz3DGsB0EKVvDQCMOOPGpEKZvfYgArpIPTo1MHtPpj3tWLL7HWI3Ox4HtnrbCT2VijzaePSyecRLQlLr5N1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852765; c=relaxed/simple;
	bh=Uu8aEP8VA8t1pCN7nvIDtXe9YZ0sStLUfZzdpt3Xdwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COUqeYSh+daDYPHhnEjswrYtbyRUsB6lLxKJugkoYhWu5Hln3YKK6Ri3G+9zNnn0aiu342xnLqaFHDfK+tBXrVllk3wQflKnobTORh+8VGLcFoN+xdKreOCyy704YqVLfHIO9uUahtjdvkp04JapEAhS/jkjT/bgJxeSsM4bOzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=G/imONNF; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="G/imONNF"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dced61e5a3so1685886a12.0
        for <bridge@lists.linux.dev>; Thu, 06 Feb 2025 06:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738852761; x=1739457561; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=THjRLKw27fymwkm9c9udCcZ4ry8EIlt6eJdjpKX8aMI=;
        b=G/imONNF3yH+WxHYD23JlNyAQLOHC0qLOkIimMaLklsJgGNvOUMhz/lvlNEYl+AR6f
         T0JvRbuaJdnu6SEqkz7lQwzeETlUDlRd9MWdthvTODbbsyZptoxDOpalWYp545m5t1Ga
         O7g/DoNsfTZXn4bXFoqXsA3d9zjtRKyzFok/wSwtNOpYi+I1/LakAPLcMAmFOsHWZqUM
         Hih60ViWtjZ3B7QeNGaimA3gOPtJAo8L9tZy/lLaiXPkUC49wex+6E5mFU7pjuYUwtHN
         MKA/w7quboOanJAKTgbJfnBwCL587feENEeuqyKj+7wMRrrKbnDvRZ/MFQd5Rh0oq0Bi
         qdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738852761; x=1739457561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=THjRLKw27fymwkm9c9udCcZ4ry8EIlt6eJdjpKX8aMI=;
        b=OLwEP8TRHjQTic5LgWTJnadWiyd79l5NWrzXHgAW4HZ+VOpndQyDivtgfC0aFfFPmf
         GcK8uSqFfKSCYtGs/96kGBLjFDNWLM3J9kVMx5c1Wp2rNBDYHAyVO/FtUqerP07T7tY2
         IjOUoCXwsxhODx9Zxbg8th6kP0cdSMlTSCPS3u4cp1FjOy93c0djb4oxThAhyWpBdbNC
         jKRsGbGk3Z0FvTFive7KEPeIe6MdCGbY4GkkwRN0PZ+OZR86tB8pAt3x+1JIws+1nvRA
         d5L8Qlbz02bHU1kAzu1atZ2uEdd+RYiCRXM3O4NZTsMFhNlkb0QKh45ZJV/ZITROZYp4
         FWOw==
X-Forwarded-Encrypted: i=1; AJvYcCWUHKJFZQQEzmmTDuqQ4+RLEjfG2cb3RlNM20EpBxX2IHRx4MWULb+mtETnOmcqSO+9pdB3TJY=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2PznlmUk903k+mkUzxHwEupevYFO4tRh5RimJjRdyLHqIfgBA
	/9/11RsomrS0UH2q0kNlUvItK6uc9dFkncVNltrNmC4uz6PshYvV6F5PPw5tAZM=
X-Gm-Gg: ASbGncu8x3HIgp+SHk0D8Z2WwqEFUgM64E8j5T+Bf1FHDntmYI2wdQqYV5sBcKACM9v
	F+dfBb07WZIzGIeDZHvjfNzoX19deolmkmcIoFslNSr/ssc3FYd6R8wn2ZMsecJoNVHaixetspN
	BDhUA0wYh21ztsG0FKiE5jiGre0kc1UKJGArtT3rTyVM/5f3LSs4gIuxVlkXSYBK58EJaDM67FN
	427rr0HPL2bDLDbmRBYqn6IFffueKfAMHV5o85OeKOGJW4+9VC3zaiKbszb+08CsmvMyhLI3uWb
	eT616Jrzjx7q1CXRiHoE0eLWOjlA/AiYQjNblS7BQ72CnlY=
X-Google-Smtp-Source: AGHT+IFlbmeulV0zbsnKd23pIgbY7sXFFTYPJ1StMcXHIPOGJvEQyfJ18rL8z1Xxot6BGyZS0rrfLw==
X-Received: by 2002:a17:906:ca48:b0:ab7:6e14:c03f with SMTP id a640c23a62f3a-ab76e14c0d5mr312575166b.21.1738852761390;
        Thu, 06 Feb 2025 06:39:21 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab772f843a9sm109650266b.67.2025.02.06.06.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:39:20 -0800 (PST)
Message-ID: <114ff1da-c7f4-4851-af3e-1a4fdabde9f5@blackwall.org>
Date: Thu, 6 Feb 2025 16:39:19 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 07/14] netfilter :nf_flow_table_offload: Add
 nf_flow_rule_bridge()
To: Eric Woudstra <ericwouds@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Joe Damato <jdamato@fastly.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250204194921.46692-1-ericwouds@gmail.com>
 <20250204194921.46692-8-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204194921.46692-8-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 21:49, Eric Woudstra wrote:
> Add nf_flow_rule_bridge().
> 
> It only calls the common rule and adds the redirect.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  include/net/netfilter/nf_flow_table.h |  3 +++
>  net/netfilter/nf_flow_table_offload.c | 13 +++++++++++++
>  2 files changed, 16 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

