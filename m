From: Vitaly Demyanec <vitas@nppfactor.kiev.ua>
Date: Fri, 22 May 2009 16:20:48 +0300
References: <200905211503.26161.vitas@nppfactor.kiev.ua>
In-Reply-To: <200905211503.26161.vitas@nppfactor.kiev.ua>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200905221620.48293.vitas@nppfactor.kiev.ua>
Subject: [Bridge] [PATCH] rstpd: sizeof mismatch + macro enhancement
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
1. For some setups (e.g. mine) sizeof(struct sockaddr_un) != 
sizeof((sa)->sun_family) + sizeof((sa)->sun_path) , which leads to incomplete 
clean-up in set_socket_address macro, which in turn leads to different socket 
addresses in rstpd and rstpctl.
2. We should avoid possible side-effects multiplication in the (sa) (e.g. when 
this macro is called like this: set_socket_address(++sa_ptr, str[i])) by the 
use of temporary variable inside the macro.

Signed-off-by: Vitaly Demyanec <vitas at nppfactor.kiev.ua>
---

diff -ur a/ctl_socket.h b/ctl_socket.h
--- a/ctl_socket.h      2009-05-22 15:34:00.000000000 +0300
+++ b/ctl_socket.h      2009-05-22 16:17:47.000000000 +0300
@@ -47,10 +47,11 @@

 #define set_socket_address(sa, string) \
  do {\
-  (sa)->sun_family = AF_UNIX; \
-  memset((sa)->sun_path, 0, sizeof((sa)->sun_path)); \
-  strcpy((sa)->sun_path + 1, (string)); \
- } while (0)
+  struct sockaddr_un * tmp_sa = (sa); \
+  memset(tmp_sa, 0, sizeof(*tmp_sa)); \
+  tmp_sa->sun_family = AF_UNIX; \
+  strcpy(tmp_sa->sun_path + 1, (string)); \
+} while (0)

 #define RSTP_SERVER_SOCK_NAME ".rstp_server"

-- 
With Best Regards,
Vitaly Demyanec
Head engineer
Factor-SPE
Kiev, Ukraine
tel/fax: +380(44)249-21-63
