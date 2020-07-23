Return-Path: <BATV+7f5d9d19594706390c49+6178+infradead.org+hch@casper.srs.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=AjKHhDGZLqL4OuQUXI3ghPRn4d0K9eK+41+WmsKDw4s=; b=CNu8wX7/4AaScPiP+yKasX/Nuq
 00LHKTXAD3IquBRcEMSnRF8bNgMD1cvHh+U+oC9aYlopzyBcHDT20XOh1UxeZFqfjZgeBbGvE1wB6
 /V6nQUH0PdaU2g+5JOnd1u9l8C/s6uwbv4KhpIhdxBK8oLO0ZwY+sqyTh4ne0vagAIgh4N5VQBGx0
 JHE6q8bbDMTkx2eOaxshkvfo9rjtP0ncEN/z4VwN6Hb6/0xYri2cf1nNOzgptOsfvtMuA7wmNkOac
 QLJGCjm4BB8DbTIK1mpqQYiSCZNmMlsC+Vd1KrBSfphtSKPM32mRgHArgFrIC0MlfCF8txHO3F2DP
 u7/I0W5g==;
From: Christoph Hellwig <hch@lst.de>
Date: Thu, 23 Jul 2020 08:08:52 +0200
Message-Id: <20200723060908.50081-11-hch@lst.de>
In-Reply-To: <20200723060908.50081-1-hch@lst.de>
References: <20200723060908.50081-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 10/26] netfilter: remove the unused user argument
	to do_update_counters
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Eric Dumazet <edumazet@google.com>
Cc: linux-s390@vger.kernel.org, rds-devel@oss.oracle.com, linux-decnet-user@lists.sourceforge.net, tipc-discussion@lists.sourceforge.net, linux-x25@vger.kernel.org, dccp@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, lvs-devel@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-sctp@vger.kernel.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, linux-crypto@vger.kernel.org, linux-hams@vger.kernel.org, bpf@vger.kernel.org, linux-wpan@vger.kernel.org, linux-afs@lists.infradead.org, mptcp@lists.01.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/bridge/netfilter/ebtables.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index fe13108af1f542..12f8929667bf43 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1242,9 +1242,8 @@ void ebt_unregister_table(struct net *net, struct ebt_table *table,
 
 /* userspace just supplied us with counters */
 static int do_update_counters(struct net *net, const char *name,
-				struct ebt_counter __user *counters,
-				unsigned int num_counters,
-				const void __user *user, unsigned int len)
+			      struct ebt_counter __user *counters,
+			      unsigned int num_counters, unsigned int len)
 {
 	int i, ret;
 	struct ebt_counter *tmp;
@@ -1299,7 +1298,7 @@ static int update_counters(struct net *net, const void __user *user,
 		return -EINVAL;
 
 	return do_update_counters(net, hlp.name, hlp.counters,
-				hlp.num_counters, user, len);
+				  hlp.num_counters, len);
 }
 
 static inline int ebt_obj_to_user(char __user *um, const char *_name,
@@ -2231,7 +2230,7 @@ static int compat_update_counters(struct net *net, void __user *user,
 		return update_counters(net, user, len);
 
 	return do_update_counters(net, hlp.name, compat_ptr(hlp.counters),
-					hlp.num_counters, user, len);
+				  hlp.num_counters, len);
 }
 
 static int compat_do_ebt_get_ctl(struct sock *sk, int cmd,
-- 
2.27.0

