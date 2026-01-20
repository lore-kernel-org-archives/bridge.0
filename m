Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EAE3D1CC1
	for <bridge@lists.linux.dev>; Tue, 20 Jan 2026 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900962; cv=none; b=DNkyP9DcFnVlWdtweQ9cAjl65N+pVobSNRK2Jr/zOKvdcdIjkI8gXIfi6IcP0Z7g7Q5ZODMarHB9VmEKljSir0PzBa0yNgBeyWaAMcQhcMFScNJ1ZpSCH2qFXf+SGXQDqndV06+3+PsCP5zE4gOMqg7DYrWtpzkmoLCgmkIhxd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900962; c=relaxed/simple;
	bh=lD+mKH/VoL7U+Xn8rlClapNXVv2BkfA7db4D0sWd64Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MaVsOnuuz4Xr8mshsU5N+kVScM77N7ZJmtBKBTjdyMQi7TcaT0VuEGSkoqN4/2PaYAyskcO8P1qdFyz2tpjPqVwzAXi6z+eSkXdCv+Mrmd7TPgtU/z35pbG3ufKtdbseSbvtTlclqTcnGD3Gdj1JPjBEagepEyu9XZnUuJ64ZLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjFiI/Xy; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjFiI/Xy"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0a95200e8so33292235ad.0
        for <bridge@lists.linux.dev>; Tue, 20 Jan 2026 01:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768900960; x=1769505760; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bWSMDHHZmGWMxvi8CWFXwngeoN3yjP8cY0r0efHq7Mg=;
        b=KjFiI/XyO25Yq/jDc8EBdQrb8VcefAUQtQ2Zp7xTsFl8KRtQmC8cx7CDEIL5LEbv5t
         AiX+1wqVxR8dfSTjqhth0D8G5BJJ1w+XWpd2mvj7rQRaNOz7eD9k6COlNKmw+VvwvaMB
         nh+ZFDVpggp21K4Wy0NdxCRMhAxLHbN6u1FLy8IZSIY88v2R77fpUW4bDbMwIq+xDEIx
         Tqd+53sGcRSYK6/z3DOnOrLAJ02XH/bdrTalDX5LFdQsWB15RfGQBvA3Wz5vWzF+8tjm
         eZ5mTnFnJISMbTwQORfuoI4E5WOKvymyUUKwx4+D3fO5pLrgma0/S5v+A+S2qDuYcv9C
         WS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768900960; x=1769505760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWSMDHHZmGWMxvi8CWFXwngeoN3yjP8cY0r0efHq7Mg=;
        b=bxM6Dzm9VWjcX+4P3mnhCj7np7c6lX73lOVEJQr7VOnG3upHFzBj2TRnsSpeYEJEri
         kG4xwMb6xuGmnIZiPhLKpR/Fgeyy8xqgC7iphtEYcOlxtN4sSbMCS0rUXHlMPd0Ho1uA
         tf6yym5UWkzmikW/yqKL/ofzqvEr23edHhEphuT1llmSk6HRVWdNXCtUW0K29Ug95/GK
         8I61G0mQ6t5zGZaKFopjdi1VsvIG1Qf62GHm2mWvMXuy57Lyozcy988KRvsiYFyKx0TL
         9BWckjiBSKT/UxNUAAl4RZUvlc1kM0Q+2Do2rmw/1qldNyrB54eHS2TRtujYggSnK6Pp
         V9OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSM75aj5NvCbvI9T74BEtSs/NxW4BTWGPBQsAatM+z/KhfjCbOGgF7FV3zkHpc44/lmrobA14=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+c2jDgJRGTZnXBFibMfp4ZGvRqRyME05NpoEFqbieXszcAWqc
	j+Hiw+FscP2/P2upwNSguugWD4npUp2Gxfk0qLUD+JfhOPGfOuU5E0Ql
X-Gm-Gg: AZuq6aKBZ/iaRVR5amQEh1WdUoc3IK8J925YFPRxyfoC/wcrQLjvoF6dy/QJztRW+j5
	B6rlkNtomT2jRriZ9xKNOITN6JBvnDQVJZjOWmveTeoxX/Zxl2LeOUn1oVW6Jum0MrYpjCVwh5h
	njwqVcPhavUl+t2SnzybqRjhPW+DxnIdkVo5dr0sZJ8A/P/FDKwn5G00wMC+KM0ftbAB+4yW3NK
	5uIVU9wzJxUVW28IVbVjtBmIkEOmibbiyDV/dtYtU0V3RuqijvA/Bhfcd8Wt4WYSqATTCwj3tdj
	o7oPluMlCxjdgl9h4N43qcCKfcU1kz919NqPqC3QEDUvzCRCkP/NmGZyIavN6cN2hfZEsrLuRyo
	vItn8LvSaMSRv9+mjIA+Qi+72eUzD33mYEn4G3Nsbz3ffZI0PHbAKdvGnWn8vcmvQUa4F+1q560
	bbOGYvxwroqvJAsfxTzmtpXYPUcjrcUmOG02m4rhnQ5P9gAiblgQhfcQ==
X-Received: by 2002:a17:902:ecc6:b0:2a0:afeb:fbbb with SMTP id d9443c01a7336-2a768b7a743mr10676105ad.1.1768900960214;
        Tue, 20 Jan 2026 01:22:40 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a719412d38sm107330435ad.87.2026.01.20.01.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:22:39 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Carolina Jubran <cjubran@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Shigeru Yoshida <syoshida@redhat.com>,
	linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev
Subject: [PATCH net-next 0/4] u64_stats: Introduce u64_stats_copy()
Date: Tue, 20 Jan 2026 17:21:28 +0800
Message-ID: <20260120092137.2161162-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing. memcpy() should not be considered atomic
against u64 values. Use u64_stats_copy() instead.

David Yang (4):
  u64_stats: Introduce u64_stats_copy()
  net: bridge: mcast: fix memcpy with u64_stats
  macsec: fix memcpy with u64_stats
  vxlan: vnifilter: fix memcpy with u64_stats

 drivers/net/macsec.c                |  6 +++---
 drivers/net/vxlan/vxlan_vnifilter.c |  2 +-
 include/linux/u64_stats_sync.h      | 15 +++++++++++++++
 net/bridge/br_multicast.c           |  2 +-
 4 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.51.0

