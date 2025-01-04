Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4001BD039
	for <bridge@lists.linux.dev>; Sat,  4 Jan 2025 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735995542; cv=none; b=rBX3N3hzveLwS5FAbjty2EXsPwdHKnNAbgceS/+0nw/ykVDimNps0jKP7GHzXR8jo7ieNjLa5U91MTuV9JmmjPcAOvRdvrdkClk5FIAuaA9xDcHHgAuGkjolPOJsLlqJyrzqLD7GkdTfXSr4dNnNgEZARQTiXGFJCqfoqe9vEUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735995542; c=relaxed/simple;
	bh=W6Jch7g8Z9mySu+CSy86wpVopsPfVKuW30huqFSsC+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rL0rx/04vuYOhdn6Xgwv6HN361dqj0KBMqB0qo/EBTRRr39Zo3I6Fl+I4U8xNMPu5QZ37rk40icLpxhs8AzBCqasPOtQeOOwBPMw/hr+KKV6SjgGfWEt0MqJj2oYO45B23jdkS3Zhqyzwo8IM+U5hoR1V3T9UnNm0QzJXeuXLVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F40pBxex; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F40pBxex"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2166022c5caso161626035ad.2
        for <bridge@lists.linux.dev>; Sat, 04 Jan 2025 04:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995539; x=1736600339; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7lhW/WxI9EK3nLn5yDY0MQG09nRFtNebbOyrqmZTug=;
        b=F40pBxexQEK92qfcPLAnWfJTSv8bCARj5bttE9BvXnsJFtCp+2tXZfkzVZHS/gHpUE
         BNJlf0tM+n+C2ZihK/jYAJy3M31ufwp8uVjS4Kv1iVWp/0ZQvnbiKZmDZA+WRb0Bs4WN
         JdpxXvt5HhtfftEQfEDlwnj5qhm0Y9g0hYNcqh/yBYOjciq/7+59CmTW5WLyCJT+0Eny
         Wfefu6QXhPqbzkIW6RBrgOIqXjHhd9i7tJERgmQFJG5pASoxB1XFZRTpkSDES/ZHbU6V
         18jg9BGbpC/ia/fEeOCgo4EPn6iUhg54OYJEDY6f0d7fIipXvbSNt9km6c6HRBNHdUS+
         tyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995539; x=1736600339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7lhW/WxI9EK3nLn5yDY0MQG09nRFtNebbOyrqmZTug=;
        b=VsOKY2ThZf6NIzFSN3zu7qeWrrJu2BtSjEH/DWvbL4z4OrslPhZCViWsVGE4gjiaDp
         XZy7hyZufRKMuOBe2yjQJYB902fN4Ztm/AOE+3NBJUO5drU449lSjzkGOOIj/nDt1dqj
         eFbBpfg+Lb8kFHXIYncOqpHkblaje3yHuR0CgPD9Sn6/RSDrvj/Th8a9Q1rEmulT90B6
         yilvhkEYazkra4iKaY7AGGG+47WzKn/kDk1hYALfUgkLHZnhj1R+MG1TBlmCPA2ehOlV
         yTGEZ8RkaL/5Kg8zNpPyCdXcUJFP9re6iU8zkmfsNn4pvQul68u7z8jusCTeSZnJVek9
         Bt+g==
X-Forwarded-Encrypted: i=1; AJvYcCXNHBFZqPAyqYhji4sZ20hJOhHiwGGYbkWZ3ItAFFW7yUK2eskvTAH2Lgzu5ifj76jdPwugzAY=@lists.linux.dev
X-Gm-Message-State: AOJu0YzI5jE/oIbrNraxidYg8AlPwIy4k80GZuGRsXo+9XUZ4OherXrQ
	kVQ5lif/62voCrHfz/zBhybL/PgAUiT1Wrko3976Fansrt7Bsi4v
X-Gm-Gg: ASbGnctmxUEcDxqXz0XNgYpl+k4ns1sXi3r7AtnBtdkDcXCjIGGpXP0UP2xC8FPCxrS
	3lB5kY+sB0SejTCoKnGyRjnflD5XblHxSpKgY6q5Y7OghJ4dYl2eei0uygPLGChm4DJHtbr1xKm
	IgF+YxuSTMY6E1BEcUFyC2pJqwK+K++CLFOLQkL6AcdIDOzw6gIjhfngmYNyW8KF2dc3b28ZHg7
	Goo/HfC3A+ToYMxaTJWVynaDox1+0AT/JnqY2lgtYVdVCs=
X-Google-Smtp-Source: AGHT+IHLCiFk9BrspEkmn14rTTpjbLwBW8SdPWZM+0IkwauKRrd0EY+n9DzEaoNgd6USL3r4X9FuKw==
X-Received: by 2002:a05:6a21:99a4:b0:1e0:e027:2eaf with SMTP id adf61e73a8af0-1e5e048adf7mr83019375637.19.1735995539121;
        Sat, 04 Jan 2025 04:58:59 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:58:58 -0800 (PST)
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
Subject: [PATCH net-next v7 09/11] rtnetlink: Create link directly in target net namespace
Date: Sat,  4 Jan 2025 20:57:30 +0800
Message-ID: <20250104125732.17335-10-shaw.leon@gmail.com>
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

Make rtnl_newlink_create() create device in target namespace directly.
Avoid extra netns change when link netns is provided.

Device drivers has been converted to be aware of link netns, that is not
assuming device netns is and link netns is the same when ops->newlink()
is called.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/core/rtnetlink.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index a2246bbaf2bc..e8126007eb00 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3776,8 +3776,8 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	dev = rtnl_create_link(link_net ? : tgt_net, ifname,
-			       name_assign_type, ops, tb, extack);
+	dev = rtnl_create_link(tgt_net, ifname, name_assign_type, ops, tb,
+			       extack);
 	if (IS_ERR(dev)) {
 		err = PTR_ERR(dev);
 		goto out;
@@ -3798,11 +3798,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	err = rtnl_configure_link(dev, ifm, portid, nlh);
 	if (err < 0)
 		goto out_unregister;
-	if (link_net) {
-		err = dev_change_net_namespace(dev, tgt_net, ifname);
-		if (err < 0)
-			goto out_unregister;
-	}
 	if (tb[IFLA_MASTER]) {
 		err = do_set_master(dev, nla_get_u32(tb[IFLA_MASTER]), extack);
 		if (err)
-- 
2.47.1

