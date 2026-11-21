Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294543;
	b=F9zJmgtMVGUgNvOJgLZCuOQGRcEyalFe5Tq8UM9HTrlRHJ6AhIFrl+7yvNwlEceXJlKi
	 EqQgFDFJewFooRYdYQH5WrBS2XQwCxo/T5iuz6jB3EdIWh3KaoCeTdMYuBE/KmnB67lX3
	 yVsYbwJzjGbCQLCdsZvUnyRcatln+Lj1Fxv+WiJ0trh4RczjR2MC47jp6pdlBg+gXAvGz
	 SOMECk7ErD5v2cWOiyYbORzsslp3wZSl/bS5OEsCea79FXvACF9CQo4VDSjAD5DFE296h
	 a4QT1AXR6wjs0Qg2Q316nsHHUWWic5pedGLkFOZ1flt2hWQrTlWg/g64PovqLioLLEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294543;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iA9GCTJobddBAA9FdF1LmGHUJsNDSuUG1BPvcdAHjlw=;
	b=gLQYLWjguOcH61Bj4a7vW6NKruuqdM84PWzm2/D8FgKVwXm1ZDjhNnjpEiIzIk8p8P+n
	 Y4LBmwu3lhcEnpaJNSKBRR3CYXWikEodju/qJb6rcUp58M2AclgGskANh7qCT3EbUPZVQ
	 d2OLkZ1Hyt6c1wlrepCwoYUTinIIm9FT15kCUuPAPvAuJklzqET86w1lYLc0fs4rypTSq
	 LJ/kZKH2eQTYzYCGLeTOqSueHGe2ZO1xerlKjYfoWweWmdUcx8k+URzkaagH9Yb0oz6O9
	 EbzWEhwYFZu08PY1iGddcx/C1QbLPS+YwJPHJnmL/0Ld3w7Oc0mXq7jbCjatnszhflg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=pqX9l30b;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942E5606A33D
	for <bridge@lists.linux.dev>; Sat, 21 Nov 2026 20:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 942E5606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=pqX9l30b
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4322d310e7so368200166b.0
        for <bridge@lists.linux.dev>; Sat, 21 Nov 2026 12:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1795294540; x=1795899340; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iA9GCTJobddBAA9FdF1LmGHUJsNDSuUG1BPvcdAHjlw=;
        b=pqX9l30byLrw9cjCyi9uAbdmh4EKm1AwwRTVgDqnaMJR7ctjPNmdc6COHpHNBDHHdB
         grnbWmxsaXuvL0Qia6kjqAUpgHDIgT0/6DL9cpvlHBVl2tEO33yCQ1nWtnvsGhbEjRCl
         t7u4Uj1HZt4nvk+mYR5xS7hySY/N+U+vsaWq6dJ0FdU+i+zdEouLuTiVr4S2UPqo3F4n
         b/mgDwsS6F67NCtt7Uipsg8IVoJU+fTb/eKKUiOgBtZJGJD4yf5epuIOVzTKEipnCdWq
         DwL9WWUubV6FRPlrl9+QvWazZlHLKu6girEgvkG4914/W56lIwDcyIXjVypJXgAXhi1E
         1jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795294540; x=1795899340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iA9GCTJobddBAA9FdF1LmGHUJsNDSuUG1BPvcdAHjlw=;
        b=Us0oUBqYuseNfY/YALDkDs6c7mMxaPJszRoOnjai2iaM4hBx550/N6pzYuWQ4pA69I
         CIdSokyDUT/WAdv3ElNR1cBsAlZWGxQRlyHfEdWIVWpIGFUNrAXrxcV4Rubt74UzzJBp
         8g5wss7lrOLOH2Qi6Vj18gCcUzDpAfYaJo+4u3gJGZfztgnj4xetpVBumMV+Zp+B0bJK
         rORnlm3BDB6GTOHEbd2wplX9z6HiuQNb4ktp0mFiyboaz7RoaiS3Odcnr+2dm8Au+HOP
         CXFLwFgaIkSSZNTScOiE+j0m8i/IXZyJiIquKKj7k1cyja2aAMnQJclhoQYxa6VaRBb0
         dnDQ==
X-Forwarded-Encrypted: i=1; AL+hErH6L0qHrR5HnRaOyrNXpOkPgknQSEtqXEiw1TaYMe/Elr2EqVMfevn31MYG4sfkqRyRbSJhm6E=@lists.linux.dev
X-Gm-Message-State: APuU4Z9c9K4f6o8SFlAvGG1bc8gLPU7BWoTQi7ev/k37nbArKaSv5vIx
	KwvE+/6pDLcZ4YRDeND5TVjit+Ox9c1TT126HNVZgl2Rlm0X/QHRZSeLqJE5ruCFdg==
X-Gm-Gg: AZFdTZfYumEScPlOb8BBbdq07T+2TN3ITRZALxTwMT87/JYnOcCfE06ACoDcR1pr908
	qyoXeJ0oUJ7HT9QLZcCC2J++dvHDSh8uTLEYN620Lg3h16OB4oVwl+wh31NhssWDtElKQJDteAR
	RcA9qOpQkzMECeAizjjfas96aMy/sMNCRwcjV+FE7iRt+bfSOQcv0WMvP2s5q5Nb4DTyCWzB1qb
	IZNk+dmXOV12rijQyzgs+3+HfKYChHDT59dviCzfvpw1OC+hkfm6f+CRNFjKLNMRXb3QRF86TTg
	fLB3dISUGpjrQMppsukz95KZgWr5fHo46QaP8Vq0eL3DXaYr7ofdKKhLhW8AlCT1FSKELRu+mNH
	fJRU1LAy54suYGcOWKllkjpu4JkV5fKuB1JuHxJVpUNPYRt8YJ7Cv+GMK5+KfSxEiLSuL0uMNbt
	OyJM7PwrBf3Pxsx7RS7WdRVC13d6J+md3DGSUuUOHcM0RLf/P2nHKaloERehX67UsQCHad4/P+w
	f8nwpXmGKzkNoKjDUyhHUQ0ov3o1WmYQ+OIbaFKrqjE7SNRT8nKapEeZMEkArF9m0DKQIG+3NPX
	muqhF56OxXm2G9oA8I5sx4zUBGEji7HfYkyyD23UQH9vBSjGN0KgmfkyTK1vASFCOibjEKWcEeX
	C8Ij3yeW86HseyQYJaWYrlK7Jt5Y4KT+n5oak6mWHD8MsaIa0JhHxxWBDwPKo4YiC7YhJUT86AZ
	CeVg0zhGPjoM73mXPb8savHs8k2fRCfPibn5s38JeC5Ng/iqfr4ZI6q6Tu+Zi0xtXwY3qK1tPEh
	G8+Vk5tOc76DszdNboCNEP8v/mLFaNuwfE5gpAafNZkHHaYIh3ubySaxJ1Vc6n4ws9I/5DtyYPL
	kbgURBbovXNIHZwesB44hu7kvz1RYqSewsPqPYnvK4VW1DI8ou9g2TkLtDlkHppZKi6EgUHDYL/
	2
X-Received: by 2002:a17:907:9693:b0:c4d:331c:2e97 with SMTP id a640c23a62f3a-c513ab47f5fmr622642366b.36.1795294539912;
        Sat, 21 Nov 2026 12:55:39 -0800 (PST)
Received: from Desktop.tail070c67.ts.net (p200300f2470dfa000000000000000a27.dip0.t-ipconnect.de. [2003:f2:470d:fa00::a27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aea28f4sm237136666b.33.2026.11.21.12.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 12:55:39 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	coreteam@netfilter.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH nf-next v11 3/3] selftests: netfilter: nft_flowtable.sh: roam a host between two bridge ports
Date: Sat, 21 Nov 2026 21:55:35 +0100
Message-ID: <20261121205535.1888592-4-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121205535.1888592-1-julius@bairaktaris.de>
References: <20261121205535.1888592-1-julius@bairaktaris.de>
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

Move a host to another port of a bridge on the router while its flow is
offloaded, and check that the transfer continues and is offloaded again.
The cases are plain and vlan bridge ports, vlan ports whose real devices
are ports of another bridge, "bridge fdb replace", a pinned and then
deleted fdb entry, an aged out entry (the flow must stay), the plain
case over IPv6, and a vlan_filtering bridge with untagged ports, with
tagged plain and vlan ports, and with the router address on a vlan
device on the bridge. Two cases give the ports vid 10 untagged while
their pvid stays 1, with a host that tags what it sends: the router
address on a vlan device on the bridge, and on the bridge with pvid 10.
With "stack" the bridge port is a vlan device of another bridge, and
with "stackout" the host moves from behind that bridge to a port of the
outer one. Three cases check that the flow follows what the bridge
delivers: the host's port is disabled and its vlan leaves the port
(the flow must stop in both), and vlan_filtering is turned off before
the host roams. In two cases the host is the remote end of an IPIP and
an IP6IP6 tunnel on the router, whose flow transmits to the bridge port
below the tunnel.

Without the gc check the transfer stalls when the host moves.

Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
v11: the host roams below an IPIP and an IP6IP6 tunnel on the router,
which Pablo's series offloads as direct xmit to the bridge port
v10: https://lore.kernel.org/netfilter-devel/20261115005555.645727-4-julius@bairaktaris.de/

 .../selftests/net/netfilter/nft_flowtable.sh  | 390 ++++++++++++++++++
 1 file changed, 390 insertions(+)

diff --git a/tools/testing/selftests/net/netfilter/nft_flowtable.sh b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
index 449c518bd947..6ae84472790f 100755
--- a/tools/testing/selftests/net/netfilter/nft_flowtable.sh
+++ b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
@@ -851,6 +851,396 @@ test_ipip
 
 test_bridge
 
+# set by setup_ns, which reuses a name it already holds
+rns1="" rnsr="" rns2=""
+
+# Roam a host between two ports of a bridge on the router while its flow is
+# offloaded, as a station moving between two access points attached to ports
+# of one bridge. The host keeps its address and mac on a bridge of its own and
+# roams by moving that bridge's port, so only the fdb changes. With a vid the
+# bridge ports are vlan devices, whose ifindex differs from the device the
+# flow transmits on. With "replace" the router's fdb entry is sticky and the
+# move is a "bridge fdb replace". With "del" the host stays, its entry is
+# pinned to the other port and then deleted, and a ping relearns it. With
+# "age" the host stays and its entry ages out, which must not tear the flow
+# down. A flow that stays on the fast path leaves no more than a few packets
+# in the forward chain, the counter tells offloaded from slow path. The plain
+# roam also runs over IPv6, and on a vlan_filtering bridge: with untagged
+# ports ("vf"), whose fdb entries are keyed by the pvid of the port, with
+# tagged ports ("tag"), and with untagged ports and the router address on a
+# vlan device on the bridge ("upper"). "asym" and "asymkeep" give the ports
+# vid 10 untagged while their pvid stays 1 and the host tags what it sends,
+# with the router address on a vlan device on the bridge or on the bridge with
+# pvid 10. With "stack" the port of br0 is a vlan device on br1, whose ports
+# the host moves between; with "stackout" the host moves from behind br1 to a
+# port of br0. With "block" the host's port is set to the disabled state,
+# which must stop the flow. With "vdel" the host's vlan leaves its port, which
+# must stop the flow, and with "toggle" vlan_filtering is turned off before
+# the host roams. With "ipip" and "ip6tnl" the host is the remote end of a
+# tunnel on the router, and the flow through the tunnel transmits to the
+# bridge port below it.
+test_bridge_roam()
+{
+	local vid=$1 how=$2 fam=${3:-4} vf=$4 trunk=$5 tun=$6
+	local p0=sr0 p1=sr1 r0=rr0 r1=rr1 rbr=br0
+	local mac=02:00:00:09:01:99
+	local what="roaming on bridge${vf:+ with vlan_filtering}"
+	[ "$vf" = tag ] && what="$what and tagged ports"
+	[ "$vf" = upper ] && what="$what and a vlan device on the bridge"
+	[ "$vf" = asym ] && what="$what, a vlan device on the bridge"
+	[ "$vf" = asymkeep ] && what="$what and the bridge pvid"
+	[ "${vf#asym}" != "$vf" ] && what="$what untagged on ports of pvid 1"
+	what="$what${vid:+ with vlan ports}"
+	case "$how" in
+	block) what="$what, the host's port disabled" ;;
+	vdel) what="$what, the vlan leaving the port" ;;
+	toggle) what="$what, vlan_filtering turned off" ;;
+	?*) what="$what by fdb $how" ;;
+	esac
+	[ "$trunk" = trunk ] &&
+		what="$what whose real devices are ports of another bridge"
+	[ "$trunk" = stack ] && what="$what on a vlan device of another bridge"
+	[ "$trunk" = stackout ] &&
+		what="$what from a vlan device of another bridge to a port"
+	local ftdevs="rr0, rr1, rw0"
+	local hn=10.9.1 wn=10.9.2 dot=. len=24 nodad="" ip6="" srv=10.9.2.99
+	local min=10000000
+	local dev old new slow fdb lpid cpid win=2
+
+	if [ "$fam" = 6 ]; then
+		hn=dead:9:1 wn=dead:9:2 dot=:: len=64 nodad=nodad ip6=-6
+		srv="[dead:9:2::99]"
+		what="$what over IPv6"
+	fi
+	[ "$tun" = ipip ] && what="$what below an IPIP tunnel"
+	[ "$tun" = ip6tnl ] && what="$what below an IP6IP6 tunnel"
+
+	setup_ns rns1 rnsr rns2
+	# router solicitations of the host would pass the bridge and refresh
+	# its fdb entry
+	if [ "$fam" = 4 ]; then
+		ip netns exec "$rns1" sysctl -q \
+			net.ipv6.conf.all.disable_ipv6=1 \
+			net.ipv6.conf.default.disable_ipv6=1
+	fi
+
+	if ! ip -net "$rnsr" link add br0 type bridge \
+	     ${vf:+vlan_filtering 1} 2>/dev/null; then
+		echo "SKIP: could not add bridge for $what"
+		[ "$ret" -eq 0 ] && ret=$ksft_skip
+		return
+	fi
+
+	ip link add sr0 netns "$rns1" type veth peer name rr0 netns "$rnsr"
+	ip link add sr1 netns "$rns1" type veth peer name rr1 netns "$rnsr"
+	ip link add rw0 netns "$rnsr" type veth peer name w0 netns "$rns2"
+	if [ "$trunk" = stackout ]; then
+		ip link add sr2 netns "$rns1" type veth peer name rr2 \
+			netns "$rnsr"
+		ip -net "$rns1" link set sr2 up
+		ip -net "$rnsr" link set rr2 up
+		ftdevs="$ftdevs, rr2"
+	fi
+	for dev in sr0 sr1; do
+		ip -net "$rns1" link set "$dev" up
+	done
+	for dev in rr0 rr1; do
+		ip -net "$rnsr" link set "$dev" up
+	done
+
+	if [ -n "$vid" ]; then
+		for dev in sr0 sr1; do
+			ip -net "$rns1" link add link "$dev" name "$dev.$vid" \
+				type vlan id "$vid"
+			ip -net "$rns1" link set "$dev.$vid" up
+		done
+		p0=sr0.$vid; p1=sr1.$vid
+	fi
+	if [ -n "$vid" ] && [ "${trunk#stack}" = "$trunk" ]; then
+		for dev in rr0 rr1; do
+			ip -net "$rnsr" link add link "$dev" name "$dev.$vid" \
+				type vlan id "$vid"
+			ip -net "$rnsr" link set "$dev.$vid" up
+		done
+		r0=rr0.$vid; r1=rr1.$vid
+	fi
+	if [ -n "$trunk" ]; then
+		ip -net "$rnsr" link add br1 type bridge
+		ip -net "$rnsr" link set rr0 master br1
+		ip -net "$rnsr" link set rr1 master br1
+		ip -net "$rnsr" link set br1 up
+	fi
+	if [ "${trunk#stack}" != "$trunk" ]; then
+		ip -net "$rnsr" link add link br1 name br1.$vid \
+			type vlan id "$vid"
+		ip -net "$rnsr" link set br1.$vid up
+		r0=br1.$vid; r1=br1.$vid
+	fi
+	# the host moves from behind br1 to a port of br0
+	[ "$trunk" = stackout ] && { r1=rr2; p1=sr2; }
+
+	ip -net "$rnsr" link set "$r0" master br0
+	[ "$r1" != "$r0" ] && ip -net "$rnsr" link set "$r1" master br0
+	ip -net "$rnsr" link set br0 up
+	if [ "$vf" = tag ]; then
+		for dev in "$r0" "$r1"; do
+			bridge -n "$rnsr" vlan add vid 10 dev "$dev"
+		done
+		bridge -n "$rnsr" vlan add vid 10 dev br0 self pvid untagged
+		for dev in "$p0" "$p1"; do
+			ip -net "$rns1" link add link "$dev" name "$dev.10" \
+				type vlan id 10
+			ip -net "$rns1" link set "$dev.10" up
+		done
+		p0=$p0.10; p1=$p1.10
+	elif [ "$vf" = upper ]; then
+		for dev in "$r0" "$r1"; do
+			bridge -n "$rnsr" vlan add vid 10 dev "$dev" \
+				pvid untagged
+		done
+		bridge -n "$rnsr" vlan add vid 10 dev br0 self
+		ip -net "$rnsr" link add link br0 name br0.10 type vlan id 10
+		ip -net "$rnsr" link set br0.10 up
+		rbr=br0.10
+	elif [ "$vf" = asym ] || [ "$vf" = asymkeep ]; then
+		# vid 10 leaves the ports untagged but is not their pvid; the
+		# host tags what it sends, so the entry is learned in vid 10.
+		for dev in "$r0" "$r1"; do
+			bridge -n "$rnsr" vlan add vid 10 dev "$dev" untagged
+		done
+		if [ "$vf" = asym ]; then
+			bridge -n "$rnsr" vlan add vid 10 dev br0 self
+			ip -net "$rnsr" link add link br0 name br0.10 \
+				type vlan id 10
+			ip -net "$rnsr" link set br0.10 up
+			rbr=br0.10
+		else
+			bridge -n "$rnsr" vlan add vid 10 dev br0 self \
+				pvid untagged
+		fi
+	fi
+	ip -net "$rnsr" addr add $hn${dot}1/$len dev $rbr $nodad
+	ip -net "$rnsr" addr add $wn${dot}1/$len dev rw0 $nodad
+	ip -net "$rnsr" link set rw0 up
+	ip netns exec "$rnsr" sysctl -q net.ipv4.ip_forward=1
+	ip netns exec "$rnsr" sysctl -q net.ipv6.conf.all.forwarding=1
+
+	# the host takes untagged frames into vid 10 and sends it tagged
+	host_port() {
+		ip -net "$rns1" link set "$1" master stbr
+		if [ "$vf" = asym ] || [ "$vf" = asymkeep ]; then
+			bridge -n "$rns1" vlan add vid 10 dev "$1" pvid
+			bridge -n "$rns1" vlan del vid 1 dev "$1"
+		fi
+	}
+	ip -net "$rns1" link add stbr type bridge
+	if [ "$vf" = asym ] || [ "$vf" = asymkeep ]; then
+		ip -net "$rns1" link set stbr type bridge vlan_filtering 1
+		bridge -n "$rns1" vlan add vid 10 dev stbr self pvid untagged
+		bridge -n "$rns1" vlan del vid 1 dev stbr self
+	fi
+	ip -net "$rns1" link set stbr address $mac
+	host_port "$p0"
+	ip -net "$rns1" link set stbr up
+	ip -net "$rns1" addr add $hn${dot}99/$len dev stbr $nodad
+	ip $ip6 -net "$rns1" route add default via $hn${dot}1
+
+	ip -net "$rns2" addr add $wn${dot}99/$len dev w0 $nodad
+	ip -net "$rns2" link set w0 up
+	ip $ip6 -net "$rns2" route add default via $wn${dot}1
+
+	if [ -n "$tun" ]; then
+		local tn=10.9.3 wnet=$wn.0
+		[ "$fam" = 6 ] && tn=dead:9:3 wnet=$wn::
+		if ! ip -net "$rnsr" link add rtun type "$tun" \
+		     local $hn${dot}1 remote $hn${dot}99 \
+		     ${ip6:+encaplimit none}; then
+			echo "SKIP: could not add tunnel for $what"
+			[ "$ret" -eq 0 ] && ret=$ksft_skip
+			return
+		fi
+		ip -net "$rns1" link add stun type "$tun" \
+			local $hn${dot}99 remote $hn${dot}1 \
+			${ip6:+encaplimit none}
+		ip -net "$rnsr" link set rtun up
+		ip -net "$rns1" link set stun up
+		ip -net "$rnsr" addr add $tn${dot}1/$len dev rtun $nodad
+		ip -net "$rns1" addr add $tn${dot}99/$len dev stun $nodad
+		ip $ip6 -net "$rns1" route add $wnet/$len dev stun
+	fi
+
+	# no neighbour probes, so the host only sends when it receives
+	ip -net "$rnsr" neigh replace $hn${dot}99 lladdr $mac nud permanent \
+		dev $rbr
+	ip -net "$rns1" neigh replace $hn${dot}1 nud permanent dev stbr \
+		lladdr "$(ip -net "$rnsr" -br link show br0 | awk '{print $3}')"
+
+	if ! ip netns exec "$rnsr" nft -f - <<EOF
+table inet filter {
+  counter roam_repl { }
+  flowtable f1 { hook ingress priority 0; devices = { $ftdevs }; }
+  chain forward {
+    type filter hook forward priority 0; policy accept;
+    meta oif "rw0" tcp dport 12345 flow add @f1
+    meta iif "rw0" tcp sport 12345 counter name roam_repl flow add @f1
+  }
+}
+EOF
+	then
+		echo "SKIP: could not load ruleset for $what"
+		[ "$ret" -eq 0 ] && ret=$ksft_skip
+		return
+	fi
+
+	# the host discards what it receives, its socket byte counter is read
+	rx_bytes() { ip netns exec "$rns1" ss -tin "dst $srv" 2>/dev/null |
+		grep -o 'bytes_received:[0-9]*' | head -1 | cut -d: -f2; }
+	rx_started() { local n; n=$(rx_bytes); [ "${n:-0}" -gt 0 ]; }
+	# forward chain packets of the reply direction since the last call
+	slow_pkts() { ip netns exec "$rnsr" \
+			nft reset counter inet filter roam_repl |
+		grep -o 'packets [0-9]*' | cut -d' ' -f2; }
+	roam_listener_ready() {
+		ss -N "$rns2" -lnt -o "sport = :12345" | grep -q 12345
+	}
+
+	roam_stop() {
+		kill "$cpid" "$lpid" 2>/dev/null
+		wait "$cpid" "$lpid" 2>/dev/null
+	}
+
+	timeout $((SOCAT_TIMEOUT * 5)) ip netns exec "$rns2" socat -u \
+		OPEN:/dev/zero TCP$fam-LISTEN:12345,reuseaddr &
+	lpid=$!
+	if ! busywait "$BUSYWAIT_TIMEOUT" roam_listener_ready; then
+		echo "FAIL: $what: listener did not start" 1>&2
+		ret=1
+		kill "$lpid" 2>/dev/null; wait "$lpid" 2>/dev/null
+		return
+	fi
+	timeout $((SOCAT_TIMEOUT * 5)) ip netns exec "$rns1" socat -u \
+		TCP$fam:$srv:12345 OPEN:/dev/null &
+	cpid=$!
+
+	if ! busywait "$BUSYWAIT_TIMEOUT" rx_started; then
+		echo "FAIL: $what: transfer did not start" 1>&2
+		ret=1
+		roam_stop
+		return
+	fi
+	sleep 2
+	slow_pkts > /dev/null
+	old=$(rx_bytes)
+	sleep 2
+	new=$(rx_bytes)
+	slow=$(slow_pkts)
+	if [ -z "$slow" ] || [ $((${new:-0} - ${old:-0})) -lt $min ] ||
+	   [ "$slow" -gt 100 ]; then
+		echo "FAIL: $what: not offloaded before the roam:" \
+		     "$((${new:-0} - ${old:-0})) bytes," \
+		     "${slow:-no} forward chain packets" 1>&2
+		ret=1
+		roam_stop
+		return
+	fi
+
+	if [ "$how" = age ]; then
+		# ageing_time is in centiseconds
+		ip -net "$rnsr" link set br0 type bridge ageing_time 200
+		win=10
+	elif [ "$how" = del ]; then
+		bridge -n "$rnsr" fdb replace $mac dev "$r1" \
+			master static sticky
+		sleep 2
+		bridge -n "$rnsr" fdb del $mac dev "$r1" master static
+		ip netns exec "$rns1" ping $ip6 -c 2 -W 1 -q $hn${dot}1 \
+			>/dev/null 2>&1
+	elif [ "$how" = block ]; then
+		# the bridge no longer delivers there, nor may the flow; the
+		# disabled state sticks without STP and keeps the fdb
+		bridge -n "$rnsr" link set dev "$r0" state 0
+	elif [ "$how" = vdel ]; then
+		# the bridge no longer delivers to the host, nor may the flow
+		bridge -n "$rnsr" vlan del vid 1 dev "$r0"
+	else
+		# roam: move the host bridge to the other port and send on it
+		if [ "$how" = toggle ]; then
+			ip -net "$rnsr" link set br0 type bridge \
+				vlan_filtering 0
+			sleep 2
+		fi
+		if [ "$how" = replace ]; then
+			bridge -n "$rnsr" fdb replace $mac dev "$r0" \
+				master static sticky
+		fi
+		ip -net "$rns1" link set "$p0" nomaster
+		host_port "$p1"
+		ip netns exec "$rns1" ping $ip6 -c 2 -W 1 -q $hn${dot}1 \
+			>/dev/null 2>&1
+		if [ "$how" = replace ]; then
+			bridge -n "$rnsr" fdb replace $mac dev "$r1" \
+				master static sticky
+		fi
+	fi
+
+	# the bytes in flight at the roam drain within the first seconds; a
+	# stale flow delivers nothing after that, a torn down one resumes and
+	# is offloaded again.
+	sleep 4
+	old=$(rx_bytes)
+	sleep 4
+	new=$(rx_bytes)
+	slow_pkts > /dev/null
+	sleep $win
+	slow=$(slow_pkts)
+	# before the host's FIN passes the bridge and relearns the entry
+	fdb=$(bridge -n "$rnsr" fdb show br br0 | grep "$mac.*master")
+	roam_stop
+
+	if [ "$how" = vdel ] || [ "$how" = block ]; then
+		if [ $((${new:-0} - ${old:-0})) -gt 0 ]; then
+			echo "FAIL: $what: $((${new:-0} - ${old:-0})) bytes" \
+			     "delivered to a port that does not forward" 1>&2
+			ret=1
+		else
+			echo "PASS: flow offload for $what"
+		fi
+	elif [ "$how" = age ] && [ -n "$fdb" ]; then
+		echo "FAIL: $what: the host's fdb entry did not age out" 1>&2
+		ret=1
+	elif [ $((${new:-0} - ${old:-0})) -lt $min ]; then
+		echo "FAIL: $what: transfer stalled after the roam" 1>&2
+		ret=1
+	elif [ "$slow" != 0 ]; then
+		echo "FAIL: $what: $slow forward chain packets after the roam" \
+			1>&2
+		ret=1
+	else
+		echo "PASS: flow offload for $what"
+	fi
+}
+
+test_bridge_roam ""
+test_bridge_roam 100
+test_bridge_roam "" replace
+test_bridge_roam "" del
+test_bridge_roam "" age
+test_bridge_roam "" "" 6
+test_bridge_roam "" "" 4 vf
+test_bridge_roam "" "" 4 tag
+test_bridge_roam 100 "" 4 tag
+test_bridge_roam 100 "" 4 "" trunk
+test_bridge_roam 100 "" 4 "" stack
+test_bridge_roam 100 "" 4 "" stackout
+test_bridge_roam "" block
+test_bridge_roam "" vdel 4 vf
+test_bridge_roam "" toggle 4 vf
+test_bridge_roam "" "" 4 upper
+test_bridge_roam "" "" 4 asym
+test_bridge_roam "" "" 4 asymkeep
+test_bridge_roam "" "" 4 "" "" ipip
+test_bridge_roam "" "" 6 "" "" ip6tnl
+
 KEY_SHA="0x"$(ps -af | sha1sum | cut -d " " -f 1)
 KEY_AES="0x"$(ps -af | md5sum | cut -d " " -f 1)
 SPI1=$RANDOM
-- 
2.53.0

