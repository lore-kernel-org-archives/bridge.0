Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644EC3E95BF
	for <bridge@lists.linux.dev>; Tue,  5 May 2026 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967263; cv=none; b=DsGYqEycNoIqM9i1ke0QOWTMyv9OSSy4lbWqUsjoQEMaE7goJRszjmm3xuJ+ntvLCrbo8dflw3oku6GAlpbo2JwNnHXFLaLy0c6UeDtzRi9pHoknhT8TSYX9PmwyAwxASq0rvBFoWn+FtofzQRJrAqJ94oOFxXPjNupqzCY+5ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967263; c=relaxed/simple;
	bh=YHsc3xQ1QDh3wysRC+94d47hYC5ygS3eQHirSNAVcO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AeuJGincesnQNYOhLnvs4Z/DX7KhaosN1TjcBy339HIGv6ea2n/BdYLnX3e6CmBKWpxi1uVorUKI5JjcEmXdNx2nJgqPAy3eHJwt20vhiBUq3kBdKeVDN9zYZdUWRh62ZdSH5LWZ9epdusmZ2duaFP7WkKrDstxtoUAtZH/wHBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWChY3rK; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWChY3rK"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so1639417a12.0
        for <bridge@lists.linux.dev>; Tue, 05 May 2026 00:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777967262; x=1778572062; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jrXH8YnPwNKHXnbJs+WEopyj0kRSAn4kPV0vpzyDE5Y=;
        b=VWChY3rKevqdLS/IHj583YTXPYCLr3zH9MM6iUA95mT2DKXaOdvFUnZhYdzS948Rlc
         XaEE/wJd2q1pd1668yHnjl4XM5yfjpTlNretTGwg2oeMCdksmwAbYZZMqcpArMm/WezO
         GHlr0HAo53y4/i101MXmD+oUWlA0lZbIeFo0Ixbj55FvCv/qRkRezy9q/rfzSMBiO2QC
         sqaOQ1Eg5ZeTtbPNmVGnQ1mA/lSvXVsauWxqep0WVmHicVmsDoTrXzWRyuc61w0ZPB0P
         pe5TXNlD8M47T6rQmk6u0Vs3RX8Rv94iyDysaQBV8cEXrcvzYdt67Hv/QAVq6cDo/F/I
         WOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967262; x=1778572062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrXH8YnPwNKHXnbJs+WEopyj0kRSAn4kPV0vpzyDE5Y=;
        b=k/gIz5apit4CHyt8kxp3iGR8FiR88AJwg48VmfVX5p9a26icfnQWb3FeLfx9xlDA4y
         IgJuLSKOfXboJrabFXDlT7qB/56yNFYy8yn/s/73iKByEB5CfTut6SYxSi4jUZa5CA4z
         lReAjU/pX65XNnUR08Pof12POnpiouY5y4dWm/tHcGCU06/3NUkveXT91oIblHVA/KgK
         ipvmfQDAgUBbTQ5LGv/yIV2AR07yKdewf4z0BGgsBgYS+yBON9WW85bMMe7gRiyJqiFR
         6G+1EC+g230xln6GsjJYKGeSoQihkCjd9JqGX8KeLyvn5K9+h5z14l66pH4hUPxIPON+
         lz+A==
X-Forwarded-Encrypted: i=1; AFNElJ/12FkD2YreE5XzGvqZeK13qmgaa2/LoCBkmA8iMFw6C/m9CB7XOpqMpyUoLeNlk+0GaoQiPvk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzcg4y7MMUrP1VvABjyHXNR/Cb9c4DZM2H2gAC5rlnuiYpiiMAa
	D9MY7SbWQAku0qWZ/Q748rJnqTBCSXX12qKTDiwukBDFyaNohwnKKY8i
X-Gm-Gg: AeBDievL5vRz1v1SX1I1GXv0i4k2ovNYKSqGUUS58yt++jXBjXlUYMw7w4aYm/Zca6C
	JcHjlwBO2yrQHGLt9gCP7mtKSvA4XiJ3lH6JjJ+wQ/5hwUMEj6uW/ZS9jduGlo9aVa5Gh83prLg
	aUuCimeUGqw9NknfbNXS65FfVMOe12aDLIU+CKShvifWwBUntwx07krifP40K3k1jwNsxN0jzwp
	Wb8UC3ZygZBuKua8ZM0wprd8VR0p/TiecG04vlKjoy5SxQdcffzdZj245pRv34KqlhTyqYr03jj
	il6FmFL0Lhd1dHAAUWtqOBI1H1ccHkpgaDONQKpsjMGEhvA42s3StWagV7Quot50NlcanAsvN/a
	VC6XxHbjjALT4xffdIk9Z2dCdi8ks89/rFhQ1GPymWIY0IdSGL8HORPtf+ji+YMrfQmn++8LHxy
	P6E0Ufk+32lpSxC/fH5PcwBOESpCCUY7Jzqg+bJk4eqbRdRFRAwz31cuoEgBIOVRiuhgDHEIrYr
	Gonj4I=
X-Received: by 2002:a05:6a20:3944:b0:3a2:bd1d:d67c with SMTP id adf61e73a8af0-3a7f1f1faa1mr13682082637.46.1777967261529;
        Tue, 05 May 2026 00:47:41 -0700 (PDT)
Received: from arch.lan ([2409:40e1:3007:cefc:472f:1ad7:13a6:92d7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbca2c49sm11833960a12.26.2026.05.05.00.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:47:40 -0700 (PDT)
From: Aadarsh Chandra <aadarsh.official.xz@gmail.com>
To: razor@blackwall.org,
	idosch@nvidia.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Aadarsh Chandra <aadarsh.official.xz@gmail.com>
Subject: [PATCH net-next v2] net: bridge: replace simple_strtoul with kstrtoul
Date: Tue,  5 May 2026 13:15:15 +0530
Message-ID: <20260505074515.636244-1-aadarsh.official.xz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The simple_strtoul() function is deprecated. It does not handle
errors or overflows correctly. Replace it with kstrtoul() in
brport_store() to ensure that invalid user input is caught and
returned as an error.

v2: target net-next and simplify by reusing the ret variable as
    suggested by Nikolay Aleksandrov.

Signed-off-by: Aadarsh Chandra <aadarsh.official.xz@gmail.com>
---
 net/bridge/br_sysfs_if.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 1f57c36a7fc0..cdecc7d1260c 100644
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
2.54.0

