Return-Path: <paulius.zaleckas@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:subject:to:date:message-id:in-reply-to:references:user-agent
	:mime-version:content-type:content-transfer-encoding;
	bh=rqCphjmzgPGjEdnqmMLeiaqB9z735yhTJzwWVeV4l8M=;
	b=VaIB3RAGRrbU+FATGFmqd3bDjrJmPXi+shh3/fdbI5Ph2p3i2L9j0M9EHUM8L2bXda
	PwwQgCLLeOoUGhuamRs1JVQU7SDg86qugvySthuXdAK9kS437Hopku7nUIT7VEZK876B
	REudGSDJK7+56Oah8AgiwXEE1E3UabH1+eybL2WyhIv8w9A2VnF8RwsBqcgCZgSI1JHN
	Wbd1pTg9s/slYi/LhE7b1UIfZoRsGTAIzDF8K81DEcnU+/OL+yWPRoKou9YdF7bn81VT
	/aQaqObdgXRnKnAP1iXyDF1dg3slbEwiM5hMvifdvvaHjAO270VLYw2p2EMNrqVtFnlt
	7ejg==
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Date: Wed, 07 Mar 2012 10:25:22 +0200
Message-ID: <20120307082522.6293.26893.stgit@localhost.localdomain>
In-Reply-To: <20120307082514.6293.59158.stgit@localhost.localdomain>
References: <20120307082514.6293.59158.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH 2/2] bridge: fix state reporting when port is
	disabled
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
eth0: link *down*
br0: port 1(eth0) entered *forwarding* state

br_log_state(p) should be called *after* p->state is set
to BR_STATE_DISABLED.

Reported-by: Zilvinas Valinskas <zilvinas@wilibox.com>
Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Acked-by: Stephen Hemminger <shemminger@vyatta.com>
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

