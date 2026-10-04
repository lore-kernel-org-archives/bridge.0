Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7815F400966
	for <bridge@lists.linux.dev>; Sun,  4 Oct 2026 04:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791087198; cv=none; b=CiyISxXRlzybH3meKQpFKnxfoMKhstZ9E2BTuyQ12fEE27NfVMss+i7//EqtOh6kPUdh2YvbJHgMsm93vaMMF1MfF95hAC9ycAuXVZIjzJnUOQCuGPEude99EMz94ZmfE5VIcDUjQd+FEiFPfigyXaquoqHqxsgSXbyPnkEMLT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791087198; c=relaxed/simple;
	bh=FqQ/IuOHKIqC7d6Pwir1eelXkSlwk9OJG87QIJC610Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fZ147RMv4x0gxWD+Wp4f0PgmGZUlOIiyQhyGAx0uYNxXkIerdAgQiH5Fd8UJ6fyECWqJWDm8cy/cnEKhui9EX9UwsFQHmXwWptFTIotVsqSDLxy6SsEqMXBjmmC30L8oXSTtZzbN4Vgpb1h4ZZpvYcjT/aTYjZ1kIgkoer0uNZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rM2UlsIz; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rM2UlsIz"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-34c4a0868b6so502562eec.0
        for <bridge@lists.linux.dev>; Sat, 03 Oct 2026 21:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791087194; x=1791691994; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o06QRhU6XAKybPqQQLYE3nZ539hXW0JwrsMXBpOaGMY=;
        b=rM2UlsIzA1AQT6VbI9ZnrqIrJbulJRZxrbe5BO/4F+vAtbD/i3qBV9kPiQcKBlFMM6
         Dp/Y7P0ceAFNpGR2dWGOFM+8utK7zDb2fmgFF2LB9AwZp/dpja1rHJhnfZr9gaiD70FZ
         GvjNwPo5g84/wHODHzLyHtfr3NEuFYqVN4gRNoRzAET0+uCFp7dK1QKe3QmwxkZSUZf6
         KvHJJP42dEPrKUwpfD9b0VuJ88wQLL7+qRWKFrgo9Hb1MFOg1ncRG/5P6ZYBj79zjw/Z
         2OuFS84Yysso1IjlzyUtIZ7Siro92sspTFoDwlxocaelLYJAm6o0aV1iGWbEC7RMoVPY
         4/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791087194; x=1791691994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o06QRhU6XAKybPqQQLYE3nZ539hXW0JwrsMXBpOaGMY=;
        b=t5Ns31f+jkBVm3zXSmNLEsmuEVCvxb54lU632kghDgycDDt2jOiW0PyN3OHRIzN5q4
         ELLAj09nSkuVjlOsKnlzTY8rfoAfE52Gh/u1HumMpMCBsPLH0aSfPfAXldiGyhEaRmwH
         mCF2aygbLgYjlrQT/LIucEuMjE7rCK1y7SF1mccmGlvS1DoOO8UAtsKgyl9AQM2BmEOE
         4Q+q7ATa7UkuOaK/7mTjKh+RB+d1+pN5SKlZun9P9cWZDJ84MfB1CgPueQMr+1SGqdPA
         XnKbxHC2eq37JRliyVk4gq17HBuXxd3PT7H25w6us7mCyK3ZrkKzCqECDAF0s8/0ZvfY
         bxHQ==
X-Forwarded-Encrypted: i=1; AKwUvBwMcIm6WyiTs5ZXiteRswoiozn1StFkFt+3/3Aw4d77k/grmb/8pfyWd/QfEHseOVAbaHjes5U=@lists.linux.dev
X-Gm-Message-State: AFq9FYKzzeebBlCAJZCiHTz7rBDG/wrwGN90oiGgvKXT7xwj5lpOxzlz
	kLSbnOEUMflFPMhCA6dPBQAgS4leu9McqD+URi9tYlFdUQIiEEBZp+4p
X-Gm-Gg: AYBFou2OAlSHnsMCObNszecV+Kys2xJKmTay9Cf24pFxrFSRfh/DXcTJ5Cb2zVvIm9V
	TXYoUAnYb7MB9f91HVY5gyaC+AxaVw+eQLmR6IufrzCjN2QDdEYkHKV3YwAsLhAePruybzf7w2w
	73I8wpkeSIsMwaxfAgn7Cp6uVxn2JXP4ap3imynSQu1S6jatPueFX6PeU9u3AbcoLMGZynLwTtX
	ir6OAxZc0+PeHBkJE/v1QktANST4rJDsA3Uns93aiDtL3TQOiihb9qL0d3ZkyDjTdMqzwqlqLQV
	iK5249W7LIlFXhk1rYsd1Nz+dLRBOxAlbkKrEjy3BhCcQxqrla5CnWR1GH84oM/vmNbFUlJPXJ1
	eOG1ekruxrB95uvJnBx43+vGZsbLbTc3Tnfd81g2v1uuvhBvYD5RsHXXQXDvL7CTDdymSoLbHBV
	yzGiLaS1RPp87yGZyPMyqswMfQTZY22XSYDqT6c0s6VDQGtbb1X0uV6XkIKxN4esPM0zBLEbeXP
	ReRj+s=
X-Received: by 2002:a05:7301:d788:b0:351:d0f:c808 with SMTP id 5a478bee46e88-3510d0fcb46mr6834841eec.6.1791087193555;
        Sat, 03 Oct 2026 21:13:13 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35127136b8esm1366253eec.6.2026.10.03.21.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 21:13:13 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	idosch@nvidia.com,
	razor@blackwall.org,
	horatiu.vultur@microchip.com,
	bridge@lists.linux.dev
Subject: [PATCH iproute2-next 0/2] bridge: add cfm command
Date: Sun,  4 Oct 2026 04:13:05 +0000
Message-ID: <20261004041307.2683990-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bridge has had 802.1ag CFM support since 5.11, but iproute2 never
got a command for it. The only userspace for it today is Microchip's out
of tree cfm tool. This series adds "bridge cfm".

Patch 1 imports cfm_bridge.h, which has the domain, direction and
interval enums the CFM attributes use. Patch 2 adds the command and a
man page section.

I tested it on a 7.0 kernel with two bridges joined by a veth pair and
a MEP on each end. CCMs go out at every interval, each side sees the
other as a peer, the TLV values and the RDI bit get through, and
ccm_defect gets set when one side stops sending. I also checked show
config and show status, text and JSON, with more than one MEP and peer
on a bridge.

While testing I found that the kernel sends CCMs from a workqueue, so
with HZ=1000 the 3.3ms interval actually comes out at about 5ms and 1s
at about 1024ms. The man page says the real interval can be longer than
its name.

One thing I wasn't sure about: the MAID is given as a hex string, the
same bytes the kernel stores. The Microchip tool builds it from an MD
name and an MA name. I can add that, but it seemed better as a separate
patch.

Separately, I'm sending a net-next patch so that CFM config changes
send a notification. Right now only status changes do. The two don't
depend on each other.

Abdul Wasey (2):
  uapi: import cfm_bridge.h
  bridge: add cfm command

 bridge/Makefile                 |    2 +-
 bridge/br_common.h              |    1 +
 bridge/bridge.c                 |    3 +-
 bridge/cfm.c                    | 1058 +++++++++++++++++++++++++++++++
 include/uapi/linux/cfm_bridge.h |   64 ++
 man/man8/bridge.8               |  196 +++++-
 6 files changed, 1321 insertions(+), 3 deletions(-)
 create mode 100644 bridge/cfm.c
 create mode 100644 include/uapi/linux/cfm_bridge.h

-- 
2.53.0

