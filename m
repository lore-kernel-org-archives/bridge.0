Return-Path: <dan.carpenter@oracle.com>
Date: Tue, 18 Jun 2013 10:46:03 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20130618074603.GF12329@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] [patch] netfilter: prevent harmless integer overflow
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bart De Schuymer <bart.de.schuymer@pandora.be>
Cc: coreteam@netfilter.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Stephen Hemminger <stephen@networkplumber.org>, netfilter@vger.kernel.org, netfilter-devel@vger.kernel.org, Patrick McHardy <kaber@trash.net>, Pablo Neira Ayuso <pablo@netfilter.org>

This overflow is harmless because a few lines later we check:

	if (num_counters != t->private->nentries) {

But it still upsets the static checkers.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 3d110c4..141350e 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1278,6 +1278,8 @@ static int do_update_counters(struct net *net, const char *name,
 
 	if (num_counters == 0)
 		return -EINVAL;
+	if (num_counters > INT_MAX / sizeof(*tmp))
+		return -ENOMEM;
 
 	tmp = vmalloc(num_counters * sizeof(*tmp));
 	if (!tmp)
