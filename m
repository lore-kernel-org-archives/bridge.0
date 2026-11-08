Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794153229;
	b=1Tv1iTWm3QLXwFfo9dDD/q9oFDFa0doL6hXobujunEbIMT4HUmL3PrPLMGmL4xjCiP/Y
	 TI9i4gKTSI9eca3UmJkTX4zUPALEVZsGVmdS+iaHphU+QaIMykft9M0WS0jEfbs6Dkv/k
	 mh66OFvPz/K5eR1voxrNTDeHOvU8dscTdMehVZNRe7rT9h/++1EYZEGKOVWHbsfQjFY1f
	 Uc60HlMr26vBwgq0khPx2eP3poI/Sr43VStCMSsIOp+3L07RT1TBxgJmNLo/+DStPFdNW
	 D+KTL7F1jDQnVXVtyQD1I6diCqWS21v5OLI+BmhMrkZA5ZGVQqPCLxGEROPkw+5qebw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794153229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FubH8KoHiuIQlI9rasAoR9CVcyoiptaz9tuOv9X2T9A=;
	b=TJylDfgK2GY3OSrG4D+rNeIbNxvzD2bOMRxYVDYDZQTTsZyq9vfbpBJ46GFkAf8UbCd1
	 L5RwVOAEJRMsnZYkJxBGCp7YaKg7OVuIfFWBs/d2YjAfL9KFzl6hBT5uhkc181f+877T5
	 VMKyAgYuo9JU9CLnACOmvate6I272i7joIDEN0ELLg1vrgMb3kqSeQfFVopKhqG6BFtC4
	 HF+eig2ZKnsCctzgJQJFFYHMmXU9BBO8M9jNvPHaOY3prHkWzcg2O3yLhllo9sJkkfGB2
	 onMUIYS+aZ0o8VgHZEzKoZ+hNpYREXEkM9FGY0S1XhLf3AOgkm9ZHsG6gDzAOct37Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=QwR56Dqt;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F1D606D806
	for <bridge@lists.linux.dev>; Sun,  8 Nov 2026 15:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87F1D606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=QwR56Dqt
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c3fd91337baso25260066b.3
        for <bridge@lists.linux.dev>; Sun, 08 Nov 2026 07:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1794153227; x=1794758027; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FubH8KoHiuIQlI9rasAoR9CVcyoiptaz9tuOv9X2T9A=;
        b=QwR56DqtOkw7EuwwTrymyskVyc7SHlpnJHcrDaxkFGxujgtV6KOVO8G41Aaa3FZ1+b
         TJKBjS1rHBqhYaz8vaAJ2tJWUOOfcj96fs177FpIdqJ7QERHh9o92OUD1AY08nTd0mhx
         Uzltr1bEe3TchiZ2EsMg7rjtMRXRc70F45BEurdFDUJOA3MBI2kXE3dOxb5R0xz5FhtD
         f6LiuJL0wcpQjVhgRXQ0hjmyblFdQgmhsTyjRnpS3+dKlY2BXNO+e24txgdXMOOdICGc
         Ybqz0GeUDYVHBH3VWt2R5rHLqvniUNvUtmZzwxLP+RgAEyBnRy6EuEiPOGrr5POkTAsE
         8T1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794153227; x=1794758027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FubH8KoHiuIQlI9rasAoR9CVcyoiptaz9tuOv9X2T9A=;
        b=XdtERq56yYM0BbwgUkcz9BXds8PqR90jTFpF5CmdtBni77+dnGk5ycyjov0M/b3DQL
         dOPb3FaTIxdQN5j+2WnjupeONJMwMs/q01yYZDf+L/cQWjPJpivCxvOMYyIsKrzpStEi
         MHQkwH4csiUuHH+yDVQt5U8J9bTDSRVeh2Eh8C60jdnR/vd4ZQS4xLx/xVfFesxpIlKR
         ZqL4J9V+VoPc9ORaxrX49bwPhPpeOMP2a+JDHrPwrjBFBkRFIdEuRkLGkCziA9F6VSS9
         UmFN4b/SRPff1PnlAUk/e9tIoWbSHdFLePfWw+KmZ+vLS2rK4Bo3a8sR2Gwm3XPwWfm2
         Shrg==
X-Forwarded-Encrypted: i=1; AL+hErHM/03qACIiwCWgJPK1/3Jtzm7wVZlOrw0vACwGY0XB2CLKxIhXEbgUeFSTSu9vMPke6zMQGUk=@lists.linux.dev
X-Gm-Message-State: APuU4Z8+45qwPB2nbAgRxKuWXOwPOwvyRpHbPtRIhdPX3ACRmT79Huco
	AbdwIqxkFA3bCFdQ955dUGMrVOt5SHJdhm1qwZdW7GTrykuhLTByBads+gwZTTKu3g==
X-Gm-Gg: AYBFou2alhcyV+IJcFqMPkCm7hoYZnv7POr5xQ/AIEEKqO+wl+PShuwdlp26Umbu+Bz
	v515mgFgBIX4IM+FQhKY6aoZEgmpVh/ngDBZKb+mfbamWEURLtcCQP3YQvTxUTa6EfZTZ5YbLEQ
	2XOZHa2SCCj6IHRzDoyh/Y0Ryf2XEnIv6RtubK6IkCgOdv6PNIarBQ8bOftElp7MYeetY3VN74p
	JpDmmj4e3REX/7f9wM52iSPem5TTVVf+tRdCXHWrOK6wB6lqogNpmmq4db3JHkbwFSvTtvsaPZy
	EQeVGbfU0NR5FVW3k6qnkCBcVYM0hlK/T3+mQBFFnxg8MfYj21xzPe5ZjmiyZggtD+sJLZhR218
	88IUKNmhikiaASJ4l1sVAMGuclATgcbkK+U1F7Y4OMTOQRITNk4h8prZnmzBhbHLBXvVbCGBLSq
	tghZZv9VEgoSQZP55vjPf1WFaSn5BeIGuQ8PLYXTeWvkTjYtQSZPnbsPJjdm1aMnnN90VceJf2z
	qKruBwJ16Qyd2wXZHiNtoHUMmzLxjpPN2RFlO9gwXKoAgO4KXzXNgoudNCEhrDDmKZIGuKBaVVP
	3bwUhAnYlqv+3IJY9BuT2nFk6IFSTLxhavQ5K0+jjIEsYu2K6ozYNHVIE74px6KckBMlxvfKmxu
	H8Em3txJf3TLk8MyDSjk1jb0UFgj6DJLOdY5FL/B5UQ+YquLjkOUJNyOUqcjr6DfYUGtETzVRUw
	9qMxq7tf2i2JlmjvC6NUaHGLQjzCQnWGwqIn7rM66hQXJcUlN+8mWugaWd8drkbRm2378XkmSiv
	k+x4nFlyX/cM+HhXTREKHvO7ggpCU724plAdAQ50pxTpYWVkbtUmVOf0o6ldEqNcz0Nh/RUGJjO
	6dcqQ3IBMy9m7vOGwgw=
X-Received: by 2002:a17:907:2d13:b0:c4d:331c:2e97 with SMTP id a640c23a62f3a-c4d6d7d957dmr125306866b.36.1794153226811;
        Sun, 08 Nov 2026 07:53:46 -0800 (PST)
Received: from Desktop (p54aff56f.dip0.t-ipconnect.de. [84.175.245.111])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d68d52f4bsm71648166b.8.2026.11.08.07.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 07:53:46 -0800 (PST)
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
	bridge@lists.linux.dev
Subject: [PATCH nf-next v9 2/2] selftests: netfilter: nft_flowtable.sh: roam a host between two bridge ports
Date: Sun,  8 Nov 2026 16:53:44 +0100
Message-ID: <20261108155344.35845-3-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108155344.35845-1-julius@bairaktaris.de>
References: <20261108155344.35845-1-julius@bairaktaris.de>
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
device on the bridge. The last case makes a vlan device of another
bridge the bridge port.

Without the gc check the transfer stalls when the host moves.

Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 .../selftests/net/netfilter/nft_flowtable.sh  | 251 ++++++++++++++++++
 1 file changed, 251 insertions(+)

diff --git a/tools/testing/selftests/net/netfilter/nft_flowtable.sh b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
index 449c518bd947d..ed6eb2e3204ed 100755
--- a/tools/testing/selftests/net/netfilter/nft_flowtable.sh
+++ b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
@@ -851,6 +851,257 @@ test_ipip
 
 test_bridge
 
+# Roam a host between two ports of a bridge on the router while its flow is
+# offloaded, as a station moving between two access points attached to ports
+# of one bridge. The host keeps its address and mac on a bridge of its own
+# and roams by moving that bridge's port, so only the fdb changes. With a vid
+# the bridge ports are vlan devices, whose ifindex differs from the device
+# the flow transmits on. With "replace" the router's fdb entry is sticky and
+# the move is a "bridge fdb replace". With "del" the host stays, its entry is
+# pinned to the other port and then deleted, and a ping relearns it. With
+# "age" the host stays and its entry ages out, which must not tear the flow
+# down. A flow that stays on the fast path leaves no more than a few packets
+# in the forward chain, the counter tells offloaded from slow path. The
+# plain roam also runs over IPv6, and on a vlan_filtering bridge: with
+# untagged ports ("vf"), whose fdb entries are keyed by the pvid of the
+# port, with tagged ports ("tag"), and with untagged ports and the router
+# address on a vlan device on the bridge ("upper"). With "stack" the port of
+# br0 is a vlan device on br1, whose ports the host moves between.
+test_bridge_roam()
+{
+	local vid=$1 how=$2 fam=${3:-4} vf=$4 trunk=$5
+	local p0=sr0 p1=sr1 r0=rr0 r1=rr1 rbr=br0
+	local mac=02:00:00:09:01:99
+	local what="roaming on bridge${vf:+ with vlan_filtering}"
+	[ "$vf" = tag ] && what="$what and tagged ports"
+	[ "$vf" = upper ] && what="$what and a vlan device on the bridge"
+	what="$what${vid:+ with vlan ports}${how:+ by fdb $how}"
+	[ "$trunk" = trunk ] &&
+		what="$what whose real devices are ports of another bridge"
+	[ "$trunk" = stack ] && what="$what on a vlan device of another bridge"
+	local hn=10.9.1 wn=10.9.2 dot=. len=24 nodad="" ip6="" srv=10.9.2.99
+	local min=10000000
+	local dev old new slow fdb lpid cpid win=2
+
+	if [ "$fam" = 6 ]; then
+		hn=dead:9:1 wn=dead:9:2 dot=:: len=64 nodad=nodad ip6=-6
+		srv="[dead:9:2::99]"
+		what="$what over IPv6"
+	fi
+
+	setup_ns rns1 rnsr rns2
+
+	if ! ip -net "$rnsr" link add br0 type bridge ${vf:+vlan_filtering 1} 2>/dev/null; then
+		echo "SKIP: could not add bridge for $what"
+		[ "$ret" -eq 0 ] && ret=$ksft_skip
+		return
+	fi
+
+	ip link add sr0 netns "$rns1" type veth peer name rr0 netns "$rnsr"
+	ip link add sr1 netns "$rns1" type veth peer name rr1 netns "$rnsr"
+	ip link add rw0 netns "$rnsr" type veth peer name w0 netns "$rns2"
+	for dev in sr0 sr1; do
+		ip -net "$rns1" link set "$dev" up
+	done
+	for dev in rr0 rr1; do
+		ip -net "$rnsr" link set "$dev" up
+	done
+
+	if [ -n "$vid" ]; then
+		for dev in sr0 sr1; do
+			ip -net "$rns1" link add link "$dev" name "$dev.$vid" type vlan id "$vid"
+			ip -net "$rns1" link set "$dev.$vid" up
+		done
+		p0=sr0.$vid; p1=sr1.$vid
+	fi
+	if [ -n "$vid" ] && [ "$trunk" != stack ]; then
+		for dev in rr0 rr1; do
+			ip -net "$rnsr" link add link "$dev" name "$dev.$vid" type vlan id "$vid"
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
+	if [ "$trunk" = stack ]; then
+		ip -net "$rnsr" link add link br1 name br1.$vid type vlan id "$vid"
+		ip -net "$rnsr" link set br1.$vid up
+		r0=br1.$vid; r1=br1.$vid
+	fi
+
+	ip -net "$rnsr" link set "$r0" master br0
+	ip -net "$rnsr" link set "$r1" master br0
+	ip -net "$rnsr" link set br0 up
+	if [ "$vf" = tag ]; then
+		for dev in "$r0" "$r1"; do
+			bridge -n "$rnsr" vlan add vid 10 dev "$dev"
+		done
+		bridge -n "$rnsr" vlan add vid 10 dev br0 self pvid untagged
+		for dev in "$p0" "$p1"; do
+			ip -net "$rns1" link add link "$dev" name "$dev.10" type vlan id 10
+			ip -net "$rns1" link set "$dev.10" up
+		done
+		p0=$p0.10; p1=$p1.10
+	elif [ "$vf" = upper ]; then
+		for dev in "$r0" "$r1"; do
+			bridge -n "$rnsr" vlan add vid 10 dev "$dev" pvid untagged
+		done
+		bridge -n "$rnsr" vlan add vid 10 dev br0 self
+		ip -net "$rnsr" link add link br0 name br0.10 type vlan id 10
+		ip -net "$rnsr" link set br0.10 up
+		rbr=br0.10
+	fi
+	ip -net "$rnsr" addr add $hn${dot}1/$len dev $rbr $nodad
+	ip -net "$rnsr" addr add $wn${dot}1/$len dev rw0 $nodad
+	ip -net "$rnsr" link set rw0 up
+	ip netns exec "$rnsr" sysctl -q net.ipv4.ip_forward=1
+	ip netns exec "$rnsr" sysctl -q net.ipv6.conf.all.forwarding=1
+
+	ip -net "$rns1" link add stbr type bridge
+	ip -net "$rns1" link set stbr address $mac
+	ip -net "$rns1" link set "$p0" master stbr
+	ip -net "$rns1" link set stbr up
+	ip -net "$rns1" addr add $hn${dot}99/$len dev stbr $nodad
+	ip $ip6 -net "$rns1" route add default via $hn${dot}1
+
+	ip -net "$rns2" addr add $wn${dot}99/$len dev w0 $nodad
+	ip -net "$rns2" link set w0 up
+	ip $ip6 -net "$rns2" route add default via $wn${dot}1
+
+	# no neighbour probes, so the host only sends when it receives
+	ip -net "$rnsr" neigh replace $hn${dot}99 lladdr $mac nud permanent dev $rbr
+	ip -net "$rns1" neigh replace $hn${dot}1 nud permanent dev stbr \
+		lladdr "$(ip -net "$rnsr" -br link show br0 | awk '{print $3}')"
+
+	if ! ip netns exec "$rnsr" nft -f - <<EOF
+table inet filter {
+  counter roam_repl { }
+  flowtable f1 { hook ingress priority 0; devices = { rr0, rr1, rw0 }; }
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
+	slow_pkts() { ip netns exec "$rnsr" nft reset counter inet filter roam_repl |
+		grep -o 'packets [0-9]*' | cut -d' ' -f2; }
+	roam_listener_ready() { ss -N "$rns2" -lnt -o "sport = :12345" | grep -q 12345; }
+
+	roam_stop() { kill "$cpid" "$lpid" 2>/dev/null; wait "$cpid" "$lpid" 2>/dev/null; }
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
+		     "$((${new:-0} - ${old:-0})) bytes, ${slow:-no} forward chain packets" 1>&2
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
+		bridge -n "$rnsr" fdb replace $mac dev "$r1" master static sticky
+		sleep 2
+		bridge -n "$rnsr" fdb del $mac dev "$r1" master static
+		ip netns exec "$rns1" ping $ip6 -c 2 -W 1 -q $hn${dot}1 >/dev/null 2>&1
+	else
+		# roam: move the host bridge to the other port and send on it
+		if [ "$how" = replace ]; then
+			bridge -n "$rnsr" fdb replace $mac dev "$r0" master static sticky
+		fi
+		ip -net "$rns1" link set "$p0" nomaster
+		ip -net "$rns1" link set "$p1" master stbr
+		ip netns exec "$rns1" ping $ip6 -c 2 -W 1 -q $hn${dot}1 >/dev/null 2>&1
+		if [ "$how" = replace ]; then
+			bridge -n "$rnsr" fdb replace $mac dev "$r1" master static sticky
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
+	if [ "$how" = age ] && [ -n "$fdb" ]; then
+		echo "FAIL: $what: the host's fdb entry did not age out" 1>&2
+		ret=1
+	elif [ $((${new:-0} - ${old:-0})) -lt $min ]; then
+		echo "FAIL: $what: transfer stalled after the roam" 1>&2
+		ret=1
+	elif [ "$slow" != 0 ]; then
+		echo "FAIL: $what: $slow forward chain packets after the roam" 1>&2
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
+test_bridge_roam "" "" 4 upper
+
 KEY_SHA="0x"$(ps -af | sha1sum | cut -d " " -f 1)
 KEY_AES="0x"$(ps -af | md5sum | cut -d " " -f 1)
 SPI1=$RANDOM
-- 
2.53.0

