From: Ian Campbell <Ian.Campbell@eu.citrix.com>
In-Reply-To: <1242298904-31325-1-git-send-email-ian.campbell@citrix.com>
References: <1242298904-31325-1-git-send-email-ian.campbell@citrix.com>
Content-Type: text/plain
Date: Thu, 14 May 2009 15:37:32 +0100
Message-ID: <1242311852.4341.36.camel@zakaz.uk.xensource.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] BRIDGE: Do not suppress FDB learning after
	topology	change when forward_delay is 0.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

On Thu, 2009-05-14 at 07:01 -0400, Ian Campbell wrote:
> I recently noticed that my bridges were flooding traffic for a period of time
> after a topology change. These bridges are part of a Xen host and therefore
> have spanning tree disabled and forward_delay of zero. In this situation there
> is no reason not to begin relearning immediately after a topology change.
> 
> The existing code uses hold_time == 0 to suppress learning in br_fdb_update.
> hold_time() returns forward_delay if a topology change has recently occurred
> and ageing_time if not. Setting each of those to zero has slightly different
> semantics: Setting forward_delay to zero effectively means forward immediately
> while setting ageing_time to zero effectively means do not learn.
> 
> The solution is to not learn after a topology change only if forward_delay is
> non-zero but to retain the existing behaviour based on ageing_time if a
> topology change has not occured.

Hmm, now I'm wondering if I'm just completely confused about the
relevance of ->forward_delay in the context of the FDB, since makes no
sense to me ;-)

There are four places in br_fdb.c which make use of hold_time() (and
therefor == ->forward_delay after a topology change):

br_fdb_update -- discussed above, why would you not learn even during
the period after a topology change?

br_fdb_cleanup -- If forward_delay is 0 then we drop all FDB entries on
topology change, which makes sense. However if forward_delay is non-0
then we drop all FDB entries some time _after_ the topology change. Or
maybe not at all of forwarding_delay > bridge_forwarding_delay. Why not
just explicitly flush the FDB on topology change?

__br_fdb_get -- (calls hold_time() via has_expired()), I don't
understand why an entry would be considered to expire at a point
forward_delay ms after a topology change, rather than immediately on the
change, or not at all.

br_fdb_fillbuf -- (calls hold_time() via has_expired()).

I guess the root of the issue is the same in all of the cases... The
code seems to have been this way since forever (i.e. since git ;-)) so I
strongly suspect there is some aspect of all this I don't understand or
appreciate ;-) Can anyone enlighten me?

As a strawman I present the following patch (on top of the previous
one)...

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 7293ba4..8b0c92e 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -52,11 +52,6 @@ void br_fdb_fini(void)
 /* if topology_changing then use forward_delay (default 15 sec)
  * otherwise keep longer (default 5 minutes)
  */
-static inline unsigned long hold_time(const struct net_bridge *br)
-{
-	return br->topology_change ? br->forward_delay : br->ageing_time;
-}
-
 static inline int should_learn(const struct net_bridge *br)
 {
 	return br->topology_change ? !br->forward_delay : !!br->ageing_time;
@@ -66,7 +61,7 @@ static inline int has_expired(const struct net_bridge *br,
 				  const struct net_bridge_fdb_entry *fdb)
 {
 	return !fdb->is_static
-		&& time_before_eq(fdb->ageing_timer + hold_time(br), jiffies);
+		&& time_before_eq(fdb->ageing_timer + br->ageing_time, jiffies);
 }
 
 static inline int br_mac_hash(const unsigned char *mac)
@@ -124,7 +119,7 @@ void br_fdb_changeaddr(struct net_bridge_port *p, const unsigned char *newaddr)
 void br_fdb_cleanup(unsigned long _data)
 {
 	struct net_bridge *br = (struct net_bridge *)_data;
-	unsigned long delay = hold_time(br);
+	unsigned long delay = br->ageing_time;
 	unsigned long next_timer = jiffies + br->forward_delay;
 	int i;
 
diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
index 6e63ec3..459acbf 100644
--- a/net/bridge/br_stp.c
+++ b/net/bridge/br_stp.c
@@ -302,6 +302,7 @@ void br_topology_change_detection(struct net_bridge *br)
 
 	if (isroot) {
 		br->topology_change = 1;
+		br_fdb_flush(br);
 		mod_timer(&br->topology_change_timer, jiffies
 			  + br->bridge_forward_delay + br->bridge_max_age);
 	} else if (!br->topology_change_detected) {


