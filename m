Return-Path: <paulius.zaleckas@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:subject:to:date:message-id:user-agent:mime-version
	:content-type:content-transfer-encoding;
	bh=4F2YxJbXgROenQc5LE1Z8guTvduEIQDaSt3A2X5KFi8=;
	b=v8fqx5F6K0jIBhr58rCF2zQDxzyjrQufi+aXaveCjTa2PYeA2NpA9+5d0o1i0YabP+
	XqkUdCdcpwrY9GimkrFiCbijpX/MVV1hJ22YiiqCxUQdeZbJQibTy1CUVaLNYOgRhQ6J
	6eoL02NzPcT4OZpHOw2lbBCfvyIutXJ+4teEUSY2Nt2mXX1YnQvEBVWknczgoeA+VKIt
	e6Z3Cc/8j6Re95248QgDwGOG/vMMeYwTErlXLBFcEhdMHZMS1hfW+3hixJdg7cz2qE4G
	IYlX174qnomivI/jmpSE6PY3vn9U7aIrDOxiVJc3Qv4D/RZDEoL8171OLQ+Oijt/ueTt
	YL1g==
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Date: Tue, 06 Mar 2012 16:22:19 +0200
Message-ID: <20120306142219.31783.30201.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH] bridge: fix "entering disabled state" logging
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, netdev@vger.kernel.org

Now we have:
eth0: link down
br0: port 1(eth0) entering forwarding state

State should be logged *after* it was changed, not before.

Reported-by: Zilvinas Valinskas <zilvinas@wilibox.com>
Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---

 net/bridge/br_stp_if.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index 19308e3..f494496 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -98,14 +98,13 @@ void br_stp_disable_port(struct net_bridge_port *p)
 	struct net_bridge *br = p->br;
 	int wasroot;
 
-	br_log_state(p);
-
 	wasroot = br_is_root_bridge(br);
 	br_become_designated_port(p);
 	p->state = BR_STATE_DISABLED;
 	p->topology_change_ack = 0;
 	p->config_pending = 0;
 
+	br_log_state(p);
 	br_ifinfo_notify(RTM_NEWLINK, p);
 
 	del_timer(&p->message_age_timer);

