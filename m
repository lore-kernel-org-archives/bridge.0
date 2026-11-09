Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794252057;
	b=H9Tie76e01Oe0xtI7awnkNhlUWb1V8d7/WUHwPyB1UoUqHX/+nLcDi4Evdd2/O8yFcW/
	 rtQXUxRg0mcyXG/k8q6IOZuMoWhkh9MLjsQJg3HXO0ogALwfqGv00b/NtR2UBg0G357VK
	 0tg27QpvnxJ/yqw2CVYtTv9g+RtFpahAYJP04GbWX7YnhR38VhsxSyxqDQ4CvbFDurxFc
	 vEj3Bjyzz+Hb9pLqK75qnfrJKaZHiOJPI3n4FJJItvsf+3hzTJDHXTMLcDSrUnHeI8TfB
	 6rlXxiCrfQ4zAts2ygP6H+5e+DOxuZ3PP7NkQg0X0jPv+STG23x+awLOg9PicQ4URIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252057;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=DgJrIpugPWavPM5Dn2kTYbIbcSr4xPFyr5egYWJlInI=;
	b=zTMEzGOQrXjjEFNyqtuJW47pYss/nIeeNaYdC2V61iluia+B1LvmANiCpcbLC2SQs96w
	 OOOY8YySEzeTN1YKI5uqkDT1Lt8PlLZlI/7XvX09joFHKq3e8/ks046G3/4MrNUlJOCm/
	 f+5HGqHWiIvDnB2GtlaIwqkZtCXzz8n3xIUT5/Ys3lZ6H8qVDqE635wA5MhvRL3AgdKjW
	 EKFtsbThzGAFOnkyM4IhkTKe0hEFWdCWJbVvTiF/mpq0VZdNObjx36bP7XzEaVuSYiPCJ
	 SBqyrCzET2nWAEwmuGa4elhUDchxAnRYUV7YHJ4OW/90Uos9qh3ednvg3jZloqoH1KQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=laveeshbansal.com;
	spf=pass smtp.mailfrom=laveeshbansal.com;
	dkim=pass header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=GhqFqpIK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7D4606A33C
	for <bridge@lists.linux.dev>; Mon,  9 Nov 2026 19:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED7D4606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=GhqFqpIK
ARC-Seal: i=1; a=rsa-sha256; t=1794252054; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=npnXBGBQg1YftHZsTRLHB7cxVcnCpgff++F+kXrbp43KgSKC2Ty7jT4R9OoMCyQLAhnWAVOm7s1IldyoUVEVMcv4gHVgOPtnmxIQVSf8BBfrc6SANAQ0UwXZqcZ1sKZhxG9Pjp8+96O9DBRX2z00bsLvzItba8I+ch/45ZfnLqM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794252054; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DgJrIpugPWavPM5Dn2kTYbIbcSr4xPFyr5egYWJlInI=; 
	b=iuYiRnecmIiWGX51N9WKXLlVUY3fGsI86KFLahwb7JwDBm3gBz6aHagRtJoEStYvuAV/Vk2zGrJe3grVK7XPGRr6JeIaX19BTfKG46m1GTYutiEJHF2vm7Y6ZrRGqIed8wIcITfJ+UbDz6E1chPgp8c+uBxCwh9s9wQdnqfWiWg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256; b=GhqFqpIKXfO78WSZdADdhW6wyRCmnQSgxE9N96Gy2UvlVtEp8CoRxNZl3rR+uq7XLbu9FP99FEzMkzMcU5FPWOxm5R/8yd91N7NVjYorcF2IlC7Cj1uWhddKNcPXfpJUVyweDiGQpVTO70BFblMLqLB4EaIgcPdPz60faeHBvDo=; c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1; bh=DgJrIpugPWavPM5Dn2kTYbIbcSr4xPFyr5egYWJlInI=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794252053265235.70482824083774;
	Mon, 9 Nov 2026 11:20:53 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	syzbot+a8ba738fe2db6b4bb27f@syzkaller.appspotmail.com,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH nf-next 2/2] selftests: netfilter: add bridge conntrack test for vlan protocol mismatch
Date: Mon,  9 Nov 2026 11:18:42 -0800
Message-ID: <20261109191842.57359-3-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109191842.57359-1-laveeshb@laveeshbansal.com>
References: <20261109191842.57359-1-laveeshb@laveeshbansal.com>
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

Test that a vlan filtering bridge with bridge conntrack forwards
fragmented packets whose vlan tag protocol differs from the vlan_protocol
of the bridge.

Send fragmented IPv4 and IPv6 pings through the bridge with matching and
different bridge and vlan protocols, including a promisc bridge and a
tagged egress port, and check that they arrive, that conntrack reassembled
them and that the kernel did not warn. The last check needs
CONFIG_DEBUG_NET.

Signed-off-by: Laveesh Bansal <laveeshb@laveeshbansal.com>
---
 .../testing/selftests/net/netfilter/Makefile  |   1 +
 .../net/netfilter/bridge_ct_vlan_proto.sh     | 198 ++++++++++++++++++
 tools/testing/selftests/net/netfilter/config  |   1 +
 3 files changed, 200 insertions(+)
 create mode 100755 tools/testing/selftests/net/netfilter/bridge_ct_vlan_proto.sh

diff --git a/tools/testing/selftests/net/netfilter/Makefile b/tools/testing/selftests/net/netfilter/Makefile
index df3c20c90f5d..1904f5b80679 100644
--- a/tools/testing/selftests/net/netfilter/Makefile
+++ b/tools/testing/selftests/net/netfilter/Makefile
@@ -12,6 +12,7 @@ TEST_PROGS := \
 	br_netfilter.sh \
 	br_netfilter_queue.sh \
 	bridge_brouter.sh \
+	bridge_ct_vlan_proto.sh \
 	conntrack_clash.sh \
 	conntrack_dump_flush.sh \
 	conntrack_icmp_related.sh \
diff --git a/tools/testing/selftests/net/netfilter/bridge_ct_vlan_proto.sh b/tools/testing/selftests/net/netfilter/bridge_ct_vlan_proto.sh
new file mode 100755
index 000000000000..28e7759655c4
--- /dev/null
+++ b/tools/testing/selftests/net/netfilter/bridge_ct_vlan_proto.sh
@@ -0,0 +1,198 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Fragmented packets in vlans forwarded by a vlan filtering bridge with
+# bridge conntrack. If the protocol of the vlan tag differs from the
+# vlan_protocol of the bridge, the bridge moves the tag into the packet after
+# prerouting, and conntrack has to fragment the reassembled packets again
+# with the tag in front of the ip header.
+#
+# Send fragmented pings through the bridge and check that they arrive, that
+# conntrack reassembled them and that the kernel did not warn.
+#
+#                       ns0 (br0)
+#   ns1 eth0.100 -- veth0 ------- veth1 -- eth1.100 ns2
+
+source lib.sh
+
+# TAINT_WARN, bridge conntrack only warns about the vlan tag on kernels built
+# with CONFIG_DEBUG_NET
+taint_warn=512
+
+checktool "nft --version" "run test without nft tool"
+checktool "bridge -V" "run test without bridge tool"
+
+read -r tainted < /proc/sys/kernel/tainted
+
+trap cleanup_all_ns EXIT
+
+ret=0
+skipped=0
+
+# $1: vlan_protocol of the bridge, $2: protocol of the vlan devices,
+# $3: "tagged" to send the frames out of the bridge tagged with vlan 1
+setup()
+{
+	local br_proto="$1"
+	local vlan_proto="$2"
+	local rx=eth1
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
+		# the bridge treats the tag as part of the packet and the
+		# frames use the default pvid 1.
+		if [ "$br_proto" = "$vlan_proto" ]; then
+			ip netns exec "$ns0" bridge vlan add dev "veth$i" vid 100 ||
+				return "$ksft_skip"
+		fi
+	done
+	ip -net "$ns0" link set br0 up
+
+	ip -net "$ns1" link set eth0 up
+	ip -net "$ns2" link set eth1 up
+
+	if [ "$3" = "tagged" ]; then
+		# The bridge adds a tag with its own protocol on egress, in
+		# front of the vlan 100 tag that is part of the packet.
+		ip netns exec "$ns0" bridge vlan add dev veth1 vid 1 pvid ||
+			return "$ksft_skip"
+		ip -net "$ns2" link add link eth1 name eth1.1 type vlan \
+			protocol "$br_proto" id 1 || return "$ksft_skip"
+		ip -net "$ns2" link set eth1.1 up
+		rx=eth1.1
+	fi
+
+	ip -net "$ns1" link add link eth0 name eth0.100 type vlan \
+		protocol "$vlan_proto" id 100 || return "$ksft_skip"
+	ip -net "$ns2" link add link "$rx" name eth1.100 type vlan \
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
+	# postrouting counters see the packets reassembled by conntrack. Without
+	# reassembly no packet is bigger than the 1400 byte mtu plus the 4 byte
+	# vlan tag. @nh,0,4 is the ip version, which works with a vlan tag
+	# inside the packet.
+	ip netns exec "$ns0" nft -f - <<EOF || return "$ksft_skip"
+table bridge t {
+	counter reasm4 { }
+	counter reasm6 { }
+	chain pre {
+		type filter hook prerouting priority 0; policy accept;
+		ct state new counter
+	}
+	chain post {
+		type filter hook postrouting priority 0; policy accept;
+		@nh,0,4 4 meta length > 1500 counter name "reasm4"
+		@nh,0,4 6 meta length > 1500 counter name "reasm6"
+	}
+}
+EOF
+
+	return 0
+}
+
+# $1: vlan_protocol of the bridge, $2: protocol of the vlan devices,
+# $3: "clone" to make the bridge forward clones, which makes fragmenting take
+#     the slow path, or "tagged", see setup()
+run_case()
+{
+	local desc="$2 vlan on $1 bridge${3:+, $3}"
+	local rc=0
+	local cnt dst
+
+	setup "$1" "$2" "$3"
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
+	for dst in 10.0.100.2 dead:100::2; do
+		cnt=reasm4
+		[ "$dst" = "dead:100::2" ] && cnt=reasm6
+
+		if ip netns exec "$ns1" ping -c 3 -i 0.2 -W 2 -s 3000 -q "$dst" >/dev/null; then
+			echo "PASS: fragmented ping to $dst, $desc"
+		else
+			echo "FAIL: fragmented ping to $dst, $desc"
+			rc=1
+		fi
+
+		if ! ip netns exec "$ns0" nft list counter bridge t "$cnt" |
+		     grep -q "packets [1-9]"; then
+			echo "FAIL: conntrack did not reassemble the packets to $dst, $desc"
+			rc=1
+		fi
+	done
+
+	cleanup_all_ns
+
+	return $rc
+}
+
+# $@: arguments for run_case
+try_case()
+{
+	run_case "$@"
+	case $? in
+	0) ;;
+	"$ksft_skip") skipped=1 ;;
+	*) ret=1 ;;
+	esac
+}
+
+# bridge protocol, protocol of the vlan devices
+try_case 802.1q 802.1q
+try_case 802.1ad 802.1q
+try_case 802.1q 802.1ad
+try_case 802.1ad 802.1q clone
+try_case 802.1ad 802.1q tagged
+
+if [ $((tainted & taint_warn)) -ne 0 ]; then
+	echo "SKIP: kernel had already warned, not checking for a warning"
+else
+	read -r tainted < /proc/sys/kernel/tainted
+	if [ $((tainted & taint_warn)) -ne 0 ]; then
+		echo "FAIL: kernel warned"
+		ret=1
+	fi
+fi
+
+if [ "$skipped" -eq 1 ] && [ "$ret" -eq 0 ]; then
+	exit "$ksft_skip"
+fi
+
+exit $ret
diff --git a/tools/testing/selftests/net/netfilter/config b/tools/testing/selftests/net/netfilter/config
index 629b2b29ed1a..91985320c292 100644
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
2.43.0

