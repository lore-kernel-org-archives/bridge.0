Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C722E6CA0
	for <bridge@lists.linux.dev>; Tue,  2 Sep 2025 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756798021; cv=none; b=ZxUhYrzA8BjgR05MPNT3AOGtev/mO3rZwl1eOW5ed36o/mAa9MTEEN36VOQzeP00Zt64reCqgyXkwafwRcjbdV1Q6pdj5EZWViBsFwOv9gHw1TNs0+tB165olyapyqf+bdNyGdS/YxTM/PrYTUcK4qyYz0zFZhf1vmZFsHym95k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756798021; c=relaxed/simple;
	bh=C0+A7LB0c+Kg1/5x9L5CjpFdJGitY1fMjfm3yvYnIgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHPJYLQMlr4vC0yuDC5J2Bpo8zQIe0sLtIvKRFVPv/mPNWP85CsIikrzyWNkr9QUIvIsyBAqeNfEY0X8bHt4eRoFAZCr1drzcLdy5GALeFkD/5Iq+BOEjQJWH1Chj3uAMX6V42FZfdfGwzGeCHZwl08noSXxl4a/hPeRlbpLqJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vnu24Jmz; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vnu24Jmz"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3297a168470so1711488a91.3
        for <bridge@lists.linux.dev>; Tue, 02 Sep 2025 00:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756798019; x=1757402819; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g74np6MvU0aLFhCl/WRP7lVvXWDBNDZlydNszztjOfA=;
        b=Vnu24JmzJxb884+EiDjJU7T2Jv48mXVlmfRNrXW/uGWifgpqJL+PsADi9By+S9Pbzj
         rhAjJBohsA1DHEKGU4+iayOnRtVtBLw4OP8K3ESMiHCm5OJnoyJNtUyXwiZs0nZ0FMzG
         yEuxPkrdLU5ZxYBXdAz4RrMqqrfIfGG71AZAt65ppBLtsO2gk+Wyf8ISnrkPCmlfOF/r
         lS2O/ojHUvaYuIuZH4MCTz3IuSwz6ZtmLQYiiLG2LGGv6eujbn/+K5LVVGyH3ENbodSA
         qOsm27odyfImC0myeTGVSsrtj/6ZSyL1pnCF+uYVzIaDT4229/UWcqbrhg5cV+bK6/uk
         fsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756798019; x=1757402819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g74np6MvU0aLFhCl/WRP7lVvXWDBNDZlydNszztjOfA=;
        b=UQCqa7LyAjmZUyI5QfBZiz+ookcmKx3sFQwma195XGZZkMRcnzJP74mgESerUko4RZ
         OkM+aN2gaWN4DbFj/7cTFCT//kMCq6qb63zJcgs+5iu7fq/How8Bnvhbmu8pUOb2DSWv
         5roGy/89AacxhoT76NrVN3ga8ELFtOCf6uqyOo8c0jIlSz3LKlgPcMjLwPdW8f2T44tQ
         t5QsN/zM+gH82zAUYhwc799a/UKXskDiC1yoFP6aAXASz5SektzY7KRZkXjpNN4diHJG
         Ndnn9SoIWvNGgeYFdBz5kICnOo6upeA9h4f4mOpOupTpaVwAv2qEi/E+K9UI/xNhum4F
         04/w==
X-Forwarded-Encrypted: i=1; AJvYcCX6Ps0R6mAvHNbu6j8oh/nkEUYJH6H4pNkC58O059KzNrBYMIIwq5v/VoWrnBHH/zB1wTIYiV8=@lists.linux.dev
X-Gm-Message-State: AOJu0YxRS+ABNp6J57TyyDq6oV5XQS0xwdcNHB3F8BX+euxcRBGnnED8
	Uvm3z+YNWI+TTM+QdJHJC2tyHK5f2gBO4xlETYpbAI0Apl2e3OXGXTUU
X-Gm-Gg: ASbGncvkSxlYDBBXE7gW8Y6eJIKidiCpXKvm7uOla510ms6s5zvahJzm3ZSMj+kSWy+
	fM9JElozddt/gWlqpjaLPOGr0ULX+qXufx/+oHD7D+dxx3L1gG04RWkpfngREGpOUai+Mw9/VqS
	D3qJA63RUNWBx2nwQPziM3VxM+x0rzWlpgwbqB8khfgASeKb2ASOxjys79l7IXN4GZuWZBSBlrJ
	EEaoRMumFg767lUcHUR17b6V79ogjDY/p/+kcK1XyF+Ok+7ur9eU6KkJdSGXd6tBj+URSrdw7e3
	nu3AkV12t03IWIzdwo6LNMuNr+G0TbZeVN1X751NMbmACLzEnyOFCxwmowbbF65MehgK4Ir04xQ
	V35wwrHoxaL2YMf5JqL9LrQjhOmnUcCMNtvg1ZawqwA==
X-Google-Smtp-Source: AGHT+IHQKbDjFwvBo0SZu3O86anZ+Hcx1gB6tGsQeRxuBBvbP4rxzoQL0eTxwyNJGlWNz8SL1uNWLA==
X-Received: by 2002:a17:90b:1848:b0:327:531b:b85c with SMTP id 98e67ed59e1d1-328156e38b4mr16195525a91.35.1756798019151;
        Tue, 02 Sep 2025 00:26:59 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327d9347189sm13416648a91.9.2025.09.02.00.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 00:26:58 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 5/5] selftests/net: add offload checking test for virtual interface
Date: Tue,  2 Sep 2025 07:26:02 +0000
Message-ID: <20250902072602.361122-6-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902072602.361122-1-liuhangbin@gmail.com>
References: <20250902072602.361122-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

make sure the virtual interface offload setting is correct after
changing lower devices.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/Makefile        |   1 +
 tools/testing/selftests/net/config          |   2 +
 tools/testing/selftests/net/vdev_offload.sh | 176 ++++++++++++++++++++
 3 files changed, 179 insertions(+)
 create mode 100755 tools/testing/selftests/net/vdev_offload.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index eef0b8f8a7b0..e195ab4038a0 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -118,6 +118,7 @@ TEST_PROGS += tfo_passive.sh
 TEST_PROGS += broadcast_pmtu.sh
 TEST_PROGS += ipv6_force_forwarding.sh
 TEST_PROGS += route_hint.sh
+TEST_PROGS += vdev_offload.sh
 
 # YNL files, must be before "include ..lib.mk"
 YNL_GEN_FILES := busy_poller netlink-dumps
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index d548611e2698..0f3a64a86474 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -117,6 +117,7 @@ CONFIG_IP_SCTP=m
 CONFIG_NETFILTER_XT_MATCH_POLICY=m
 CONFIG_CRYPTO_ARIA=y
 CONFIG_XFRM_INTERFACE=m
+CONFIG_XFRM_OFFLOAD=y
 CONFIG_XFRM_USER=m
 CONFIG_IP_NF_MATCH_RPFILTER=m
 CONFIG_IP6_NF_MATCH_RPFILTER=m
@@ -128,3 +129,4 @@ CONFIG_NETKIT=y
 CONFIG_NET_PKTGEN=m
 CONFIG_IPV6_ILA=m
 CONFIG_IPV6_RPL_LWTUNNEL=y
+CONFIG_NET_TEAM=m
diff --git a/tools/testing/selftests/net/vdev_offload.sh b/tools/testing/selftests/net/vdev_offload.sh
new file mode 100755
index 000000000000..78fc212efd4a
--- /dev/null
+++ b/tools/testing/selftests/net/vdev_offload.sh
@@ -0,0 +1,176 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# shellcheck disable=SC1091
+source lib.sh
+
+# Set related offload on lower deivces and check if upper devices re-compute
+# Some features are fixed on veth interface. Just list here in case we have a
+# better way to test in future.
+set_offload()
+{
+	local dev="$1"
+	local state="$2"
+
+	# VLAN features
+	# NETIF_F_FRAGLIST: tx-scatter-gather-fraglist
+	# shellcheck disable=SC2154
+	ip netns exec "$ns" ethtool -K "$dev" tx-scatter-gather-fraglist "$state"
+
+	# ENC features
+	# NETIF_F_RXCSUM: rx-checksum (bond/team/bridge fixed)
+
+	# XFRM features (veth fixed, netdevsim supports)
+	# NETIF_F_HW_ESP: esp-hw-offload
+	# NETIF_F_GSO_ESP: tx-esp-segmentation
+
+	# GSO partial features
+	# NETIF_F_GSO_PARTIAL: tx-gso-partial (veth/bond fixed)
+
+	# Common features
+	# NETIF_F_SG: tx-scatter-gather
+	ip netns exec "$ns" ethtool -K "$dev" tx-scatter-gather "$state" &> /dev/null
+	# NETIF_F_GSO_SOFTWARE: NETIF_F_GSO_ACCECN: tx-tcp-accecn-segmentation
+	ip netns exec "$ns" ethtool -K "$dev" tx-tcp-accecn-segmentation "$state"
+	# NETIF_F_GSO_SOFTWARE: NETIF_F_GSO_SCTP: tx-sctp-segmentation
+	ip netns exec "$ns" ethtool -K "$dev" tx-sctp-segmentation "$state"
+	# NETIF_F_GSO_SOFTWARE: NETIF_F_GSO_FRAGLIST: tx-gso-list
+	ip netns exec "$ns" ethtool -K "$dev" tx-gso-list "$state"
+}
+
+__check_offload()
+{
+	local dev=$1
+	local opt=$2
+	local expect=$3
+
+	ip netns exec "$ns" ethtool --json -k "$dev" | \
+		jq -r -e ".[].\"$opt\".active == ${expect}" >/dev/null
+}
+
+check_offload()
+{
+	local dev=$1
+	local state=$2
+
+	__check_offload "$dev" "tx-scatter-gather-fraglist" "$state" || RET=1
+	__check_offload "$dev" "tx-scatter-gather" "$state" || RET=1
+	__check_offload "$dev" "tx-tcp-accecn-segmentation" "$state" || RET=1
+	__check_offload "$dev" "tx-sctp-segmentation" "$state" || RET=1
+	__check_offload "$dev" "tx-gso-list" "$state" || RET=1
+}
+
+setup_veth()
+{
+	# Set up test netns
+	setup_ns ns switch
+
+	# shellcheck disable=SC2154
+	ip -n "$ns" link add veth0 type veth peer name veth0 netns "$switch"
+	ip -n "$ns" link add veth1 type veth peer name veth1 netns "$switch"
+	ip -n "$switch" link set veth0 up
+	ip -n "$switch" link set veth1 up
+
+	link_0=veth0
+	link_1=veth1
+}
+
+setup_netdevsim()
+{
+	setup_ns ns
+	# The create_netdevsim() function will set the interface up. Later,
+	# when it is added to bonded, we need to set it down first. And when
+	# set down, it will have no carrier. So we need to add netdevsim ourselves.
+	modprobe netdevsim
+	udevadm settle
+	echo "0 2" | ip netns exec "$ns" tee /sys/bus/netdevsim/new_device >/dev/null
+	link_0=$(ip netns exec "$ns" ls /sys/bus/netdevsim/devices/netdevsim0/net | head -n 1)
+	link_1=$(ip netns exec "$ns" ls /sys/bus/netdevsim/devices/netdevsim0/net | tail -n 1)
+}
+
+cleanup()
+{
+	cleanup_netdevsim 0
+	cleanup_all_ns
+}
+
+setup_bond()
+{
+	ip -n "$ns" link set "$link_0" nomaster
+	ip -n "$ns" link set "$link_1" nomaster
+	ip -n "$ns" link add bond0 type bond mode active-backup miimon 100
+	ip -n "$ns" link set "$link_0" master bond0
+	ip -n "$ns" link set "$link_1" master bond0
+	ip -n "$ns" link set bond0 up
+}
+
+setup_team()
+{
+	ip -n "$ns" link set "$link_0" nomaster
+	ip -n "$ns" link set "$link_1" nomaster
+	ip -n "$ns" link add team0 type team
+	ip -n "$ns" link set "$link_0" master team0
+	ip -n "$ns" link set "$link_1" master team0
+	ip -n "$ns" link set team0 up
+}
+
+setup_bridge()
+{
+	ip -n "$ns" link set "$link_0" nomaster
+	ip -n "$ns" link set "$link_1" nomaster
+	ip -n "$ns" link add br0 type bridge
+	ip -n "$ns" link set "$link_0" master br0
+	ip -n "$ns" link set "$link_1" master br0
+	ip -n "$ns" link set br0 up
+}
+
+check_xfrm()
+{
+	local dev=$1
+	local src=192.0.2.1
+	local dst=192.0.2.2
+	local key="0x3132333435363738393031323334353664636261"
+
+	RET=0
+
+	ip -n "$ns" xfrm state flush
+	ip -n "$ns" xfrm state add proto esp src "$src" dst "$dst" spi 9 \
+		mode transport reqid 42 aead "rfc4106(gcm(aes))" "$key" 128 \
+		sel src "$src"/24 dst "$dst"/24 offload dev "$dev" dir out
+
+	# shellcheck disable=SC2034
+	ip -n "$ns" xfrm state list | grep -q "crypto offload parameters: dev $dev dir" || RET=1
+	log_test "$dev" "xfrm offload"
+}
+
+do_test()
+{
+	local dev=$1
+
+	RET=0
+	set_offload veth0 "on"
+	set_offload veth1 "on"
+	check_offload "$dev" "true"
+	log_test "$dev" "enable offload"
+
+	RET=0
+	set_offload veth0 "off"
+	set_offload veth1 "off"
+	check_offload "$dev" "false"
+	log_test "$dev" "disable offload"
+}
+
+trap cleanup EXIT
+setup_veth
+setup_bond
+do_test bond0
+setup_team
+do_test team0
+setup_bridge
+do_test br0
+
+# Check NETIF_F_HW_ESP
+# Only test bond as team and bridge haven't implemented xfrm offload
+setup_netdevsim
+setup_bond
+check_xfrm bond0
-- 
2.50.1

