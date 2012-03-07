Return-Path: <paulius.zaleckas@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:subject:to:date:message-id:user-agent:mime-version
	:content-type:content-transfer-encoding;
	bh=+FmK8eV5LDHd+ZivvfscTQwd9Zlj5fGAfijkHOtNdAQ=;
	b=f0d6EczxDQL9smFNXH9CXD9kPKFqw96d+Fx4bygFZAt+bTjXDlGmw6hetj5Vmk68fB
	E9b2l0lks6B6CkwRXHnmdCnRkBG8lMI3UwAT2IL/xCXnaQGgZ3TLZP8X784u3kDiUzFQ
	24Ranx0cWMEMZeglzfdqFJKK02hmSRFlZGymY1NHnpR/LlOjBkN7tyKYOKslPmVMrqOE
	npUS3EypfUlGpQaacHb/1hl1GnuY2eCiCXKipCMvibU/nLq96m5kMn1+Eppx8ecrCw3W
	ENfsPmLnjhWhwzXxVeBEWkRWbhuTiP1wdhGCu7dS5yfWBrQ+yuMoriW0NdUJ98E+/Juy
	FDqw==
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Date: Wed, 07 Mar 2012 10:25:14 +0200
Message-ID: <20120307082514.6293.59158.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH 1/2] bridge: br_log_state() s/entering/entered/
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, netdev@vger.kernel.org

When br_log_state() is reporting state it should say "entered"
istead of "entering" since state at this point is already
changed.

Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---

 net/bridge/br_stp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
index 6751ed4..8c836d9 100644
--- a/net/bridge/br_stp.c
+++ b/net/bridge/br_stp.c
@@ -31,7 +31,7 @@ static const char *const br_port_state_names[] = {
 
 void br_log_state(const struct net_bridge_port *p)
 {
-	br_info(p->br, "port %u(%s) entering %s state\n",
+	br_info(p->br, "port %u(%s) entered %s state\n",
 		(unsigned) p->port_no, p->dev->name,
 		br_port_state_names[p->state]);
 }

