Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F949330328
	for <bridge@lists.linux.dev>; Sat, 12 Sep 2026 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789221042; cv=none; b=kV79xhrPCTTw4aItUiqxkxfhLjw/lZk5SHwAS54m+dF8E3GYyvzFtnUS7/np9obA0v7+JvhIBUzu//pZiC88T4OLZ06QlzRNNxmSEuO2pmvxcV0dp9qEbYx03sctIy18b+tqRN0W6qT39bIcH6VMVNFGDSOv67f3a0Yt0qTn474=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789221042; c=relaxed/simple;
	bh=9JjWJlQanOFgNu6EDHV88ITYLaK2cjjVq8yIXb93bls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZtNjEYvGkPWoy50xYBp0bmhKCIZBD/8qExYmnjVE0cN3mcCi0dvO1NbgqfG8BnWOsxmqkYCyev+giCvBEYjRKM2DjMy8/ad+XWZZYGtAMx961KUhGD5MiJB9RhaapbkSL4ZmnSTbC79xy4JaLXchltaiuFi+8ekIl0PRNtB+r+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o92yPXUg; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o92yPXUg"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f13d7aso559015e87.1
        for <bridge@lists.linux.dev>; Sat, 12 Sep 2026 06:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789221037; x=1789825837; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PkBUg+m8HfIyEOkPoB1jZJ5opS1mW8Hh1Xx4YggldGE=;
        b=o92yPXUgTe1vYzR2u5J2aNdEuK4W/U92eITwca155m6tl43NVMLsigDC+SWkkg1NMq
         mhAC56K6mV3QfVzfDrqNbRSTk14Xa8DOENNm8RjLRDcUKnYPFGkJU+aYPLJtLItnoPTu
         n/pJlAtkxlRuGmqcHbaYasem8Z5kNDJJaJ7N63hG8z1YVdgsMpUB83V8ajXXK1mNwGKR
         Fifn4M43Qjgdszhc4VP9MLhtm1QQCvmke7FByGiKlSNOYjjxZYDSM9e9/z8PykmDznab
         lrUj79hC+nd5KepqG+IuFHdRiqCEb6OVMeIlNoG2ZoMEG3jrE6kcjKSC3sMVbDu24H3d
         LGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789221037; x=1789825837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PkBUg+m8HfIyEOkPoB1jZJ5opS1mW8Hh1Xx4YggldGE=;
        b=Vr1nCzLW5Bby2jGyqf5Z2rlKirBP/jHapmJc73qv3iyiy6mGhJMuQyBDYjl/2EuD7G
         +tSKA95YH6naM9V8xu9urSfzZIucOANIKGGXzLj5cfDu7paqD4tzbbP+tFxC1oK77YVN
         DZgvAkPB9DQ1dcymjyBQt2lzLdqxANle32Df18+9dAAWrOp9auw2R/5o7BN798RzOWib
         Z0fjNvEu+PVvXrOHn/fGp3ZeZnFUC5xy+7WKQQsqn9np5VjNiBFqKuuSNVl+3Wq+fADv
         BML/PMKiuHrDBXUrNjLsy4LEjXysrkpJQhSTCeDt6Ss+2EkI0hJHnRp3lvTOEpG+GrtA
         TCmw==
X-Gm-Message-State: AFuF++kaGhEgwEJp44gHCN2ICRI4kUUMBdkn5ETUIgOq7tjxtn5wpVAq
	44YQBic6+lWSXwBMnpFdbT90ZZgwmSTd2iHioYYQK30l46z1wHMeX6pgYQGlZ9kt1Mc=
X-Gm-Gg: AYBFou24j2xBcrdRwhp5I64e7Per/eWkkW0FAgRTClbeDnt/l6fdUTZUbJpcPu8yddK
	iYsGeTl4MWrebTvvdJtdL3/QuILcuQaql1w0uEuAGnJO1r45it0cFbkjKkyDPu0hWzV8WVQVQ3M
	IsCOdUVJgS7ZmcYWjz5jAoi1RdC/5tYB3kX8BBDpHKNzkKUoB37TUI6YJagWXWykLJ5+cI7OdUk
	AE9bgbIspriJ8xlMFQ+NjC/J7th5Jo1MLloKJ2q1IK9Jc6nmPMt4Tr/ytapIcZ7xXjsWhELWdwn
	30+Ts/Dt7t8nNsH7tsefRs2E0IAyrvBSlzUwp0ryf5Zny4uSd+unKHIk65kmlYNv9H67+l/CeF4
	z4iVrn1h0wgsnQx7o8VYCJFj43bdOb44Z8f4gw7PiI7QvbqoSb5qlh5BqfNpKDYtAdkdLrYLqpe
	ijX7nF26HWQepVSaipMjt5tXMCRRXpllVCKdwbznZs3B85ipF8Spv902v0Ofj8vCgH5L7y9QI98
	lMLeNVoc3fg2ovRUnpGdZHzXnmKTDkbYw7n1bzy0RxMu1Vx60uIoOQBd9R9WPGc30a9
X-Received: by 2002:a05:6512:1594:b0:5b0:eda:de1c with SMTP id 2adb3069b0e04-5b8a8ea0818mr465882e87.5.1789221037446;
        Sat, 12 Sep 2026 06:50:37 -0700 (PDT)
Received: from localhost.localdomain (46-138-187-224.dynamic.spd-mgts.ru. [46.138.187.224])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a0457246sm1257770e87.23.2026.09.12.06.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 06:50:37 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	kuniyu@google.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	oss-drivers@corigine.com,
	wintera@linux.ibm.com,
	aswin@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH net-next v2 2/2] net: bridge: fail link info that does not fit the IFLA_AF_SPEC nest
Date: Sat, 12 Sep 2026 16:50:22 +0300
Message-ID: <20260912135022.1701-3-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260912135022.1701-1-iprintercanon@gmail.com>
References: <20260912135022.1701-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

br_fill_ifinfo() puts all of a port's VLAN, tunnel and MST entries into
one nest, and nla_len is a u16, so a large enough port produces a nest
whose length wraps and userspace reads garbage.

Cancel the message and return -E2BIG with an extack pointing at
RTM_GETVLAN instead. The dump retries the port with an empty skb and
the error goes to userspace; notifications reach rtnl_set_sk_err() and
listeners resync. Not -EMSGSIZE, since no bigger buffer would help.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 net/bridge/br_netlink.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 855a46aec3a89..53676df9e4d11 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -459,7 +459,7 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 			  const struct net_bridge_port *port,
 			  u32 pid, u32 seq, int event, unsigned int flags,
 			  u32 filter_mask, const struct net_device *dev,
-			  bool getlink)
+			  bool getlink, struct netlink_ext_ack *extack)
 {
 	u8 operstate = netif_running(dev) ? READ_ONCE(dev->operstate) :
 					    IF_OPER_DOWN;
@@ -613,6 +613,12 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 
 done:
 	if (af) {
+		if (skb_tail_pointer(skb) - (unsigned char *)af > U16_MAX) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "VLAN information does not fit in one message, use RTM_GETVLAN");
+			nlmsg_cancel(skb, nlh);
+			return -E2BIG;
+		}
 		if (nlmsg_get_pos(skb) - (void *)af > nla_attr_size(0))
 			nla_nest_end(skb, af);
 		else
@@ -654,7 +660,8 @@ void br_info_notify(int event, const struct net_bridge *br,
 	if (skb == NULL)
 		goto errout;
 
-	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false);
+	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false,
+			     NULL);
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in br_nlmsg_size() */
 		WARN_ON(err == -EMSGSIZE);
@@ -693,7 +700,7 @@ int br_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 		return 0;
 
 	return br_fill_ifinfo(skb, port, pid, seq, RTM_NEWLINK, nlflags,
-			      filter_mask, dev, true);
+			      filter_mask, dev, true, extack);
 }
 
 static int br_vlan_info(struct net_bridge *br, struct net_bridge_port *p,
-- 
2.43.0

