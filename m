Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9255236449
	for <bridge@lists.linux.dev>; Thu,  6 Feb 2025 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852748; cv=none; b=gC9pTlRnXcBVxbVNSQFySLwlENTVBV4tjjkmnUukpgnlMKFhiuBrcXwWizE8W/CRhKX7AsAH2o3TsY5Tf3h5jnyqKdx6E/HeytAOid5KxnNNqXyiywwP/kfNaNeV5kDxwZS6FLg5GqyX+DFyysYplnDGhnMcMVL28ULUNAVBmWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852748; c=relaxed/simple;
	bh=ISXGN/k+kX7BuDCNrato4yYtVy7+BXIuaTBPg+6KtsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nf+xVmYv3sv/c3Ukf5a+BEz5zeiWXmEMrCEjJnHRXtDEstz8pEaUt/NW3oZPmknK8++o+qKN+URMziWTYVtTFMFXWsR49/UfmCpDiv7Kf4MMFHRkxn5YxaQUVyr8VZ77DQkoxBlYJWbzvYHvcnoYvM8qdJ0kzjhgU2XFsROggMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=N+Jc3yi9; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="N+Jc3yi9"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab7814aa2adso34364766b.0
        for <bridge@lists.linux.dev>; Thu, 06 Feb 2025 06:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738852745; x=1739457545; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S0JkQI3U6f+a8v60Ya7beYBhUDwWewUAZsXtUyTx0ac=;
        b=N+Jc3yi9f8XKlj3ZXRzlt+tna5YHA/sBpPPpGpfC6HTv8/4H6mk42ENbNl+H8zIwL/
         Hi415WmlR0OYeZursV3/vBYuyFIAgfajdPnWoDYMMuHm8+7QBY0ckKSEEhbsKuZpfytc
         aw0WfIPChl4a1g2xbKbVoyEUSSakgsjtCwBx+2anmuBTHw9wQCHUOdmpV6MaiO4yp/De
         jxh07jefsTFQlNLCBGJ5uw6v99WgCMHZVgSmeNtlikxcPwcaGZUJ1+VOw5jYqsKrW3PO
         yrxTBVWOGee/DCGCGn6Xb/UIYXzN/D7nvTDbHRcFgEtsiDLySsX+RIfEkjcm02muwkAA
         blUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738852745; x=1739457545;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0JkQI3U6f+a8v60Ya7beYBhUDwWewUAZsXtUyTx0ac=;
        b=fl+ms7q9VYmWTLrlswnGBTfYcNg+vOjWd00uOqXreJjspgUpkbpphF/v311SOHfB3n
         lCG7xMuD+v2U6i2agHCbps2huQkvw/CDYeOP3hDBNC+A+EjoSE+qWfW1UEXUIW8yfDDf
         eW5O3MPGZPYUZKjg2XNmBXUGKHY9lVkI4qULDJZv6CGv5oUIcHOssXgq5mkXQQgnkQxv
         KpzdMche3QnWkTBYkdzRC0uRQjnRzESuD3w+Z1tezwaYaskoTZmT8vVBhRwKD7GgswBt
         fhH27ZSlj6s+nmWmwrNAFMXuc3+QKasZHAt5IBZZggwGBlq5V3HwwYIJcVRpY1yr+8Wb
         +W1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9sTLDuwWhLrpHOVJftE9tNjRW3CAlGYbJHaHIA5hZRMHzKweZ8VfIEzuvqb/7FPQ9NPau7Rg=@lists.linux.dev
X-Gm-Message-State: AOJu0YxFYhFkv7A/c3FD6yCIDbtW2gjCOvMPw+1z/2XHBssEJe6xQUWu
	O4FBaE5dG+3KyWCXaHoPkUpQmUV8Y4FR0aWNybZZGo8PomoO5eJK6XtlMzw0I3c=
X-Gm-Gg: ASbGncta5fkTyddh5I86d0eNRqTGY30E2lY1B4lAf88f+IEq4uSng+lWtrSkWfn5RNU
	7jyyyI621q2tHk3OWZJeSPsTsr0iOgXEzlYa0ne65D7ndFhZw2Xcnw4UXSukdr1gf/U+YZl5Iw5
	tX05FrHhukT8WAd6Q7s7as4u3iYrrVJx0G7gC/AxChsHqvmQOeMHt3Gl9gJDq/X79Hk8EgnhLME
	KpWO6bLECqM+ATlKwq9XYZzfEkOJLSYu4TJjdAOXXAJBLgRGxEGtALeCI9buoKxotewVydR+IdK
	vxPcdDUOcDdDp5849p7Q3/CS0h1Y+8gSOzHUcir0EX9KnOs=
X-Google-Smtp-Source: AGHT+IFfccbgqNHY4pVflwA0HY/1yvIqL3O/a0V1EXaUtiholMev7dwDOL+lRjcs6CbBMFf4cXAhig==
X-Received: by 2002:a05:6402:2812:b0:5d0:bf5e:eb8 with SMTP id 4fb4d7f45d1cf-5dcdb762d40mr15968196a12.23.1738852744810;
        Thu, 06 Feb 2025 06:39:04 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab773339349sm107647866b.146.2025.02.06.06.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:39:04 -0800 (PST)
Message-ID: <98c8cbec-28f4-4814-bce4-e07101553f92@blackwall.org>
Date: Thu, 6 Feb 2025 16:39:02 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 04/14] netfilter: nft_chain_filter: Add bridge
 double vlan and pppoe
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
 <20250204194921.46692-5-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204194921.46692-5-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 21:49, Eric Woudstra wrote:
> This adds the capability to evaluate 802.1ad, QinQ, PPPoE and PPPoE-in-Q
> packets in the bridge filter chain.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/netfilter/nft_chain_filter.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

