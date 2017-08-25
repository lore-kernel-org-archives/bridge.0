Return-Path: <bhumirks@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=082xeCy+8Xn/1LiA3sTNYiPaFB70YPaDY6P5z5YhH+g=;
	b=MWLh5pkKslHUn+zu7PXGz8KBZa0tFV/dk1G9z3wLr44RALFSwHYfaZ2xaAdotd+deg
	MhwgS63ZMUCF5vwe7OUtd2fOU+zLitRWQdecFwR8AlibIfgxob9480YBETqQTwOb5Rxc
	gwzInNA+1EKIpz4sYNZ651Hf8vifFz06gwvJE1GQwjg1SYnAeAO9tsbFzmLfdU86o71S
	Ry3LPNbCZUV9+U6tFAWCyQbLWK34XfjO2n/LjtxBBeqLEHcHKyM7U2cjLEMbjqNa0kwF
	wUgIxI2EzMna11qqXZI7+Ny//aDhOalLONvn1dhKwT+b3p+ycObyqhE3KQGwrD4L7/Wn
	OZBQ==
From: Bhumika Goyal <bhumirks@gmail.com>
Message-Id: <1503670907-23221-5-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1503670907-23221-1-git-send-email-bhumirks@gmail.com>
References: <1503670907-23221-1-git-send-email-bhumirks@gmail.com>
Subject: [Bridge] [PATCH 4/7] ipv4: make net_protocol const
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Fri, 25 Aug 2017 14:23:46 -0000
To: julia.lawall@lip6.fr, marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com, davem@davemloft.net, pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de, stephen@networkplumber.org, alex.aring@gmail.com, stefan@osg.samsung.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, santosh.shilimkar@oracle.com, trond.myklebust@primarydata.com, anna.schumaker@netapp.com, bfields@fieldses.org, jlayton@poochiereds.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, bridge@lists.linux-foundation.org, linux-wpan@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, linux-nfs@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Make these const as they are only passed to a const argument of the
function inet_add_protocol.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 net/ipv4/af_inet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index d678820..19aee07 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1596,7 +1596,7 @@ u64 snmp_fold_field64(void __percpu *mib, int offt, size_t syncp_offset)
 };
 #endif
 
-static struct net_protocol tcp_protocol = {
+static const struct net_protocol tcp_protocol = {
 	.early_demux	=	tcp_v4_early_demux,
 	.early_demux_handler =  tcp_v4_early_demux,
 	.handler	=	tcp_v4_rcv,
@@ -1606,7 +1606,7 @@ u64 snmp_fold_field64(void __percpu *mib, int offt, size_t syncp_offset)
 	.icmp_strict_tag_validation = 1,
 };
 
-static struct net_protocol udp_protocol = {
+static const struct net_protocol udp_protocol = {
 	.early_demux =	udp_v4_early_demux,
 	.early_demux_handler =	udp_v4_early_demux,
 	.handler =	udp_rcv,
-- 
1.9.1

