Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294539;
	b=xYUKFRWVYy+wYIOc47fHFW+WgQBsT9LFHQdq0SOkoKhpcCkshxFlD9vKJp1JI6BNOG3o
	 kXySKUbipxmVn1WFcYCxbq5pDrGckHDE5fa4UmK1UCztDbf2nxCWV9P2lQ+7A5rCRvGcW
	 u8u49+NUWlLpid46cV2zS2TdckbDODc3Nd17jCT6EoDaFk0Ni9oCEa8SbLHbXxTPf0OAN
	 ofJEDEGAF66ggqcAfEOV2YFl3v/cLyG2i9Sk7h2BnsmCGfdNuDAR2KFTBve4nwqcsCPJa
	 25F4NKbyVYoqNTBH3ltRv2lQsAoeE2xmL/Y98e/Xy2CzYOl2BE80YMzWa3beyUnx8VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FH6CAC7V6zrcojqtjKmAk9ZWlQF+y6QKr70PrUGFm5M=;
	b=OBalSKxIcWr2E0E4wc10zkihmBuV5DUHWfA3RYasmd+VhJqp7N8nzTKTKSzrMc9bq2g2
	 FhwD9JhhHbQqBZ62aEp0mb4E1l5Bos5pvUAeRsLjbXX2c5Hqsx5tFaWgT9rHOxagH0Uus
	 p9U9Cjws8FYItgMFuCVZplw9yB5rSmoNQuqihOHcb9Sp3Ja3ggBupgDVFhn77dDaLnIfm
	 2/jg1vvdCsimMbFtn2/mQ4wg5SPR8Vq3T+ghdy+nPqa0W6AczQ+iBZ5EuIp0K8dX++4SS
	 OQK2vFOGnkZnULH/SJ4FhyX1aGNwBN98E4EWSc+dJ70gWR1V/xSwC8iGyWApwlcnc5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=sBqte3pF;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F10D606A336
	for <bridge@lists.linux.dev>; Sat, 21 Nov 2026 20:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F10D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=sBqte3pF
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c50d3ac6b51so669305266b.1
        for <bridge@lists.linux.dev>; Sat, 21 Nov 2026 12:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1795294536; x=1795899336; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FH6CAC7V6zrcojqtjKmAk9ZWlQF+y6QKr70PrUGFm5M=;
        b=sBqte3pFvu4QocirGqgFBGlF+b+WvgHmCUALIYK0pyzzKTJ1vEItI+H8sRtcY6J3qg
         d6jnFV/wA4Kx7kkBLovM9OHz2u7bLRKzbRTSnGpJYNlROkgJig5mXgQseyfmxlm4mHOq
         GDzd/+K4ydigB07Qj6twBYmk5+AJKCXvQ6ebDD+/4zFGoSc8RnQwJQGiudV5hesKZbAc
         4s1RVjZlN0EteTXmZz4Ox/vCSE4F6bEtGQk6y4IUPULnw2KirWpHgEzshQuBKfEnJRlx
         egdbkgYLtetlQuTxxRBbcRD5x5fZyDlPywGihlOSp1aUT1SSyV7F5YX6HCc2ds8mmK68
         Me2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795294536; x=1795899336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FH6CAC7V6zrcojqtjKmAk9ZWlQF+y6QKr70PrUGFm5M=;
        b=oK7Bu8YFalrTdLa+rh2nUOQwwgO3LdyffIQylblM+gu1uGRdhm84/JHrLO7NlGgquk
         jDwuh77KFONVXHh/JxYdOLVCIlMEFiUezFLF389g/9HYUCKAKkPx95ud8EOKxa+gDqLm
         jjwcGhgP2pVN/7fmyj9/+Hp00I3Mpi2OQr1LQ07UGC89D4l2xwzM3xCF7Pqa8uFK6RbF
         /VRf9t7HTwSTTl5dgBZ3VEH7toREaE79IlRjEgjZvLoyA5doJ9OLn/QT9ILuDgIc6rlt
         BtOgNH7kNZy3RGKp6qAS1/Wq+U1bPb04h6i+2NFTUwS98S4jo02RyQ0Ptsu1yjrLXtUG
         a29Q==
X-Forwarded-Encrypted: i=1; AL+hErFeHq/k873c2bgKTHGOZtBs3xgDGej+OFoyXpmHNojPbV2MSGxfPQP96qGOmJkYvS0nmJkOeNY=@lists.linux.dev
X-Gm-Message-State: APuU4Z/V0UKdZ5gcPDHdNkHNjKY/rTzhDhJPifANhGhf9crA6AM7g7Ds
	VebtSQTFFiuLgNk19s2WbIyEnShaB6H1dtw01wnOCq5bCIVFm/Na9snJhHpyc8UrGA==
X-Gm-Gg: AZFdTZeIi/iXo1Ff6vg0ixrQ8NGK4ZW9Lqqpp2LFHC9Qojo78qk6wK2aLGJVz+YZ0gS
	2V5Pg1oAym1DhSF6BqxnoNLRfRSOhH6a6Z31UBdXRiFN6epw2j0HSDWyoV09e6OxV7nPkqD3kLO
	peyz9ozff9JBAfU4D4VkSRGA30d6EENius6A1MVesGIxFTbMGYgCMIhB91vg74vRfQlsJAE+fbq
	Vx+IM3ry7H5s3rgFs2huBTh7Je/I2QvEMJy0cbd5VfayjHBY3rcXQ2b/EIqH/nVk5cpSuwhrUW6
	WlEN6bugCKmxrA8Za4rFbHzZdzlvDQk4f961MC0EcyYV8L7EFGFMwpw8VJpOTcu5C8o7oYvXQxY
	fhhY7b/P7pwZIVKSFU41PH2dX9Zas4FjqXnz1lHTDC/7Wzx1HY7yuBh3OCJTusW1J1PZDtXZcy8
	s5kQLs/R3QDKFqafMx4UF8Tz0A9Bx99713sZb+yqH5FuxJkjQKbF+LqymsDWzn7Km6tBPTVQDGS
	KyMzo2qBNCBoqafQDCCE74jQZY9iKpec8jCtsBxz/ArLgz7KTlOnyKN126V9/WphpjrmpZr+8rb
	tZQ771HKaBktMiZ4bHTBE/3eRw97FFGVA4I1cMkX8MvuP3S9NN3nVOQB7FQNWxxhHGLpot3ATb1
	7Btj+0SnkFbx156Jux8kZPKL8NtTC4/EFmTsWB1uD956ugZoBH6MAaJh//cC5Q2gNTMy6XfDw2t
	FaezDXDkT4vQf2Sv2uemwxA9Y2ZBB2MwTKdlz8FmznnKqnv0g4fPWsiKExQ1xt80Z/1B79KJ/mS
	J8C9o1G4pEpNAZwKAoBeMREOzMq7w13bsaCA3ouYpQVF4CA9EWRjsGcviWLd7j7BlUiZ0AISz1r
	n6YUvsG7fG91pDvkeuklV8y4u1JUxBIITtOnOLyxlaT8+x2h3TO3N3Q=
X-Received: by 2002:a17:907:3e86:b0:c36:777f:824c with SMTP id a640c23a62f3a-c51315851d7mr813630666b.4.1795294535198;
        Sat, 21 Nov 2026 12:55:35 -0800 (PST)
Received: from Desktop.tail070c67.ts.net (p200300f2470dfa000000000000000a27.dip0.t-ipconnect.de. [2003:f2:470d:fa00::a27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aea28f4sm237136666b.33.2026.11.21.12.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 12:55:34 -0800 (PST)
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
Subject: [PATCH nf-next v11 0/3] netfilter: flowtable: tear down bridged flows on layer 2 roaming
Date: Sat, 21 Nov 2026 21:55:32 +0100
Message-ID: <20261121205535.1888592-1-julius@bairaktaris.de>
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

A flowtable flow that transmits straight to a bridge port keeps sending
to the old port when the host moves to another port, for example a Wi-Fi
station roaming between access points.

The series applies on top of Pablo's "netfilter: flowtable: unify direct
and neigh xmit path" series (nf, v6):
https://lore.kernel.org/netfilter-devel/20261120225227.3565643-1-pablo@netfilter.org/
His series is posted for nf; this series is for nf-next and applies once
nf, with his series, has been merged into nf-next.

Patch 1 is a bridge fix the series needs: br_fill_forward_path() fills a
path to a port that does not forward (STP blocking or disabled, an MST
vlan not forwarding), so the flowtable transmits where the bridge would
not. Patch 2 makes the gc tear a flow down when the fdb entry moves or
the port no longer forwards in its vid. It is Pablo's patch with my
changes on top: it keeps his authorship, his Signed-off-by from his
posting and a note of what I changed. Patch 3 adds selftest cases.

The gc finds the bridge port from out.ifidx through the vlan devices of
the path and the bridge from the port, and looks the entry up in the vid
the forward path used, which the tuple now keeps in out.bridge_vid. With
two bridges on the path it also checks the outer one. Neigh xmit flows
need no such check: a forward path through a bridge always makes the
flow direct xmit. struct flow_offload grows from 296 to 312 bytes on
x86_64; its slab cache is SLAB_HWCACHE_ALIGN, so an object takes 320
bytes either way. A gc pass over 2000 flows, 1021 of them offloaded to a
bridge port, took 368 to 393 us with the series and 261 to 276 us
without it (median of each of three runs), and no flow was torn down.

Tested on nf-next 994089a3fa38 with Pablo's series in an x86_64 guest:
nft_flowtable.sh passes three runs out of three with PROVE_LOCKING and
three out of three with KASAN and PROVE_LOCKING, including the twenty
roaming cases in both of its passes, with no lockdep or KASAN report.
Without this series every roaming case but "del" and "age" fails, the
two tunnel cases included. net/netfilter and net/bridge build without
warnings with W=1 (x86_64 allmodconfig), each patch on its own, and with
BRIDGE_VLAN_FILTERING off.

I used Claude (Anthropic) to help write these patches.

Changes in v11:
- rebased onto nf-next and Pablo's xmit series: the gc checks the fdb
  entry after his nf_flow_dst_check_gc()
- selftest: the host roams below an IPIP and an IP6IP6 tunnel on the
  router; Pablo's series offloads such a flow as direct xmit to the
  bridge port

Changes in v10:
- the tuple keeps the vid of the fdb lookup (out.bridge_vid) instead of
  the bridge_vlan bit and the port pvid: a bridge vlan that leaves the
  port untagged is popped from the encap stack (DEV_PATH_BR_VLAN_UNTAG)
  or never pushed (DEV_PATH_BR_VLAN_KEEP), so v9 looked in the pvid of
  the port, which is another vlan when the untagged one is not the pvid,
  and kept the stale flow (Sashiko). This answers Pablo's v7 question on
  bridge_vid: no bit can recover that vid
- the gc also tears the flow down when the port stops forwarding in its
  vid (STP blocking or a disabled port, a vlan removed from the port,
  vlan_filtering toggled); v9 kept sending to a disabled port and in a
  vlan removed from the port. The new patch 1 keeps the forward path
  from recreating such a flow
- with two stacked bridges the gc checks the outer one too; v9 checked
  only the bridge of the transmit port and missed a move on the outer
- selftest: vid 10 untagged on ports of pvid 1 through a vlan device on
  the bridge and through the bridge pvid; a move from behind the inner
  to a port of the outer bridge; the host's port disabled; the vlan
  leaving the port; vlan_filtering turned off before a roam
- selftest: the IPv4 roaming cases turn IPv6 off on the host, whose
  router solicitations crossed the bridge and refreshed the entry the
  "age" case waits to expire (2 of 8 runs failed)
- selftest: lines wrapped to 80 columns, namespace names initialised
  (NIPA checkpatch and shellcheck on v9)
- Cc coreteam and linux-kselftest (NIPA cc_maintainers on v9)

Changes in v9:
- reset port_vlans at each bridge in the forward path, so the gc checks
  the bridge the flow transmits on: with a vlan device of one bridge
  enslaved to another, v8 counted the vlans below both bridges, looked
  up the bridge port from the wrong device and read past encap[]
  (Sashiko)
- selftest: a bridge port that is a vlan device of another bridge
- selftest: the roaming cases give socat five times SOCAT_TIMEOUT, as
  roam_stop() ends it; on a loaded host a case took 109 s and the 60 s
  timeout ended the transfer before the check
- authorship: Pablo's patch is credited as such, with his sign-off from
  his posting and a note of my changes, instead of Co-developed-by; his
  paragraph on the switchdev notifier alternative is back in the commit
  message
- rebased onto current nf-next

Changes in v8:
- drop bridge_ifidx and bridge_vid (Pablo): the bridge port is found
  from out.ifidx through the vlan devices below the port, the vid comes
  from the encap stack (bridge_vlan bit) or is the pvid of an untagged
  port of a vlan_filtering bridge
- the fdb check sits in nf_flow_dst_valid() next to nf_flow_dst_check(),
  the hook is fdb_valid_dst() again, and the comments Pablo pointed out
  are gone

v10: https://lore.kernel.org/netfilter-devel/20261115005555.645727-1-julius@bairaktaris.de/
v9: https://lore.kernel.org/netfilter-devel/20261108155344.35845-1-julius@bairaktaris.de/
v8: https://lore.kernel.org/netfilter-devel/20261017235849.1066624-1-julius@bairaktaris.de/
v7: https://lore.kernel.org/netfilter-devel/20261014235628.197976-1-julius@bairaktaris.de/
v6: https://lore.kernel.org/netfilter-devel/20261004171605.3544792-1-julius@bairaktaris.de/
v5: https://lore.kernel.org/netfilter-devel/20260914072541.897040-1-julius@bairaktaris.de/
Pablo's patch: https://lore.kernel.org/netfilter-devel/20261014210256.1573072-1-pablo@netfilter.org/

Julius Bairaktaris (2):
  net: bridge: fill a forward path only to a port that forwards
  selftests: netfilter: nft_flowtable.sh: roam a host between two bridge
    ports

Pablo Neira Ayuso (1):
  netfilter: flowtable: tear down direct xmit flows when the fdb entry
    moves

 include/linux/netfilter.h                     |   7 +
 include/net/netfilter/nf_flow_table.h         |  22 +-
 net/bridge/Makefile                           |   2 +
 net/bridge/br.c                               |   2 +
 net/bridge/br_device.c                        |   2 +-
 net/bridge/br_forward.c                       |  19 +
 net/bridge/br_nf_utils.c                      |  35 ++
 net/bridge/br_private.h                       |  14 +
 net/netfilter/core.c                          |   3 +
 net/netfilter/nf_flow_table_core.c            |  68 ++-
 net/netfilter/nf_flow_table_path.c            |  29 +-
 .../selftests/net/netfilter/nft_flowtable.sh  | 390 ++++++++++++++++++
 12 files changed, 587 insertions(+), 6 deletions(-)
 create mode 100644 net/bridge/br_nf_utils.c


base-commit: 994089a3fa3882f27f4bed9fc5815ee7df502e88
prerequisite-patch-id: d7af24391d138e7c6afe5585de4a14c8bba23c67
prerequisite-patch-id: dfb16f54f47b0c18b09eeeeccba9725bd15a6c7d
prerequisite-patch-id: 9949846db34c9fa718ff1968445bcb618920f93b
-- 
2.53.0

