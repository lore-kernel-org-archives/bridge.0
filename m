Message-ID: <4BFF7BE2.6020503@redhat.com>
Date: Fri, 28 May 2010 16:16:34 +0800
From: Cong Wang <amwang@redhat.com>
MIME-Version: 1.0
References: <20100505081514.5157.83783.sendpatchset@localhost.localdomain>
	<20100527180545.GA2345@sysclose.org>
In-Reply-To: <20100527180545.GA2345@sysclose.org>
Content-Type: multipart/mixed; boundary="------------050607000507050808060501"
Subject: Re: [Bridge] [v5 Patch 1/3] netpoll: add generic support for bridge
 and bonding devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Flavio Leitner <fbl@sysclose.org>
Cc: Jay Vosburgh <fubar@us.ibm.com>, Neil Horman <nhorman@tuxdriver.com>, netdev@vger.kernel.org, Matt Mackall <mpm@selenic.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Jeff Moyer <jmoyer@redhat.com>, Andy Gospodarek <gospo@redhat.com>, bonding-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------050607000507050808060501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 05/28/10 02:05, Flavio Leitner wrote:
>
> Hi guys!
>
> I finally could test this to see if an old problem reported on bugzilla[1] was
> fixed now, but unfortunately it is still there.
>
> The ticket is private I guess, but basically the problem happens when bonding
> driver tries to print something after it had taken the write_lock (monitor
> functions, enslave/de-enslave), so the printk() will pass through netpoll, then
> on bonding again which no matter what mode you use, it will try to read_lock()
> the lock again. The result is a deadlock and the entire system hangs.
>

Does the attached patch fix this hang?

Thanks!

----------------------->

We should notify netconsole that bond is changing its slaves
when we use active-backup mode.

Signed-off-by: WANG Cong <amwang@redhat.com>

----


--------------050607000507050808060501
Content-Type: text/x-patch;
 name="drivers-net-bonding-fix-activebackup-deadlock.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="drivers-net-bonding-fix-activebackup-deadlock.diff"

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 5e12462..9494c02 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1199,6 +1199,7 @@ void bond_select_active_slave(struct bonding *bond)
 
 	best_slave = bond_find_best_slave(bond);
 	if (best_slave != bond->curr_active_slave) {
+		netdev_bonding_change(bond->dev, NETDEV_BONDING_DESLAVE);
 		bond_change_active_slave(bond, best_slave);
 		rv = bond_set_carrier(bond);
 		if (!rv)
@@ -2154,6 +2155,7 @@ static int bond_ioctl_change_active(struct net_device *bond_dev, struct net_devi
 	    (old_active) &&
 	    (new_active->link == BOND_LINK_UP) &&
 	    IS_UP(new_active->dev)) {
+		netdev_bonding_change(bond->dev, NETDEV_BONDING_DESLAVE);
 		write_lock_bh(&bond->curr_slave_lock);
 		bond_change_active_slave(bond, new_active);
 		write_unlock_bh(&bond->curr_slave_lock);

--------------050607000507050808060501--
