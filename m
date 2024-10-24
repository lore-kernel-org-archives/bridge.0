Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12D41741D4
	for <bridge@lists.linux.dev>; Thu, 24 Oct 2024 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762483; cv=none; b=R4wkkTz+bSVNJ1Stdymtj9M16EfTUDoy8wwAouxSWyh9h8dwnsRa1yHq/ow+aaP4MnhDfiXEJFgThJ+XufnvzK1CVxfumAVjpCVqJyyLdeoEJYyTjJw8feNQzJg5i1jdPGSONvj7pOtPFpRoUoV05brJMErdmvUucScEERgoEow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762483; c=relaxed/simple;
	bh=N8rGFDTUThVhTEHIJIIJx0HReyP83ZUzy0Cx8KDZfW4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cRYzaWbGZQpkU9CMwGf2RM412PvIKWr+ogl1uI/9Q69xSPWlRMow/HBbATwlPR49z+A5MD5n/PcMz7J087Y83YHJsOhTU26bO6vdspM1n8ppnEJELDj151FX6LTF7MH8O3oDTG+xCp4nZyiK/j+HYOQ0q9ZmuXd3SlGuR1/W8Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hj8zGyl/; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hj8zGyl/"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-71e70c32cd7so558386b3a.1
        for <bridge@lists.linux.dev>; Thu, 24 Oct 2024 02:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729762481; x=1730367281; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gq6+xdJlSauKVvYdMuUpgAyl8qNz5z/Asf+huhDS4l8=;
        b=Hj8zGyl/pGy9gnf4UfNDvexzGeVJ+2E4Et3TvKyD1SfOf8c5wrrECkAPYGLkmer1dy
         umheyXDuduHrR5DSYxdlbMWroAtQ4lkuBrUzzCzRFu+NbguMB5WPb5pDGnDL4yVzOMnR
         csep5fUeVKQXwbiwWQLwhafftBOxnnKxmCKmktEUI2aFgGREaeoKn5J9SCXZA3QPaSMn
         Bc4BMeXNTiFeDkWPBasq4kubmsBIGk8llRvmdq8eMa3vqqhFYiiJyAcdr62kQ5aIMLTy
         +aK/OJzsH5+eCImB+3gJH+fjKmAFXq+YUDiiOVdHytss5/yUqcPR02d0O1uwFPFlfvNb
         Hxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729762481; x=1730367281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gq6+xdJlSauKVvYdMuUpgAyl8qNz5z/Asf+huhDS4l8=;
        b=O695o6dbSVcApdMqk9oD5Y7+9QsJSNOVuSg266E4796OYZqdVk18S5rlLczIv70nFV
         C9dXJyG9FVOzLPVN9Lo1yUYMfXvHwpFouww1QA+CdM53jfX66u71K6gTVMzgV6ggLXDV
         JoguigwYlunRBto9sjXdAJTwaFNr6051mqd1TtbYBlVQCFgwn+uyU0Gk/gW4A3oaaqr4
         W55SnMgnssysZkAC3fzhv4ePhlq/F97Adj/dDXPNPtnWsuPgK5GSjJ+Eb+9+wTDMZ3h/
         IJAPv9d1S1iVRiYl1l5KH3hWxRKYgHOzpKnD0mW8cGVg9x+/GjbFp/WZ8WC3psXoa/w/
         uQzA==
X-Forwarded-Encrypted: i=1; AJvYcCXoofTp+Iyuwwoq3/ZspkGSGbnbRBQo9MDmXgCeY6/0s7+2xkSKzIbDlZyd7fQVO4pRDox5pxc=@lists.linux.dev
X-Gm-Message-State: AOJu0YxF8HQ6fCvNbIMtleV5HuvitzOUFTCdYyVddC7/lYp5C8GjCEOq
	DXXAw/PExFhqUIKBMORgZeZL1/AUShj5CiHEFNXTREgcc5OqCmww
X-Google-Smtp-Source: AGHT+IEi9NPaVF8AmWnxXDS59//oyrACNXuZ9nb/Z22FGVjJuu34vBlUIeCF56L0MF4nThbztRGTAw==
X-Received: by 2002:a05:6a00:3d4d:b0:720:2dbf:9f60 with SMTP id d2e1a72fcca58-72045e78ef0mr1482957b3a.16.1729762481077;
        Thu, 24 Oct 2024 02:34:41 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1415071sm7600287b3a.217.2024.10.24.02.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:34:40 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	dsahern@kernel.org,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	gnault@redhat.com,
	bigeasy@linutronix.de,
	idosch@nvidia.com,
	ast@kernel.org,
	dongml2@chinatelecom.cn,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v4 0/9] net: ip: add drop reasons to input route
Date: Thu, 24 Oct 2024 17:33:39 +0800
Message-Id: <20241024093348.353245-1-dongml2@chinatelecom.cn>
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

