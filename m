Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1E418BBAE
	for <bridge@lists.linux.dev>; Mon, 30 Sep 2024 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690349; cv=none; b=s99O6Bi+kwZxY6H19afxGpovk+4qtbOg9eUj1VzngOF1Lu68W7Fdy6BMHN6OVxZF6Dlg6RfQNmH/0K0hc7lM45fCriewDyacKbADjXG2BCVyOhhbhDm78boFtn0VhzCEmUGL8GLrUttZjqMlA12CG2NHflCqZ1y6slxAx0RQf3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690349; c=relaxed/simple;
	bh=RuOIFrHPmb6/uwq0jCfQWQUmMMFqbmacpWJpXv+x21Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V+xudpzsQxxIxWedNjtniVV9CuFPE35RrFvN28L/7paRc02WQVNJxCfCZ3hHg5r2/ThDdTP2G0HTxNgWUsiRVtoct4zi0SfObZC0QiCN4TiivXIIt6uQaxzg2h/YJFNHwDGT/39N++dI4kmNLrg6uITgMc4Cux51cw2wRWTTwt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c42f406e29so5826189a12.2
        for <bridge@lists.linux.dev>; Mon, 30 Sep 2024 02:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727690346; x=1728295146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qO+df0OBVgMIgNoBlXyBeG6a4YtOqRyUfk78PqMYEmw=;
        b=IxxE9KmkQHepaBis7si+4u6BVJjCPhKjydEMqxBwH3fJQkJ2f495CYW60EnMNcI+/f
         DYWfeDOrkrf/idCeK2lwDyK8Aik7EmQLvh/TIi5G13r1TcFzMJoWJm8So358EpBAw9Nf
         ZckImnX57CAfFXaga4IUGIzY0BQbldnJcXYD1nfb3dvsfHwP/HH2JVNZoju5l85+4eRC
         s7/jMkjtVNhiHNcWKSHDpOpnV9iEEAwyX9vW9wgV3UAB6rYUnIN5ychMbRY90IRO1HrU
         HsOWfmqz0q0uFgl4j5n5PaFm//L5tlZkBuBDp6uB88w1FmKeE7ru5a+QzZep3rlrobPu
         S6eA==
X-Forwarded-Encrypted: i=1; AJvYcCWpS9kqBfjpHN0ckhkbaECl+LkXKj4lhjPVN/Q/ZLELukxxo3OWlMQEfaPKz2lIYQgscGGV9Xs=@lists.linux.dev
X-Gm-Message-State: AOJu0YxFIKq1kyt5VMh9+pC45cWi5p9IZpfbTviLbsSIQH7XpUXdXJss
	Lr9AMCICe/usiEK/dspS2tO8uM71PnQFzYGyPhBGSWna3n6feV4A
X-Google-Smtp-Source: AGHT+IEyjhn+UsZ3JO+xfeIX3mmofoVPVMzwXKjd++w7dxcu51gwytlrH85yheivpcOz2zKjnZPt5A==
X-Received: by 2002:a17:907:6d15:b0:a91:158c:8057 with SMTP id a640c23a62f3a-a93c4aeb8bbmr1264431866b.54.1727690345759;
        Mon, 30 Sep 2024 02:59:05 -0700 (PDT)
Received: from localhost (fwdproxy-lla-113.fbsv.net. [2a03:2880:30ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2996631sm501298966b.200.2024.09.30.02.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 02:59:05 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: fw@strlen.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pablo@netfilter.org,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>
Cc: rbc@meta.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org (open list:NETFILTER),
	bridge@lists.linux.dev (open list:ETHERNET BRIDGE)
Subject: [PATCH nf-next v6] netfilter: Make legacy configs user selectable
Date: Mon, 30 Sep 2024 02:58:54 -0700
Message-ID: <20240930095855.453342-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This option makes legacy Netfilter Kconfig user selectable, giving users
the option to configure iptables without enabling any other config.

Make the following KConfig entries user selectable:
 * BRIDGE_NF_EBTABLES_LEGACY
 * IP_NF_ARPTABLES
 * IP_NF_IPTABLES_LEGACY
 * IP6_NF_IPTABLES_LEGACY

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changelog:
v6:
 * Expand it for BRIDGE_NF_EBTABLES_LEGACY and IP_NF_ARPTABLES (Pablo)
 * Merge all changes in a single patch (Pablo)

v5:
 * Change the description of the legacy Kconfig (Pablo)
 * https://lore.kernel.org/all/20240909084620.3155679-2-leitao@debian.org/

v4:
 * Remove the "depends on" part, which may come later in a separate
   change, given its intrusive on how to configure selftests
 * https://lore.kernel.org/all/20240829161656.832208-1-leitao@debian.org/

v3:
 * Make sure that the generate from  tools/testing/selftests/net/config
   look the same before and after. (Jakub)
 * https://lore.kernel.org/all/20240827145242.3094777-1-leitao@debian.org/

v2:
 * Added the new configuration in the selftest configs (Jakub)
 * Added this simple cover letter
 * https://lore.kernel.org/all/20240823174855.3052334-1-leitao@debian.org/

v1:
 * https://lore.kernel.org/all/20240822175537.3626036-1-leitao@debian.org/


 net/bridge/netfilter/Kconfig |  8 +++++++-
 net/ipv4/netfilter/Kconfig   | 16 ++++++++++++++--
 net/ipv6/netfilter/Kconfig   |  9 ++++++++-
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/net/bridge/netfilter/Kconfig b/net/bridge/netfilter/Kconfig
index 104c0125e32e..f16bbbbb9481 100644
--- a/net/bridge/netfilter/Kconfig
+++ b/net/bridge/netfilter/Kconfig
@@ -41,7 +41,13 @@ config NF_CONNTRACK_BRIDGE
 
 # old sockopt interface and eval loop
 config BRIDGE_NF_EBTABLES_LEGACY
-	tristate
+	tristate "Legacy EBTABLES support"
+	depends on BRIDGE && NETFILTER_XTABLES
+	default n
+	help
+	 Legacy ebtables packet/frame classifier.
+	 This is not needed if you are using ebtables over nftables
+	 (iptables-nft).
 
 menuconfig BRIDGE_NF_EBTABLES
 	tristate "Ethernet Bridge tables (ebtables) support"
diff --git a/net/ipv4/netfilter/Kconfig b/net/ipv4/netfilter/Kconfig
index 1b991b889506..ef8009281da5 100644
--- a/net/ipv4/netfilter/Kconfig
+++ b/net/ipv4/netfilter/Kconfig
@@ -12,7 +12,13 @@ config NF_DEFRAG_IPV4
 
 # old sockopt interface and eval loop
 config IP_NF_IPTABLES_LEGACY
-	tristate
+	tristate "Legacy IP tables support"
+	default	n
+	select NETFILTER_XTABLES
+	help
+	  iptables is a legacy packet classifier.
+	  This is not needed if you are using iptables over nftables
+	  (iptables-nft).
 
 config NF_SOCKET_IPV4
 	tristate "IPv4 socket lookup support"
@@ -318,7 +324,13 @@ endif # IP_NF_IPTABLES
 
 # ARP tables
 config IP_NF_ARPTABLES
-	tristate
+	tristate "Legacy ARPTABLES support"
+	depends on NETFILTER_XTABLES
+	default n
+	help
+	  arptables is a legacy packet classifier.
+	  This is not needed if you are using arptables over nftables
+	  (iptables-nft).
 
 config NFT_COMPAT_ARP
 	tristate
diff --git a/net/ipv6/netfilter/Kconfig b/net/ipv6/netfilter/Kconfig
index f3c8e2d918e1..e087a8e97ba7 100644
--- a/net/ipv6/netfilter/Kconfig
+++ b/net/ipv6/netfilter/Kconfig
@@ -8,7 +8,14 @@ menu "IPv6: Netfilter Configuration"
 
 # old sockopt interface and eval loop
 config IP6_NF_IPTABLES_LEGACY
-	tristate
+	tristate "Legacy IP6 tables support"
+	depends on INET && IPV6
+	select NETFILTER_XTABLES
+	default n
+	help
+	  ip6tables is a legacy packet classifier.
+	  This is not needed if you are using iptables over nftables
+	  (iptables-nft).
 
 config NF_SOCKET_IPV6
 	tristate "IPv6 socket lookup support"
-- 
2.43.5

