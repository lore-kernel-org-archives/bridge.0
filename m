Return-Path: <santoshprasadnayak@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=fmHhVfjLzSqSANPixWTgIxQXuhUT+3LTYFAQOKVVUCY=;
	b=i4ySxGb3YnR4+brYcrzrHtuLHnksfjHIni0Gcl+NT1TCyKVa2efrcyD8/6zWuuaOpR
	5CtekGaMHmYjrkNRblaUCRrHjZOqBdZm7bU5hrjYUflCOW5MCXMPsKt+HVmnyEgbFQ3S
	UUcQiYOxJbtDU0dar6D/GSlPlUI/QP+JXmLmQ=
From: santosh nayak <santoshprasadnayak@gmail.com>
Date: Thu,  1 Mar 2012 14:46:30 +0530
Message-Id: <1330593390-19233-1-git-send-email-santoshprasadnayak@gmail.com>
Subject: [Bridge] [PATCH 1/3] netfilter: Fix copy_to_user too small size
	parametre.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bart.de.schuymer@pandora.be
Cc: Santosh Nayak <santoshprasadnayak@gmail.com>, coreteam@netfilter.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, netfilter@vger.kernel.org, netfilter-devel@vger.kernel.org, shemminger@vyatta.com, pablo@netfilter.org

From: Santosh Nayak <santoshprasadnayak@gmail.com>

While copying to userspace, the size of source is 29byte where as
size parametre is 32 byte.  Its leaking extra-information from
kernel space to user space.
Replace EBT_FUNCTION_MAXNAMELEN by XT_EXTENSION_MAXNAMELEN.

Signed-off-by: Santosh Nayak <santoshprasadnayak@gmail.com>
---
 net/bridge/netfilter/ebtables.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 5864cc4..f3fcbd9 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1335,7 +1335,7 @@ static inline int ebt_make_matchname(const struct ebt_entry_match *m,
     const char *base, char __user *ubase)
 {
 	char __user *hlp = ubase + ((char *)m - base);
-	if (copy_to_user(hlp, m->u.match->name, EBT_FUNCTION_MAXNAMELEN))
+	if (copy_to_user(hlp, m->u.match->name, XT_EXTENSION_MAXNAMELEN))
 		return -EFAULT;
 	return 0;
 }
@@ -1344,7 +1344,7 @@ static inline int ebt_make_watchername(const struct ebt_entry_watcher *w,
     const char *base, char __user *ubase)
 {
 	char __user *hlp = ubase + ((char *)w - base);
-	if (copy_to_user(hlp , w->u.watcher->name, EBT_FUNCTION_MAXNAMELEN))
+	if (copy_to_user(hlp , w->u.watcher->name, XT_EXTENSION_MAXNAMELEN))
 		return -EFAULT;
 	return 0;
 }
@@ -1368,7 +1368,7 @@ ebt_make_names(struct ebt_entry *e, const char *base, char __user *ubase)
 	ret = EBT_WATCHER_ITERATE(e, ebt_make_watchername, base, ubase);
 	if (ret != 0)
 		return ret;
-	if (copy_to_user(hlp, t->u.target->name, EBT_FUNCTION_MAXNAMELEN))
+	if (copy_to_user(hlp, t->u.target->name, XT_EXTENSION_MAXNAMELEN))
 		return -EFAULT;
 	return 0;
 }
-- 
1.7.4.4

