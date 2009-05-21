From: Vitaly Demyanec <vitas@nppfactor.kiev.ua>
Date: Thu, 21 May 2009 15:03:26 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905211503.26161.vitas@nppfactor.kiev.ua>
Subject: [Bridge] [PATCH] rstpd: sizeof mismatch for some setups
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

This patch is against rstpd v.0.21 (get it here: 
https://lists.linux-foundation.org/pipermail/bridge/2009-February/006178.html).
BTW, it seems there are 2 rstpd forks, one is v.0.21 and is maintained by 
Srinivas, while the other uses rstplib, is v.0.16 and is maintained by 
Stephen (here: 
http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;a=summary)
I am pretty confused with this divergence, which should one use to start from? 
(personally I selected Srinivas' version as it seems to be more up-to-date).

Description:
For some setups (e.g. mine) sizeof(STP_MacAddress) != 6, which causes compiler 
error (thanks to the CMP macro, it's really useful)

Signed-off-by: Vitaly Demyanec <vitas at nppfactor.kiev.ua>
---

--- a/rstp.c	2009-05-21 13:01:09.000000000 +0300
+++ b/rstp.c	2009-05-21 13:06:08.000000000 +0300
@@ -2600,9 +2600,9 @@
   }
 
   if (cfg->set_bridge_address &&
-      CMP(BridgeIdentifier.bridge_address, !=, cfg->bridge_address)) {
+      CMP(BridgeIdentifier.bridge_address, !=, cfg->bridge_address.addr)) {
 
-    CPY(BridgeIdentifier.bridge_address, cfg->bridge_address);
+    CPY(BridgeIdentifier.bridge_address, cfg->bridge_address.addr);
 
     changed = TRUE;
     init = TRUE;

-- 
With Best Regards,
Vitaly Demyanec
Head engineer
Factor-SPE
Kiev, Ukraine
tel/fax: +380(44)249-21-63
