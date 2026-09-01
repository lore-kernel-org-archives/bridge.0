Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6205039446B
	for <bridge@lists.linux.dev>; Tue,  1 Sep 2026 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264457; cv=none; b=BwvTsvjyj2/x1KxUt0zRfUN2jIE21THSZPmRWmbzMszPLIJrdMAs/MrJgu1TwMwgk32dIX4JsHYdHEj5hdIod6HIekvfdHadWDwYpUeiPCEYd9sE7oCFudadrSEkFp2xVP/fQKNq1n23iXDeGVR67aQItrZFYabN3t5NIzGLH4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264457; c=relaxed/simple;
	bh=ksAbz+B0pS2tsxtSwHB1iSS9zQwp+Us2OZCC04wZCHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tNsVVZIFs1otoZLv/JyyZZ0fO8ULeQbJSARVkM9rDGX/2LqP1IMycJHj80BiblSsD/0e8zweqSwpiVMZyVE/H1IIIAVapF1t13LgGX0SmZMH6t78x6BUDLHQFb0jzvD1k3QGZls3GEAidjROFEnO+bZaa+DkuGYYtkpdAc6lpp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Gnu+Vo/v; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Gnu+Vo/v"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4843f205a5bso1073599f8f.1
        for <bridge@lists.linux.dev>; Tue, 01 Sep 2026 05:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788264454; x=1788869254; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SlLlvMrdns+nyLoZQvdODsJ4s6K6WZzEbSlSJroGQQU=;
        b=Gnu+Vo/vfyzytnkSa0cjQQ2Lc4OuRrZUvxY13AGEE9r67Xnrm3FFPXA0/S9e8ciNi9
         BQi0dh/3Bc2PziiBhfVeGveePPQlwxOFhzV7P7YG8mBHunERH8gBtlaHDwica4kMcJPl
         kgtGISHebSrh5N2VmE5UbJYR9SvT2Cb2u2dFnZojeSGqN+SftDW4aIO6rw7WK65JW1gU
         SS0qcPsTOu+QrMBldjMni9RW9FK063e7VIuwIL5Er/AwZaKAVySbpxLt7wUUg6RU/E4Q
         JrDqDvG4j5POqPy0GbpEFAKQj1v9bOQ9gZV0kpITPy03pyOPO1bT8qs06pcmoi0OYqEx
         FmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264454; x=1788869254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SlLlvMrdns+nyLoZQvdODsJ4s6K6WZzEbSlSJroGQQU=;
        b=GOOIbaPDh/ZQLv1CN4yYLJg4LwhzTPdiqPjOoRYYu8OcLPeG4xUTgWHYCrQZM5STfX
         tCGVotZ5n6SUZowX5sAVb9L4CuKBieX9vJ3CP51AYN/RaICzqvi0tpYTO7p/EXS2BOO0
         sq3p/1C7CWgtfrEEQuF+8i/0vgSiQW61jVnhrNPrhYUBklJaic/IWlNmr6Wg5jElxQxX
         lnOEnCOiRY9bIHcMv1+B3r8MWtZojVX/odEeSM0+cqp4mqqgBe4F8yj4uWzG9JH7G/tG
         pN9EM3fnNaNXk5aiOXXUI7Unmqf87BSPh+gdLxNxNHTmW+Qxod/76qZdJzEizf7ayxar
         AMSQ==
X-Forwarded-Encrypted: i=1; AKwUvByHRTlsXF93m4HKIjFx5jOS0r3iCMieszeFZyVVzU4O3UdFb8A9JOeER+MOkXZlYehBUutfFvc=@lists.linux.dev
X-Gm-Message-State: AFuF++n5hpnvo3BubE06OmnQZ+MQEOgJ6S3HbVd0E0Nq4v865p5YNIEe
	T4jnk7Irp+aVPBldRIfvRakcO+L1Ya4PMYDHCkCWFQZZi78FVg15aTkkDMin7oSzSeg=
X-Gm-Gg: AYBFou03WTXoDThxzD7NiS8oE43lq1nBwI9kJPtGVSv6RAT1c+mO/liqZ9+rAUJLjiq
	CVAikOP8+qcn/YNPgwdCpU7TbRIVv7axAIwZDrvO+Cd/sqgmiVut7Sxb6d/SSGoDHHoSwjUVi7a
	ZABPw6no8yJD2VV/+w49/3saRn3lAr5LAsHjPV48pS2tmgPYZlePn2MWqb3J0Qni55YjTwCbCRn
	b5bac4pFhu0ypYucUQGw52kUa/lbCOPcIVPYJiuMgn1e7Cef8kFuV+o+C5XVw/cs00moiEjunyR
	4/RIsDkG3AMF0ligco8nYlhzW1zCOmHcuLQKq5i/Cw02EWpAfO4npj9EzRkUTC/rAxGXK+Y6v85
	/CAbTY5iQI/o343gXUGjXL+osZU9g4iLxZyFX8vW16QbJECM5Oy1In2kiZYiOy1PdojPCmdV2qf
	oqLkT6JYi5fkPBCwlQrze3N9fILVnHK2qGP58IsthDJeqYTNmbq0O2/Q9LsmmsLDpN3MUQU4Z+9
	v3y343JieI=
X-Received: by 2002:a5d:588e:0:b0:484:3d59:5df with SMTP id ffacd0b85a97d-4843d5908e5mr20598245f8f.2.1788264453640;
        Tue, 01 Sep 2026 05:07:33 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48442d7e70csm4278875f8f.36.2026.09.01.05.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:07:30 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 0/9] net: bridge: vlan: minor cleanups and annotations
Date: Tue,  1 Sep 2026 15:07:12 +0300
Message-ID: <20260901120721.747908-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
In preparation for a complete vlan fast-path re-work, this set cleans up
a few minor things - removing legacy code barriers that don't help,
                     annotating lockless accesses and using proper helpers.
No functional changes are intended. Sashiko will find many pre-existing
problems, none of them are related to this set. I will try to fix
everything pre-existing separately in -net, there will probably be a few
critical items. So if there are missed places to annotate, or if there're
actual functional changes, these obviously should be addressed in this set.

Thanks,
 Nik

Nikolay Aleksandrov (9):
  net: bridge: vlan: drop legacy memory barriers
  net: bridge: vlan: annotate lockless pvid use
  net: bridge: mst: use br_get_pvid helper
  net: bridge: vlan: annotate lockless vlan flags use
  net: bridge: vlan: annotate lockless use of private flags
  net: bridge: vlan: annotate lockless use of num_vlans
  net: bridge: vlan: annotate lockless use of msti
  net: bridge: vlan: add missing tinfo.tunnel_id annotations
  net: bridge: vlan: use br_vlan_get_state to get vlan state

 net/bridge/br_arp_nd_proxy.c   |  6 ++++--
 net/bridge/br_mst.c            | 12 ++++++-----
 net/bridge/br_multicast.c      | 18 ++++++++++------
 net/bridge/br_netlink.c        | 10 ++++-----
 net/bridge/br_netlink_tunnel.c | 12 +++++------
 net/bridge/br_private.h        | 16 ++++++++------
 net/bridge/br_vlan.c           | 39 +++++++++++++++++-----------------
 net/bridge/br_vlan_options.c   |  6 ++++--
 net/bridge/br_vlan_tunnel.c    |  2 +-
 9 files changed, 67 insertions(+), 54 deletions(-)

-- 
2.47.3

