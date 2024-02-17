Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2947FBD7
	for <bridge@lists.linux.dev>; Sat, 17 Feb 2024 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708200793; cv=none; b=Uv07YZkaU4MRiPYFfCGTnkE9w4n0Gn55Nj81PW/3qc0Huk4tWReR+Nz7e8QiUwHOa7wjtXlgPP2qZ084YTogQ535GetkfR9g4TTsgSHireakdvCfkz35F9or7PfbTPavaiwkX4lgd5fJwShPEY7V5B0y783xjdqeaNMOrtl758k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708200793; c=relaxed/simple;
	bh=aQBvQr+Pe+2Gdbn5h+6FJWRS7Wqp35hLnpBo+JrfFcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LBtgU6lWR5tKRbgfMcknZ1OthJ0cRn5Ejav/8jSwZqCeo8RCCcXP8Je9Es8gvgMPTvExG9x/tUd+EwXlkjLFIXcl2dlXVdRiKTK1jR72TT5Tcw/W4xmZG0XBAQiFBRHI512JSJHsqjtz8gwb3cACkDd9JeZ+Cdg/E59EAYSQhsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=UmxpvfAq; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="UmxpvfAq"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e104196e6eso3254533b3a.0
        for <bridge@lists.linux.dev>; Sat, 17 Feb 2024 12:13:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708200791; x=1708805591;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FEuXntwtolyrlm3wbVMT08ww/bg3HU5xRFFUlrOyRbQ=;
        b=GO1rLwasl4ZM7X6WGUQQSO3FA+szLqNPqIpF0Y11+gAxEi0Z5rxTPR/1EMp6CAmCDI
         iA3vb31oRfbWARV1g8hDgfmLB8bptf60op+3Ovw73S6nNRwhZm2u9Kz2wmE1TIPrrCOq
         OdIudqIONi8hUwsK/WX5ZznnL85EAp7qDr7BFC4ktiT71zaMexPL7prz46++9Xoff2Ku
         TruJ4JSbA8d4g6I3aZtRC2nMkWHE+GmKFj991qklAPK8bjH0nvGyPqIpioniiq/pAi8H
         ukQG2dglNWsQccNAKp+W5FowJOnDoyEEuKGkOBFIa9Svcj0hqt2TJx7WR+u+wxGPbTio
         FtoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlPEiYtLrzpeOEeXS7N3ku9esIqGMHWRqODfHd11voD6IrWFBrYbRMc7K0r3wCW2gNranpcjVrNTRJjrGF1Bnn7fOzbCqo
X-Gm-Message-State: AOJu0YxgQHu9B2RE8vEBcDo05t7+oxFtRUYbav3pnhCNd6sMXpl2AuQM
	O/j5ttgqR4S3Y1Gg04GZIInOZQoIjL8LwOY1394F2IP3O4J5bhrT
X-Google-Smtp-Source: AGHT+IE6eFVutf1BYTTUYSRgr8HCyPIsLiQPHnoPhdZoeptC1ac1MJxlH+mBle21JoDut38uXqmsWg==
X-Received: by 2002:aa7:988e:0:b0:6e1:3095:ad9d with SMTP id r14-20020aa7988e000000b006e13095ad9dmr6509095pfl.15.1708200791427;
        Sat, 17 Feb 2024 12:13:11 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id fa42-20020a056a002d2a00b006e1171f258fsm2019454pfb.89.2024.02.17.12.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 12:13:10 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708200789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FEuXntwtolyrlm3wbVMT08ww/bg3HU5xRFFUlrOyRbQ=;
	b=UmxpvfAqarUNkPffy3seTReZz5qMWgi8v3SApdgmR1d9vczN8F5+eoq+4uWMSPnxA4Af57
	djqaNikBLM7JvGpYvAqTgkPkKYnqfCs8bWa7SurWtfxc+2uZ9wDkAI5ixDavGrNrpVtrH1
	SetmFix30f8vyzl8qID7V4ygKmVNcIbJ7Ql12HVsKmpGeyHR5tB1i0QqSjvG4L4CDIYJEy
	xoAJQRyDMDrh0Irqjlkm7HknuMgyU8r2yCYMhKOqzu655ySnR7YYN0qab02enpzw6zechU
	JZac+ksmPQwewiIMeuR7q9PfRXBuYQvrLKFZXgIJoid9MTzWejB5AMU6unjR1Q==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 17 Feb 2024 17:13:27 -0300
Subject: [PATCH 05/12] net: ppp: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-device_cleanup-net-v1-5-1eb31fb689f7@marliere.net>
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
In-Reply-To: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
To: Oliver Neukum <oneukum@suse.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Loic Poulain <loic.poulain@linaro.org>, 
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev, 
 linux-ppp@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=930; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=aQBvQr+Pe+2Gdbn5h+6FJWRS7Wqp35hLnpBo+JrfFcE=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl0RNs2f1g5o/e/BEyd4kl0ZtxijMW2EcQb6nFx
 2kSle2JEJaJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdETbAAKCRDJC4p8Y4ZY
 pikTEACbuU2f2CGOpTmtcYMBYAQ4we2HAl59b7wf7IiC/ErBNVITa5kPdRvcbD/iiBf2w7QAPT9
 gCfs1vJ3mEhkX+lxOKTXdTyu3z2Ta8TlIcc/umZQqMulq2FhTV/429JGz9AMqS6GgB2GZxslU9z
 YV4EcJED89mFqLpMnbrkICBrg7tQor/KpbNnMHsMc5GTqtlAIJdZ6+MHfFUsTgf3TuDymVfydgt
 RDLf1rnGcebKQdL6MfMiucDiVUNKJK6nIvFv+VisZ8v3EBE3tH3Q4FSxnuj3c8kaAgHyg1vo8gZ
 re9kyyPW3Jj4oB62OOcKace4iCsonf2ggVotYHJeAfupENj7sDnoag+g69J4ju63V6d/hsbW6XM
 0KuYQywggRLJ9skWFOg2ZubU3gRFfDVIe9CQIh5HBhCmaTDFn3JZCq3v/3k4h3ISRJTLwuIuMYJ
 DRzo+sbrjAdLVYczG9LLuZUPxgY/LJB2YgBfZAveHStWkiWMoKfAWdVXxPmSayBbKd+HXFIsjS8
 JO3RM0o98BIP5teqd8mxcOwViytpLH1LdnOdmRZ1ENK+ulJk7vKNIDddHC9aqOMA+UND90lyNeB
 Z6XowtvByutULf+ZSv9S8umsPWlCtkV7wVfqW0WzGtNyxMjM+X5VFkCeL9gfYBkM/yZLy0p9gIz
 D/L8xC+Lb0X6CRw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the ppp_type
variable to be a constant structure as well, placing it into read-only
memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/net/ppp/ppp_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 3dd52bf28f15..db1d11ae817b 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1607,7 +1607,7 @@ static const struct net_device_ops ppp_netdev_ops = {
 	.ndo_fill_forward_path = ppp_fill_forward_path,
 };
 
-static struct device_type ppp_type = {
+static const struct device_type ppp_type = {
 	.name = "ppp",
 };
 

-- 
2.43.0

