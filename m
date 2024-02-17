Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758C8004A
	for <bridge@lists.linux.dev>; Sat, 17 Feb 2024 20:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708200796; cv=none; b=lCfcgSgSiOUeiYPorC/F1NgD9ewAjV2tjKs6aL+HyKjowQ2C0OxUEnru2cahw50iov84gJCRfH21z5etUOJpZcM8L/juLuPr+JHyJX5hmAe5ZZ/vgC5TVFoV+365m38UebQ8cj8/fzENkm+WZNLeupAQDkArgbxn1DdI4t+sz/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708200796; c=relaxed/simple;
	bh=YOg8kzVQDwjf4Bq7kKhd7VeOutfQ0nCyul1OGYb2N1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NL9we+zT1b6DLg5HX7Ph1PvqHr927qeHrBCvJcMWYln52wgeckTh4GVOILRsqh7AmR9foLYAlu7ywD678pMB9W69Qm2AQ2Vqt29AqdL1+xVNMPThbwVW9ZbbLRGBYBHQ6fTFOTCzlxoyVWioqEyLiT+Tzo8nDLDPo5Yb6hDT69k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=LvJD02uW; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="LvJD02uW"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5e152c757a5so177919a12.2
        for <bridge@lists.linux.dev>; Sat, 17 Feb 2024 12:13:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708200794; x=1708805594;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCWx4XGyppekyhLkQZEpGjtegnjXjHw0zMannEoZGZM=;
        b=b5cl9RgjMjqkv6Ee0twhUsmR8ErCUxRpxCFWr+QyKF5NKu2GRH63i56xCR/O7DQ9TW
         tfBSxxDTvd52DhQWCMvGXe54ZtqiM1EJQknU2Y0V+TOufwljZvwFA9Pzdy13iq/B1BaN
         Kdww7Kt+UJko9xMew/lFT6dChh9auVyp84bPBiuQXBiGbdv+hpMkqz3+EreeZndaPKQ8
         6+pvAolYQTRf9zPg4fkojgffsHk4rEMB6dcSgnExA3hHPmKnSY00buKwnnfP7He0IBlc
         eqMa/NktIupA5Lp3Cgs7LzkvvXp0BqbzHwUyJEvaMXmtecQ30XVnDw1yZpqR5VqVzE61
         iqYA==
X-Forwarded-Encrypted: i=1; AJvYcCWA2Licd2RVi15A8yJR1ZeqoEBWM996sx4WB+pEF4/oeBZbX98EAR7fTi1yP1I9wxDFMju5/Bd830sSlBK865A7KA2ogAmN
X-Gm-Message-State: AOJu0YznuE4ytUKdeutb5oymao9Lpuvx4zKEgHRs5GIpRK9563OParpM
	MA1uusZt4f57eLdybRDcj+b0+wvko8Sz4E8Bxv1hsoevoE3UdtJn
X-Google-Smtp-Source: AGHT+IE4hSfNSmmELalct0I9YR0J6e+q9Mspk8ruDuaB7ft9GHU35clTQuhdcdisWurlEqC2wsid/A==
X-Received: by 2002:a17:902:7802:b0:1db:c407:c2dd with SMTP id p2-20020a170902780200b001dbc407c2ddmr2001054pll.18.1708200794578;
        Sat, 17 Feb 2024 12:13:14 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ea8400b001da27cbcf60sm1784564plb.236.2024.02.17.12.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 12:13:14 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708200793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCWx4XGyppekyhLkQZEpGjtegnjXjHw0zMannEoZGZM=;
	b=LvJD02uWj3k+Nr08+LjoZQ4U7zHCX5o/x5xf8cTMehEuoendWssKo7jsK3Y3dIbmqY27bO
	HVZwSMo0j8JE1cIHlW+yxmTt/cttr5H/6zkgwZZSJwJSMZVHEPvVfa9kWlVAGOv7nB8Y0l
	/NYIgRISInQs5VMHhYeD748dVhOyZwaK1ksQwbma1qk/BGUgrLkcpRCSu+d8OBDV7L/sS7
	ZAaAkQvOT4VVK6TebZmLAtyTQQE+0w4wZnw325LDS8IRpcMN8oSWvESk16yz6aTozA6APA
	nvw8LlQvlNe23sOWVmii54uxj8rJ+JL7Rocsd+1BuJRkPaIz4LZxTXCbVrBjoQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 17 Feb 2024 17:13:28 -0300
Subject: [PATCH 06/12] net: geneve: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-device_cleanup-net-v1-6-1eb31fb689f7@marliere.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=909; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=YOg8kzVQDwjf4Bq7kKhd7VeOutfQ0nCyul1OGYb2N1k=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl0RNsrHlscC/Pn9bzC2NTQXqUj6ySs9nByifKi
 Ccg3q013BKJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdETbAAKCRDJC4p8Y4ZY
 piy+EAChCqwWchqM6ZpXCLcRkuV6P3qJl4sCOXUzQ4bhSoNfWUXQiTyMHFwVnEdNFKRDIaKYeYk
 U5iUFdSNy5AtfAslyF/33sONfDbXEw6rC03PEWcuUW6mOl4xSuqnY7zqoKkFd86g9Yb8vVdqmUs
 TeFGPKd0qrUT0WpJQJI3XJ9wf4QLnkwJ9EQzUfai8SCDzKmQf7H3MS0FdUxdzDy6djgYRm1MZ0r
 4Mv2WDB6N4uDnxkizopad3qg+jKPVNDMAXRh9/Nh10Wx6azjN26ZrPIhkCinLObvpv1TFppx4Ly
 DTsGFIEvwLHORp6rBzzLC4z1+zzCf2vj7eXO5D3WIsMjHp1+xx0Bm2MvnHIOoJsp71P0Mu3a6ZZ
 4vPNQujw7d9a8rGJqTOUwaeaamj94SpFMjRn4rDeItrOGVVsw3fwqS9Sz61NqVS33XgkLykI8sm
 AwASMJSANRsleN1X3J9+o5mgSCMgMu1GmolcH1rEaXwYuO6wcbieCos8jnyWB/3LsOpZiEbALfX
 dzgiJiAicO2OW2TpD7s9UitbToW9uTUECq4SDHa8pAcvkVtGY+ELdfqVfUZ3LQU9DrSgIy+qiV2
 yryHWLG2/fQTBIraubqEub3LrZW4PVmCQ7AzimX/Aon0FL5NAcqIar65NMJq3GKN7gqoJoQRwKL
 +uVTULqhpNK+LmQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the geneve_type
variable to be a constant structure as well, placing it into read-only
memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/net/geneve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 256602a72356..6f3f9b446b1d 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1142,7 +1142,7 @@ static const struct ethtool_ops geneve_ethtool_ops = {
 };
 
 /* Info for udev, that this is a virtual tunnel endpoint */
-static struct device_type geneve_type = {
+static const struct device_type geneve_type = {
 	.name = "geneve",
 };
 

-- 
2.43.0

