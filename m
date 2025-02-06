Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0FB1C701B
	for <bridge@lists.linux.dev>; Thu,  6 Feb 2025 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851740; cv=none; b=Sbvp2szneyoRq9D3uWI/zW6QzOh61JjeaNJ5R9r9ZypKk2r0DK7owxa+n4V2U8V0cdKMt/415qFo0azxzlSMRDOPJ699sGiGwC5IvMffyeZ6xg4dImAgi/M7DUShzDcKtGP47RBfhco/hJI9UtWYaTLYY8Sc4VBoP52QlNzGoF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851740; c=relaxed/simple;
	bh=bi07utj+cl2ojuyIDCD/sVJyWBo4xWIZEqhSrnnju3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IkcPQLwkqOVBm6EbZkzANvRe5nXIuaochCHjtzp+4jugW712nBrP7N5zpiPB8+VlsB6As6H7PWSnDmpRwT9XMI1rvMQj5TgkCFjXKzUls79tBWjqno6+usy6g+XuSQXuoP6boNTzJIaPl/YZ7qF9nB/5QEK2TkuAUcgE9EJFfyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=osqYktnA; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="osqYktnA"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab74ecfdae4so143941666b.2
        for <bridge@lists.linux.dev>; Thu, 06 Feb 2025 06:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738851736; x=1739456536; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qy52E7wooPVVAtEuLO+Qhyc2iLHEhNjVLiIzlhHyrWs=;
        b=osqYktnApVhRuyaWC2VYJD9HamQw93c2iKSGc3+G4VUeOOf3zZifBLqI/Sj5/ItzTA
         PFqqyQI37Z0plysrUysPCg7JY7eMLuOG2u5UvfzrgZWfq+mK9Zz5Bbso4U4r8xenXBkf
         DHFTtbfg+sdcchtk02vL7xFgX2eVKgWH64lj6HPubT48ThR72g2L9aRrGMWLqS9p2/1+
         9AqJ7C5DDA9clAYy/rYRToaZbjEgX3mTQuH1tKu9iejsx5T6awijAxzmw2UoeicycSgr
         byMOqjg+Ej1PscfqwJaCqpUL/wHEO3E1oBxzz07zGiDPtKrHjDGGHeGyAS3CIrP4mceD
         Fjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738851736; x=1739456536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qy52E7wooPVVAtEuLO+Qhyc2iLHEhNjVLiIzlhHyrWs=;
        b=FoHHgrWRX4f/ST6o0d3BiaherjJAoPf4+K8ms2CX0Hz/5xAhjNwKrihBcZvlSPn+ea
         mHA5ZDi2I3wCqCS97OTBCMYk7yzTmoVAp42e/cVlSQrlZqo3Y8knE1mJgbwEpAcWRQZQ
         SgRNgdTVzfkAuw+NvGU1TvjgZa1Tb1mXD4ysbDrYYAlWAD2Aedhkoek2tlCk9vuH6Neo
         To66Thsg6zFBeaz/ftU4eNqnNnIhn6kh12bRN95bJIBb4skvsUICeAQKfma3uaKlTQ8g
         j3XCCd17GCfWaNQdlNCfUA6kbb7YEuhVBnFiNbQyWzSJIHBotNMAxvXIlB37kSMbP/kJ
         UIYA==
X-Forwarded-Encrypted: i=1; AJvYcCVPgjbrL/zNgK+ijAwzOP5GSjnCCz8RyRHefgwfWn2AsbCFL3stImmF2ZiLAy+8KT2NMHG3KQQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YyVwYXOPAc7/qMhTnlo8dqRouvc8B7a2VVNnmbjckLlN/+Ymge/
	uRy0JEe1glWzNVGWbAFgJgxurGnryDmKEkDl2lxw0cIH8JQNY0EA/ZyEr6H20kQ=
X-Gm-Gg: ASbGnctq2NfG3c0wIXXMZCOJ8TwoKTW4hR0DV0ldXvbiQ3AmVPknWuUruB37kHyUIOS
	fUh+mIjXMxb0zUHC7ypoKW+YvzHsSPPg7w57xaHQVtx2ULADprJQ9CIQ1g8SwquPW5dbtWoGAf8
	4SvDMzcVvaqzUHbcIzZoxnN12KGP9ppC564zZt8D+L/OKYQ6ylRcv8OzGDipAvMK5YKfL3lLE6Z
	Fk4R7NOsMcQb1V+TNBNc+V2MGB1oM1qX1Ja7zGP/0Cxo+U7eY4qmqCjOa0ia2hc6eAw4NHMqIyg
	r+yGdgcjHh/rB7QMuO5Nq8o4kBDzB/tDGkeCiEPrTHhT1/A=
X-Google-Smtp-Source: AGHT+IG6aiDjgy1nFvIKHnHHwV2g9kBo0v+xziTDZFU9m8b3NS4nlzYz1Qp3ZZ0dcQwrhEvWNvqV8Q==
X-Received: by 2002:a17:907:7249:b0:ab6:36fd:1c8f with SMTP id a640c23a62f3a-ab75e2f655emr719799466b.39.1738851735691;
        Thu, 06 Feb 2025 06:22:15 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab77f5f5a0esm40785966b.155.2025.02.06.06.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:22:15 -0800 (PST)
Message-ID: <cc8b741a-72a4-4059-bbcd-3f32c7ef56d0@blackwall.org>
Date: Thu, 6 Feb 2025 16:22:13 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 13/14] bridge: Introduce
 DEV_PATH_BR_VLAN_KEEP_HW for bridge-fastpath
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
 <20250204194921.46692-14-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204194921.46692-14-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 21:49, Eric Woudstra wrote:
> This patch introduces DEV_PATH_BR_VLAN_KEEP_HW. It is needed in the
> bridge fastpath for switchdevs supporting SWITCHDEV_OBJ_ID_PORT_VLAN.
> 
> It is similar to DEV_PATH_BR_VLAN_TAG, with the correcponding bit in
> ingress_vlans set.
> 
> In the forward fastpath it is not needed.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  include/linux/netdevice.h        |  1 +
>  net/bridge/br_device.c           |  4 ++++
>  net/bridge/br_vlan.c             | 18 +++++++++++-------
>  net/netfilter/nft_flow_offload.c |  3 +++
>  4 files changed, 19 insertions(+), 7 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

