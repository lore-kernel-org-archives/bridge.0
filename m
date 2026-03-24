Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC41406279
	for <bridge@lists.linux.dev>; Tue, 24 Mar 2026 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366245; cv=none; b=ckVgYh0VmjYfv9mdtPj2c4NYi4d3H6gZRki794vNq2rcksx03OANL6vu8fQmgcq0srz+mn4eCAr9r21OVLhg6kpSRi+1x5s8UGbAURVbiMcwqSPJ7z+7T4DabN1Fl+Hg/6wBntbLRUcBolPp+WVlJ8rA9MMj4UqPnbAkjuvcKes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366245; c=relaxed/simple;
	bh=TxJ+oDNySr+IyxdxccVfNUa3nwBwfiPZNX0RSPAlVx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dxsnNO24SopPVC0nzor4JXbEP/9sq48Vpx3ZCKS/m4YsafVqamnQRmdmfnKxdT+E1JvysSpf1qKVCzbprOCYE5ai8oYAwX2TUh7jn1oJBfi+cj3V4zpoMayzWrp8xu13TGkfg1siJbuvJ9J5igKzgOADaBM5J6EfsFu8Lj/2gj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wy2bowSz; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wy2bowSz"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-12a695044a4so2559610c88.0
        for <bridge@lists.linux.dev>; Tue, 24 Mar 2026 08:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774366242; x=1774971042; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0bro20BaiUhSDFUr5rtVn5yIB3sY7AcX1uY+fY9VQbQ=;
        b=Wy2bowSz0EP29er6PigWF/Lg45QmGOVW7wkxG3w+p2UksvaDUAT/Wq7mcOzrR+ILjx
         zIZ6IttqrtV4M4yR/CvuVDL8ALVaH0M7CMmSVho5X1tHGMietI7jl6qwxTLbl4KKpFvn
         416VHvpelvRzNHoU8nWGIdN/m2zfmwiP01pvFgNkPNcPKA+vKJkpA/HHqm+1Hz+nxtOV
         XRCA6/HXZH3vQKxXV0g4sD/ATbwbmDPK2ROOwkEpxsxfKz+QUjv8p/unb58I0T6R83rL
         /NSlWasD+U2RXdxy2h4aoPN8kiON/K/jw1RoXwUpJJATg2MsTzEQ/u+Phi/JU6s7AT2H
         fWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774366242; x=1774971042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bro20BaiUhSDFUr5rtVn5yIB3sY7AcX1uY+fY9VQbQ=;
        b=Is2uxTFSGlluYpo5grNt9eSkn+ITMuGiTSQUTf/d8bS1oQe58R2mCsbfROvK71yYLC
         +IjjxTSyBH3dUqY8GI+u8sfoX57NQNzlLdPp1IinKJMBoRr/6TfmSED18SCdpxx9Xx3o
         APNiNW8VF3nOmemisKXvmeEfqYdxvG/Y19E7y9HQE6eS78VXq41OcrRKQEmBndIA82Ih
         GwF/GNIAJNr3OCJDnY7TIAJUnBEKqJ/mPzBbsoHeJl11B9FRfz5XpBR1hWdq8bZr+xIZ
         VkmbYMy8PXrZsrwgs1hc1PQKD7icUbiPYR8k1UfwZzdB0zHIF54eYQEmxuf5l2Moy90J
         3kBg==
X-Forwarded-Encrypted: i=1; AJvYcCXonz91VEV6dZeQ5lMLac8ZkVmqBYH2gc8M0AVtZ73Brh+NnddO9iVwgNY5wEzVPCcCbw/oaps=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzv4yQjkIdsyfO1WGTmREGWkuMjs22u5g9UZ6BYrxR20xQfZcnH
	kA0MBXh3owza+qGYPHX8ZE1hIv0no7h3bJ0baUyRIzZ7enHzgKvyU0UJ
X-Gm-Gg: ATEYQzwvdllVxJLvkiywMD7pmkVrOI5bNxYz2wdTHQMtaxNQrtISw8oH06B1SBy7z47
	rEK6MHcImkpP+tA0jWhyH8TknNKr+vK34G/yP8a2cB+PXlq8psE+Pa/rAytPM8op2HkBj0U7RaW
	CuKveTJA1t2FE3Yb8p6842oEk2RtD1siLezLjTCVVd3tvF1TpEgmbG8qewuJs3eG85ErjM+cjCX
	bJNFXU6EV2cCw1jrnXTwVE/tUjs9R7fUBM+zCRVFTgunXYVfO2R5g0MKinXefqTHzNmVpvsJIwC
	gytpPnmTZ7mq43hkElf7ZVtJVENRkg5ml892rWzAesdh/KXvYMv4X4f3P9uZm2qA8inWLM6axMU
	FtOiWNwU9O39ypK4r2ljosrRJIseLHGgFrGZnEY0mOw1S1dL6EnfTuMfMRXXg73gonLBQxKPEic
	hAx7B+ZiNGZ1PvwWDNIAGcav/i7jmgPtSFB1MLxIxqCcxlx6IMV9dsdp4uIe5tphR+su3SwA==
X-Received: by 2002:a05:7022:6728:b0:123:34e8:aec2 with SMTP id a92af1059eb24-12a726570a2mr7392229c88.1.1774366242086;
        Tue, 24 Mar 2026 08:30:42 -0700 (PDT)
Received: from localhost.localdomain ([38.244.25.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a736b952asm11668865c88.12.2026.03.24.08.30.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Mar 2026 08:30:41 -0700 (PDT)
From: Eric-Terminal <ericterminal@gmail.com>
To: horms@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	Yufan Chen <ericterminal@gmail.com>
Subject: [PATCH v3 0/2] net: replace deprecated simple_strto* parsers
Date: Tue, 24 Mar 2026 23:30:34 +0800
Message-ID: <20260324153036.86901-1-ericterminal@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079; i=ericterminal@gmail.com; h=from:subject; bh=zssS49qkfo1363PBqfzh1+o0wqR3w3I90sqNuTWA/YU=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWQeWqt1U3fWI3nWM4keKiwnX1zjcNFncLoTmswjNZfl6 MwlHotWdkxkYRDjYrAUU2S5+3/f3FyvW3Oucx/OhZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31 DI10DHSMGbg4BWCqDXkZGS6fq+ysZvv9Nn0VZ4Gu1JSfoWwyH1iWO3Pv2tjI77k18TUjwyTxPLZ zRfXLtgq9m77WxbxqkuLXaGZZ/nUVU76K6SdVswMA
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit

From: Yufan Chen <ericterminal@gmail.com>

Hi,

This series replaces deprecated simple_strto* parsers in two net paths
with kstrto* helpers and tightens parse semantics.

The series has been split from a previous mixed 9p/net series to ease
review and align with subsystem boundaries.

Patch 1 switches bridge brport_store() to kstrtoul() to ensure strict
input validation before taking locks.

Patch 2 updates sunrpc proc_dodebug() to use kstrtouint() for full-token
conversion, improving error reporting consistency in sysctl paths.

Testing:
- Verified migration to kstrto* ensures that sysfs/procfs interfaces now
  properly validate the entire input string, rejecting malformed input.

v3:
- Split into a dedicated net series for bridge and sunrpc.
- No functional changes since v2.

Yufan Chen (2):
  net: bridge: replace deprecated simple_strtoul with kstrtoul
  net: sunrpc: replace deprecated simple_strtol with kstrtouint

 net/bridge/br_sysfs_if.c |  5 +++--
 net/sunrpc/sysctl.c      | 24 ++++++++++++------------
 2 files changed, 15 insertions(+), 14 deletions(-)

-- 
2.47.3
