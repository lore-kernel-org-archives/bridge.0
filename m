Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3F23AEF45
	for <bridge@lists.linux.dev>; Tue, 18 Aug 2026 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065692; cv=none; b=hkT1B0s0arozbfey7X5PXnaz3UGNM4dt194582EhQPrWHGLheQOftlxfVsDTgbJ9ZalO1TxbFux11qotyRTzz4xDp9VQj4PtA9cwJGFUTNPpkk/8vtY83WSNVrj1p7h25kYIZebrLnl9kTkNmcdQnkrn33Yv8N5U7K714JCCm4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065692; c=relaxed/simple;
	bh=orYruE8rwkL+ojQp7lSc7D4f0zd5SSPB0JbO/i7kNVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QJT9nVbF0BR+Nv5RHQbhpHs3pifqwQVr3+XnbZ4xKCG7SiIdwsyMtN3u47ZtURwbaWQHa511+8qX0hypP/Kt7xHQ4C9tfsFgjBbC2mjRXVhLnDGIdkk6jZC/yOOR1hDZY2AfGK3ix/fQXihiIZeZ1tw8+AZLiKvC5rW6x7FFKOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=E49g6okq; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="E49g6okq"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47de0093c42so4158743f8f.3
        for <bridge@lists.linux.dev>; Tue, 18 Aug 2026 08:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787065689; x=1787670489; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d6pSy6zxul/pOC6qg9HR4Dtl8Ytd4LSgVsEi+aLWf9Y=;
        b=E49g6okqfxG/m0O29DFy+XlKhTbbyfTYyuYHBjESr41PQIpWVfeJHjU1mWNBtZBUm4
         oUss6PoptwHivyOFuUmwFmANTEQwP9MSu9BYV7hbet5vezSIujnrzZMyinGve+ScyB8z
         wW0zbE2pJ3yu6gEAgEQ9y7yuuAdxw+qQJuIA6dVR9JHS2t5ZFvmOwGOTOp95AlKgGV6d
         Dojptm5NGxpXm4Wxy/k8d1J0VYq53MpQa2nn+cWDD8Jk5zSbwSyo7AyWUvJXUzHnKLcD
         zCt6iikuB5aCDlpZTpQHiaPJGSfszypogQ6SdUiDTziWokfVJeslC3w/A9pAvypyB6Ah
         ha9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787065689; x=1787670489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d6pSy6zxul/pOC6qg9HR4Dtl8Ytd4LSgVsEi+aLWf9Y=;
        b=DtRYNK/mOJXiWJE7MXfEZ6mo0BS6DaQxO5iAto0hdIo9/DMObEEEYcE561iaKya2Rl
         EADr/Ia3Z+ob4r9rc4QL+/zqINV2rBFNF00m/tOlAC3uvX2SyJl37yRnA3sHiTj8SjgK
         DeHpxgSEyDo6DNsSCdnUaYzipszTIDgbShEMtXqAX6blv40jGA0zCIMkV5XKZ84lslB2
         /U0bEHFMGNqRa0NphAjgaUCa5H0eSDmHJ/pbCpVFRdrkbE1tF3JoJN12Po4HrV9+h25b
         4DkmyMHpWXWQB+uEPJcVyqOztwFIs8m/plrTF4NTsi8dTygty5hFbI2sS/2FyiLyL9/v
         ZqTA==
X-Forwarded-Encrypted: i=1; AHgh+Rqf7PWIIG034LVu8wLAswYKbidrEj+g7KF0qLBHR6ZsUkMWxftciB04vBHHiNXM94uCi9MpD3s=@lists.linux.dev
X-Gm-Message-State: AOJu0YxCOQCV0Bv01j1J7nZj7v5oBGQHxzHoFS/b37ZRUsKkuUDG/TbM
	74vxylMDdBfH13sFWgoA7d945+YWwvxOpYMrQa0NfGIEPLO1L5foDLLkeEhbFnyJ1Yo=
X-Gm-Gg: AR+sD13x+pLyEINyJRcRSxkuWr2OA26O1Rm2uKvT5Lfi2p79kfVAZxUvQZZZl+0P7w/
	ZKL8GvMkrQlGiphO5rzvRyQIXEVekAPZ8bxnh65MA9SQ9q92QqThITjhu0lzoInFkx2T3alRpX0
	t0h/IE31PUJ1kpUbVJ3I5ZAZ1/I1SPI6KhFddyZDXn4iXk5SRI29/GA/5jmo7py9y1//qn8PmKn
	GvpVNG0qL8eWt759B0DAZFYhO2NW1dSGUX3UafxBd4jtiHoh01XLeCg6Hce1Vmxr62o4wATzi8j
	w5AMB6P47F8jj7zWSkm5IB+A4D4mLjKOw1G5WLSGAf14WPUNX69Qxx1aFpi8kDW5bcD1ewwF+fF
	J3bbWTgncWnZuc7EpcMCO7Cgbj1bPbLpDWthjGiarMMkEiBm/9A129vc9OMdBDRYa4e7b8OjXUO
	RjEFyksquzMK3sv0tbU+rwoalpgsOyW/oWfV12FxgNwdOCLKlXJWx1SQXeW2YxK2XscoFYWGdsV
	1C+FU1ot4E=
X-Received: by 2002:a05:600c:68ca:b0:495:641a:bd3f with SMTP id 5b1f17b1804b1-49987995272mr433756325e9.13.1787065688567;
        Tue, 18 Aug 2026 08:08:08 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4999d0fb85csm183842525e9.11.2026.08.18.08.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 08:08:08 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	roopa@nvidia.com,
	bridge@lists.linux.dev,
	andrew+netdev@lunn.ch,
	dlstevens@us.ibm.com,
	amwang@redhat.com,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net v2 0/2] bridge/vxlan: fix reading neigh ha without synchronization
Date: Tue, 18 Aug 2026 18:07:54 +0300
Message-ID: <20260818150756.890025-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
Neigh ha address must be read using the seqlock to get a stable snapshot.
Both the bridge and vxlan read it directly and can see partial updates.
I reproduced both issues with running neigh updates and exercising these
paths in parallel and saw partial addresses, e.g. updating between
neigh A: 02:00:00:00:00:00 neigh B: fe:ff:ff:ff:ff:ff was able to observe
02:00:ff:ff:ff:ff and fe:ff:00:00:00:00 in packets. Noticed this initially
in the bridge, then checked vxlan and its arp/neigh_reduce functions have
the same bug, route_shortcircuit is doing the right thing already.

v1 link: https://lore.kernel.org/netdev/20260817143613.685769-1-razor@blackwall.org/
v2: - use ETH_ALEN instead of MAX_ADDR_LEN, the bridge devices all use
      ETH_ALEN and vxlan allows arp/nd reduce only when not in raw/gpe
      so it also always uses ETH_ALEN
    - align ha to 2 bytes because ether_addr_copy() expects it (Sashiko)

2-byte alignment is not strictly necessary everywhere (e.g. the ARP
suppress side can't reach ether_addr_copy) but it doesn't cost us anything
and is aligned with the rest of the code.

Cheers,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: arp/nd proxy: fix reading neigh ha
  vxlan: fix reading neigh ha

 drivers/net/vxlan/vxlan_core.c | 20 +++++++++++++-------
 net/bridge/br_arp_nd_proxy.c   | 24 ++++++++++++++----------
 2 files changed, 27 insertions(+), 17 deletions(-)

-- 
2.47.3

