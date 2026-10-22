Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660607;
	b=aR00tLWRbbhSCAtwpHSqhGlULVfVlXTltGbJy5/xZL2LMFW815kr9I/XXyGSMJGV383R
	 VJFgh+x4ZGXQK7efZYvQ9HPTB986G/nQ00J5Mk7ByoyWkk1M7vB2qwxyNExDti87gCzQZ
	 Wa88rfuCs4CEix/v5gmKfS250L0AEreBi0HwmoQWAoqnNAYQUXgUp+ZzxzbC/29PhtVCV
	 DpTmJQ9zyf7stNZgv7bIxmr4ACWW6kV8sfenKq/i5/zBaJSY3CWriIdL7YpaXlBJj+rEf
	 0Xa1Q+xDQkMCjD+YoDQnGq0HcVo22aSI2tqtZ9zm7BMV4EOrS5Ma6ILIZ6zyAQuzQog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660607;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Pv1Dk4E92+Y81x316CmYEZVjvBF08c29+bZvlM2Ctvc=;
	b=DOiNmAj7ODmj+ZwNUjRpN1mBtPLkYtlQwEJHM3QX9ynlNC8dvCLhE5mvq6MgHYz2ZaUO
	 P3bWel44w2CjGU9fxeMrFWnEXYnBLfMraCa7MbauDlNw27yrU0Cx0R3IDvlLJZmyNnngO
	 A7ffHhyJsqLZGxkynnl1v/g0WpPxpsjZLBk9tPLMczZc/F+g6dzkZcYvB24Tsk0sDaMlw
	 yiVlFiXQ3ZC8ftutmE5JreN4S5YW1GEax+5fSvrT/pJDUo/fjtvLBAJC+57D3OtHhGKWo
	 gr7eiHXSipkwCdED8pgVQB5iv33B1hMfhLr4Mf5tlfYyXutil1gGnovJGF07NuaXC5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fXgF1hW5;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F7C606A31A
	for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 09:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83F7C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fXgF1hW5
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1931ff67a29so1587639c88.1
        for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 02:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660607; x=1793265407; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pv1Dk4E92+Y81x316CmYEZVjvBF08c29+bZvlM2Ctvc=;
        b=fXgF1hW5Ktwq2njuSHADMNwycDtwsK1w8SYDlUkkD67iI2HL8iV32ULuaebUn4ZyQ/
         ui8A94SAo/Wj489bFa+Mz3XFSWgYQggV9SHHBOwLg6hIySjG7ZHOn28Xl9/05ppQJMAH
         FPEdM32JW/ptO+Z43cuVNfOryQFsyjPhxoxs9cXqPibJcgbLygR18cjboQ39w4VSnEbp
         cPf4hAhXTBRizKb695FpJnyEmkz4r/z89fmQQma9ReXSWynOBFhr42B13yOWdsDAIJJd
         czZFUWhDFYiUmZwPb1qXG4lfOpi71u8UZVDV39bIGpVmU4yTwP/USqy7rdFHT+yR3z+G
         TH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660607; x=1793265407;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pv1Dk4E92+Y81x316CmYEZVjvBF08c29+bZvlM2Ctvc=;
        b=MhJ0O2gDteXkV3D3i+JgCK7tsc85+u/3rKrNVhaL1g3Im34t2V86CUqFYY9TyJf44N
         RDOn1xb1AjXuQcUIq7Q3LDB7k13slI9fC6PJov0LGqT0D1oxbkDVpOVLZkUUbl3gIupB
         M6tbRURX54Q22aoaP7oee5EUIdBJsY0jOqJWwZClRnH1ZkIaWpn4jZ8eQtoJypGhvg5L
         YvKMlvk8LPmLGqwyzAd1CYzLwf7V4E8GdM4HxCU4/2tvnQu8nOnuu7qdE7/NpVr7cZ5L
         GK9IYhTi8V9xV3utKxTAFCSlgmTVxhPZm4aHbFNIn8cThxexJZZRYII+XiKbkMhAnVOX
         T4sA==
X-Forwarded-Encrypted: i=1; AKwUvBy3qTizvsvckR68PefuzIOr7kmSeXFoRhX3JLAniPTdNjrkUsHRWjiVNSJlxWFyuoSIfHAkljU=@lists.linux.dev
X-Gm-Message-State: AFq9FYK6luMxOVORG6C5h2amdx9vetsFtufws+fKwRA8/8OHSiM65ySr
	NiAEC8+s+rzArt24VdnXt1Zi0XbxV+j7pBP7SwKDKqlr+RvuX6bqfd71
X-Gm-Gg: AYBFou1uQIdxQhZGxp6irdsOuEyuX+0Ue1CETvTGfAWniDcv0m21L+zgMoZphMUK+dh
	crDgddHyciHRU+TszFPYFYbudb+0pm5kan6iGPKEHm4KVjdDNMbS/vja1MeVvpbmuSAW8w/pZaF
	12bFegyqYwwSnol+pQD1XGn9j3ctjihZY37ICVqTIMUnyW7Q3GT8Gv+LVfvS2Gbts5s8npFMRhi
	3AVALLXJ11ui1GTlLlZheZAPId9nEDl3T5B2hNsNDWZDGkkwug+1tyd35W3xucYxvr1Y5ZSErEh
	KlDSbojN6M62vem4xDU02uF0Nxko7bay5Dx5/zBAW74D/J3aKeYEY8XsJlvbL0DhmAG5jhJZ+d1
	L5ZIFu7UDkD7c7tpeMNZ6WfUVt7gVpkmgr6vTzX3eRE6On/tyqTRTMrY1g94qtKVH3V8AdvLbIz
	u8N/yKGxYf9dACxCNQ3yGLa1hWvf+u7KFJgvG1z2GRyCTIO5gdlXWA9gWCNgCWtsL5ez8pJixdc
	tHnupUoP05ovz4bUiEyNuZ5PMxmWC5CRa3R04nXFsl7qcGaCv22Z1PhF5pO9Z8gueFH+W9D0+Qp
	mo05qqCeyskArl3Ytas=
X-Received: by 2002:a05:701a:ca01:b0:149:50cb:2175 with SMTP id a92af1059eb24-190a67f9f1fmr6394878c88.33.1792660606730;
        Thu, 22 Oct 2026 02:16:46 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bf5d61csm13188815c88.15.2026.10.22.02.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:16:46 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: bridge: tunnel ID zero works on ingress but not egress
Date: Thu, 22 Oct 2026 02:16:40 -0700
Message-Id: <20261022091640.3652180-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

__vlan_tunnel_info_add() accepts tunnel ID 0, creates a valid
tunnel_dst, and inserts the VLAN into the tunnel hash with key 0.
Ingress looks up key 0 and retags the frame.

The egress path treats tunnel_id == 0 as "not configured" and returns
before installing tunnel metadata.  The same mapping therefore works in
one direction and is inert in the other, while RTM_GETLINK reports it
as present.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1:

  VID 100 -> tunnel id 0:
    ingress VNI 0 is retagged to VID 100
    egress emits VID 100 tagged but installs no VXLAN metadata

  remap VID 100 -> tunnel id 3000:
    egress immediately produces VNI 3000

Two independent cold boots produced the same result.

Either reject tunnel ID 0 as reserved or stop using zero as the egress
presence sentinel and make ingress and egress interpret the mapping
consistently.

This is distinct from candidate BR-063's netlink-size undercount for a
tid-zero entry, which has a pending sizing patch.

I found no matching functional fix or CVE.

The self-contained PoC and both console logs are available on request.

This was found with a multi-agent workflow; the
ingress/egress asymmetry was reproduced in QEMU.

Thanks,
Cheng Yongkang
