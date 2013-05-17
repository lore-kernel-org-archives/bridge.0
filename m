Return-Path: <gang.chen@asianux.com>
Message-ID: <5195E53A.4060406@asianux.com>
Date: Fri, 17 May 2013 16:07:22 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH] bridge: netfilter: using strlcpy() instead of
	strncpy()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bart.de.schuymer@pandora.be, pablo@netfilter.org, kaber@trash.net, stephen@networkplumber.org
Cc: netfilter@vger.kernel.org, netdev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, David Miller <davem@davemloft.net>


'name' has already set all zero when it is defined, so not need let
strncpy() to pad it again.

'name' is a string, better always let is NUL terminated, so use
strlcpy() instead of strncpy().


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 net/bridge/netfilter/ebtables.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 3d110c4..ac78024 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1339,7 +1339,7 @@ static inline int ebt_make_matchname(const struct ebt_entry_match *m,
 
 	/* ebtables expects 32 bytes long names but xt_match names are 29 bytes
 	   long. Copy 29 bytes and fill remaining bytes with zeroes. */
-	strncpy(name, m->u.match->name, sizeof(name));
+	strlcpy(name, m->u.match->name, sizeof(name));
 	if (copy_to_user(hlp, name, EBT_FUNCTION_MAXNAMELEN))
 		return -EFAULT;
 	return 0;
@@ -1351,7 +1351,7 @@ static inline int ebt_make_watchername(const struct ebt_entry_watcher *w,
 	char __user *hlp = ubase + ((char *)w - base);
 	char name[EBT_FUNCTION_MAXNAMELEN] = {};
 
-	strncpy(name, w->u.watcher->name, sizeof(name));
+	strlcpy(name, w->u.watcher->name, sizeof(name));
 	if (copy_to_user(hlp , name, EBT_FUNCTION_MAXNAMELEN))
 		return -EFAULT;
 	return 0;
@@ -1377,7 +1377,7 @@ ebt_make_names(struct ebt_entry *e, const char *base, char __user *ubase)
 	ret = EBT_WATCHER_ITERATE(e, ebt_make_watchername, base, ubase);
 	if (ret != 0)
 		return ret;
-	strncpy(name, t->u.target->name, sizeof(name));
+	strlcpy(name, t->u.target->name, sizeof(name));
 	if (copy_to_user(hlp, name, EBT_FUNCTION_MAXNAMELEN))
 		return -EFAULT;
 	return 0;
-- 
1.7.7.6
