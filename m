DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed; d=gmail.com; s=beta;
	h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
	b=hLaY+Z8gDVjIF80B4o8C0EeB7BaqZSKOWwUmHskKPnGmJ2kWJBpdbMvjdmDpxFQArUoeFRBnYur+sDYlL4HCE0VWVxsAa4onjmIOK23ri0DyQDZ5PCppPYuAJ3EiId5TPKW9SKcmLsjAjTo15Qt85vgB92l1HvbyYCF3i6ANfkA=
From: Jesper Juhl <jesper.juhl@gmail.com>
Date: Sat, 21 Jul 2007 17:03:36 +0200
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200707211703.37119.jesper.juhl@gmail.com>
Subject: [Bridge] [PATCH][27/37] Clean up duplicate includes in net/bridge/
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, netfilter-devel@lists.netfilter.org, Bart De Schuymer <bdschuym@pandora.be>, Marc Boucher <marc@mbsi.ca>, Harald Welte <laforge@netfilter.org>, netdev@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>, bridge@lists.linux-foundation.org, James Morris <jmorris@namei.org>, Andrew Morton <akpm@linux-foundation.org>, David S Miller <davem@davemloft.net>

Hi,

This patch cleans up duplicate includes in
	net/bridge/


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

diff --git a/net/bridge/netfilter/ebt_log.c b/net/bridge/netfilter/ebt_log.c
index 031bfa4..89d0d59 100644
--- a/net/bridge/netfilter/ebt_log.c
+++ b/net/bridge/netfilter/ebt_log.c
@@ -9,7 +9,6 @@
  *
  */
 
-#include <linux/in.h>
 #include <linux/netfilter_bridge/ebtables.h>
 #include <linux/netfilter_bridge/ebt_log.h>
 #include <linux/netfilter.h>
diff --git a/net/bridge/netfilter/ebt_ulog.c b/net/bridge/netfilter/ebt_ulog.c
index 9411db6..a31402a 100644
--- a/net/bridge/netfilter/ebt_ulog.c
+++ b/net/bridge/netfilter/ebt_ulog.c
@@ -36,7 +36,6 @@
 #include <linux/timer.h>
 #include <linux/netlink.h>
 #include <linux/netdevice.h>
-#include <linux/module.h>
 #include <linux/netfilter_bridge/ebtables.h>
 #include <linux/netfilter_bridge/ebt_ulog.h>
 #include <net/sock.h>
