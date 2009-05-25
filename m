From: Vitaly Demyanec <vitas@nppfactor.kiev.ua>
Date: Mon, 25 May 2009 18:48:02 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905251848.03023.vitas@nppfactor.kiev.ua>
Subject: [Bridge] [PATCH 1/2] rstpd: Fixed erroneous error message
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

Description:
Error condition was broken. Fixed.

Signed-off-by: Vitaly Demyanec <vitas at nppfactor.kiev.ua>
---

diff -ur a/ctl_socket.c b/ctl_socket.c
--- a/ctl_socket.c	2009-05-25 18:37:51.000000000 +0300
+++ b/ctl_socket.c	2009-05-25 18:38:58.000000000 +0300
@@ -152,10 +152,10 @@
 	l = sendmsg(p->fd, &msg, MSG_NOSIGNAL);
 	if (l < 0)
 		ERROR("CTL: Couldn't send response: %m");
-	else if (l != sizeof(mhdr) + mhdr.lout) {
+	else if (l != sizeof(mhdr) + mhdr.lout + mhdr.llog) {
 		ERROR
 		    ("CTL: Couldn't send full response, sent %d bytes instead of %zd.",
-		     l, sizeof(mhdr) + mhdr.lout);
+		     l, sizeof(mhdr) + mhdr.lout + mhdr.llog);
 	}
 }

-- 
With Best Regards,
Vitaly Demyanec
