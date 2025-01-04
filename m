Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061EC15E5C2
	for <bridge@lists.linux.dev>; Sat,  4 Jan 2025 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735995476; cv=none; b=OjxXaTTg5LX31EsdSjoQ8KCAxnun6FEJOvELjT/EwhueFOIgOSLTEwLvz74oRCUsnh22Wx4FVtNMwmDl6sIO2oWQPQ9wYnVvtEKitM/ulf51Jo6AfFLYRtaBdRIMsCovOtG4/toMIOj+4XAVHTvpYnZQkfKzl+S+BzByYCYswFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735995476; c=relaxed/simple;
	bh=CIC06w4e2E1VMUFcW91Xc/7RxK+9Sh2l/b7I4i1q96g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9irCTenaqwCFLdOF5O6e+DQZuGMJKFrT5816FGanbho1txTskw4hHk57Pb1wbop0xqTU+ETZiB+CQ2kPyAGyA5qQ0ZXvJ5x9JwXt+XSEgvVKTO+8xPcJwuRCo+8sUjNtp1RdbSzZLC/yN9uYxs27IdI7mD12A781F5FLEAHCTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5J2l6cW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5J2l6cW"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21636268e43so102783745ad.2
        for <bridge@lists.linux.dev>; Sat, 04 Jan 2025 04:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995474; x=1736600274; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0y9nB6XisXA1oDe7UDcZLSsAyAYhl+7T93j9PgZqLs=;
        b=X5J2l6cWiEdzBOyVSA21dt1XSd32zlvu/s4jdKcM+qFhQdEnyAJjBN6C/xXUXmwKJj
         3cU16Re/VHTt0sXHFBaEvKiMdO5h4HwTSd5k29iFKDexpqXrdvWuEnfcpGjWseOXFNvj
         xIdj1TM9vCYroI1Zf9cH74HZVh9z6n1yZlq1q7p4TuzduBCfLyLw7oBEde6oPI+xfeOF
         alckW7us9RhNfYE6R6L8zn00ym+2meiim5WF5DB+9XlCJbTZf6h9ehcx7RXv/6F3y7OM
         B/0/HeeRj+20N2G+L4Zb8pVJuDccoPmYu2qFR0Sp4IbSh4YmYZPAhQ1ZvZSvXgjE8Dye
         aY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995474; x=1736600274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0y9nB6XisXA1oDe7UDcZLSsAyAYhl+7T93j9PgZqLs=;
        b=IdT/psmjC/g72QDiPsA9Sct5ocrWGOmrRDKx6eY+xiJg4PuIDj5TUpkNOSv3sV9/LZ
         5lqM06sT83umc4QQxqDmVbR5A2nKsFFlCjyGrs+9rtoZvrXCcZyPh7jM5e+1+ymVVCna
         qa0WTgSv/z6A7AI+Vd1FhZmw2dshdxT1Gf90MMttx4PcnwHKOsjy8Lw6A+Zn5KE1s3XD
         7+gVpI1D2ekMNcO8UacF4GsFO9PyplEe3o8omzC/S0wynPTZAbOeagCA3idlDycnxsuQ
         ttBnBRZfkCabKskjAAg14mBcOem7vqfJpbbaCUSWMy6R9DIMf3f6kHKmsBYE8J6DEnH1
         mVlg==
X-Forwarded-Encrypted: i=1; AJvYcCU/Wf7W3ADFZdJtPkamuBlFEkDoMV4+QEdxcXS2OAmynb3L/ABUEp/C5/PvvUMEmSbmoKonrHw=@lists.linux.dev
X-Gm-Message-State: AOJu0YxKnm0LygoOIFUedQDH0gTm9O8qRy+KB3Gm6kXZIRcWUxyDnlWv
	vJukNa5gGl6U0BSy4o9NL0DFlLA+W2CLtjgi0XtX4a5q7M/fVRAB
X-Gm-Gg: ASbGnctWoEnAuJYgipa3oSxteafpdolnk3ekzQ9HDrJF+UGVXk6w7Y2tl78VoRAVtt6
	1PB3qmjiJXmpocQi/J4Y7XGckzVJq5yLeHP5Iqhd/hD/lepLFdwxhBVxiTJrQCtIFGWor3EZAG8
	Iv1s9L3DxhepuYcFiWfqVP8dkLy+mIc4IVWH0IEPir47IGN7PRAhhbI62K92UCA0LtfE22zP61B
	vKhp0F+Mwjfu5Q5osB9g3knrWHRyZEd2F4FMSu1ShkZe+Y=
X-Google-Smtp-Source: AGHT+IFUA9yMRsjxfnRxzsse9+CSmxwl7XAkA4eYuGkgQjijZt7M7pM04aasIYGaynTW3Vzrs9d/kg==
X-Received: by 2002:a05:6a00:22c2:b0:725:ef4b:de33 with SMTP id d2e1a72fcca58-72abdbe4de8mr66912486b3a.0.1735995474274;
        Sat, 04 Jan 2025 04:57:54 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:57:53 -0800 (PST)
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
Subject: [PATCH net-next v7 01/11] rtnetlink: Lookup device in target netns when creating link
Date: Sat,  4 Jan 2025 20:57:22 +0800
Message-ID: <20250104125732.17335-2-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104125732.17335-1-shaw.leon@gmail.com>
References: <20250104125732.17335-1-shaw.leon@gmail.com>
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
index 6b745096809d..f65bd49da541 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3852,20 +3852,26 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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

