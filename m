Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7EA381A3
	for <bridge@lists.linux.dev>; Sat, 19 Apr 2025 06:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745044925; cv=none; b=oWrmUYb/C0bul8F2Oj3/mqhyk1lZ9FRGNSNWNBRqlylntwFA443dVpRaaiXBOBGsSPSkiKojr9PWGPMemdFi4+CbHldHyx9eWn9DE4aS8ef5Tb7WUpYpFBASiiE8TFp3+K1TAwydn0xV180Brn5tfXwnqtG+ReJfuGkqUwHImqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745044925; c=relaxed/simple;
	bh=dwfegz5E7yhUv5wGWmn8LAB/4tuZa5IyvqOOeH42idE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eo6WD2P1puEHdqdesQ3H9CmPsiyA2V/V0ChygBgVaPZDhXqlhujMASaiQ3L08rdKSp1XTj441pLBfyHZMn55CNWXaHbDQDDu1FLx8myTwuQJC9oru8vwM85zqqfe7hHsNK2/eEtSA7RsjKxyO21CD6evv1eaJgvZM55NNKJDL2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=D5ID3TvD; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="D5ID3TvD"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5f62d3ed994so2002404a12.2
        for <bridge@lists.linux.dev>; Fri, 18 Apr 2025 23:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1745044920; x=1745649720; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1CcAbqixIuGQqthd7kNH9FiBKY02ut5UY/pBA+EHL5U=;
        b=D5ID3TvDpVyzkYDFWZESqlui+wHOmx5ADwZ3cEctHtY4txVdIg7aInrePhXOkVZqeg
         +94qrxbINNVl7VtI8idMEgKxrIIh36N1yvg/3DjmbSsYr5xrazIGwkEEnwymztijdQSL
         JN8EGx61w4LZUjEmc3mwQv2YyrTeGMOVq4T7hgoiygq7ZoBiFo6rqtOiJk97/3EDTCov
         kTGB28QNsEaXIl6P1SKfs6fti8yiiX470ys3W5tq73lA/6H5v9rtozGXsuD/vcbD1zoy
         TaOR8LUTR00H96UgkcFRlqfgw0re4gzCS/+qYoGQQeotndn4L8C/68n7AYOJ/oP90dTA
         Up0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745044920; x=1745649720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1CcAbqixIuGQqthd7kNH9FiBKY02ut5UY/pBA+EHL5U=;
        b=Iunr8i7hD91BW/XpgoBNe3RXVY3rY396SG2a4y9kRvaPLcblmdysu+pX1muenv4wj0
         DsIr9b8+lWxli8fImuR0Lua/6i/XfF5hhzfxUaJSxxNxao3df2z8D5yK1ghQVGeQEclY
         9CPsS0w+SFqWQhk7I/W1Q4uAMNZq6TqYPRXAz6fzU6nzwMmb126dOcJcmRmmIUaLQvZE
         hck6YOw7rdPp9/ZJ3VFlk2dqQt+RfcTddsUMnNYhThql7w88CjK2aaC+xafxdu1uj5So
         SgZv+TwD4RV+JbMi0n71X6XmwBbMqD5CtLdnFc3GwfhnhAMtSE4zh2BE8nQA9+Stp9jm
         eYgg==
X-Forwarded-Encrypted: i=1; AJvYcCVqY+9gS+nnWlZ9xtlxkK20jywoAljjZIVc/XyQIZLyY6WB584cfqQtWTY3LZGxOEYa0cHFrTw=@lists.linux.dev
X-Gm-Message-State: AOJu0YxIp4QDXWrBIu0XfN8gNQn1uxNGvk7D+VoujXBuDm4c4hSNmy6+
	PRQbtmxRuvDrW1Fiso6e55JpyOLBB93yxGYHoev9MFCc9tPVSAlv1kDq97BaJW8=
X-Gm-Gg: ASbGncuSwzFZ+HgSn81tvjhSmzN9fjVBGB9oDTNI+R+fsQq/fiv8JARBeC9TjohJARK
	+uJuknjosWjLl5QJquuwdLrrw/BqWMXZa8QAj3OdGYKWcM5J/HGuDg0DZUqjd34J63n3ZZ4yIaQ
	YMWg3HhwLbxAd09OZH1yDRBSKBuK0P4IrU7sHNJD+WlmYzv7/HuQ/LrsRErfSrnS/H558j7rrrz
	fJDkpOibypZYuyqeOkypvmAheDz2bQBwv+pJ0i1rRDAI0zacxZeWSUWIy8l35oAVTuBEslzBWiz
	stRvWIUmuW2XjxOUfkTIJbdXFq7FvtHnfgLENR44W1AoFvqU9pLGa4Tdlg2IVZr3AgkLrbuhdlB
	kL0tV3Ug=
X-Google-Smtp-Source: AGHT+IHbtfuzzLcA2xcM8p05Ap1rPOFlrdSx9BRr3j8cL7IztIjuqPw8h7MzO2V1NueWtCGUqsGoMQ==
X-Received: by 2002:a17:907:2ce4:b0:ac7:3323:cfdc with SMTP id a640c23a62f3a-acb74af286amr415673366b.10.1745044920282;
        Fri, 18 Apr 2025 23:42:00 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6eefcf76sm222642266b.100.2025.04.18.23.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 23:41:59 -0700 (PDT)
Message-ID: <c10c2e0b-3243-4f48-9795-6c31d98f97f4@blackwall.org>
Date: Sat, 19 Apr 2025 09:41:58 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] selftests: net/bridge : add tests for per
 vlan snooping with stp state changes
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev,
 Yong Wang <yongwang@nvidia.com>, Andy Roulin <aroulin@nvidia.com>,
 mlxsw@nvidia.com
References: <cover.1744896433.git.petrm@nvidia.com>
 <cee6216f125ea6c829e22c879b47a47c14db9af7.1744896433.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <cee6216f125ea6c829e22c879b47a47c14db9af7.1744896433.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 16:43, Petr Machata wrote:
> From: Yong Wang <yongwang@nvidia.com>
> 
> Change ALL_TESTS definition to "test-per-line".
> 
> Add the test case of per vlan snooping with port stp state change to
> forwarding and also vlan equivalent case in both bridge_igmp.sh and
> bridge_mld.sh.
> 
> Signed-off-by: Yong Wang <yongwang@nvidia.com>
> Reviewed-by: Andy Roulin <aroulin@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  .../selftests/net/forwarding/bridge_igmp.sh   | 80 +++++++++++++++++-
>  .../selftests/net/forwarding/bridge_mld.sh    | 81 ++++++++++++++++++-
>  tools/testing/selftests/net/forwarding/config |  1 +
>  3 files changed, 154 insertions(+), 8 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

