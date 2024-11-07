Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EA820FABE
	for <bridge@lists.linux.dev>; Thu,  7 Nov 2024 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984199; cv=none; b=hUnky1SHSPMQIZaZgJSJHDoh1mucpR1BwjO2kxIXCJ9NDkZ6+zzkRKW2OgB/1sU/9MTw2YOaVUmp/+LUqBRFMcA/r1N5lXAVQI2Dv5sHEPzT3Jky3ILTV42eQ6A1B1dj8RJgcISBFlnGSZJKEixehsbUmBx8NIoUXWujhdrLymg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984199; c=relaxed/simple;
	bh=90LuHD8laAu8s+2lzOXwrI1PNKvtP9Qf1hO/C06hHiA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BjBzHRWWDTYg4SC3WZAmDWvvC+NvWrgXzHy+zYHrIr+q5sdiZAyru0I868qrHMaTZUK9J8HLOajHnas1KEW4lswxcmw1xFNXmB6y2bSDpSN7f0SCpHcCw3UnM3D+2+/2QdHWhF1sXXBt98BEbEe23Qh2n6vp3i7a8dQJeo+ccuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fov0FjtR; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fov0FjtR"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-72041ff06a0so710037b3a.2
        for <bridge@lists.linux.dev>; Thu, 07 Nov 2024 04:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730984197; x=1731588997; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UdA7nsCFTrN7tSAJGLMrxfIWlfUIz0l1LxRNiQDm5GY=;
        b=Fov0FjtRFI8PyGfgzPDbaqL7+te7Y+arLEBTgMc6rqGAiqTg/Ks4hdQnAknI0t+PY+
         oRYLuY8iryodW0A5qmIQyig3O53F+WGvXcuPuz5/2oTqpZhF+HeDiZpI3QolRk4Maa3/
         /4gdeykj+l0mc1LflX078VpMPAIJkxeSM90B2ip1yNXaQVBdQfWB0B9Lfu0l19KDo/P7
         h37y98dBZTHtT5UhBf7xXsTZk1vmwp5exC7EIbYrU3ZsYTy/f8iU75c+Qb2oxkciLksq
         VlJKFH+tTPFSelGz87/LPmLUljLaaEZUA1sg2dJqGIW78PY8K8yHMuGlC91Hh0QjPJfV
         LQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730984197; x=1731588997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdA7nsCFTrN7tSAJGLMrxfIWlfUIz0l1LxRNiQDm5GY=;
        b=Kf6QljILy8njet3LBl8tifkx769DTZJ/HTa5UWTAlPIs99VXhBAK/CTHc3lebPsQOM
         Hge2NJPiCNHbeobHlWT0cizCFXnhLBNA8VisJGL9UodX1EEUnEUdgKhzxdXVaQsu6wcN
         GWjWGZBuIJzbQoqVEhDvYEMVGhwoyDLEMOGSWQzOYbiXYuNLZZWtlZEtdVxO570C3dmw
         /Ys57eMs9TnM6bavV6oNvH2sTw8Es7TPVbVD+dgZfnx5LZ3B/QjwfEVhW/MGovPr7+Cx
         LG25NuLBY8GtVS5G6S8IViJHnRlF7DmnwjCp3OaEMp2j+EQ/9p52xrBqw5jAleEl46F+
         hTMg==
X-Forwarded-Encrypted: i=1; AJvYcCXAh0ihpieIeZjLiDubKG6TzCLJ2Tk+B66CH2NwOAxCQ5iuMANRx1vI9C6u7XHctWeag0tENGA=@lists.linux.dev
X-Gm-Message-State: AOJu0YzZt58YF0EMDpnUpQKB61IFpGIM7xxwdeViVSk/Tt0xgFNJJBIY
	5rSthb6g6MkLtC54pj8epJra7NzrbTZdi5nafDErYNaFidSFoX4a
X-Google-Smtp-Source: AGHT+IEzr1IifU6MMH+fx8wH4FyqoykSy74KB4WKiRH4KzZnH1+yiCSFlPrFXP4KUGKs3piToboQvA==
X-Received: by 2002:a05:6a00:987:b0:71e:6ed:9108 with SMTP id d2e1a72fcca58-720c9883499mr30639483b3a.2.1730984196934;
        Thu, 07 Nov 2024 04:56:36 -0800 (PST)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffeesm1441651b3a.3.2024.11.07.04.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:56:36 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	dsahern@kernel.org,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	gnault@redhat.com,
	bigeasy@linutronix.de,
	hawk@kernel.org,
	idosch@nvidia.com,
	dongml2@chinatelecom.cn,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v5 0/9] net: ip: add drop reasons to input route
Date: Thu,  7 Nov 2024 20:55:52 +0800
Message-Id: <20241107125601.1076814-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this series, we mainly add some skb drop reasons to the input path of
ip routing, and we make the following functions return drop reasons:

  fib_validate_source()
  ip_route_input_mc()
  ip_mc_validate_source()
  ip_route_input_slow()
  ip_route_input_rcu()
  ip_route_input_noref()
  ip_route_input()
  ip_mkroute_input()
  __mkroute_input()
  ip_route_use_hint()

And following new skb drop reasons are added:

  SKB_DROP_REASON_IP_LOCAL_SOURCE
  SKB_DROP_REASON_IP_INVALID_SOURCE
  SKB_DROP_REASON_IP_LOCALNET
  SKB_DROP_REASON_IP_INVALID_DEST

Changes since v4:
- in the 6th patch: remove the unneeded "else" in ip_expire()
- in the 8th patch: delete the unneeded comment in __mkroute_input()
- in the 9th patch: replace "return 0" with "return SKB_NOT_DROPPED_YET"
  in ip_route_use_hint()

Changes since v3:
- don't refactor fib_validate_source/__fib_validate_source, and introduce
  a wrapper for fib_validate_source() instead in the 1st patch.
- some small adjustment in the 4-7 patches

Changes since v2:
- refactor fib_validate_source and __fib_validate_source to make
  fib_validate_source return drop reasons
- add the 9th and 10th patches to make this series cover the input route
  code path

Changes since v1:
- make ip_route_input_noref/ip_route_input_rcu/ip_route_input_slow return
  drop reasons, instead of passing a local variable to their function
  arguments.

Menglong Dong (9):
  net: ip: make fib_validate_source() support drop reasons
  net: ip: make ip_route_input_mc() return drop reason
  net: ip: make ip_mc_validate_source() return drop reason
  net: ip: make ip_route_input_slow() return drop reasons
  net: ip: make ip_route_input_rcu() return drop reasons
  net: ip: make ip_route_input_noref() return drop reasons
  net: ip: make ip_route_input() return drop reasons
  net: ip: make ip_mkroute_input/__mkroute_input return drop reasons
  net: ip: make ip_route_use_hint() return drop reasons

 include/net/dropreason-core.h   |  26 ++++
 include/net/ip_fib.h            |  12 ++
 include/net/route.h             |  34 ++---
 net/bridge/br_netfilter_hooks.c |  11 +-
 net/core/lwt_bpf.c              |   6 +-
 net/ipv4/fib_frontend.c         |  17 ++-
 net/ipv4/icmp.c                 |   2 +-
 net/ipv4/ip_fragment.c          |  11 +-
 net/ipv4/ip_input.c             |  20 ++-
 net/ipv4/ip_options.c           |   2 +-
 net/ipv4/route.c                | 211 ++++++++++++++++++--------------
 net/ipv6/seg6_local.c           |  14 +--
 12 files changed, 225 insertions(+), 141 deletions(-)

-- 
2.39.5

