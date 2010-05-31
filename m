Message-ID: <4C034FA4.5000401@redhat.com>
Date: Mon, 31 May 2010 13:56:52 +0800
From: Cong Wang <amwang@redhat.com>
MIME-Version: 1.0
References: <20100505081514.5157.83783.sendpatchset@localhost.localdomain>
	<20100527180545.GA2345@sysclose.org> <4BFF2EA5.9090008@redhat.com>
	<20100528194041.GC2345@sysclose.org>
In-Reply-To: <20100528194041.GC2345@sysclose.org>
Content-Type: multipart/mixed; boundary="------------080108050002040107090202"
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
--------------080108050002040107090202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Flavio,

Please use the attached patch instead, try to see if it solves
all your problems.

Thanks a lot!


--------------080108050002040107090202
Content-Type: text/x-patch;
 name="drivers-net-bonding-fix-activebackup-deadlock.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="drivers-net-bonding-fix-activebackup-deadlock.diff"

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index ca142c4..2d1d594 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -666,7 +666,8 @@ static int netconsole_netdev_event(struct notifier_block *this,
 	struct net_device *dev = ptr;
 
 	if (!(event == NETDEV_CHANGENAME || event == NETDEV_UNREGISTER ||
-	      event == NETDEV_BONDING_DESLAVE || event == NETDEV_GOING_DOWN))
+	      event == NETDEV_BONDING_DESLAVE || event == NETDEV_GOING_DOWN ||
+	      event == NETDEV_BONDING_FAILOVER))
 		goto done;
 
 	spin_lock_irqsave(&target_list_lock, flags);
@@ -682,6 +683,7 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				/* Fall through */
 			case NETDEV_GOING_DOWN:
 			case NETDEV_BONDING_DESLAVE:
+			case NETDEV_BONDING_FAILOVER:
 				nt->enabled = 0;
 				break;
 			}

--------------080108050002040107090202--
