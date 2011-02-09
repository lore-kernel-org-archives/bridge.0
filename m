Date: Wed, 9 Feb 2011 19:17:52 +0100
From: Veaceslav Falico <vfalico@redhat.com>
Message-ID: <20110209181752.GA2042@darkmag.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] mac addresses of local interfaces do not obey setageing 0
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org

Hello,

I have a host and a VM inside this host bridged. I've set ageing_time and
forward_delay to 0 and trying to capture all the traffic that goes through that
bridge from my VM, but it fails to capture the traffic that has dst ether
address the same as the hosts address (i.e. I can't capture the traffic to the
host).

From the code, I see that br->ageing_time doesn't really work with local mac
addresses - has_expired() function never says that a local interface mac address
is expired, because it verifies if fdb->is_static is set and returns right away.

Is this the desired behaviour? If so, is there a way to capture packets with
destination to a local interface from another interface?

I've also done a small patch and it seems to fix the situation, but I am not
sure if it's the right way to do it.


Regards,
Veaceslav

---
 net/bridge/br_fdb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 88485cc..3d380c2 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -61,8 +61,8 @@ static inline unsigned long hold_time(const struct net_bridge *br)
 static inline int has_expired(const struct net_bridge *br,
 				  const struct net_bridge_fdb_entry *fdb)
 {
-	return !fdb->is_static &&
-		time_before_eq(fdb->ageing_timer + hold_time(br), jiffies);
+	return (br->ageing_time == 0) || (!fdb->is_static &&
+		time_before_eq(fdb->ageing_timer + hold_time(br), jiffies));
 }
 
 static inline int br_mac_hash(const unsigned char *mac)
