Message-ID: <fed120860901021101s6d52f6cfi7e91c126f3488577@mail.gmail.com>
Date: Sat, 3 Jan 2009 00:31:17 +0530
From: "Srinivas M.A." <srinivas.aji@gmail.com>
In-Reply-To: <c0bb1def0901020953v1b7722baw7f0daafdc8d02abb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <c0bb1def0901020953v1b7722baw7f0daafdc8d02abb@mail.gmail.com>
Subject: Re: [Bridge] RSTPD user mode daemon segfaults with kernel 2.6.24
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Antonio Di Bacco <a.dibacco@gmail.com>
Cc: bridge@lists.linux-foundation.org

Hi, the fix for this is:

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


On Fri, Jan 2, 2009 at 11:23 PM, Antonio Di Bacco <a.dibacco@gmail.com> wrote:
> Hi,
>
> I have downloaded rstp from sourceforge and I get a segfaults when running
> the daemon.
> This is the line where the problem arises:
>
>     TST(ifc->master->stp_up,);
>
> just at the beginning of function:
>
>   void bridge_bpdu_rcv(int if_index, const unsigned char *data, int len)
>
> in file bridge_track.c
>
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
