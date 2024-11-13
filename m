Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1672B1DF25E
	for <bridge@lists.linux.dev>; Wed, 13 Nov 2024 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502683; cv=none; b=hTwXXJ/BmkAziKWU3O3cyvWD0ce6+sdn0VdJdx0L/HNS6reENepZ+etrWyJ/HPplQszdfKNiWtn/ggx6QVuKBylac3BvGdmzSuNKKNVAVzj80P/PDXgukbPUFaI5fg3bzMnTQ5BLbLQyjHHZiVrHx9jatKhc2S47aXsq77WAuf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502683; c=relaxed/simple;
	bh=LFiCqhXlvihNQqIohXypmeWbbfe7D5PEOM7sD6uUzcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6R81cvxO4o9Ux5rHUPZP5bHdexqSLat3PEsPu/4Fh2u42nN05rMkW8hEoWzDmKhglNNUP6RzUBTHlpCDkc0nUdQH+5HEhwIahYvhUk0RUe8mmmK25pYSBamYT9yR0o6ecIfgH/w1HlVSWtB8UoWD8DzRtVjI3izbru43W0r9HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2Tt8zIo; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2Tt8zIo"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2ad9825a7so5287512a91.0
        for <bridge@lists.linux.dev>; Wed, 13 Nov 2024 04:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731502681; x=1732107481; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r30qTLZF8ANhBKyxqq0VyimbMaQgwK/VTM3BE1AEUlA=;
        b=W2Tt8zIoxUto/p8229mwMJ7ZH1u7s1fRqOglqSqmdOXFvOsifQkRxShGJcMtNEckdZ
         mEJYMI2KIDzbu8KOty30hnU6HhhPgL705Zj8rf8SL5AzWkacu72HmQ3Tc1LhBadDv/59
         2+OsoVMkyHf1Wxs27jdOkBmnBp50fPmTPop1ECqCnLyju48DhhgEXKrblfx7Jhi6STdH
         d0MqlWkOFuffdm1EmzuFRhz0GTCH7zDwR17rQLYcI2onFY69RvkB6kqH3k5yoGHxQLDQ
         UcPwMY6pj7sd3plfnttCLKG9OHplV+a7m3WTVr1ZYB1bbx+ZBONydIvn7deeEUuZ4vqx
         HscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502681; x=1732107481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r30qTLZF8ANhBKyxqq0VyimbMaQgwK/VTM3BE1AEUlA=;
        b=puQwL2gd7fBL+7FQz3kC3a+Kb1m+klSi1kPYUK9EiLzKdgRQ2koftzUesg2MFrN1HK
         kPU++OvoX2scJ44c7lAy1ePkxsXAJosAoPI+x86vWC31aQe8/M7LnuJDiOCRLC/4Xcvz
         5bNeh6Yl5wsPxgFzDSlEfsIlhufwVebjXjniwuKtV7e2VIANWvi4+WcnVqGnbNBZ529H
         frQuvURzcS1UTkWX7yQlQoNACKC/fC5qJa4ERrWGlzGSXDRqlICJHrTY/WRltmLX1sbw
         DDvuECvMHBcEXbp5hAyNWS1T5qAiCfPd0nTecpTlMBxTVF/KTk5SCtXDwYUZra0H7JK4
         YzGw==
X-Forwarded-Encrypted: i=1; AJvYcCXGaA75R2kYYMUTFyTMNVpmjAJ9VSDNdARiIXgKOARMxiNxIyI4auXydYZlrXK5eZqJwYs+iRQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzmu+IRwjcYLUrspMzDluZD8cC4mQeL07P19bn6aroqepaeSDlr
	PqC5znsAtzVDQ96+sHes7NX+gSXyyH3GqPFLk2z6qizKm4GKcF97
X-Google-Smtp-Source: AGHT+IGHbWu6TztKh6tN8Sp6Cv2pF+0T1uVgEKu2tiVbycxbLB+U4mJhCEtmHq5ke3dUIYABcOdsZA==
X-Received: by 2002:a17:90b:3907:b0:2c9:df1c:4a58 with SMTP id 98e67ed59e1d1-2e9b177fdcdmr24476632a91.23.1731502681391;
        Wed, 13 Nov 2024 04:58:01 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3f8ed0esm1398632a91.40.2024.11.13.04.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:58:00 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-can@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org,
	bpf@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	wireguard@lists.zx2c4.com,
	linux-wireless@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	bridge@lists.linux.dev,
	linux-wpan@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 3/6] rtnetlink: Lookup device in target netns when creating link
Date: Wed, 13 Nov 2024 20:57:12 +0800
Message-ID: <20241113125715.150201-4-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113125715.150201-1-shaw.leon@gmail.com>
References: <20241113125715.150201-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When creating link, lookup for existing device in target net namespace
instead of current one.
For example, two links created by:

  # ip link add dummy1 type dummy
  # ip link add netns ns1 dummy1 type dummy

should have no conflict since they are in different namespaces.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/core/rtnetlink.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 327fa4957929..f573ace60234 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3846,20 +3846,26 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 {
 	struct nlattr ** const tb = tbs->tb;
 	struct net *net = sock_net(skb->sk);
+	struct net *device_net;
 	struct net_device *dev;
 	struct ifinfomsg *ifm;
 	bool link_specified;
 
+	/* When creating, lookup for existing device in target net namespace */
+	device_net = (nlh->nlmsg_flags & NLM_F_CREATE) &&
+		     (nlh->nlmsg_flags & NLM_F_EXCL) ?
+		     tgt_net : net;
+
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index > 0) {
 		link_specified = true;
-		dev = __dev_get_by_index(net, ifm->ifi_index);
+		dev = __dev_get_by_index(device_net, ifm->ifi_index);
 	} else if (ifm->ifi_index < 0) {
 		NL_SET_ERR_MSG(extack, "ifindex can't be negative");
 		return -EINVAL;
 	} else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME]) {
 		link_specified = true;
-		dev = rtnl_dev_get(net, tb);
+		dev = rtnl_dev_get(device_net, tb);
 	} else {
 		link_specified = false;
 		dev = NULL;
-- 
2.47.0

