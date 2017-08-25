Return-Path: <bhumirks@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=4EcOVHEH1/KZdVqt8qbisQWBZPll0UHZn159PLCKP4k=;
	b=oghlhpIg9u6Oy9XxtVOR2KGdsyg+Uf2muf5DTCt/yTVJDYPv8Zoh2Qb+v26XlVjG38
	u0D4uxjGPZIVdQR1DcVs+zp8NBp1o5gfOJ+/CA07afdikJhK41Rp32/4o3Y8Rv/Ezx8B
	JP9QXhZlkHPBuUfVGgowU2TNXKUkZOXCHGTRbT4Bl9EV0kGzxwO73JQSjNflysyQqKah
	KSrVrvzwtn+I5x7QYJlvq4RwvbuFS0QTYrZHIzdIKbih32BLRaPFUgb51Q/bjCuukm1x
	AA2BnhVNywQVsjSUsysJF/IMHXdrhCloE9MldBs0vmTcbqPKpLzjRfVFBJ834y1WsOI2
	4FTw==
From: Bhumika Goyal <bhumirks@gmail.com>
Message-Id: <1503670907-23221-8-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1503670907-23221-1-git-send-email-bhumirks@gmail.com>
References: <1503670907-23221-1-git-send-email-bhumirks@gmail.com>
Subject: [Bridge] [PATCH 7/7] SUNRPC: make kvec const
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Fri, 25 Aug 2017 14:24:42 -0000
To: julia.lawall@lip6.fr, marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com, davem@davemloft.net, pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de, stephen@networkplumber.org, alex.aring@gmail.com, stefan@osg.samsung.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, santosh.shilimkar@oracle.com, trond.myklebust@primarydata.com, anna.schumaker@netapp.com, bfields@fieldses.org, jlayton@poochiereds.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, bridge@lists.linux-foundation.org, linux-wpan@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, linux-nfs@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Make this const as it is only used during a copy operation.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 net/sunrpc/xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index e34f4ee..a096025 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -998,7 +998,7 @@ void xdr_enter_page(struct xdr_stream *xdr, unsigned int len)
 }
 EXPORT_SYMBOL_GPL(xdr_enter_page);
 
-static struct kvec empty_iov = {.iov_base = NULL, .iov_len = 0};
+static const struct kvec empty_iov = {.iov_base = NULL, .iov_len = 0};
 
 void
 xdr_buf_from_iov(struct kvec *iov, struct xdr_buf *buf)
-- 
1.9.1

