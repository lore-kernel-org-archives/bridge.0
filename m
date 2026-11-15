Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794704165;
	b=YKd2g1pu/XeEfYf7Gp5zz/9nGr6w78tD9OsbCBel5vo3vTUB2OoUr8T3kZR34k6LdBum
	 HoEqtf1Z49kLrCkzPCAtHdrcZqi6Zt8/OAOwKdT9GvcrDBiAoLZ0ICrcr8GHp3YAWy1jm
	 fXh35RGun/SSLAv2uwh8zqybSYK9obWf/veysuIujxfWuQ+z972Bz2mVqK5oL+o7qXCaX
	 c8bhDwhy/oCFWkP4eRqhsbLMLufe53DQd4MbsFfBfSrSWhvFN2hXwM4t0bDy61C5hW2Hu
	 qDGP1Lt+4Q/A/q3w3qYX5+DE1xNP6j/IhDSDW2FNIhPyPfIfWkWPLY5cZxvVoI1PMoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794704165;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TEe8D5P09T7tDxCiTRWgdiV435JqX7aUW5WkZ/vkqBo=;
	b=paCLe2TMuCf8K4elvSm148K+slTKAG3X4JziHYp+vIT7TwfNAYLFeOOs+DNZVbQAB1EC
	 mA5ECiPd1C3RAxED16dbPJ949n/gT5Tozg18D3LrYdioQA9OQJZiUYtlTvUNlUt9I+b6i
	 XOIyqP68lL89K4fn+iWxNSi68VR8R4ZYeZKXI3pzFQi57FjdvLijg7G4usEctA1z4iWs0
	 aoLciSUg+aOVPaDtSHswpWYakiWfTpDcE+xGlr7oWepRyAb4gzYjfCgOm2rm3YX2nAuyV
	 +/o6unzyThwgulTU5NKBrgbVwGHiVlg1GnX44KItQcYBes3uJKXrV0HjeWuWpLGYRYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=Teb9SuPC;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AD6606A329
	for <bridge@lists.linux.dev>; Sun, 15 Nov 2026 00:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22AD6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=Teb9SuPC
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4d581da0aaso294727566b.2
        for <bridge@lists.linux.dev>; Sat, 14 Nov 2026 16:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1794704163; x=1795308963; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TEe8D5P09T7tDxCiTRWgdiV435JqX7aUW5WkZ/vkqBo=;
        b=Teb9SuPC0sGk7jRrqycm5zXMg2RZQnHcyAnoecM2bjE8oKCPd0NNjc4ku4d0ldRc8d
         pf/x9SsDEVo/RKW6TCE6ngZPKEJ2xfcY1MH84XJq+hMVf/K4u7Ih5injIIPz10PtYj9/
         yPc8R3u7XAPdYSdvhpLEZoHZ0RPAWIeQMInV5pxzv+EMUjrW2+CHD5J8BNBiHEz1QwgU
         3KmUVPLDCDoCVd25UMEYezRVE4mHREaJIUPlxrbDyZsnjS5up1iZAUdRzS3MBsF9AsBi
         iFeC+B+NfgiBXXjm6ApgirdioO0uI5cz6njlxIgBHW1202YryThvDjXLN7zM4kRvNaLu
         FQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794704163; x=1795308963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TEe8D5P09T7tDxCiTRWgdiV435JqX7aUW5WkZ/vkqBo=;
        b=dRO3vnTYZWvtRwy91y4DLJc4mP9NRT3NbUICrBDuCKqTsS3vg6wrwUNATeYSoqpcH7
         hwLyS9CetQpVnadvKs3eiXJo6FtPGRFMMuzMRUZaYfk/CR5jiBFXV2IL+hrqEBesdVpk
         7mJaYn6CLLIcjyBRy+IPjNXbSncz3bJ7BymCqu96/GYmL69q6BzYOOfcdQBl6Czqgk7I
         aZncsgAlZ/qCTiFMmaxrkjw8kVefYkz5qSwgezUuC5njhRsaeyDXnl/rTCldeW4dxsbB
         gfXC90qo/OR9YG1qyMPzvaztAQh1BQ3FZvb7qQ64qkebRMcRH6bGA3zLN8QeTSwsUSjN
         WBeQ==
X-Forwarded-Encrypted: i=1; AL+hErHmSv3W1cIYwaKRDA+hG+AKmvkLnwAR2a/1dF3cmjv1SCHgfmw6XKYNwsYwWDKASF9hxw1ivBk=@lists.linux.dev
X-Gm-Message-State: APuU4Z8D2M1Ki1J2xRtU7hHKEw3ZEiQfioRhENUA56lfz/Mc3eny9QLe
	8M3y7VzhJp0h59XBsOwOfrDrFxR1N3+Ewtqu6dDBeO6WFKSMoJDeG8sa6WVMAr+vdA==
X-Gm-Gg: AYBFou3WiEDwi/+gJ25aXGnVmVBBfwVgqZVIPY3NTTnFOZrhapKUPkBbbGqj/83wPbZ
	1ykG0pq24tLe/AkppI81fHPRJG/4cnmM1B6EZf/dTtH4nx4aDsv88hGPE7x3zruyO+jl+TyaA4W
	i1heiHshizXVjiAnL1A/2wdbZX4N1T90zUE5KWb15s0WplkrlTOKEIBrYiRY90cKx51/n58MSL4
	srYpSSwyeME5ehYtQePTU8xNMmxM/thKS8uRoqAVzHjiaipRup+awZCSlUwNhGeGNLK25BL1InV
	Ekg0SE300IzHgcCsfERChGopPYs2vwZlnEDiJCPodZjxEohrT1UHnWg8qSBxQqub9fJe+y+wEzj
	y4z0br8/N5avLvHgy/lLigwb0ckDBmUgTOc1hec44j3Vs8GqWbNU3m6On3bnaEKLeRPQ2gUtusd
	O5tMY7dx5tiTr2+sMcQBA3T62tneDcirs5y0m0eM0eYkH/YsHIeC77LtdUU2l4Ud7IHqyPVfXJa
	CySx7ClBv/z3XvdWMwhCFgHpRLY1A/VpzaeUgm4vfJIDlBxtXR+p9etiOa3YwmvIChR2P2oI93p
	rsXijkg9v7f0lkMiNwlbN7q1GSFir0EnHMYlos7yfYITOEoWYBTw11gVk4dApreNR49QR0rNA6f
	/mZEhTySkEVtLy4p6laMCgV0NB5zew7R51XNbe11dRgZvvk+otbQkDpM08HB6pfAGQ/ORwUTegz
	Ee22ZxCnsKSHLyxTO8KI8L3rmgbudbt5oGwhYQxHkb4QdbT63hHLbsJhk+3vzserXqAb5eHvGOt
	XqaI3HAeBtMsDTTkqwibuqfhx718yNB/XffwrckQARdUJeTpHu4EstiUbQPF9u/3krjTZLV641v
	k/lZnmdtBdz0hlf1+7ojWDEm0Rf2s73W6L/oBQcDhNXGois6qoH+GKJ10qRzQ2CgvUUGqvXl
X-Received: by 2002:a17:907:3d44:b0:c40:4965:72c3 with SMTP id a640c23a62f3a-c509637c12emr491035466b.19.1794704162921;
        Sat, 14 Nov 2026 16:56:02 -0800 (PST)
Received: from Desktop (p200300f2470a670069e45948b1a17361.dip0.t-ipconnect.de. [2003:f2:470a:6700:69e4:5948:b1a1:7361])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b921d4sm266313166b.83.2026.11.14.16.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 16:56:01 -0800 (PST)
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
Subject: [PATCH nf-next v10 0/3] netfilter: flowtable: tear down bridged flows on layer 2 roaming
Date: Sun, 15 Nov 2026 01:55:52 +0100
Message-ID: <20261115005555.645727-1-julius@bairaktaris.de>
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
two bridges on the path it also checks the outer one. struct
flow_offload grows from 296 to 312 bytes on x86_64; its slab cache is
SLAB_HWCACHE_ALIGN, so an object takes 320 bytes either way. A gc pass
over 2000 flows, 1021 of them offloaded to a bridge port, took 277 to
278 us with the series and 171 to 281 us without it (median of each of
three runs), and no flow was torn down.

Tested on nf-next 734bef548a96 in an x86_64 guest with PROVE_LOCKING:
nft_flowtable.sh passes three runs out of three, including the eighteen
roaming cases in both of its passes, with no lockdep splat; the "block"
case took its final form after those runs and passes three runs of its
own. On v9 the cases for the fixes of this version fail (stacked
bridges, the untagged vlan that is not the pvid, the disabled port, the
vlan leaving the port); without the series every roaming case but "del"
and "age" fails. net/netfilter and net/bridge build without warnings
with W=1 (x86_64 allmodconfig), each patch on its own, and with
BRIDGE_VLAN_FILTERING off.

I used Claude (Anthropic) to help write these patches.

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
 net/netfilter/nf_flow_table_core.c            |  68 +++-
 net/netfilter/nf_flow_table_path.c            |  29 +-
 .../selftests/net/netfilter/nft_flowtable.sh  | 364 ++++++++++++++++++
 12 files changed, 561 insertions(+), 6 deletions(-)
 create mode 100644 net/bridge/br_nf_utils.c


base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.53.0

