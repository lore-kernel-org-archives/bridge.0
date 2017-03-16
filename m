Return-Path: <avagin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=VxRjo3qHuCXSl07yC7raLPUrFSUTCTsQihdy17pAcDo=;
	b=n7NDeOStKjgbhBJoNL5H14COHvop0vivQYf3xNO26Hao7xN3fCw6O6klyF7W0ixfo1
	5bvtE7r6fr3HDnU9Eny9wurCGmdAsYn5+AtxIxxvn/gU+cXE5wDjTFkdlUdAdejXn3zd
	LW6E0HqOmAt6cMmZl1OpV/Z3GVVokXgtMaMK4YyjVhjFvQsTxYr+HaYhhI5AKdiJnl0I
	TPg1b/LUbzPdAXeKL/lUFgm/E6BXy5YYvKUvWe+mHtDdu2os+8GXeJpBxm7dBIzyUzHu
	iNBvFbH8IxGrV3AID2phXVOamb1bFx5kSrXx7Xt3mEbN77Gp+PJ4NL66nXvZgtI1V6oD
	WPPA==
MIME-Version: 1.0
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 15 Mar 2017 18:12:52 -0700
Message-ID: <CANaxB-zhLdJLz1AHdensX_zfQ7O3rzjhJn5eSTWC1tUAk2axTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Bridge] linux-next: WARNING: CPU: 1 PID: 19544 at
	net/bridge/br_fdb.c:109 br_fdb_find+0x19d/0x1b0
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linux Kernel Network Developers <netdev@vger.kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, bridge@lists.linux-foundation.org

Hello,

We execute CRIU tests for linux-next and here is a new warning:
[  178.930950] ------------[ cut here ]------------
[  178.930960] WARNING: CPU: 1 PID: 19544 at net/bridge/br_fdb.c:109
br_fdb_find+0x19d/0x1b0
[  178.930961] Modules linked in:
[  178.930966] CPU: 1 PID: 19544 Comm: criu Not tainted
4.11.0-rc1-next-20170310 #1
[  178.930968] Hardware name: Google Google Compute Engine/Google
Compute Engine, BIOS Google 01/01/2011
[  178.930970] Call Trace:
[  178.930976]  dump_stack+0x85/0xc9
[  178.930982]  __warn+0xd1/0xf0
[  178.930988]  warn_slowpath_null+0x1d/0x20
[  178.930990]  br_fdb_find+0x19d/0x1b0
[  178.930994]  br_fdb_change_mac_address+0x38/0x80
[  178.930999]  br_stp_change_bridge_id+0x44/0x140
[  178.931003]  br_dev_newlink+0x3f/0x70
[  178.931009]  rtnl_newlink+0x68e/0x830
[  178.931014]  ? netlink_broadcast_filtered+0x134/0x3e0
[  178.931025]  ? get_partial_node.isra.76+0x4b/0x2a0
[  178.931032]  ? nla_parse+0xa3/0x100
[  178.931035]  ? nla_strlcpy+0x5b/0x70
[  178.931037]  ? rtnl_link_ops_get+0x39/0x50
[  178.931040]  ? rtnl_newlink+0x158/0x830
[  178.931064]  rtnetlink_rcv_msg+0x95/0x230
[  178.931068]  ? rtnl_newlink+0x830/0x830
[  178.931072]  netlink_rcv_skb+0xa7/0xc0
[  178.931075]  rtnetlink_rcv+0x2a/0x40
[  178.931078]  netlink_unicast+0x15b/0x210
[  178.931082]  netlink_sendmsg+0x31a/0x3a0
[  178.931089]  sock_sendmsg+0x38/0x50
[  178.931092]  ___sys_sendmsg+0x26c/0x280
[  178.931099]  ? __generic_file_write_iter+0x19b/0x1e0
[  178.931105]  ? up_write+0x1f/0x40
[  178.931110]  ? ext4_file_write_iter+0xa4/0x390
[  178.931120]  __sys_sendmsg+0x45/0x80
[  178.931126]  SyS_sendmsg+0x12/0x20
[  178.931130]  entry_SYSCALL_64_fastpath+0x23/0xc2
[  178.931132] RIP: 0033:0x2b71009f99a0
[  178.931134] RSP: 002b:00007ffed7413c58 EFLAGS: 00000246 ORIG_RAX:
000000000000002e
[  178.931137] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00002b71009f99a0
[  178.931139] RDX: 0000000000000000 RSI: 00007ffed7413c90 RDI: 0000000000000002
[  178.931140] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  178.931142] R10: 00002b710180cfe0 R11: 0000000000000246 R12: 0000000000000001
[  178.931144] R13: 0000000000000004 R14: 00007ffed74134b0 R15: 0000000000000003
[  178.931152] ---[ end trace 61d5dd5e3b9abaf8 ]---
[  178.931453] IPv6: ADDRCONF(NETDEV_UP): zdtmbr0: li

All logs are here:
https://s3.amazonaws.com/archive.travis-ci.org/jobs/211220073/log.txt
