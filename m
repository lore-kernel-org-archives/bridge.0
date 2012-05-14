Return-Path: <devendra.aaru@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=8ZSPUSPPReMXZdNtU1pZVlk+3MifAhqMrMIIzVyj7Qc=;
	b=vZiIhEG3sCTjcr/1EiUrhTX88c61BxMH4dlymL+VGO6Uky4QZEuP4SGVkRXazEoza8
	35z7jNN8U3EzgA/bQHqZ8KO6rBWbbyijQH4fEuxWggwa/QEpr9CWe4liFFutyZwJyFM/
	kJnsBUIW396IfICyFtANrTVPXLGxYu0kHkH6jEeSe2gnqZBeGB1MpbIFNdpgzVu36o0N
	PRnzJNVP2uq+yUTHJK7EpoVO5m/PJ6sP+CMk0FP4rC5lv8Qojoo0HbpE90FoPodC+TRb
	yaO/h3r048OF/NxO5VfHBCzrhtNkLi48tTUSU7l+WZs8A1X5pNkg84S6WRSwCqY37xzt
	OQ9Q==
From: Devendra Naga <devendra.aaru@gmail.com>
Date: Tue, 15 May 2012 01:00:17 +0530
Message-Id: <1337023817-26132-1-git-send-email-devendra.aaru@gmail.com>
Subject: [Bridge] [PATCH] net/bridge/netfilter: Fix the randconfig warning
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Patrick McHardy <kaber@trash.net>, Stephen Hemminger <shemminger@vyatta.com>, "David S. Miller" <davem@davemloft.net>, netfilter-devel@vger.kernel.org, netfilter@vger.kernel.org, coreteam@netfilter.org, bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: Devendra Naga <devendra.aaru@gmail.com>

when ran with make randconfig got

warning: (BRIDGE_NF_EBTABLES) selects NETFILTER_XTABLES which has unmet direct dependencies (NET && INET && NETFILTER)

added NET && INET && NETFILTER dependency to the BRIDGE_NF_EBTABLES

Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
---
 net/bridge/netfilter/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/netfilter/Kconfig b/net/bridge/netfilter/Kconfig
index a9aff9c..34f6d9d 100644
--- a/net/bridge/netfilter/Kconfig
+++ b/net/bridge/netfilter/Kconfig
@@ -4,7 +4,7 @@
 
 menuconfig BRIDGE_NF_EBTABLES
 	tristate "Ethernet Bridge tables (ebtables) support"
-	depends on BRIDGE && NETFILTER
+	depends on NET && INET && BRIDGE && NETFILTER
 	select NETFILTER_XTABLES
 	help
 	  ebtables is a general, extensible frame/packet identification
-- 
1.7.9.5

