Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE0D80034
	for <bridge@lists.linux.dev>; Tue, 15 Oct 2024 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001297; cv=none; b=fsO587EhD6wpxnkfjYu3ovax5V4OwLV6/uHIyk4yboXZYOqIEG2brQ1Jfo6GD8HKx3na/UkBrONrdDp58orkcA2iu1nVDau+HM7tI6Mgn6MvY07qRq8oaN+MV46kdIrd6EW7XOmM/hZ2IwFwCe3ScKQohK8e+YJWQn7O810fCoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001297; c=relaxed/simple;
	bh=SdRhUPPHFHXC1xpfQuq0g1vtB4NUTL+nVKsz52Zeais=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rn07vENTrNFnvCo1B56n5Gv0TtIhFYGw826nJFIyd90sxCRDolCDVocipof1wc2/QSID8lED6LhAR3OiBsHuzwKsda4zCPU/NIqZI87O8mY/Ppi9dVJha45Mhu2YUIIDHocZa2SDz0AhVf2tgRbp8og6X0N4NxbPo0sHD2gniZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ry2py2Dp; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ry2py2Dp"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20ce5e3b116so18183825ad.1
        for <bridge@lists.linux.dev>; Tue, 15 Oct 2024 07:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729001295; x=1729606095; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=59OjeE70KMfAYYXX4g/s1D5SKLpH3DxcgTnqpspojAE=;
        b=Ry2py2DpVpjzc71FTyEIPtHsm76F2w90lukOmDSoIRS8cMougsaWrrG7n4ff1sdqOS
         +N1OKMcPGQZ4tmnQDTFSSrRoyL2XEypcQwft4DY5iPS4LTLjCt02VNcto4Sdas9gfB8J
         yJfPI8YXdtBHKmgPyVRqJMMiV38IkcVEyYW59eW1XjOstPwTDwDtIHqcjXHbsmusXx2R
         i7iU0fhHuZtZFpEUMQfiGLbnBBIHZKK7nvR35FucP+O0+atkkaMQJioib+XHyf2u8ckQ
         5TCEXhmSo8ymFLFAAJNywiQcxtMrah6xClMcpTJ/1jHI4750Vwq/HK0RqYteo0hG/1qg
         Mw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729001295; x=1729606095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59OjeE70KMfAYYXX4g/s1D5SKLpH3DxcgTnqpspojAE=;
        b=TcGpgQkkFezoEpW6hmKSM3hs3Ecoa5m54Hk79Xvatu/3RfA3hOPGzHIjxSy9LHJfBI
         fkdDItsqoeYyuWaGG1rxLp535FY0DuzYxKQaImk5FLdc1QpmHOlt6hAcPEkvGABF3z3o
         zcF5GgVrlgjF0HdBNnjWN0ILR2rCsfqcuS9apAmfdpsX+z1Tbx/PimllTF/CWbxJ885G
         hVH14m2NserPzFIAGfbp9PQQYC1fKnlkZFGe6dHuM+2llRWNeNiFTsz0wyvIVpDxu0Tn
         NVJBlzx729+GqZibgIY/ZflNx41lIlI+My78Lnnwa71vAtvbl7zH2YRk5AkIlFp5eYHW
         tEHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEM9+vwCu9XcjtRnlLGOPdZ/iu3rj4XgPl7mA9ctZaBDmV4roUSwHrY6Y3DeIh72Shfi70Uew=@lists.linux.dev
X-Gm-Message-State: AOJu0YyPC2X2amEClrSkDlUnqIwE94+psG6vsbcDsIGNKfAlzriAP8Zb
	oCS7yBuO+ra1DcMksEXBQskTxphIYHc5FoT68TpXD6MWpHnPk4tw
X-Google-Smtp-Source: AGHT+IHuZyCLIzTWRvWfCqwBL2LHNbLeK+xm/bpQdNVx7q0gy5JC5xAbFQM6Eh5o+P/Yka4vu8yY8Q==
X-Received: by 2002:a17:902:db0d:b0:20c:637e:b28 with SMTP id d9443c01a7336-20cbb23057bmr167155595ad.39.1729001295219;
        Tue, 15 Oct 2024 07:08:15 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9d419sm12437625ad.93.2024.10.15.07.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:08:14 -0700 (PDT)
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
Subject: [PATCH net-next v3 00/10] net: ip: add drop reasons to input route
Date: Tue, 15 Oct 2024 22:07:50 +0800
Message-Id: <20241015140800.159466-1-dongml2@chinatelecom.cn>
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

In order to make fib_validate_source() return drop reasons, we do some
refactoring to fib_validate_source() and __fib_validate_source(). The
main idea is to combine fib_validate_source() into __fib_validate_source()
and make fib_validate_source() an inline call to __fib_validate_source()
in the 1st patch.

And following new skb drop reasons are added:

  SKB_DROP_REASON_IP_LOCAL_SOURCE
  SKB_DROP_REASON_IP_INVALID_SOURCE
  SKB_DROP_REASON_IP_LOCALNET
  SKB_DROP_REASON_IP_INVALID_DEST

Changes since v2:
- refactor fib_validate_source and __fib_validate_source to make
  fib_validate_source return drop reasons
- add the 9th and 10th patches to make this series cover the input route
  code path

Changes since v1:
- make ip_route_input_noref/ip_route_input_rcu/ip_route_input_slow return
  drop reasons, instead of passing a local variable to their function
  arguments.

Menglong Dong (10):
  net: ip: refactor fib_validate_source/__fib_validate_source
  net: ip: make fib_validate_source() return drop reason
  net: ip: make ip_route_input_mc() return drop reason
  net: ip: make ip_mc_validate_source() return drop reason
  net: ip: make ip_route_input_slow() return drop reasons
  net: ip: make ip_route_input_rcu() return drop reasons
  net: ip: make ip_route_input_noref() return drop reasons
  net: ip: make ip_route_input() return drop reasons
  net: ip: make ip_mkroute_input/__mkroute_input return drop reasons
  net: ip: make ip_route_use_hint() return drop reasons

 include/net/dropreason-core.h   |  26 ++++
 include/net/ip_fib.h            |  18 ++-
 include/net/route.h             |  34 ++---
 net/bridge/br_netfilter_hooks.c |  11 +-
 net/core/lwt_bpf.c              |   1 +
 net/ipv4/fib_frontend.c         |  81 ++++++------
 net/ipv4/icmp.c                 |   1 +
 net/ipv4/ip_fragment.c          |  12 +-
 net/ipv4/ip_input.c             |  20 ++-
 net/ipv4/route.c                | 212 ++++++++++++++++++--------------
 10 files changed, 245 insertions(+), 171 deletions(-)

-- 
2.39.5

