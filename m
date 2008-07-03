Message-ID: <fed120860807031018h6394f7dfu3ff97965de4bd635@mail.gmail.com>
Date: Thu, 3 Jul 2008 22:48:55 +0530
From: "Srinivas M.A." <srinivas.aji@gmail.com>
In-Reply-To: <20080703135939.GA31482@linux-wlan.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080702230917.GD21344@linux-wlan.com>
	<fed120860807022323u5147beedn33960694ab4e05a5@mail.gmail.com>
	<20080703135939.GA31482@linux-wlan.com>
Subject: Re: [Bridge] [patch] rstpd crashes with GARP/GMRP packets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Solomon Peachy <solomon@linux-wlan.com>
Cc: bridge@lists.linux-foundation.org

Thanks. I put in a modified patch, checking ifc->is_bridge, so that
the bridge and port specific fields of struct ifdata can be put into a
variant record at some point.

commit 8172012df1d981ef1934ede430c4936eae50e5f7
Author: Srinivas Aji <Aji_Srinivas@emc.com>
Date:   Thu Jul 3 22:45:03 2008 +0530

    Fix crash when BPDU received on bridge if.

    We could receive non STP BPDU's on bridge interface, or even STP BPDUs
    if STP is off for the bridge. The crash is avoided by checking for bridge
    interface and not processing further in that case.

    Patch based on one from Solomon Peachy <solomon@linux-wlan.com>

diff --git a/bridge_track.c b/bridge_track.c
index e93c014..802db7a 100644
--- a/bridge_track.c
+++ b/bridge_track.c
@@ -447,6 +447,12 @@ void bridge_bpdu_rcv(int if_index, const unsigned char *dat
        if (!ifc)
                return;

+       /* We could get a STP BPDU from a bridge interface if STP is off,
+          or a non STP packet as well, e.g. GMRP, even when STP is on.
+          Don't process it, else we will crash at ifc->master->stp_up */
+       if (ifc->is_bridge)
+               return;
+
        TST(ifc->up,);
        if (!ifc->master->stp_up)
                return;
