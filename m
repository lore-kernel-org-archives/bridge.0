Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4669747FB19
	for <bridge@lists.linux.dev>; Wed, 14 Oct 2026 23:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792022194; cv=none; b=RiPLA02dwKCc46Fzuos+pNbLeSgtPd+csMIV3Reymfg8avB6BqIOB2rT0MnYR2X1sDFeoNptw2OoGqN9O0PISfY2LxXFcv/8iiN9VdJMYhWqj6dM4F5J0Os/DdlNxAjl7njGOAbcEw6e8UqO1cib1HyszxXCm3bKOqbroFZxlEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792022194; c=relaxed/simple;
	bh=nLu9+jS/Cn6oFT3DAy2pgKLYerUk78AHPFMk+9gkrY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a2HqA0GZbcPgN1GQOYUR8MloJSswPKKCUuo+q9Qfpj0skB8CzCnrtLEbjwmR68Y4qr5NT0NUNPOaJIiseXb6pugFREHkXYWIhLo91yHGzj3QBlXQ90mSH4af4rh4kVE9NO7fQ1TZrD03udzreJvhKxjXW7qEsSiZbAtOIRlUKn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=Y1ziNk7m; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="Y1ziNk7m"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c350db5a761so619235366b.1
        for <bridge@lists.linux.dev>; Wed, 14 Oct 2026 16:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792022191; x=1792626991; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ujWOXhajkBZtlCmsZmCoVumMM+X/QUn/djLaiVsONPE=;
        b=Y1ziNk7m6JunzWNV0Sg/fGPe5DTgtTbH3jr+TVr4nXcwcSfBor6PVLYbd+Oki+ntlZ
         nplgT97HPnqY5VfcYRx5bDCADUq0ob8Yd3H9T6MAM82g6zgz1BAWhF22+DYJSTRJXG1T
         7DDUQnZ1HrHmeowKHq7odiPJJCbUzl0r93fi30dL/PKzAWIhBgE8YAzCe5oFVMC3yT91
         5E1EcsZDTViDcV3NljBST8Wx8Uj8s5nn2oYHKMkwipFT4qna7ODjzcY9v/LvOey8dMdM
         yEunRf8pRlSsDkf5rU6S8IAPEgCWSSagmJqeq8sU67mAZnSjCdQPvGQlTcgiTCOlNQ4u
         s/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792022191; x=1792626991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ujWOXhajkBZtlCmsZmCoVumMM+X/QUn/djLaiVsONPE=;
        b=pN7+aF5SqHrsgepilXhT2Wa3Bz1cjXp71frdWKF4oypGEEAMTr5ChMKnb1pqqZd6r6
         ctD/TZSB0PjsxKNcMSpbFvSpVpLBCZeAvdIMPzfkG19cARaGCCHAKYGgHVAnqrPuziDH
         0WeeBIJ0Kd1exIo5+t+hS1cZ4zBWtRvU/SXYyBy9brH2eZjUnw+DcxhCTEQ6A7ExsGYB
         BFMt7nsOxXPRK0qIcVI8NgkVwVwjcHNTW/4JIUjWHYND3yAuJAYcQ7VXXqqBSqhIIP8u
         LvXJzrze5fdgRO8sCB7d9XGN5Aff8Pp0LEzrJz6IaYfg6H4uC+NKJmrbl96r8xWLIw7C
         QbWA==
X-Forwarded-Encrypted: i=1; AKwUvByfN/SsF049VrXyRVuaUXJmarA1wyJiCJEFAAUpC8w1mINoxnLPXvRMQWtZR9uyIwUfoU11Pvw=@lists.linux.dev
X-Gm-Message-State: AFq9FYJiiKFy3QciVEYgXZYRoG1Uv53iB/aVHaMPtapWQWAtMG4K8uod
	Hw0caoqAKYV+aPYtbEESzmemsrn8h6btvJaBJLID1VUw+IyANn5bd96IyMweaA6guw==
X-Gm-Gg: AYBFou27OIkKcD7jTNcM6OvZPw+/kdESfCp7xin0UlbHFM5h34B3OWIVnkF9IlkCPRj
	hiifIp84g7mb3EAurMfIpqsxWr+Xzyr86g1fO/FvTqQmJb8tNHCWGlUjJG57+92IXlO1bx3KqwG
	/YVChDASVgnlv4DXG9H73XzXzt0Z4NM/sAN2e3aFdGdaFghlqF2GtmetR/4F/EUAhEGVo1Vw39i
	LkXBN6/E0+XF6AXFJCMGRX6hPCdTyPwNid6NJ2WPyaBf6pQhl++arGX/vPIL+ZG4TKyOdOah5qx
	1tuZZ1bbArduttmUp/PqNKEjtEdwfL2ke8nnbRSOBJsVBOpwcHOsPuCBlsWZ2fgshu4dRaYcS0V
	maYokPzbftAuNypemeiP53PAOHTBTOXU1M7twnpfUJpbW3Hu9DbtyN77ysDev+HzFS+EuEvIo3I
	mzdDSFDThs308dZC80gtjMtO15x2kj3e9tcbBQW0o8Yph/1WVNChPPdWa5qA10nJtDYuQLx9Ge0
	L811pFMd92tUcO31rvw2Z2FGDlM4XHJOrEdvH39V/7tWlfNh7viKXe3qDpyoXdl+uOdAGWNc7s0
	vHfPN6Pbib7T7Z3+Ob512CnlXh3BHoRA5CwhAdJ2MPMcFxJ4GTMESue33GLn8ZlNpwH6IR2YNMJ
	obUqXn1mQAVFfFaKZ6z1tgS1LEp/ffCQ204PI3nO/b1hbZKKdFNKn7YF4v/iLKwb6OPsclpYJ8Z
	5VoWBcGhusdetmEc3SVCkIPAQ=
X-Received: by 2002:a17:907:3d52:b0:c26:1648:a076 with SMTP id a640c23a62f3a-c31aa0e93bdmr1626520966b.49.1792022191008;
        Wed, 14 Oct 2026 16:56:31 -0700 (PDT)
Received: from Desktop (p54affd5a.dip0.t-ipconnect.de. [84.175.253.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3edab12007sm46101666b.82.2026.10.14.16.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 16:56:30 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	kadlec@netfilter.org,
	phil@nwl.cc,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	razor@blackwall.org,
	idosch@nvidia.com,
	ericwouds@gmail.com,
	dqfext@gmail.com,
	netdev@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kselftest@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH nf-next v7 0/2] netfilter: flowtable: tear down bridged flows on layer 2 roaming
Date: Thu, 15 Oct 2026 01:56:25 +0200
Message-ID: <20261014235628.197976-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A flowtable flow that transmits straight to a bridge port keeps sending
to the old port when the host moves to another port, for example a
Wi-Fi station roaming between access points.

Patch 1 makes the gc tear such a flow down, using the bridge fdb lookup
from Pablo's patch. Patch 2 adds selftest cases.

Tested on nf-next a5e7d8e446af in an x86 guest: nft_flowtable.sh passes,
including all seven roaming cases, and ftrace shows no
flow_offload_teardown during 10 s of steady traffic in any of them.
flow_offload grows by 16 bytes (296 to 312 on x86_64).

Changes in v7:
- look up the fdb entry through a bridge hook instead of walking the
  forward path again (from Pablo's patch)
- save the vid of the fdb lookup; the encap stack does not have it for
  untagged ports of a vlan_filtering bridge
- build br_nf_utils.o only with CONFIG_NF_FLOW_TABLE
- selftest: vlan_filtering case

v6: https://lore.kernel.org/netfilter-devel/20261004171605.3544792-1-julius@bairaktaris.de/
Pablo's patch: https://lore.kernel.org/netfilter-devel/20261014210256.1573072-1-pablo@netfilter.org/

Julius Bairaktaris (2):
  netfilter: flowtable: tear down direct xmit flows when the fdb entry
    moves
  selftests: netfilter: nft_flowtable.sh: roam a host between two bridge
    ports

 include/linux/netfilter.h                     |   8 +
 include/net/netfilter/nf_flow_table.h         |   4 +
 net/bridge/Makefile                           |   2 +
 net/bridge/br.c                               |   2 +
 net/bridge/br_nf_utils.c                      |  40 ++++
 net/bridge/br_private.h                       |  13 ++
 net/netfilter/core.c                          |   3 +
 net/netfilter/nf_flow_table_core.c            |  27 +++
 net/netfilter/nf_flow_table_path.c            |   9 +
 .../selftests/net/netfilter/nft_flowtable.sh  | 204 ++++++++++++++++++
 10 files changed, 312 insertions(+)
 create mode 100644 net/bridge/br_nf_utils.c


base-commit: a5e7d8e446af9803e37a3b6a4d416fb41178348f
-- 
2.53.0

