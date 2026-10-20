Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792457813;
	b=AkqgdkzYBBAX0RPPwEGP6ILDbFK5Vu5wLaC55xwmASzxFgN5PT9Vr7xoLloXJfaFBjQ5
	 W8gsl9/h/sw8OoUpAzRaB7/s6JQeizELmE5eIevctexjTyba1OPWFCv89fjzRREx6483K
	 hb4QLYjyW+PHo56O9lVDEHuiu1Z97lSfEuC6nSGJn3TbMYgXJIH7Sk3V+4gFwgC1lcBMv
	 KpuN8Xbzs4pBk9lBv4OhT/jyw+kAJpX8W4EMSjE4UprsET2LizTDlfDo6DGcgiiGKOgQT
	 UK2EvAcNw4bWYFgBPvhNtezwgFptWTUsK+TxM8f7r/dDFyaQSbZdeoD+6NPGtuDm4Qw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792457813;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=ZtyuI4QRG4oxCECc81KPb73a03n4gRDC7MVg7hwxF68=;
	b=F9rJYSR8GpFQ4v9OUaocVwHgF+371LtHRBPDbTp2LN2B2NqalchZCaWjweeC+5DuiK+U
	 hO6ZZmWsCd5/VyW7fhcngvBm+tLYypydtWCC+VOYWZBiiYpurkLWNofXi0Zw2gTMmB6ac
	 I6yf91kdXCu1ID1Dc0wZRnvbCbKYYpIaQ0N76dexLEYqcC08wk4wOeD/CdtTARqqZFlFU
	 ha6AieYBVWt74U/eQlqWEAYnc01tqHbeZKzfC91q/eQJaVHSkV2rH83KJrjZXM7LSu3eo
	 ku1av1m5WrAUUMwoRBFhazHfMkAZvYy42LHIINb33O+yEkoeQdjHql9Dp4bnMDUmwLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=laveeshbansal.com;
	spf=pass smtp.mailfrom=laveeshbansal.com;
	dkim=pass header.d=laveeshbansal.com header.i=laveeshb@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=HMSCK+L+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68316606A31A
	for <bridge@lists.linux.dev>; Tue, 20 Oct 2026 00:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68316606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=laveeshbansal.com header.i=laveeshb@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=HMSCK+L+
ARC-Seal: i=1; a=rsa-sha256; t=1792457810; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IGXf7WT/CCKjW6E/ZYQ7Io1CaNwns+62/e4lOkBssBMTt1C0fHih9Tm00SC7QwPissE9RjTKEc/xI/jq9IocGtk+E2od6IHek/m5dObe6NqFnhrGHYKDa9VaTiT7WzR4onLQqtU4RT/gtLuymwEx4Q5BFSd9tIplEAHMCmKIVyc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792457810; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZtyuI4QRG4oxCECc81KPb73a03n4gRDC7MVg7hwxF68=; 
	b=DFZFXEvTChkamxAn9J2QlJJ5w0AzkKf7mvLcGZvkaZx0Df7F/HebL9f6rWtGl30DvIC+kdp+EUzJdWs88X2wj3mxC0J4bPlw+HB3pd2gV+OfD+1cVbGwQJ2QG1j7dUgz8iI8u864GSEziloXhoVLf1O8i3N1Pb7ivfVlM9U8+DE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792457810;
	s=zoho; d=laveeshbansal.com; i=laveeshb@laveeshbansal.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ZtyuI4QRG4oxCECc81KPb73a03n4gRDC7MVg7hwxF68=;
	b=HMSCK+L+O8L9TDpHIZaPntmRio5522yivDxB6P5DNtao7lLpgYqc68IDH9pImjYR
	RQphTLwY6VMI8sppqWMvnRTOYKdVt9ddVh6iESs5zOCB7DEfWD2S3xOb6xbjcrD+K6E
	7AnWfxaIWPZ+DatI0sJwH4mKSmW4X7tDN/NGRvy8=
Received: by smtp.zohomail.com with SMTPS id 1792457807481180.3103182117402;
	Mon, 19 Oct 2026 17:56:47 -0700 (PDT)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH 2/2] selftests: netfilter: add bridge conntrack test for vlan protocol mismatch
Date: Mon, 19 Oct 2026 17:56:42 -0700
Message-ID: <20261020005642.39494-1-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020000308.37362-1-laveeshb@laveeshbansal.com>
References: <20261020000308.37362-1-laveeshb@laveeshbansal.com>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add a test for fragmented packets in vlans that are forwarded by a vlan
filtering bridge with bridge conntrack.

If the protocol of the vlan tag differs from the vlan_protocol of the
bridge, the bridge moves the tag into the packet after prerouting, which
made bridge conntrack warn and drop the fragments. The test uses an 802.1Q
vlan on an 802.1ad bridge and the reverse, and an 802.1Q vlan on an 802.1Q
bridge as control.

Send fragmented IPv4 and IPv6 pings through the bridge and check that they
get through, that conntrack reassembled them and that the kernel did not
warn. Repeat the first mismatching case with promisc set on the bridge,
which makes it forward clones of the packets, so that fragmenting them
takes the slow path.

Assisted-by: LLM
Signed-off-by: Laveesh Bansal <laveeshb@laveeshbansal.com>
---
 .../testing/selftests/net/netfilter/Makefile  |   1 +
 .../net/netfilter/bridge_ct_vlan_proto.sh     | 182 ++++++++++++++++++
 tools/testing/selftests/net/netfilter/config  |   1 +
 3 files changed, 184 insertions(+)
 create mode 100755 tools/testing/selftests/net/netfilter/bridge_ct_vlan_proto.sh

diff --git a/tools/testing/selftests/net/netfilter/Makefile b/tools/testing/selftests/net/netfilter/Makefile
index f88dd4ef8d26..314f678f3dfc 100644
--- a/tools/testing/selftests/net/netfilter/Makefile
+++ b/tools/testing/selftests/net/netfilter/Makefile
@@ -10,6 +10,7 @@ TEST_PROGS := \
 	br_netfilter.sh \
 	br_netfilter_queue.sh \
 	bridge_brouter.sh \
+	bridge_ct_vlan_proto.sh \
 	conntrack_clash.sh \
 	conntrack_dump_flush.sh \
 	conntrack_icmp_related.sh \
diff --git a/tools/testing/selftests/net/netfilter/bridge_ct_vlan_proto.sh b/tools/testing/selftests/net/netfilter/bridge_ct_vlan_proto.sh
new file mode 100755
index 000000000000..19f842e17060
--- /dev/null
+++ b/tools/testing/selftests/net/netfilter/bridge_ct_vlan_proto.sh
@@ -0,0 +1,182 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# A VLAN filtering bridge moves the vlan tag of a frame into the packet if the
+# protocol of the tag differs from the vlan_protocol of the bridge, after the
+# bridge prerouting hooks have run. skb->protocol is a vlan ethertype when the
+# postrouting hooks see the frame.
+#
+# Bridge conntrack defragments IP packets in prerouting and fragments them
+# again in postrouting. It used to warn and drop fragmented packets that are
+# forwarded like this.
+#
+# Send fragmented ping packets in vlans through a bridge with bridge conntrack
+# and check that they are forwarded, that they were reassembled by conntrack
+# and that the kernel does not warn.
+#
+#                       ns0 (br0)
+#   ns1 eth0.100 -- veth0 ------- veth1 -- eth1.100 ns2
+
+source lib.sh
+
+# TAINT_WARN
+taint_warn=512
+
+checktool "nft --version" "run test without nft tool"
+checktool "bridge -V" "run test without bridge tool"
+checktool "ping -V" "run test without ping"
+
+read -r t < /proc/sys/kernel/tainted
+if [ $((t & taint_warn)) -ne 0 ]; then
+	echo "SKIP: kernel has already warned"
+	exit "$ksft_skip"
+fi
+
+cleanup() {
+	cleanup_all_ns
+}
+
+trap cleanup EXIT
+
+ret=0
+
+# $1: vlan_protocol of the bridge, $2: protocol of the vlan devices
+setup()
+{
+	local br_proto="$1"
+	local vlan_proto="$2"
+
+	setup_ns ns0 ns1 ns2
+
+	ip -net "$ns0" link add br0 type bridge vlan_filtering 1 \
+		vlan_protocol "$br_proto" || return "$ksft_skip"
+	ip -net "$ns0" link add veth0 type veth peer name eth0 netns "$ns1" || return "$ksft_skip"
+	ip -net "$ns0" link add veth1 type veth peer name eth1 netns "$ns2" || return "$ksft_skip"
+
+	for i in 0 1; do
+		ip -net "$ns0" link set "veth$i" master br0
+		ip -net "$ns0" link set "veth$i" up
+		# If the protocols match, vlan 100 has to be allowed. If not,
+		# the bridge treats the tag as part of the packet.
+		if [ "$br_proto" = "802.1q" ] && [ "$vlan_proto" = "802.1q" ]; then
+			ip netns exec "$ns0" bridge vlan add dev "veth$i" vid 100 ||
+				return "$ksft_skip"
+		fi
+	done
+	ip -net "$ns0" link set br0 up
+
+	ip -net "$ns1" link set eth0 up
+	ip -net "$ns2" link set eth1 up
+
+	ip -net "$ns1" link add link eth0 name eth0.100 type vlan \
+		protocol "$vlan_proto" id 100 || return "$ksft_skip"
+	ip -net "$ns2" link add link eth1 name eth1.100 type vlan \
+		protocol "$vlan_proto" id 100 || return "$ksft_skip"
+
+	ip -net "$ns1" link set eth0.100 mtu 1400 up
+	ip -net "$ns2" link set eth1.100 mtu 1400 up
+
+	ip -net "$ns1" addr add 10.0.100.1/24 dev eth0.100
+	ip -net "$ns2" addr add 10.0.100.2/24 dev eth1.100
+	ip -net "$ns1" addr add dead:100::1/64 dev eth0.100 nodad
+	ip -net "$ns2" addr add dead:100::2/64 dev eth1.100 nodad
+
+	# Loading a ct rule in the bridge family enables bridge conntrack. The
+	# postrouting counter sees the packets reassembled by conntrack.
+	ip netns exec "$ns0" nft -f - <<EOF || return "$ksft_skip"
+table bridge t {
+	chain pre {
+		type filter hook prerouting priority 0; policy accept;
+		ct state new counter
+	}
+	chain post {
+		type filter hook postrouting priority 0; policy accept;
+		meta length > 1400 counter
+	}
+}
+EOF
+
+	return 0
+}
+
+# $1: vlan_protocol of the bridge, $2: protocol of the vlan devices,
+# $3: "clone" to make the bridge forward clones, which makes fragmenting take
+#     the slow path
+run_case()
+{
+	local desc="$2 vlan on $1 bridge${3:+, $3}"
+	local rc=0
+
+	setup "$1" "$2"
+	rc=$?
+	if [ "$rc" -ne 0 ]; then
+		echo "SKIP: could not set up $desc"
+		return "$rc"
+	fi
+
+	if [ "$3" = "clone" ]; then
+		# The bridge delivers a clone of the packets it forwards if it
+		# also receives them.
+		ip -net "$ns0" link set br0 promisc on
+	fi
+
+	# Wait until the bridge forwards the plain vlan traffic.
+	if ! busywait 5000 ip netns exec "$ns1" ping -c 1 -W 1 -q 10.0.100.2 >/dev/null 2>&1; then
+		echo "FAIL: no connectivity through the bridge, $desc"
+		cleanup_all_ns
+		return 1
+	fi
+
+	# 3000 bytes of icmp payload do not fit the 1400 byte mtu, the sender
+	# fragments the packets and bridge conntrack reassembles and fragments
+	# them again.
+	for ip in 10.0.100.2 dead:100::2; do
+		if ip netns exec "$ns1" ping -c 3 -W 2 -s 3000 -q "$ip" >/dev/null; then
+			echo "PASS: fragmented ping to $ip, $desc"
+		else
+			echo "FAIL: fragmented ping to $ip, $desc"
+			rc=1
+		fi
+	done
+
+	if ! ip netns exec "$ns0" nft list chain bridge t post | grep -q "packets [1-9]"; then
+		echo "FAIL: conntrack did not reassemble the packets, $desc"
+		rc=1
+	fi
+
+	cleanup_all_ns
+
+	return $rc
+}
+
+run_all()
+{
+	local rc
+
+	# bridge protocol, protocol of the vlan devices
+	for case in "802.1q 802.1q" "802.1ad 802.1q" "802.1q 802.1ad" "802.1ad 802.1q clone"; do
+		# shellcheck disable=SC2086
+		run_case $case
+		rc=$?
+		if [ "$rc" -eq "$ksft_skip" ]; then
+			return "$ksft_skip"
+		fi
+		[ "$rc" -ne 0 ] && ret=1
+	done
+
+	return 0
+}
+
+run_all
+rc=$?
+if [ "$rc" -eq "$ksft_skip" ] && [ "$ret" -eq 0 ]; then
+	exit "$ksft_skip"
+fi
+
+read -r t < /proc/sys/kernel/tainted
+if [ $((t & taint_warn)) -ne 0 ]; then
+	echo "FAIL: kernel warned"
+	ret=1
+fi
+
+exit $ret
diff --git a/tools/testing/selftests/net/netfilter/config b/tools/testing/selftests/net/netfilter/config
index c3c121b6f300..e91bb10d1072 100644
--- a/tools/testing/selftests/net/netfilter/config
+++ b/tools/testing/selftests/net/netfilter/config
@@ -62,6 +62,7 @@ CONFIG_NET_SCH_HTB=m
 CONFIG_NET_SCH_NETEM=m
 CONFIG_NET_VRF=y
 CONFIG_NF_CONNTRACK=m
+CONFIG_NF_CONNTRACK_BRIDGE=m
 CONFIG_NF_CONNTRACK_EVENTS=y
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_MARK=y
-- 
2.54.0 (Apple Git-157)

