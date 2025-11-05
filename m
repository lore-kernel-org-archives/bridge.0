Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E8F2C17A1
	for <bridge@lists.linux.dev>; Wed,  5 Nov 2025 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341612; cv=none; b=BZrVV7YVDRfEIM/R7MAo3CosD+ndMQUXeivBSFLju4gVzwwAEXSlwOWE6elx99TP/AGZUcOtNbOzzstd/p/Y4SXbYl1HSG3hGk5Kwjty9ffCHwK8jzDE9CMJix9skwIuN3t/XGVGDG4aY8sYy4iHtsPDgELSTpVrIZYfmxYHerE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341612; c=relaxed/simple;
	bh=jg9JQhH4jC+1PYtjc2yGbQiHAhtmYm3wKu/Ci02YltM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IBJdXE0BoMMl1cDc1dMvPHzlXdWNxqQ3R4kDI/BYGdQ+UAfMnA6ytT/KzhrNRASxXgTiYk1DWmfsR7KQfCb/Pn8gOmPWVUgv1VklP0lXN7yBl9jtbhiDuGNvbOba+xv3tFSYM3S2Qe3ewZLNQK0kdSZO50cUju+EDVj7EuXzQ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=AqKyCTSK; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="AqKyCTSK"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so1284896966b.0
        for <bridge@lists.linux.dev>; Wed, 05 Nov 2025 03:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1762341609; x=1762946409; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GPx7TEpg2PCWQMCzIdCwjLuxukIo7EnolPdS5y3Rh20=;
        b=AqKyCTSKTIK36E6wbRGnFuMtaWDwf4uHYQgVO36+l3zDqCrfNDyPpMxW3usztFxRq+
         bDmn9Stp0JF7WeULtRHwwutZwNo6vGmIsidSQrHSGPZsyRK4kIL0GCibSwzTRzpskJxy
         XoueD95JY+ptpRuuMOg1vr7QMfT84RTfSWHsnOAO9ZnVrFjVRwde4wR4dHW3qeDYIe3x
         IMJIQeFXHqv5pxrgaPwEBdFXJWkkmOcNG1lL0MNt4bdg0NFt9/ma7CTGsvQ7XEBW74Lo
         nBdTjCNEJgDlLzJz0rRFv/rIPk5wnDqA5lB62SEWCs6MUdfi9lC3uI1I8I/2tqlXsrRa
         fB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762341609; x=1762946409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPx7TEpg2PCWQMCzIdCwjLuxukIo7EnolPdS5y3Rh20=;
        b=lY2lhnyHThVVV7Z/AqUgVi2GN7kgfbp3U+1oO1ZeNooEy0PHdRL9xSMScDMga7amqD
         oS6BUOP1ZdFV6ITPnBLYENsPtDExKq+PCEpd7O2VvvwUx3FR+78kudfP1Z7IeFpgGdzU
         Sa8AMfnCUTvTis1NZBN02m9iuklgkXnSTQwiJI4O9Iu1I/1I/Fiu5hMajPv+mSEz1fFp
         6aVetEBTaDMnW2AnKMH3eNSFXMmBwnmXUrtUmR9yWEAYAEDI+hMWWDECNpN0LJUbv5lX
         +G/SX6tFhPKw1HLJNlHKpRA3CgVuTa105/nP7P7kODovHCOwqRL9N9c+02DYwGVOiR9J
         M30Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfWh+kY44UhVu45DVjASrLQCx8sd15DRVczy6V7DYpESyB0u4sgYkc7MdJFGdZtOZ5i3soVxk=@lists.linux.dev
X-Gm-Message-State: AOJu0YyxPsQsulJUhhpfrb5+AKWILu8Cc8ZN3iy7QyNeB6ypnSrfq/hz
	NfVRIeKcRj4vpFBVFkHIauqNiMCJarqKGeBXvFxZ5leDBw0QVrBIOYNQSGobaRoS+8Q=
X-Gm-Gg: ASbGnculydNc3jya6TUs0ET4vdODgmfvJtAiaXdx/T4XOXk/QJUSILigVH0nA/Mk3cx
	thTvyuQRP308+P6K2XTletGT+e59lxOr1sxK302HohS+6w/fhn2s8++mjSryWMyswN54qEPJ6XN
	RrsB0XRKPiCf1TwMtff1GptiUYzUIaUNXB2VdxgVR8ZPMIyQElrZdds4LFtVfGgxNd2hmUJyVrV
	Xt/tJPy+INajZpfD5IPMjUshH0zNIvQD7uLqQeOY5Xpqv0oonq+f293MzodqERM2sbtkQPn31IQ
	TSZB9QrPhkO2tv3uuPm5E/HU27MHdjTF+H9R9aGZKyXeBw1xyTPMg4Z/cKHTK+/cCnv4OWbOd+B
	FpMgvvX3IMh/9GkOEhNlDQIKb3/MrM+ZQnGgUNuU6uX5G67OlLhc4JG8jObTHx0mSbfiZOzMjcT
	bFOTBNLJ2rQyoKtOlXlF3Ig0432ltu2wl2ng==
X-Google-Smtp-Source: AGHT+IGRLAPN+U8MsOi98eMXNR9poCLGHE6zHV2WLUCBS2zrBTES/2GZ6P1qjmj02rFfUreHnCGQAQ==
X-Received: by 2002:a17:907:3f22:b0:b6d:2773:3dcb with SMTP id a640c23a62f3a-b7265296c93mr276688266b.14.1762341609321;
        Wed, 05 Nov 2025 03:20:09 -0800 (PST)
Received: from debil.nvidia.com (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b724064d25csm455208266b.72.2025.11.05.03.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 03:20:08 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: tobias@waldekranz.com,
	idosch@nvidia.com,
	kuba@kernel.org,
	davem@davemloft.net,
	bridge@lists.linux.dev,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	petrm@nvidia.com,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net v2 0/2] net: bridge: fix two MST bugs
Date: Wed,  5 Nov 2025 13:19:17 +0200
Message-ID: <20251105111919.1499702-1-razor@blackwall.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
Patch 01 fixes a race condition that exists between expired fdb deletion
and port deletion when MST is enabled. Learning can happen after the
port's state has been changed to disabled which could lead to that
port's memory being used after it's been freed. The issue was reported
by syzbot, more information in patch 01. Patch 02 fixes an issue with
MST's static key which Ido spotted, we can have multiple bridges with MST
and a single bridge can erroneously disable it for all.

v2: dropped the selftest as it is useless with the new fix
    patch 01 - new fix approach relying on port's vlan group
    patch 02 - new patch fixing an issue with MST's static key

Thanks,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: fix use-after-free due to MST port state bypass
  net: bridge: fix MST static key usage

 net/bridge/br_forward.c |  2 +-
 net/bridge/br_if.c      |  1 +
 net/bridge/br_input.c   |  4 ++--
 net/bridge/br_mst.c     | 10 ++++++++--
 net/bridge/br_private.h | 13 ++++++++++---
 5 files changed, 22 insertions(+), 8 deletions(-)

-- 
2.51.0

