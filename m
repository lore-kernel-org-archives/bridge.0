Date: Mon, 24 May 2004 14:42:09 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040524144209.5449d829@dell_ss3.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.58.0405230121530.13087@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0405230121530.13087@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH] update  Documentation/networking/bridge.txt
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "David S. Miller" <davem@redhat.com>
Cc: netdev@oss.sgi.com, bridge@osdl.org, Trent Jarvi <taj@www.linux.org.uk>

Trent Jarvi <taj@www.linux.org.uk> noticed this.  The file was out of date
with current web site and maintainer.  Please apply to 2.4 and 2.6.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

diff -Nru a/Documentation/networking/bridge.txt b/Documentation/networking/bridge.txt
--- a/Documentation/networking/bridge.txt	2004-05-24 14:38:05 -07:00
+++ b/Documentation/networking/bridge.txt	2004-05-24 14:38:05 -07:00
@@ -1,11 +1,8 @@
-In order to use the ethernet bridging functionality you'll need the
-userspace tools available at http://www.math.leidenuniv.nl/~buytenh/bridge.
-The tarball available there contains extensive documentation, but if you
-still have questions, don't hesitate to post to the mailing list (more info
-at http://www.math.leidenuniv.nl/mailman/listinfo/bridge). You can also
-mail me at buytenh@gnu.org.
+In order to use the Ethernet bridging functionality, you'll need the
+userspace tools. These programs and documentation are available
+at http://bridge.sourceforge.net.  The download page is
+http://prdownloads.sourceforge.net/bridge.
 
+If you still have questions, don't hesitate to post to the mailing list 
+(more info http://lists.osdl.org/mailman/listinfo/bridge).
 
-
-Lennert Buytenhek
-<buytenh@gnu.org>
