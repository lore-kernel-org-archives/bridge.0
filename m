Date: Wed, 31 May 2006 14:33:41 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060531143341.77ee1b4f@localhost.localdomain>
In-Reply-To: <447E0456.10609@arcoscom.com>
References: <447CBD31.2090802@arcoscom.com>
	<20060530162106.30702d1b@dxpl.pdx.osdl.net>
	<447D77A4.5050205@arcoscom.com>
	<20060531091022.12361f66@localhost.localdomain>
	<447E0456.10609@arcoscom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH] Fix bug where changing port priority changed path
 cost instead.
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Samuel =?UTF-8?B?RMOtYXogR2FyY8OtYQ==?= <samueldg@arcoscom.com>
Cc: bridge@lists.osdl.org

Just applied this to the bridge git repository.

---

 ChangeLog         |    4 ++++
 brctl/brctl_cmd.c |    2 +-
 2 files changed, 5 insertions(+), 1 deletions(-)

32a43e993241ff53f3333c4533d135c4f6cead73
diff --git a/ChangeLog b/ChangeLog
index e31da93..435d2f5 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2006-05-31  Stephen Hemminger  <shemminger@zqx3.pdx.osdl.net>
+
+	* Fixed bug where setting port priority set path cost instead
+
 2006-01-31  Stephen Hemminger  <shemminger@osdl.org>
 
 	* Released bridge-utils 1.1
diff --git a/brctl/brctl_cmd.c b/brctl/brctl_cmd.c
index 6d0785e..67aaad4 100644
--- a/brctl/brctl_cmd.c
+++ b/brctl/brctl_cmd.c
@@ -267,7 +267,7 @@ static int br_cmd_setportprio(int argc, 
 		return 1;
 	}
 
-	err = br_set_path_cost(argv[1], argv[2], cost);
+	err = br_set_port_priority(argv[1], argv[2], cost);
 	if (err)
 		fprintf(stderr, "set port priority failed: %s\n",
 			strerror(errno));
-- 
1.2.4

