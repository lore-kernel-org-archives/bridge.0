Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C398A3161BE
	for <bridge@lists.linux.dev>; Mon,  5 Oct 2026 04:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791175113; cv=none; b=rFmmfiZQ90joWVcwoGT/O23kABhRgKy/pz+79xvFw1tXZzzuOYd0PnhahPUkkQ0UU1o30aKNSaaQR84Zj8+WrV1FMguoyg5AYBti4E6sNv8zqOXyOWBi2t2Clwtw3lBjvZBITNyhZyT6XhqOmQt2VzqE9MaKOwHwYwkH1JBYVlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791175113; c=relaxed/simple;
	bh=DVe/Uf9lRLG7TXnSdmrHU+KiaSzva7YYvHSdv24lx/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jwv0ib/Qhj7qLaU9jC4Q1+IaCRIje6rZanqCODkA2mCCNM4xFvQdX0DYY7gp9cHfCa4A3Lxdd+eeaHT3HHdX0eSqZ8Ur7c9znD1hf5iQ9bLCzz5HoBT7BU8qY32xc4QoM+wu9nD5kMPg1edOfL9pvEqzhvdWC8Y35HZJCq/tfkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vsy6Bxmq; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vsy6Bxmq"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33bfb26865fso860233eec.2
        for <bridge@lists.linux.dev>; Sun, 04 Oct 2026 21:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791175109; x=1791779909; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C4UZFNv6HMjAlmXNHL/VJdByu8s7YE2QayAHEqne0TE=;
        b=Vsy6BxmqBh8CSFhr/Q0zjxgWJk7El314G7dSbI4cBn1391wX9tBaof/6vhsOuCwhmU
         TAL1b9OEhoaFcGBOi3m3nbVDnyOwHv3h+MGGMkCwXE9fCZczqbdVSt+r0NcN8VFVsdZ8
         M/p5jmuF/9MAhZY6OjZ+j8WPC+KWQ2PyWaVMMgsO1dogUL9sv4v1QmjuSCKcfmg0UhXP
         WWH/SDI0sUynVkuCgEC2JzuKoPmz4biMXBpCvrJyfaQZ8sQ+17vj/Hm0qPjetrgbrxZ5
         RdsdRXkrj6HAzYJSs0Wo87vcBhxviHp6Nn/X74ZxUdqnJHDP3jwPxoxkuPEBhENaV5BS
         rPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791175109; x=1791779909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C4UZFNv6HMjAlmXNHL/VJdByu8s7YE2QayAHEqne0TE=;
        b=wYRaHuGM/vKohb0qsYKkGv26qIPirc1h0o50SmQSmhWBW7sovBQvRAfDmXnicSTDWT
         G+dsJhVkga16PkLu0AtHUDlbNzgzuqGbaP3XnSoEip+OSQy1G0QQSkLK6SRKLTQwjYqL
         yDPgmAoUnZYyFK/ETrkvEdy7DTmJv21dmH5rDWPXlg4GG1uuPIVOa+PnPyWbDElPxL31
         aVNReE7PaJp4qzvaT2pcQYbMuYI65M/tCdgQvRIkA4cEYEC0RFMPJ9mAcXEpICbAfw5s
         JtG4MOB1QuE9u6a7r/Vga9tnMSnb0Egj+iJFvvaisL5F73yYi/ZvHFq9+2MVtkYrfkEN
         6exg==
X-Forwarded-Encrypted: i=1; AKwUvBzi9EU+VKtbamqrKlPIy87GAuXB3bpVKuRxWhcllOAPW9Q2b2Jg6f9L0XQn3rN2Oj2ljc76b1g=@lists.linux.dev
X-Gm-Message-State: AFq9FYIQSfv5S9ZsWMRIW+qikbmAnSKNZzJ0afbkKLIsBeT0iv6C292V
	cVOi7b71IIGifxNS8OjIAInfiGzSWyUVKGCQvLyVPLFCVnHv029K4Usg
X-Gm-Gg: AYBFou3VTEibrgS2FVcBz75PTxBtGpx/jJRSU4U/1ZTOLncB9GlIHJwXOMvv5ZFFjZb
	NiynIA+8lmxenJgx1uvc05WSZHj12NbEdCs/QLdEfIKmXUjrMghMmWF7ZyC2eQAMPhxwAiY6QK3
	2PcjdScWzy8QC5VV/bb33563tDuYrtEaFST5CUonGlk6jbvPsXkoUJWTqk4b7MpfKd/rhz2jlio
	KtHtklVOJ4m50QAaovqlJPKkaSmyeGQkM6XKDdYbZrpauyXGMstBYEwcM8HWaqaMRhAFnLPg7uh
	/aS7iesU2hUicg+N3NFqnYRy6VcbM2Bp5SvVUYz5GbvL5xBcDseSQ0q/maNLiabbMpHyhqK/8A+
	Y1EyxdWoFnVmaVIDe9624qtvfvj/UgkW+zFPNI03uE/PxZQQf71QN/w4f8Y0tXR8SYjM1dXsxtU
	IB5ZIg+sud1ocWuZLJKa3+li3jIVxvqLLyYnVDUu9yWZ1Y4Pq00tN9nW7LsvM0s5nCvQX59tBL0
	4d6ozc=
X-Received: by 2002:a05:7300:e5c2:b0:341:ec1b:5632 with SMTP id 5a478bee46e88-34f2199a7c6mr13011722eec.34.1791175108894;
        Sun, 04 Oct 2026 21:38:28 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35127136b8esm9518581eec.6.2026.10.04.21.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 21:38:28 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: netdev@vger.kernel.org
Cc: razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	horatiu.vultur@microchip.com,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/3] net: bridge: cfm: notify userspace on CFM config changes
Date: Mon,  5 Oct 2026 04:38:19 +0000
Message-ID: <20261005043822.3106580-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CFM status changes are sent to userspace, config changes are not, so
the only way to see a MEP being created, a peer added or CCM
transmission started is to poll RTM_GETLINK. Patch 3 adds the
notification. Patches 1 and 2 fix the two problems the AI review found
in v1.

Patch 1 makes br_get_link_af_size_filtered() count the CFM config
attributes. Without it the notification overflows its skb once a MEP
has about 32 peers, and br_info_notify() hits its WARN_ON. Patch 2 puts
an empty IFLA_BRIDGE_CFM nest in the message when the bridge has no
MEPs, so deleting the last MEP is visible to a listener.

Tested with virtme-ng on net-next: 300 peer MEPs and config changes
give one notification each (6248 byte CFM payload) and no warning;
deleting the last MEP gives a notification with an empty
IFLA_BRIDGE_CFM; a request that fails before changing anything sends
nothing, one that fails half way still sends one. Also built with
CONFIG_BRIDGE_CFM off.

v2:
- new patch 1, count the config attributes in the message size
- new patch 2, empty CFM nest for a bridge with no MEPs
- patch 3: unchanged, rebased on current net-next

v1: https://lore.kernel.org/netdev/20261004041320.2684045-1-w453y.me@gmail.com/

Abdul Wasey (3):
  net: bridge: cfm: count CFM config attributes in the link message size
  net: bridge: cfm: send an empty CFM nest when a bridge has no MEPs
  net: bridge: cfm: notify userspace on CFM config changes

 net/bridge/br_cfm_netlink.c | 32 ++++++++++++++++++-------
 net/bridge/br_netlink.c     | 47 ++++++++++++++++++++++++++++++++++---
 2 files changed, 67 insertions(+), 12 deletions(-)

-- 
2.53.0

