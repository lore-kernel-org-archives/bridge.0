Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039E41CFBC
	for <bridge@lists.linux.dev>; Wed, 30 Oct 2024 01:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252577; cv=none; b=JaVe7xAt6vUZj6Pczj1pRD3VlfrQpbNkrew8JmnykB9+dYzZLRjmUG2fCu4FlxSir1NPe0+6vOnkrBqrKFT9gwJjYPd4/CVOoSZhStgdcWdgRccJ04nObF9iXSEPqPquNjgld+NwfSGBRBCWvJgz7Y84hy94SoAf2iY3bHYVG2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252577; c=relaxed/simple;
	bh=N8rGFDTUThVhTEHIJIIJx0HReyP83ZUzy0Cx8KDZfW4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sA1gTeMlKbUZroDoGkKH5bLJCwi9jWbHDvvTlIfw8jztVd13u+iH8yw9WW5J4SFziMC5seZ0BhSLHmsMFfluB7vGZBvDO7Hzt+hozJYEOArbqDMqaJfJvYGFuiI0vqV204Pe4SKODGrUqDcWRbi5lYpgYCguyc+q6DIgHuUQvjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GU+LgS7i; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GU+LgS7i"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7183a3f3beaso3016316a34.1
        for <bridge@lists.linux.dev>; Tue, 29 Oct 2024 18:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730252575; x=1730857375; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gq6+xdJlSauKVvYdMuUpgAyl8qNz5z/Asf+huhDS4l8=;
        b=GU+LgS7iMhMePCiBLGf/uH3olZYV40pDnPE4OMucgSXijdPOcZF+2dN0bsGxAat8Y8
         7u5rGXqH9Nkzi+w8UgoYDu7NboVTcB9XS5+OtDZmM5NEhdvPTMzEaMsMZQhgbkrXyDW1
         LqhIwcHLg56MVUdU2c7skoj6eZ+SoUjr8XFj3wza0uDTxjSgKrzwcqdcwMhRSE4NP+Tx
         NXHwT+C9K2v1XFvwfHghwKEwhu6Qx6Ya3EjQc1vIOL+T9IGx5WcmqYw742Gc1oCqLLs5
         dWcFCKg74j1Oc5x17C4Z2ilxbBjecBTrxTTIrUz7wS7mB6nb1TEQsVNUTysqddrjzIkU
         v+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730252575; x=1730857375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gq6+xdJlSauKVvYdMuUpgAyl8qNz5z/Asf+huhDS4l8=;
        b=f2oWTEq/t00+E8FQKCtDCbXtCz6i3NGtgDdCHjPt25BLTIK1siBSZWY6l4XMEsZEWp
         S+cSVS1ih5MftHEGxGUnW0n7iiBPqbXQmd4fvwx65YXDGnpKFNcF9XToyUITfaB084pb
         W/fJGkQ36Dll66+9SAecoWJilhkMnmIFw8XUQw4oZkIXywSUbTqN0nY78uR7FHozWY8x
         GfsMiZWe5JCBmD7ELuWJ0+v6xtPg3mSrcIXmTtnd5Kp6AU9ihtrZ/7h59qB9AN767hLA
         Z1bLcAOj0BT3JV660N6WTCVr1QGQSVLxdiH69Bw2lA7jYtwBmkCzB8LsR3Zou5TfNJYd
         YbMg==
X-Forwarded-Encrypted: i=1; AJvYcCXJZz+X+61Sy18tE7Jl2Xr5npUAFAmsDKDJjgEWthhRZJdz/wv6rzCZw4kt+IPIUcaOCDx6QlQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+MoHu0rFtn8MCVi6js1fzl/msM0cWDSccDiqJ6bctuAge/fXw
	vY9ZXZRMhq005uVZ25/NqMNRXsWzGs6QwKplA6+9FGHNEYyDt251
X-Google-Smtp-Source: AGHT+IGLH/hZZ7hWGWLxPfmagO461IIMSWoSWP+WCb8WxZ7ERpymRfaGRQY/xzyfibXkMEpby78vsA==
X-Received: by 2002:a05:6870:e0ca:b0:278:c6bf:fd34 with SMTP id 586e51a60fabf-29051bdaef8mr12039957fac.27.1730252574765;
        Tue, 29 Oct 2024 18:42:54 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc866906dsm8138407a12.10.2024.10.29.18.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 18:42:54 -0700 (PDT)
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
Subject: [PATCH RESEND net-next v4 0/9] net: ip: add drop reasons to input route
Date: Wed, 30 Oct 2024 09:41:36 +0800
Message-Id: <20241030014145.1409628-1-dongml2@chinatelecom.cn>
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
 include/net/route.h             |  34 +++---
 net/bridge/br_netfilter_hooks.c |  11 +-
 net/core/lwt_bpf.c              |   6 +-
 net/ipv4/fib_frontend.c         |  17 ++-
 net/ipv4/icmp.c                 |   2 +-
 net/ipv4/ip_fragment.c          |  12 +-
 net/ipv4/ip_input.c             |  20 ++-
 net/ipv4/ip_options.c           |   2 +-
 net/ipv4/route.c                | 210 +++++++++++++++++++-------------
 net/ipv6/seg6_local.c           |  14 +--
 12 files changed, 226 insertions(+), 140 deletions(-)

-- 
2.39.5

