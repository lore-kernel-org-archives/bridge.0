Message-ID: <4C04D98D.4020509@redhat.com>
Date: Tue, 01 Jun 2010 17:57:33 +0800
From: Cong Wang <amwang@redhat.com>
MIME-Version: 1.0
References: <20100505081514.5157.83783.sendpatchset@localhost.localdomain>
	<20100527180545.GA2345@sysclose.org> <4BFF2EA5.9090008@redhat.com>
	<20100528194041.GC2345@sysclose.org> <4C034FA4.5000401@redhat.com>
	<20100531190820.GA24569@sysclose.org>
In-Reply-To: <20100531190820.GA24569@sysclose.org>
Content-Type: multipart/mixed; boundary="------------080508020407030406080308"
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
--------------080508020407030406080308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 06/01/10 03:08, Flavio Leitner wrote:
> On Mon, May 31, 2010 at 01:56:52PM +0800, Cong Wang wrote:
>> Hi, Flavio,
>>
>> Please use the attached patch instead, try to see if it solves
>> all your problems.
>
> I tried and it hangs. No backtraces this time.
> The bond_change_active_slave() prints before NETDEV_BONDING_FAILOVER
> notification, so I think it won't work.

Ah, I thought the same.

>
> Please, correct if I'm wrong, but when a failover happens with your
> patch applied, the netconsole would be disabled forever even with
> another healthy slave, right?
>

Yes, this is an easy solution, because bonding has several modes,
it is complex to make netpoll work in different modes.

Would you like to test the following patch?

Thanks much!


--------------080508020407030406080308
Content-Type: text/x-patch;
 name="drivers-net-bonding-fix-activebackup-deadlock.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="drivers-net-bonding-fix-activebackup-deadlock.diff"

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 5e12462..59ade92 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1109,6 +1109,14 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
 	if (old_active == new_active)
 		return;
 
+	write_unlock_bh(&bond->curr_slave_lock);
+	read_unlock(&bond->lock);
+
+	netdev_bonding_change(bond->dev, NETDEV_BONDING_DESLAVE);
+
+	read_lock(&bond->lock);
+	write_lock_bh(&bond->curr_slave_lock);
+
 	if (new_active) {
 		new_active->jiffies = jiffies;
 

--------------080508020407030406080308--
