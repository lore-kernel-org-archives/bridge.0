Date: Tue, 20 May 2008 01:08:34 +0300
From: Adrian Bunk <bunk@kernel.org>
Message-ID: <20080519220834.GT17716@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Bridge] [2.6 patch] bridge: update URL
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@linux-foundation.org
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

This patch updates the URL of the bridge homepage.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 Documentation/networking/bridge.txt |    2 +-
 MAINTAINERS                         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

442926ef29170feab89570cbe478e8dff2946f6d diff --git a/Documentation/networking/bridge.txt b/Documentation/networking/bridge.txt
index bdae2db..bec69a8 100644
--- a/Documentation/networking/bridge.txt
+++ b/Documentation/networking/bridge.txt
@@ -1,6 +1,6 @@
 In order to use the Ethernet bridging functionality, you'll need the
 userspace tools. These programs and documentation are available
-at http://bridge.sourceforge.net.  The download page is
+at http://www.linux-foundation.org/en/Net:Bridge.  The download page is
 http://prdownloads.sourceforge.net/bridge.
 
 If you still have questions, don't hesitate to post to the mailing list 
diff --git a/MAINTAINERS b/MAINTAINERS
index bfbe353..52b7035 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1591,7 +1591,7 @@ ETHERNET BRIDGE
 P:	Stephen Hemminger
 M:	shemminger@linux-foundation.org
 L:	bridge@lists.linux-foundation.org
-W:	http://bridge.sourceforge.net/
+W:	http://www.linux-foundation.org/en/Net:Bridge
 S:	Maintained
 
 ETHERTEAM 16I DRIVER

