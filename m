Return-Path: <festevam@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=rLiwiMToZ2w19m6niIytlB7PI+bgH0DDKMD8/wthpHM=;
	b=Y4TNS9H81cNykiZQRVIijWMY24sUMKlQKtCifdT89llDwqU5vaFO594Tfw8ZgcxV2t
	iOONFlffUHzAokRmpvhXFFAsZL2OJgu71H46qZfykbOe6rhdaxV+5R5YhgC/xqrVIRzK
	pbm/HOUDPBR2wBvUhHYMTMo1J1xCIWCGJHyPA=
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 10 Jan 2012 23:48:25 -0200
Message-Id: <1326246505-5038-1-git-send-email-festevam@gmail.com>
Subject: [Bridge] [PATCH] net: bridge: netfilter: Fix dependency for
	BRIDGE_NF_EBTABLES
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, shemminger@vyatta.com, bridge@lists.linux-foundation.org, Fabio Estevam <festevam@gmail.com>, davem@davemloft.net

Fix the following build warning:

warning: (BRIDGE_NF_EBTABLES) selects NETFILTER_XTABLES which has unmet direct dependencies (NET && INET && NETFILTER)

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 net/bridge/netfilter/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bridge/netfilter/Kconfig b/net/bridge/netfilter/Kconfig
index a9aff9c..9ca621a 100644
--- a/net/bridge/netfilter/Kconfig
+++ b/net/bridge/netfilter/Kconfig
@@ -4,7 +4,7 @@
 
 menuconfig BRIDGE_NF_EBTABLES
 	tristate "Ethernet Bridge tables (ebtables) support"
-	depends on BRIDGE && NETFILTER
+	depends on BRIDGE && NETFILTER && INET
 	select NETFILTER_XTABLES
 	help
 	  ebtables is a general, extensible frame/packet identification
-- 
1.7.1

