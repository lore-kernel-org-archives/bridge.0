Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2997916E886
	for <bridge@lists.linux-foundation.org>; Thu, 31 Oct 2024 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730364717; cv=none; b=AnyXQ3G/dz/1eZmTit+gJYIkpycN1ZxTTHKG/k138oknRplT0BkvYGjW5cLTfDsEsmb716Cl7LntkJg2Akfnr5CkSAqa1dPaU5OHVf5a4Angl/azJ5Btc9ottNE7Y4tH9fsK/DIZnSjpcABW1XtBfyxB56aqgsXd010lHxuz8fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730364717; c=relaxed/simple;
	bh=keLAsrbqu5wusbLNmVx4so4/6s67Ngs933Swj8QFA3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZQMFIEYILSGAgbAK8mYkkMrrx/YlWT0qiCS3bGxolNZzgsA+mmFBcdPr/tRiFmmiLomAmfXIwukfpvPL7Xo7+4qaSOyfb/1u6IQ3CtfDlrPu2fu0HBaNSuvKT3hTEh5uk4+Ip77o1cWZLCalDSQCJP+1+WVAJp1aTjyrq9Bs5ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=FeloD6aQ; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="FeloD6aQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD22040281
	for <bridge@lists.linux-foundation.org>; Thu, 31 Oct 2024 08:51:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ibwjMEQq3pWR for <bridge@lists.linux-foundation.org>;
 Thu, 31 Oct 2024 08:51:55 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::131; helo=mail-lf1-x131.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4AF104027F
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4AF104027F
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=FeloD6aQ
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4AF104027F
	for <bridge@lists.linux-foundation.org>; Thu, 31 Oct 2024 08:51:54 +0000 (UTC)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-539eb97f26aso683128e87.2
        for <bridge@lists.linux-foundation.org>; Thu, 31 Oct 2024 01:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1730364712; x=1730969512; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LbjI29rEhU99xCQgy89HXzzOvneufGgxKzspf6W7IOs=;
        b=FeloD6aQWWBfN17LVGJhlFPXNY7s8VETxckPrR6DuSo4XpEGOuvr2xK4PCpaVDE4oR
         0+zSRJ+W4kcIBA8gDA2vyIorKBOHEtTpbG40fztOgDTjtXTa2sui2DcTyxRNhTfgYubA
         XVnOi04VD4h6Cl4HQGOHGFS70mwDBHVkjeumxflI6NZPqdpk401Vl1ay4SWQMI+oxNAc
         4Psf7bc4wEzQyMkEfGKcqWPTNMaQ1Hg8IeErhxNfd3x61HSMNcMAxYozF0tyxui4k3jd
         z0HoZrfbOJ9tm8a2wzk0MFeFYAGvXarbY0231huTgflw3WWajAiFa5o8HlgDyI9oZaq3
         APfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730364712; x=1730969512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LbjI29rEhU99xCQgy89HXzzOvneufGgxKzspf6W7IOs=;
        b=W38pOYwjzNkod/NchqU+ScNch93QyuXFvz1bDku4/tShFGL/RmNND2r1Ax8gjjnz5u
         GpT68KBmECEQy/TWgAMyll08otUo4+lmwZIEbVSHrtEHTLjvGzskXENDfN6vveyIEF8C
         URx/c9zI3qg82ADUbwxzYwurT7o9lXMNaRQKF6Tlp/ibjLo3Ul4PcwFyQLvV2UFvjnn/
         1xq4NCfJpiEac5xbh2eHsuzfwCNnvzi1iPl6jysW2nNrWHuRsOXDzFft8fuUCfPESfBS
         IPf9pPkKN6cZaD9IZCp0MykLn9Fj536zrTOX+azyocfLxfEE8JAlR3XAOcAHWQwsjrxr
         QiIw==
X-Forwarded-Encrypted: i=1; AJvYcCUfkeijkMP6e2XxPi2YvU2PekGNEZx+YGApnkzKnTc/JS5f7IxPgCZku8UMgAdK+aBAJ7XlSqc=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yyc2EoHxk8URLVAUAQdqfLR8nnU30Fih8XXvZ6/HvbCrznS+yjZ
	8DwhUBSqaXBPraK5xwfS42uq+NCrg69vbt6MUswDcxWTwU2w3MXIKLByJ+WFoX0=
X-Google-Smtp-Source: AGHT+IE3R0ZFeOqnz66KU1cU1oBGqbRxu7LdsyGachcQjg06jZsCgMepoi5QRHMR4XpCtcrRc6xkqA==
X-Received: by 2002:a05:6512:33c5:b0:539:d428:fbf2 with SMTP id 2adb3069b0e04-53b7ecdebbcmr3857181e87.13.1730364711966;
        Thu, 31 Oct 2024 01:51:51 -0700 (PDT)
Received: from debil.. ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d4b82sm1454565f8f.43.2024.10.31.01.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 01:51:51 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	roopa@nvidia.com,
	dsahern@gmail.com,
	bridge@lists.linux-foundation.org,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH iproute2-next] bridge: add ip/iplink_bridge files to MAINTAINERS
Date: Thu, 31 Oct 2024 10:51:43 +0200
Message-ID: <20241031085143.878433-1-razor@blackwall.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add F line for the ip/iplink_bridge* files to bridge's MAINTAINERS
entry.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b49d69eb2dd..84931abd561d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -30,6 +30,7 @@ M: Roopa Prabhu <roopa@nvidia.com>
 M: Nikolay Aleksandrov <razor@blackwall.org>
 L: bridge@lists.linux-foundation.org (moderated for non-subscribers)
 F: bridge/*
+F: ip/iplink_bridge*
 
 Data Center Bridging - dcb
 M: Petr Machata <me@pmachata.org>
-- 
2.44.0

