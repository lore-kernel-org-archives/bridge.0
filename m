From: Bart De Schuymer <bdschuym@pandora.be>
Content-Type: text/plain
Date: Wed, 12 Jan 2005 21:37:36 +0100
Message-Id: <1105562256.3387.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [EBTABLES][PATCH] fix gcc format warning
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, ebtables-devel@lists.sourceforge.net, bridge@lists.osdl.org

Hi Dave,

Please apply this compiler warning fix from Randy.


Signed-off-by: Bart De Schuymer <bdschuym@telenet.be>
Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diff -Naurp ./net/bridge/netfilter/ebt_ulog.c~brnetf_types ./net/bridge/netfilter/ebt_ulog.c
--- ./net/bridge/netfilter/ebt_ulog.c~brnetf_types	2005-01-10 10:38:40.531343592 -0800
+++ ./net/bridge/netfilter/ebt_ulog.c	2005-01-10 12:31:10.076256800 -0800
@@ -135,7 +135,7 @@ static void ebt_ulog(const struct sk_buf
 
 	size = NLMSG_SPACE(sizeof(*pm) + copy_len);
 	if (size > nlbufsiz) {
-		PRINTR("ebt_ulog: Size %d needed, but nlbufsiz=%d\n",
+		PRINTR("ebt_ulog: Size %zu needed, but nlbufsiz=%u\n",
 		       size, nlbufsiz);
 		return;
 	}


