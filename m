Return-Path: <joel.granados@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C2E784187E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A4A2541887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691578227; x=1692183027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FA2Np0axnCcM7zYYQ9J3PNsrfsw3IGeC9vgEKu3nCGU=;
 b=rEyYCnfsy3v2ug/uuoFLOJFvx97QjFH3Ja4HZMdP4ywagN1Opk8E+zw15eNChpRGwe
 NQPtx3FXl6/MJAxf65uU0/tZ91owLPW0nUcSngIU7L7MJI5+ofN10W6SiJdOJzKrwCrk
 dn7hPAPLn54iejr9Gj6f9FzWJEM8tLVE/rLuH7GPZukjcTv6ydi6aVxcw4vbbc60hWhD
 XTwHq2EX8pi1TNUg77QYUmZ1R7SP1UzNhZk2I2tB+gFKeBvKXjkWHmIc2ShCnYm9kZYv
 vxhwgV34w5SpV2tB4e6z8ifiW7cxLXpVQhl7MDJ7US8VK0w5BAzOH4LOZmkDHGVXubwR
 QqJQ==
From: Joel Granados <joel.granados@gmail.com>
Date: Wed,  9 Aug 2023 12:50:01 +0200
Message-Id: <20230809105006.1198165-10-j.granados@samsung.com>
In-Reply-To: <20230809105006.1198165-1-j.granados@samsung.com>
References: <20230809105006.1198165-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v3 09/14] ax.25: Update to register_net_sysctl_sz
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: mcgrof@kernel.org
Cc: Joel Granados <j.granados@samsung.com>, Alexander Aring <alex.aring@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Nikolay Aleksandrov <razor@blackwall.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, linux-sctp@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Mat Martineau <martineau@kernel.org>, Will Deacon <will@kernel.org>, Jan Karcher <jaka@linux.ibm.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Steffen Klassert <steffen.klassert@secunet.com>, linux-s390@vger.kernel.org, rds-devel@oss.oracle.com, Xin Long <lucien.xin@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-rdma@vger.kernel.org, Tony Lu <tonylu@linux.alibaba.com>, bridge@lists.linux-foundation.org, willy@infradead.org, Jozsef Kadlecsik <kadlec@netfilter.org>, lvs-devel@vger.kernel.org, Julian Anastasov <ja@ssi.bg>, coreteam@netfilter.org, Iurii Zaikin <yzaikin@google.com>, Roopa Prabhu <roopa@nvidia.com>, Wen Gu <guwen@linux.alibaba.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Joerg Reuter <jreuter@yaina.de>, Sven Schnelle <svens@linux.ibm.com>, keescook@chromium.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, josh@joshtriplett.org, Wenjia Zhang <wenjia@linux.ibm.com>, Simon Horman <horms@verge.net.au>, Jakub Kicinski <kuba@kernel.org>, linux-hams@vger.kernel.org, mptcp@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Karsten Graul <kgraul@linux.ibm.com>, netfilter-devel@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, "D. Wythe" <alibuda@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, Matthieu Baerts <matthieu.baerts@tessares.net>, linux-wpan@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

Move from register_net_sysctl to register_net_sysctl_sz and pass the
ARRAY_SIZE of the ctl_table array that was used to create the table
variable. We need to move to the new function in preparation for when we
change SIZE_MAX to ARRAY_SIZE() in the register_net_sysctl macro.
Failing to do so would erroneously allow ARRAY_SIZE() to be called on a
pointer. We hold off the SIZE_MAX to ARRAY_SIZE change until we have
migrated all the relevant net sysctl registering functions to
register_net_sysctl_sz in subsequent commits.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 net/ax25/sysctl_net_ax25.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ax25/sysctl_net_ax25.c b/net/ax25/sysctl_net_ax25.c
index 2154d004d3dc..db66e11e7fe8 100644
--- a/net/ax25/sysctl_net_ax25.c
+++ b/net/ax25/sysctl_net_ax25.c
@@ -159,7 +159,8 @@ int ax25_register_dev_sysctl(ax25_dev *ax25_dev)
 		table[k].data = &ax25_dev->values[k];
 
 	snprintf(path, sizeof(path), "net/ax25/%s", ax25_dev->dev->name);
-	ax25_dev->sysheader = register_net_sysctl(&init_net, path, table);
+	ax25_dev->sysheader = register_net_sysctl_sz(&init_net, path, table,
+						     ARRAY_SIZE(ax25_param_table));
 	if (!ax25_dev->sysheader) {
 		kfree(table);
 		return -ENOMEM;
-- 
2.30.2

