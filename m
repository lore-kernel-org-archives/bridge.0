Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B3B1E51EE
	for <bridge@lists.linux.dev>; Wed, 19 Feb 2025 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969465; cv=none; b=mcNGt7GM12Y/cFW2p6AXlB+Q8OiVTcV14nSt2b+iovmqmKZQyz9+PmS2Ra0k71C6jl3jI6+fmVsXesptXHgCEnPjga9HfMmSmoV9NWB8LVNashD3PFA7kz6PNTfwSaxLQ1mR718L8OH2AHL6Pp7WfBRj0tnNcoidH1HuOr0eJy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969465; c=relaxed/simple;
	bh=PbUXwb75wlN+Ai+ym+Xm59yi3YKBtBMlSAHxh5phdAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYyVQJ6Dj98Z1a4lYjrSkuJERU29X9ekkkQGDW0J3t6uqZqkTEej7a6KOKK7CsCone4K8Bx/LOwnh+UIbFNRvWB53pl3hI8wlQ5Q8rkr/1tMX4tO2WUg3hv7jqVEAbdViecaRTqr1dqaL/lIchHtCSKqmNngCL0mmspfmggp6tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLv5nTlb; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLv5nTlb"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220e83d65e5so108263095ad.1
        for <bridge@lists.linux.dev>; Wed, 19 Feb 2025 04:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969463; x=1740574263; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUZVG0cQpX36tsrgh/ArNurrF9hV9SVnXTfgFQUKvso=;
        b=gLv5nTlb3Fa2q4MH/cZAXf02NEpzd4kFe6BxozopkM3oTYsibJcMzRmYxBKvr4fQ7M
         IS3YzYa2Kk95y1xq0xcy/gtsBmtIx1BTif7dV2fjTx1SnaalaVnVfN/SggniHiBVTPT7
         lXki5B83PZQ46RMkkzHzo+oVHVYc0GbRwxO6Ee4eM60crqt96BC20+TYnq+vkm6bayJ+
         eepGd9mkSj8UiCpI9PTEAnT09K7/iYH/CW9LUPcjbu+2t1f7KINjmMHnlaR+bspSOwi4
         lcSDJNQpEgquqv2CRXsLnux5e+L6QjoNShqVaV8bxy86Tr2EGHVIWrvpdMQ/ZCsA9hG3
         cZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969463; x=1740574263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUZVG0cQpX36tsrgh/ArNurrF9hV9SVnXTfgFQUKvso=;
        b=ghW6j9tMv+GvNYMjlULAL5iG46iVGtN/U9/yvuAbB2+s1QDwWAa5Qsn9lX2+T+1dI+
         UzMCW8G4+dPNCxt/WUDC0FIrs9KdSZmWxKrXDkBEriemyTDZU0pUys8HOEJ4EIKy3+FW
         bD4avJSDoEReXciKz9o0lNJLqzUYm181WfQ8Q/QayM7SWUZ/1dvXTt+43nomqXVzXcBT
         dTYrBhe5KFIxf18iht0phpcmPfh3tR220n1lxEWgEwmtxws2aGJl6997f/tXRaQYNaDY
         WYFyf8Ki/jQAwdGrzkLYV2O/pG+sqPi103bea5HTyqam0p0roM2Doy3UssFsgA3GdUPt
         WNLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGJg4IEpCZe9IzRg98NcXYPot4nO5S2upzHfuCxT5iz7u55BGp7cevMrH/nn+pTk9FO+sjvZw=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4fXuSqgsw1T1bAPOkPER1wk5WW5t2NDxXexwAGYy7+UMzV/7F
	+Sy5Ea5TA6ytB+EFMGvKAxOQBrGCutIOIVdzFahQo1AaNlj6cS/I
X-Gm-Gg: ASbGncskWlJGXwA9d+buhTZyIufQd9svatMoyMyofRHfluqhT8aNygmjaE5mOkFh7Bf
	Jr8TqSsGWYF2HgKXLAA+qWFxEF3nCX2DxbIxzlMxtOfl7+RpTklfYsxrZIJFF2gCB9yF5YCQGEf
	oZmHYJApMsF/egibfY/QS7wdDsalUheIFDYQdaXguNErUIiP9BeRxtHyf8OV0EefWmn9+ENnY5b
	lwOYh5EzGqZU5ggfU1k3KnG5vVPRjIH1FuInXRoQNhfIhkWhoQMfJr8tPyNgDCu5NnUbH3dbOQm
	XuGTJQ==
X-Google-Smtp-Source: AGHT+IGj+mvdG9uQ6taCs0F1tgau+Kd1RL6XlmFtErS9OY17fyECZArX3uy2OYbhVupliE/g/xkWBw==
X-Received: by 2002:a17:902:d2c6:b0:220:be86:a42d with SMTP id d9443c01a7336-22170777df8mr53655825ad.21.1739969462888;
        Wed, 19 Feb 2025 04:51:02 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:51:02 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
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
Subject: [PATCH net-next v10 01/13] rtnetlink: Lookup device in target netns when creating link
Date: Wed, 19 Feb 2025 20:50:27 +0800
Message-ID: <20250219125039.18024-2-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219125039.18024-1-shaw.leon@gmail.com>
References: <20250219125039.18024-1-shaw.leon@gmail.com>
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
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/rtnetlink.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index abe1a461ea67..0f3e2c6021de 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3867,20 +3867,26 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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
2.48.1

