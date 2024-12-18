Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7E21BEF78
	for <bridge@lists.linux.dev>; Wed, 18 Dec 2024 13:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527375; cv=none; b=r4Mh3Km0CRk5Oo8ub7t+QXjEjpLzknx76PQ2d/YPRfdZqFV+LDHKjrB3VhM4Lpu6ypbg6pHPbTFivAce0ccYiIf876S33jwjr+LPmiU6JHwM373ZNkJneyYspQ/3tLdc8DofkZTn9uiqhnETWSe95UUZeGRbheZjcd2KQXk8mvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527375; c=relaxed/simple;
	bh=Egm70QFHoPJQeKbJRemzVe3pKzsMp6lZRsVFCxj3tAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=meiLWGGmjayuW3ELdlfVu0oBZIhD/o1wWchOI7TZX4fmXb9ce79I1MNUENv91FHloqPhec68mJXTu5olg1GS/Tm7lLIUtpVwXxavQ1Zok46dVTf5YtRvmtJF06pXDqsBr1z++66qKYi4lXZI0F16/UDQL6tyCUlAwKqr/8dswi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrZv8oz5; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrZv8oz5"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so4758289a12.0
        for <bridge@lists.linux.dev>; Wed, 18 Dec 2024 05:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734527373; x=1735132173; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqBeWHkwlk4K5tQfUbZueoC1cX5zOkU9dpB02VEAE+k=;
        b=ZrZv8oz5ZFslOHqAJb2y7DU9fvmJpbAAX0ecjMwc2N81CJfvQV7MQpfRFJIDAPpW/V
         T7j6Q7QaDEbTL2dNdbdKl9ojrbGW4arxr8+vezrWO/o4CE5hK1L6yAGY3rf1rD4uDZDU
         MZ+5a+sBKWMEBsbZeD0Y9tF0FBwQ1pYU3uu9MH0NfIdhXEQNEkYd8AmM15Q4c6UfjMQc
         A/u5PpuawjtClkn629K7B2GVTRIYV6++oeDaDMS1vWby4JAxbpyYmx55IzVn65efIe3d
         ssGrsZSUv9R6Yqa0y9W7EWrM6r73o470Pdwo4NjiQ2m7BUEY6OY3TL8Sm4AFdgox0ZR1
         L3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527373; x=1735132173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqBeWHkwlk4K5tQfUbZueoC1cX5zOkU9dpB02VEAE+k=;
        b=wAeMz2ZeqsPuy8pOdLqPq1U9OgY11Kfmc/RZXgIZDeZHGyd50qaLyRnmszUIxoOZA8
         rnV4rjgS+50BibwWiWIsbQpYXhgYeOC8EhxV18yy5aBM9UUQ0xRLtgHjhQb6rq4SrOkd
         Z21OLD3PGULgZ18zoDNreMvT3nP3oZEPNXA1qzqP0bMBExr+Ly0KqCPbunmno702PuNd
         e8EZo+s+YubOh1lvNqgWZXodwIXnTYnw/517ONqbczEGB7bxtOIr77y1n0t9Ikio5Nvm
         OGb3A6AbputiEPSA9dMIJudOegVzErfH2GfUXmcKAIyIXs54JsRSLPkYiz2lDewsZ3Pc
         KeCA==
X-Forwarded-Encrypted: i=1; AJvYcCXeXDC0mq6kNsspVp99G2tnzQF45HTLmTzHdRqV+xHwruNoSxm+/DvxYVfN3CPH8ToFl70hy5M=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3HIRKAWAWGd5Gp6/OnvWh9i6Ic13AsUzMLbD2SY5GUuqY+kkA
	iLMtlcBmsF+XLN7t8/eUUFZngU05dYiiKNO94uMNwClA2vd0IONd
X-Gm-Gg: ASbGnctascn+/cfR8lqm5JAWAf5gIq7bLyObSOt4e+FPkqDEfq57PRiim132dAKinQ9
	eUBVgSGdWKloVarbzS/qM0LkKQ4S69JAhD7y/9e5psYoG3ObysY4dk4pamdmbIdulMblsH0bFuH
	8kZD44USOw8vWphx40KsjW30jekCRKCoNliIjXacqVvQTVnJyixE3LvH7wd/F3XEtQGm0pNVAC6
	tLl/plWGOi1QO6IM9+EgJwX3FZejwEYAPbHg3PwuPgDfvk=
X-Google-Smtp-Source: AGHT+IGwupxRC65MgCyutia2fH86BtEscvZ3hC19otgxhx9O+M/gNgTyzVuSwrO7sHgcHk/UbitTJA==
X-Received: by 2002:a17:90b:5490:b0:2ee:48bf:7dc9 with SMTP id 98e67ed59e1d1-2f2e91f1112mr4682540a91.15.1734527372952;
        Wed, 18 Dec 2024 05:09:32 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c0f59asm7434754a12.67.2024.12.18.05.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:09:32 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
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
Subject: [PATCH net-next v6 01/11] rtnetlink: Lookup device in target netns when creating link
Date: Wed, 18 Dec 2024 21:08:59 +0800
Message-ID: <20241218130909.2173-2-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218130909.2173-1-shaw.leon@gmail.com>
References: <20241218130909.2173-1-shaw.leon@gmail.com>
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
index d9e363d9fa31..6a2fa030c8e0 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3851,20 +3851,26 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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
2.47.1

