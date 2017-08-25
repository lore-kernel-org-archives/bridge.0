Return-Path: <bhumirks@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=f4epf0R2uJXROaG7I21o3lLDGO97EvZRqxDhHO5dckM=;
	b=R5mYci3sDHfxEAZlP7+Zfxjw79FPt2n3OovHgZTM/qhHPtrmhye496ZFyA5jQQpOmq
	QqnbZedXYFrUR+Gw15x9Ku+g6Ti7e64lOKZCF30anF+zhLUljtbUD3f/KIxVF4TU+M/D
	b91s9yXiisKAWdGE0C/6Gju2HjDRMFqgXZFXsgaoOxyXg9lwUzCVm9eXdNBMkatYW8bq
	EwZrkq62AxNf99YAb0YG+qnGRncE94e+dvUcdupX1Rvdzf+feRuXn1Q28Pgpc3TIXhGo
	fNc77tx31ekipGS9rdbIhpA1Wk3QyJiOkoVVvtbgZkyIyPBbei1vGjcIWSs73x7Zc7eA
	3f2g==
From: Bhumika Goyal <bhumirks@gmail.com>
Message-Id: <1503670907-23221-1-git-send-email-bhumirks@gmail.com>
Subject: [Bridge] [PATCH 0/7] net: make some structures const
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Fri, 25 Aug 2017 14:22:29 -0000
To: julia.lawall@lip6.fr, marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com, davem@davemloft.net, pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de, stephen@networkplumber.org, alex.aring@gmail.com, stefan@osg.samsung.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, santosh.shilimkar@oracle.com, trond.myklebust@primarydata.com, anna.schumaker@netapp.com, bfields@fieldses.org, jlayton@poochiereds.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, bridge@lists.linux-foundation.org, linux-wpan@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, linux-nfs@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Make these const as they are not modified.

Bhumika Goyal (7):
  Bluetooth: 6lowpan: make header_ops const
  bridge: make ebt_table const
  ieee802154: 6lowpan: make header_ops const
  ipv4: make net_protocol const
  RDS: make rhashtable_params const
  netfilter: nat: make rhashtable_params const
  SUNRPC: make kvec const

 net/bluetooth/6lowpan.c            | 2 +-
 net/bridge/netfilter/ebtable_nat.c | 2 +-
 net/ieee802154/6lowpan/core.c      | 2 +-
 net/ipv4/af_inet.c                 | 4 ++--
 net/netfilter/nf_nat_core.c        | 2 +-
 net/rds/bind.c                     | 2 +-
 net/sunrpc/xdr.c                   | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

-- 
1.9.1

