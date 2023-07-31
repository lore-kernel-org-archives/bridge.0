Return-Path: <joel.granados@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C417681DF4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E79C781DEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690787875; x=1691392675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5noSV5uL5R3dSrbr/R0oWH8ijMnn3jtlsPFspVagWKY=;
 b=SdrDkcAXByY0sJ7+rsAQdKfwmVG3c5WCPbN//BnCCScfOVUkasmGjo067IR+VtoRFo
 D6fwH8JniXv/Aup+rPGRbJrL8OTu9SbMmBiODdKPF8oMnV5nnhT5Dk8pAsrGnQ1wlSD+
 ZPSjKJj0Pl4FANdos20Y/es0ysWL5w8sQZmI+ZHUBkv+tuJ1lk6dlgDvkzs/df09zXrj
 ozr7xMnnfqrKvmouPpdXKljCbCEOiFQv0X/hWykCE2eIqIt79Ja2MJK+869pNwih6sKq
 TE5UeaBofIs4fRFHFLZTtsmqowO2I2B2j/4dl6w9Zz7MLeQMomK17YoLSMVAB2k5xiif
 a5kw==
From: Joel Granados <joel.granados@gmail.com>
Date: Mon, 31 Jul 2023 09:17:27 +0200
Message-Id: <20230731071728.3493794-14-j.granados@samsung.com>
In-Reply-To: <20230731071728.3493794-1-j.granados@samsung.com>
References: <20230731071728.3493794-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v2 13/14] sysctl: SIZE_MAX->ARRAY_SIZE in
	register_net_sysctl
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: mcgrof@kernel.org
Cc: Joel Granados <j.granados@samsung.com>, Wen Gu <guwen@linux.alibaba.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Catalin Marinas <catalin.marinas@arm.com>, Nikolay Aleksandrov <razor@blackwall.org>, Alexander Aring <alex.aring@gmail.com>, linux-sctp@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, Jan Karcher <jaka@linux.ibm.com>, Mat Martineau <martineau@kernel.org>, Will Deacon <will@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Steffen Klassert <steffen.klassert@secunet.com>, linux-s390@vger.kernel.org, rds-devel@oss.oracle.com, Xin Long <lucien.xin@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-rdma@vger.kernel.org, Tony Lu <tonylu@linux.alibaba.com>, bridge@lists.linux-foundation.org, willy@infradead.org, Jozsef Kadlecsik <kadlec@netfilter.org>, lvs-devel@vger.kernel.org, Julian Anastasov <ja@ssi.bg>, coreteam@netfilter.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Joerg Reuter <jreuter@yaina.de>, Christian Borntraeger <borntraeger@linux.ibm.com>, Kees Cook <keescook@chromium.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, josh@joshtriplett.org, Jani Nikula <jani.nikula@linux.intel.com>, Wenjia Zhang <wenjia@linux.ibm.com>, Simon Horman <horms@verge.net.au>, linux-hams@vger.kernel.org, mptcp@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Iurii Zaikin <yzaikin@google.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, netfilter-devel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, Matthieu Baerts <matthieu.baerts@tessares.net>, linux-wpan@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>

Replace SIZE_MAX with ARRAY_SIZE in the register_net_sysctl macro. Now
that all the callers to register_net_sysctl are actual arrays, we can
call ARRAY_SIZE() without any compilation warnings. By calculating the
actual array size, this commit is making sure that register_net_sysctl
and all its callers forward the table_size into sysctl backend for when
the sentinel elements in the ctl_table arrays (last empty markers) are
removed. Without it the removal would fail lacking a stopping criteria
for traversing the ctl_table arrays.

Stopping condition continues to be based on both table size and the
procname null test. This is needed in order to allow for the systematic
removal al the sentinel element in subsequent commits: Before removing
sentinel the stopping criteria will be the last null element. When the
sentinel is removed then the (correct) size will take over.

Signed-off-by: Joel Granados <j.granados@samsung.com>
Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
---
 include/net/net_namespace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index e4e5fe75a281..75dba309e043 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -470,7 +470,7 @@ void unregister_pernet_device(struct pernet_operations *);
 struct ctl_table;
 
 #define register_net_sysctl(net, path, table)	\
-	register_net_sysctl_sz(net, path, table, SIZE_MAX)
+	register_net_sysctl_sz(net, path, table, ARRAY_SIZE(table))
 #ifdef CONFIG_SYSCTL
 int net_sysctl_init(void);
 struct ctl_table_header *register_net_sysctl_sz(struct net *net, const char *path,
-- 
2.30.2

