Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A210A3DBD5E
	for <bridge@lists.linux.dev>; Tue, 24 Mar 2026 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366247; cv=none; b=aeK5015TDcInTYXhVHV9NVGAHe4l47q0oJki9I2CR/ASJFmYh8bG65njiUbeWjemI2OkJvICNUWMvDimWHeUoMlb4SHMc2bOWnG+gj3quZFNQJ4snvmfNkQ1zmkF3ESzEN3zAw0zP4WepkE0arjqrXKWsXRm4ODf5nYGOT/REgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366247; c=relaxed/simple;
	bh=qAMA6Cx9mPQhYM79N+NXd1PhapKY6/Vo4PUKqwiUNQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuDnwLAMPB+5wiIgqFN7RNquJaxRUgEH58nQISKMgz7q9zOnkZeZhPmrcs+ko3SIKL2Z9QDHsnrmhlrIkL3yK8Xvapy9Z4Sl/fzpafr6PSAbRgJPXWeCfvEX1KDuwr7rtVfySn46kaP01awh6jwXx5dopOwIVrgnhEzA+jju8GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgB72OFh; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgB72OFh"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so2427030eec.1
        for <bridge@lists.linux.dev>; Tue, 24 Mar 2026 08:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774366246; x=1774971046; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a51ClirKzzDenotId8TaR0Ai/wpNXRaf05Y+a91QSjg=;
        b=hgB72OFhkN42wcdTsXDKAOj9anTI6c/N31NcG6f2suU/nJaqppCmhS4ch9oX9bEukH
         mzp89I1cQ4/YSCgL+vFUWmk6C7R6FCDMboxUZ/Z9olE9hThKotea43roeQce6z45F+zi
         XwciZZscyf7PsI7z6v3D07zyguM4aaNOoKUivDGsNHGUTlqSZAI4efVIbunH7tckShMl
         lK4zZuhdszw7URVcXMUepRqai5sNM90ry1oVObzVI75adhH8romTTD6iZRZIZiTbb+h2
         jwWGSGUqJzt7UJyNg7lGJgqCYykyGa6DFfMeQGY+z98ZjnZBonNDTPYT0god23Ub519C
         +Fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774366246; x=1774971046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a51ClirKzzDenotId8TaR0Ai/wpNXRaf05Y+a91QSjg=;
        b=ObqT35E4gIR63VIUradGa6EOSN3QxNpNnIdD2nBIS3jl21OOv9pdHtv1lwEj0c3MuW
         1Bv1ZReyd1kv9SRheEDmhK/5WIms5aafQ01DvkkFpXdWIJTMclHprhcuPos0vD8g/PQb
         +C/80qY/ma/haGhdqDNAP6AhPg6NNVjpUjT7ob8rvHF7eY6n52JprV+XbPHpk5ILFptT
         Um/pFua/W4WPdSqA85m36idHuHQmEIO/j2L+RfDjzvKvZxRmRjSBTeqzs2YH3IJDcR+C
         6ywdI9yhxQwgXCysowJ37PZQjUvBGsLt5ZMP6eT1r/GYexbZ7uRMAKBA6eo8Uu5FEgHw
         Ns7A==
X-Forwarded-Encrypted: i=1; AJvYcCWbadleWZ+MHAFceozLt9Jf2EEt3cr/ZX6V5HogErf/qeEGXr2GB24GBDssVjGtmzaUZaWdhNc=@lists.linux.dev
X-Gm-Message-State: AOJu0YzZms4IB+tKSm2qX+zKAXTkbZ4bh57mDrT+VS2BrVBLHq8eV/4j
	5JB7zNpbBZ+AtgFsVE5sfivy7f9oZ22FjFikPV/Jw2iW8bYjC9E7wWRv
X-Gm-Gg: ATEYQzzve8npU58u9L+CptEQSI0tMlTKvIdW9whSakmaPlubjPA4ULTfev/C1MZ2ZbO
	ahVsadr+xILH8OYxMzn7ZfN+bGF8cb1jxZVQMqkRxu2LMUp29s1m22MpgiPE8zFuXCwiLEvpVp5
	db4/8Bj6/7n5Paw/LN2BAUbscgtCltXH5cq5PzEYEC3INYWg5sPzvaBkZ0CH+GGJ9E+BES8MTsC
	umcFjIaSTnfHRfO/stFiVEfEtFESh5UWkbCDrxBDGORYAgtYpIqm26MpuIwGjTibSDX8KpQ+thc
	1arzaaXA1Sf4cbJcKKiuY1DUzlJf5NRm0LtaNo6Undd5SB+qJO+FV2x/k2q54mY9qMA82VoPDjr
	0ltAiBNWwAIH+IkxH05kDuFKHQ3uscAqnzV3Vyn4ut3RZZTB5iW/d3pz6dLz+alzO9Qj0C9IZ2H
	uNB0JCFsbk6XROoDcFry08cTzI0xs7qokQPykNWnq42shKelrVMGJk0iNRg9okauItweIgrsAp2
	NsQ9JK3
X-Received: by 2002:a05:7023:b82:b0:11b:bf3f:5240 with SMTP id a92af1059eb24-12a726572bcmr8336993c88.9.1774366245659;
        Tue, 24 Mar 2026 08:30:45 -0700 (PDT)
Received: from localhost.localdomain ([38.244.25.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a736b952asm11668865c88.12.2026.03.24.08.30.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Mar 2026 08:30:45 -0700 (PDT)
From: Eric-Terminal <ericterminal@gmail.com>
To: horms@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	Yufan Chen <ericterminal@gmail.com>
Subject: [PATCH v3 1/2] net: bridge: replace deprecated simple_strtoul with kstrtoul
Date: Tue, 24 Mar 2026 23:30:35 +0800
Message-ID: <20260324153036.86901-2-ericterminal@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324153036.86901-1-ericterminal@gmail.com>
References: <20260324153036.86901-1-ericterminal@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272; i=ericterminal@gmail.com; h=from:subject; bh=avaxbwaSm85gGcPuo27n20U2dgBtXUVQ3RMKsRhQtJ4=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWQeWqs1bb9Ey5Gr+x/pKgr3LCp5/vneVZF/CiX2D1l1o ud6rNH17pjIwiDGxWAppshy9/++ublet+Zc5z6cCzOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq GRrpGOgYM3BxCsBUb1jO8FfauSe2uLLf7f8uoStpv5b4bSmct4+HsUC+TVelpqz+Qisjw2yVJXX V/MqyrN9THi1/cTxo87vF2Vahc3gnPZnNb/+LlQkA
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit

From: Yufan Chen <ericterminal@gmail.com>

In brport_store(), switch to kstrtoul() so parse failures and range errors
return standard errno directly before taking the bridge lock.

This removes a deprecated API and improves error reporting consistency.

Signed-off-by: Yufan Chen <ericterminal@gmail.com>
---
v3:
- Split from mixed series into a dedicated net series.
- No functional changes since v2.

 net/bridge/br_sysfs_if.c |  5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 1f57c36a7..cdecc7d12 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -318,7 +318,6 @@ static ssize_t brport_store(struct kobject *kobj,
 	struct net_bridge_port *p = kobj_to_brport(kobj);
 	ssize_t ret = -EINVAL;
 	unsigned long val;
-	char *endp;
 
 	if (!ns_capable(dev_net(p->dev)->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
@@ -339,8 +338,8 @@ static ssize_t brport_store(struct kobject *kobj,
 		spin_unlock_bh(&p->br->lock);
 		kfree(buf_copy);
 	} else if (brport_attr->store) {
-		val = simple_strtoul(buf, &endp, 0);
-		if (endp == buf)
+		ret = kstrtoul(buf, 0, &val);
+		if (ret)
 			goto out_unlock;
 		spin_lock_bh(&p->br->lock);
 		ret = brport_attr->store(p, val);
-- 
2.47.3

