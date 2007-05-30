Date: Wed, 30 May 2007 12:14:22 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070530121422.0cdd90eb@freepuppy>
In-Reply-To: <20070530121252.1248f506@freepuppy>
References: <20070519224605.GG14235@galon.ev-en.org>
	<20070530121252.1248f506@freepuppy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH 2/2] bridge: round off STP perodic timers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, Baruch Even <baruch@ev-en.org>, power@bughost.org, bridge@linux-foundation.org

Peroidic STP timers don't have to be exact.
The hold timer runs at 1HZ, and the hello timer normally runs
at 2HZ; save power by aligning it them to next second.

Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>

---
 net/bridge/br_stp.c       |    3 ++-
 net/bridge/br_stp_timer.c |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

--- a/net/bridge/br_stp.c	2007-05-30 11:42:16.000000000 -0700
+++ b/net/bridge/br_stp.c	2007-05-30 11:51:51.000000000 -0700
@@ -178,7 +178,8 @@ void br_transmit_config(struct net_bridg
 		br_send_config_bpdu(p, &bpdu);
 		p->topology_change_ack = 0;
 		p->config_pending = 0;
-		mod_timer(&p->hold_timer, jiffies + BR_HOLD_TIME);
+		mod_timer(&p->hold_timer,
+			  round_jiffies(jiffies + BR_HOLD_TIME));
 	}
 }
 
--- a/net/bridge/br_stp_timer.c	2007-05-30 11:42:16.000000000 -0700
+++ b/net/bridge/br_stp_timer.c	2007-05-30 11:53:08.000000000 -0700
@@ -42,7 +42,7 @@ static void br_hello_timer_expired(unsig
 	if (br->dev->flags & IFF_UP) {
 		br_config_bpdu_generation(br);
 
-		mod_timer(&br->hello_timer, jiffies + br->hello_time);
+		mod_timer(&br->hello_timer, round_jiffies(jiffies + br->hello_time));
 	}
 	spin_unlock(&br->lock);
 }
