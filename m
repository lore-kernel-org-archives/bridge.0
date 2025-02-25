Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063E5215780
	for <bridge@lists.linux.dev>; Tue, 25 Feb 2025 20:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514600; cv=none; b=qpB40y8+m7TK7++RYmgaqhWaYYrr0giV9aAhiwGlz0TYoMTpcrwPXEWJhVivB9CzdJ1ie0KEziixsxbAcXlwW7qnRU8UyEt5Iar8h0vvPHgYXabWCef6dObuvIZii3j+vbpKNlQLNUWInEg/jFPg4sr3B/rzd1WimP90l3HHL6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514600; c=relaxed/simple;
	bh=Xf5mlATXYp8EYoXU9a3w+XGI157o2p4WZAmB5ikh7tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHlRWPL9oH0HRMo46cJrUky2fjT200/sbaZ5v+FresfXa5aOj1LEby839CLH7yAQnydU3iVHava+5U7Y3/LA37o6nO6dtaZGAqTSyKVIQmOJaJVrsevEiTe0Arr1nFOcv7dpgno37ojbigM9J+xTXySgyB+8Eri8SPlHyJSpiVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmnC6Y40; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmnC6Y40"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abba1b74586so882281466b.2
        for <bridge@lists.linux.dev>; Tue, 25 Feb 2025 12:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740514597; x=1741119397; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNvAyhAv6GepxNEYkCskllQBVi38mrCeZ4SsbbR7WSY=;
        b=VmnC6Y40onJ+/MJ+GUeSMqpm5PgVfpIz8kFL0gmJCQfrQoTrWgpsGdQRSzLbgHL8E7
         kxlfUsAT/WIygtqWnPN0/CifnYp55Cwvt1NQKrvObnoR4zbCuzAkVj1+DP3iydeQGQsS
         I+JGiG+B8rq8+zdmWC9q62Ar8xGWNYnL+8ZeWA53xPf7ekt9dIfwA8CT2JdmrHhjsAtD
         SOA03smwEWpNIG1QJ/tzAi4kHuVxv8yh1JlU/7wwbgQKHqZ+PSFIDYpgb3Dz5+bYwr3i
         QJS/8ryNiFUulukucA4k+DBZrwdWybXwdEPR02Nky7pmx28HyvFbwsWqJVLCwNQ2zeK4
         7cWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740514597; x=1741119397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNvAyhAv6GepxNEYkCskllQBVi38mrCeZ4SsbbR7WSY=;
        b=mNjlG0ojA4earE0f0dGPlNVONYHu3+I1GeYwiw8Fssljr/3KyCetpeldMMZwvaX4OH
         qezj+yY8WUR1L8+n6HgOPMDwdhvVLhJ6WmIakexCtA28DcL04f4vu8xYHWjHidVsuGPk
         jY5sYTegejBOpXEMsLM4PuY+wSi+k18DZ8B49UYyJ4WqPZPEXxwfgFjql9reGTYDeCpy
         08+L7LrSGmLFYGSFR30e6rqabgGHdRkr01lsFPkWQicXrgQ4c5kR+I42OvDLuZwJbOsm
         mSHo7hLPlQa1XX3QdcSygS+2EwObBxjGareCY8Wq19Ls7xtqos+Ljief0c7a9psUKG4y
         tE2g==
X-Forwarded-Encrypted: i=1; AJvYcCX0ke+37IPs7QHx1nKm5NP+U7FAfENryvCjy2NCrsXbjfF0Sxt3/KlxHfPs5igThfvesYrYWBk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9H7SPdGnH1aQDJuf7HrRz2xbMYEKbzhfy48mPtty34N9IsLqS
	8Ax5OAZdxXIJVKbiEiIG5BJMXSR5qO+hGF0IJzL6+0w6OqE+nfh7
X-Gm-Gg: ASbGncs29Q8mn/1gikofzTFhmiskttDUDWDkd9TWiI7+QWO5YCRu31z3R1B5WQ/2jv5
	W0zhd/ROxRV8fGDMMMU7IBt72SMExkovHJA7zK6WFnHC+O9rPQ/sJZABKv/ZvvR7nLPMiB2ELa1
	ZR/WPQgsOs3C5i42B9Ki9Z4qCr6S64QhmQgh3AwznulfzT1b2qCWkyo9kG5+FXT8M8DSRYMwdfS
	7lnyRwFqqafuYhYd6K5WEfHSTlxMnDiHu1aBWWnegGH72J96vz0e37gKbYzZjm+UUub3D65uOIT
	TgRnRX0BaBhPg7Qnt0J+qEOcwsCBfrjmG2icfwYEDsh4I392zgiBeH3t8+0Ut5UuHqwdDtBclIF
	IJOg6RUbpNwx61vZrPv/HQ8Spd1TsVlfOYXXgrP+SU/s=
X-Google-Smtp-Source: AGHT+IGxUdijvIUHSsavOxjOEGtqnGWOKkNqobQSxe06Fq+xOGdhhx0QApPI1c+j5z6WHzO8JVwaLA==
X-Received: by 2002:a17:907:1ca4:b0:ab6:d575:9540 with SMTP id a640c23a62f3a-abed1076c86mr522925566b.50.1740514597100;
        Tue, 25 Feb 2025 12:16:37 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed201218fsm194319666b.104.2025.02.25.12.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:16:36 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v7 net-next 10/14] netfilter: nft_flow_offload: Add DEV_PATH_MTK_WDMA to nft_dev_path_info()
Date: Tue, 25 Feb 2025 21:16:12 +0100
Message-ID: <20250225201616.21114-11-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250225201616.21114-1-ericwouds@gmail.com>
References: <20250225201616.21114-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of using mediatek wireless, in nft_dev_fill_forward_path(), the
forward path is filled, ending with mediatek wlan1.

Because DEV_PATH_MTK_WDMA is unknown inside nft_dev_path_info() it returns
with info.indev = NULL. Then nft_dev_forward_path() returns without
setting the direct transmit parameters.

This results in a neighbor transmit, and direct transmit not possible.
But we want to use it for flow between bridged interfaces.

So this patch adds DEV_PATH_MTK_WDMA to nft_dev_path_info() and makes
direct transmission possible.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_flow_offload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 323c531c7046..b9e6d9e6df66 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -105,6 +105,7 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 		switch (path->type) {
 		case DEV_PATH_ETHERNET:
 		case DEV_PATH_DSA:
+		case DEV_PATH_MTK_WDMA:
 		case DEV_PATH_VLAN:
 		case DEV_PATH_PPPOE:
 			info->indev = path->dev;
@@ -117,6 +118,10 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 				i = stack->num_paths;
 				break;
 			}
+			if (path->type == DEV_PATH_MTK_WDMA) {
+				i = stack->num_paths;
+				break;
+			}
 
 			/* DEV_PATH_VLAN and DEV_PATH_PPPOE */
 			if (info->num_encaps >= NF_FLOW_TABLE_ENCAP_MAX) {
-- 
2.47.1

