Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C2414658D
	for <bridge@lists.linux.dev>; Wed,  5 Mar 2025 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162825; cv=none; b=DnwV4HBvIwmjEFBo4lPXduoV+N4mc6XKbnvFBnx98wKly6a7r3LZ6Ic9who1Ib9KbkZKqLIM5h9yLUr/WxyOYrrBzbLImC5rmeAJIf49GAYRHLrj0j1H/782hFxMXOdkfNju1NfV41ZTjLVOjzkrwmDbiP9zrOE+Z0fw+rUBDa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162825; c=relaxed/simple;
	bh=RWpWc+faJ0YZsTPx4jkXwG1vJYFHTnCeCj6HQ2ZWZ8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SiVO7ONyc+vniUsl668B534jSRB1+Ul385S0NgsBvdJMIiJoXObW40ONaK6E2ap7rIkpj7fycKzsCZXrGaYsvwM7O/pV1ehR2hWaK2fsy/xZZbOqgoS0Vz6BactflOjJGrOGOytvcIYzYoILFlWU15UxsisO7i3WjsBi1F07dco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=RK2Myo5F; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="RK2Myo5F"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e539ea490dso4490336a12.0
        for <bridge@lists.linux.dev>; Wed, 05 Mar 2025 00:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1741162821; x=1741767621; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZ9TMmWBCnKwhuUOANBJp50uacRGJFZ/d6Ba0SS8K6o=;
        b=RK2Myo5Fxv8w6C+4+oOC2Y51KQME3+Ev2RR1/FG+i5AmwMu8bjAjgnrnYBqbVP4wIr
         CEXX5gV2h1RghEVUcqQvJGicIRy0clBAZx4eHx1rir4B4PNAOkVA+XqYUXqi8qF8XYrE
         1d12N+3Ab9qVsHiOG4ke7r/ZLYnv8C6sejMjzjQTNCzrQAa1xGPYkPuI+iTIOtI96rv5
         1iNP43D2BvNQ9cnC+oa5XXa4MDtQNF/cTrOgT89pFt0TYosJ+/Vkdgc6aD+c9Fg12JFD
         19qvrte43gCnSV5R5UL2riuZqn3RblJ01HJXyMCjTQi2qgJ2fdA7LCJIQSpOFqmBvPD+
         OkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741162821; x=1741767621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZ9TMmWBCnKwhuUOANBJp50uacRGJFZ/d6Ba0SS8K6o=;
        b=JQc63b9jkCJUPILSl8hJ93quGzcGEMNb+kwUGffoiiaYe2WN8kDYvyF08dkSuxwqSs
         XJp1YfmPHt2uxW7lxCQeGfM3uUDIulrCycpeo8RCZzQep2U4OFDK3A8eBTbNFkKPxs+W
         0mgFV4yXOlnSWdSC2mdhXU/t0VR+ZFZy/0SqpMKdo2KerIIXPMNhkqWdxE76HdkZEiDr
         NzzwmQPXMGCg9RRMVFBI9CLYlJnk76QNCNXod+EYBw9svcrNOs68jRUOcOnoBwCDw23k
         QTnCLBlIF2VqSMoc+d7IgiBSTsBK7aVoz64olugQY1Pu04oGkQQ6gze26+1nIHU7qOva
         V2tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUeB3LQxUkTjruCdPvqFiI9IV/TmYGLnGWs7rJ4l/ouxvNWly6ApV9OMSBOLw1pVSueh07CtQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YzB0OCLnIGngIIun2JamcSHtNyBgl8DmeQQ29hgRJKNd3M/VsC1
	ASMOfy2xKorzx3CsPQm7bV/0rh/Qo/bZNiDYM1ka437w5c5W69E3OFVobocgj7c=
X-Gm-Gg: ASbGncsAIxshXgItAI9jbQjxTZ4zqOWXywrCRgmamwt5mdy8t23BvMY+bu48lQG2ZoJ
	pqNqDL5+bcoJ8WI/VRwnDRBkl3LcS9KCLzsuT1dxxi1bHoEEaTS1hi+NA+PzTvmRk5NNu0WiAR1
	OHkctgSbmOTgYa61OOiAaD1o+ojI61Zc4t9xTU3J7vBdKI4OJZp60uaMLDQzc4+g+o8hghGIjYs
	EmSk55N1SKU8/WxhjF/UPLrmLE4+qsMfQthONEjhIuGVm2qAn1pQ3a+Eqq755dTEPABgmrEQ9Vc
	8GhXdEYrxm6/MydjZtVCo13t0H2yzXy9Je1mkDWWJqR14365UNctLvE0qa/n5aT7oCvqq47Br9K
	S
X-Google-Smtp-Source: AGHT+IG3uX4osOFdkeIE8BVoOkaHQ2eM06ismAlJEsM6OrJRVb5spjiMCAH7SqlSZ6VKBFc01zjVCQ==
X-Received: by 2002:a05:6402:2714:b0:5dc:6e27:e6e8 with SMTP id 4fb4d7f45d1cf-5e59f47ced8mr4078134a12.24.1741162821234;
        Wed, 05 Mar 2025 00:20:21 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf3f3bbfb3sm845989066b.77.2025.03.05.00.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 00:20:20 -0800 (PST)
Message-ID: <2690fc33-0646-4aff-aacf-2760706139e1@blackwall.org>
Date: Wed, 5 Mar 2025 10:20:18 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 04/15] netfilter: bridge: Add conntrack double
 vlan and pppoe
To: Eric Woudstra <ericwouds@gmail.com>,
 Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20250228201533.23836-1-ericwouds@gmail.com>
 <20250228201533.23836-5-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250228201533.23836-5-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 22:15, Eric Woudstra wrote:
> This adds the capability to conntrack 802.1ad, QinQ, PPPoE and PPPoE-in-Q
> packets that are passing a bridge.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/bridge/netfilter/nf_conntrack_bridge.c | 83 ++++++++++++++++++----
>  1 file changed, 71 insertions(+), 12 deletions(-)
>

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

