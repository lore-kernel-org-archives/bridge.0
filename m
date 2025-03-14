Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEDD1EF09A
	for <bridge@lists.linux.dev>; Fri, 14 Mar 2025 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946865; cv=none; b=UgLOudhP0IIbbQccuw6YSVl02Movs+6kt7aHx6LK7u7FdPBTEn0A+DoJDEFqtH1aM/jApTn1sck4hy8inr+Y7EPGeLMWNAKlcyjF6taNFqsanXbpTRbmmawiKwLmQk6eMt3z8QPdkh8JDg8lzzgozUpebQEkGNVB2J12m6sprVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946865; c=relaxed/simple;
	bh=8HKls/vyB5Nb7yFTUbMYOUr3j4jvqnSvKpBCWy4txP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fVPeUNVEY2ObiLLC68se19myw0nYhhK4P/dsllnjlfywDc1yIprFHIe0hgWpIB/CIQdEENKkdOA79V1rbX33DfMqr2BX3/Ao/uibqVFt1G8eCWXbG5Kaa4/jQrP6l774XZtO5Ur5Mz1pOVYRFjedQ0ItjqyfmIrk8G6N2nvm2AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=ivXDaplO; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ivXDaplO"
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5e56b229d60so5585226a12.0
        for <bridge@lists.linux.dev>; Fri, 14 Mar 2025 03:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1741946861; x=1742551661; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cfffNHYI49Xl5zPC144OdkSFN9wBx2U8lL7yj9iYGbU=;
        b=ivXDaplOLkbsF7tIpfXxDEVnzhU3pmeZADob2vVdGbx1D+yQiLdIB9s9JoSXSZzfPT
         8MYHi2kGMMJrFQvKBHEiPPo6Hc/Pqmv1+D6V1oYdg4C4ou64H55wTwBxbQN+3g5a63sH
         dkZgTTVkxAaid5wtNyUJPr7ADTOsZS/2E8GjBUVtVm9UU4WChYLo7HbmPM3EqyF88EBw
         NySR/zxWoRVcjTudyVqiwNnJZ8uYuUVPUCH+lf20eujU7tKxI3j8kWTuIfJRhXl/CY/B
         Wf77/3eHmYyj4vgPph2ygBfbO9OtRZTC/ckK0XEpFsDfddUooVgA0fafcLJJ2vsIsQKT
         6q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741946861; x=1742551661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfffNHYI49Xl5zPC144OdkSFN9wBx2U8lL7yj9iYGbU=;
        b=qmJX2AxOfsaDIKkKWKb+uJifwfIQZyllhdlvzmuCTI83/Y91FOZdnS1iepQ6m56s9D
         r6RnPHALMVYMwZnrtsTGja3A6Uadr7k4cbEYj4SkJfBVXjyrFpA3s/Py7qGefN23Y5Pe
         qaAv913+oJ5eqTpc3jopCObKo4+NDwkGRyfJPEYstQst5uL92lFbBMOJkiXlWwb5hOBg
         iJTWNqlO87SE0wuqwxeJ4/wuI6LOYKIFqeHJj/SzSe7do27m5L2Rm+Xpdq0I/rFT9RX2
         oJHyzanAfAD28HMds4hkFdDzmup0Qdo9MzP7KxyaHb78BS3+0kqpBj4VY3B9Xz1AKwMx
         mDdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTtNzaeqrGvECQgVoTSKNbVlOoKCgwO5OMH5Vx0OD+8x6FUNCMA3rFCAfHCGQ6dbnftcTI5wI=@lists.linux.dev
X-Gm-Message-State: AOJu0YxJ8TDs/GXhoBmT26VZjJh7zcxS6l/hBNfxW6WggngyYaVkJq+U
	0wFnGfKFAoiA4rrTWfZ657q+J4Jr5GyxdMTUJ1m8NQoHCoqgBacNxGsjMiEMHOY=
X-Gm-Gg: ASbGncvbman4haDLX1K//Mv0Sokt4A56mEx4o1+K63LL1+4EwtgMCBvLFDiZlhC9L9a
	KLBFq7feXgpyjnYbcvkbG/CbSnD8ryiYtezSqsrH9vn1t4qkIYCwOPk1ZHXqjMLgkc+s44Wm1Aa
	caUlVs+jnOrbSj3A4YsCkOFMl+kvsO9ALYo+WGDph3aH8md2+GNovOXohRdx2hFq7X8wyVUF1ni
	XmXC5vcv6FMjwass4T4NBkTVyNyygga/PFPv022oYZGKHFMgoCgMmmSYp3or+fYsY7AtYOtj8Cb
	0L33/qjjEtHgI9uyOjM8XdJmq69uoCXdTrU=
X-Google-Smtp-Source: AGHT+IGwUZoSMFSvs6YN2fIDJa6ZdB6rTlqmRL2w5zcN20nZYYMiUFmpXajVLtXPMDz24Mri2X0QDw==
X-Received: by 2002:a05:6402:1ecc:b0:5e0:6e6c:e2b5 with SMTP id 4fb4d7f45d1cf-5e814dedc7dmr6711949a12.9.1741946860969;
        Fri, 14 Mar 2025 03:07:40 -0700 (PDT)
Received: from dev.. ([195.29.209.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afe26bsm1770804a12.72.2025.03.14.03.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:07:40 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	idosch@idosch.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	bridge@lists.linux.dev,
	davem@davemloft.net,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next] MAINTAINERS: update bridge entry
Date: Fri, 14 Mar 2025 12:06:31 +0200
Message-ID: <20250314100631.40999-1-razor@blackwall.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Roopa has decided to withdraw as a bridge maintainer and Ido has agreed to
step up and co-maintain the bridge with me. He has been very helpful in
bridge patch reviews and has contributed a lot to the bridge over the
years. Add an entry for Roopa to CREDITS and also add bridge's headers
to its MAINTAINERS entry.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 CREDITS     | 4 ++++
 MAINTAINERS | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 53d11a46fd69..d71d42c30044 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3233,6 +3233,10 @@ N: Rui Prior
 E: rprior@inescn.pt
 D: ATM device driver for NICStAR based cards
 
+N: Roopa Prabhu
+E: roopa@nvidia.com
+D: Bridge co-maintainer, vxlan and networking contributor
+
 N: Stefan Probst
 E: sp@caldera.de
 D: The Linux Support Team Erlangen, 1993-97
diff --git a/MAINTAINERS b/MAINTAINERS
index 241ca9e260a2..3169b1e3f006 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8590,12 +8590,14 @@ F:	Documentation/networking/devlink/etas_es58x.rst
 F:	drivers/net/can/usb/etas_es58x/
 
 ETHERNET BRIDGE
-M:	Roopa Prabhu <roopa@nvidia.com>
 M:	Nikolay Aleksandrov <razor@blackwall.org>
+M:	Ido Schimmel <idosch@nvidia.com>
 L:	bridge@lists.linux.dev
 L:	netdev@vger.kernel.org
 S:	Maintained
 W:	http://www.linuxfoundation.org/en/Net:Bridge
+F:	include/linux/if_bridge.h
+F:	include/uapi/linux/if_bridge.h
 F:	include/linux/netfilter_bridge/
 F:	net/bridge/
 
-- 
2.48.1

