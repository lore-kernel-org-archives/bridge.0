Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E931A238D
	for <bridge@lists.linux.dev>; Mon,  9 Dec 2024 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733753028; cv=none; b=od35OPzsPP/wtCoR4h8xWlq6jz6Lmr3teaUcL5QQVzYq1boVWiOUVk/Mm/YmfNPHl/nYU/XKJA3W/jAtzAhDVEqWnPtmFZOkdOoEZviFAZP9olMWsR1Bn7t2jZWHx0SEkF7j5+MVVakqp9abu2As3ET2aOg7VNAJN1prbj+c5ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733753028; c=relaxed/simple;
	bh=P+WesIXJWgwaVpGsZha80KW/I6PB+JZFQ4FU6cAXIU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArIedKRp2/Tyx/EaNAnqPi968LZTfezty9TyO9fKGmP6zYosBgUeRkRmDEXa11BP4bL9oydIPw/WG2zQwOXeeKloc+3pjm7rp4aGXn3wDOZI8zxSVlYqpdFKM8ws5Qgx3ilVdxef1XBzRq3dQ7oC7o9uA4dEL2/Io8i+mXt/Msg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlMnq3dC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlMnq3dC"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cf3e36a76so37998115ad.0
        for <bridge@lists.linux.dev>; Mon, 09 Dec 2024 06:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733753027; x=1734357827; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gu2pXduYtokx49vUkdKLIncKvOPJKtJoZQ/PcO8iW+o=;
        b=QlMnq3dCGNlvA/y1nI0oE5HDhUkBqUvaqhR0xL6jHjQQ2u9FCXwIQhQuIhdKWvIeF2
         /twgFOwG4UTUMxUDtsE4o4yZzmuhXwQKpRt+9SObVnI4+VCLGpssVONx865pOAuMP6t0
         KEYDGTd8EZASmEwULBiurdi4i7bFFG9e7lVvODUb7ICxR4t5C7LctRHvlqYYfN/9hLBh
         ErRU2I0zNXYzJJxk99PdLHGhjv8ZbLqHV9vtHZDnvySdpkmHZvxMPOkU4K6RFordtZw/
         MHwkFn5an58Zz5g4x/zzpkBGVvUJniJWW6uTXCGwQb4UQFE5FzSepOmm+UXH6BgtBXoZ
         GwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733753027; x=1734357827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gu2pXduYtokx49vUkdKLIncKvOPJKtJoZQ/PcO8iW+o=;
        b=LhFnwvN1a2qGFH2nKosY2qKLCttTb82Ul3upzNV3tlRhIJ0bQMGf8HJArLuadpyk8s
         /yaounFBieNi9tJiVoGfCB8+lUMqNAYYVyNnXKDDDQbcdsCZK+U5GZyyxx3LdT9fyh6v
         VTmQYqZAtJ6AOYKzXELkG8XDk8ctKFZObyYK79wUy/crYmq9vuMIrEqr+j6Rz9hocm3E
         Ccd92zEo+Qnp39HhhA0qExZSzcu8YifhyWsGIElAQ8CYiwbGmaylkziSpffLSxHTtwNZ
         gbG8tZYyEsZXzgB7c0MaHGEc6CvNLrhxA2y1AI7WGVa9F+mQrs9PRR4nRI1y8p+vgU3x
         hCjA==
X-Forwarded-Encrypted: i=1; AJvYcCW0iR6OxRUTpSC76KBqHhCC2yRvSI0VjHdq0fFJ65DSorked791lrNt8FEAz63O0iNtHf0cNr8=@lists.linux.dev
X-Gm-Message-State: AOJu0YwP7cxHQW3qwirAtkYKUZqJSyun4YoN9pQWG05AjvCXl8MTtxPX
	EjZA5/IOocQ18a1is+S1TkjXT9U4uLUsCku35p/5rery6swj32S3
X-Gm-Gg: ASbGnctRqXXOXWPwVOG/y8L6DtZzG7f2U4iQOBActeuYVeAVKFu6e5itfJUUWYDKQZs
	k0GvV+95BWNxOAWC4+53dnKOdiqHvDnV14eI+IAi5OrfHThSOAt1T1MOTdS76OHqHc2LtXbs92s
	SfF4LZnn3bR/YZ+K3ztQDC0JT/Z68ys6XsdW6EpPv1eYq4u3TRzW/4iW2zxhW8hkUJGWbdqGIgG
	/xdP7j+4ffRxzG7oGygVlXkiScDN6muAD4AS3S/bYKpq5o=
X-Google-Smtp-Source: AGHT+IFvuzKQIZf1qkxZ4+Ci/Eeds3C/nB8ZqihF0Bnr/4C7RYL2k3LJsI5chnoI4Z2JG+UfbiRHQQ==
X-Received: by 2002:a17:902:e5c5:b0:216:393b:23d4 with SMTP id d9443c01a7336-21669f993b4mr7567455ad.11.1733753026559;
        Mon, 09 Dec 2024 06:03:46 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216221db645sm49605645ad.46.2024.12.09.06.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:03:45 -0800 (PST)
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
Subject: [PATCH net-next v5 2/5] rtnetlink: Lookup device in target netns when creating link
Date: Mon,  9 Dec 2024 22:01:48 +0800
Message-ID: <20241209140151.231257-3-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209140151.231257-1-shaw.leon@gmail.com>
References: <20241209140151.231257-1-shaw.leon@gmail.com>
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
index ab5f201bf0ab..7855f81c917b 100644
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

