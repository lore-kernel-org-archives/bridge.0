From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Sat, 29 Mar 2008 18:07:56 +0100
Message-Id: <1206810476-27078-1-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <>
References: <>
Subject: [Bridge] [PATCH] Fix typo in bridge-stp script
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bridge@lists.linux-foundation.org
Cc: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>


Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---

Just noticed a minor typo

 bridge-stp |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bridge-stp b/bridge-stp
index 49d5a41..5e663a9 100755
--- a/bridge-stp
+++ b/bridge-stp
@@ -53,9 +53,9 @@ start() {
 case $2 in
      start) 
 	daemon
-	exec /sbin/rstpctl $bridge on ;;
+	exec /sbin/rstpctl rstp $bridge on ;;
      stop)  
-	exec /sbin/rstpctl $bridge off ;;
+	exec /sbin/rstpctl rstp $bridge off ;;
      *)
      	echo "Unknown action:" $2
 	echo "Usage: bridge-stp <bridge> {start|stop}"
-- 
1.5.4.3

