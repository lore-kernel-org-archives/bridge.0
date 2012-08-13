Return-Path: <jiri@resnulli.us>
From: Jiri Pirko <jiri@resnulli.us>
Message-Id: <1344871635-1052-6-git-send-email-jiri@resnulli.us>
In-Reply-To: <1344871635-1052-1-git-send-email-jiri@resnulli.us>
References: <1344871635-1052-1-git-send-email-jiri@resnulli.us>
Subject: [Bridge] [patch net-next 05/16] team: remove usage of
	netdev_set_master()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Mon, 13 Aug 2012 15:27:34 -0000
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, ursula.braun@de.ibm.com, john.r.fastabend@intel.com, edumazet@google.com, shemminger@vyatta.com, sean.hefty@intel.com, therbert@google.com, roland@kernel.org, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, fubar@us.ibm.com, fbl@redhat.com, hal.rosenstock@gmail.com, faisal.latif@intel.com, sony.chacko@qlogic.com, blaschka@linux.vnet.ibm.com, gregory.v.rose@intel.com, bhutchings@solarflare.com, xiyou.wangcong@gmail.com, jitendra.kalsaria@qlogic.com, divy@chelsio.com, linux-driver@qlogic.com, linux-kernel@vger.kernel.org, kaber@trash.net, joe@perches.com, linux390@de.ibm.com, davem@davemloft.net

Signed-off-by: Jiri Pirko <jiri@resnulli.us>
---
 drivers/net/team/team.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index ba10c46..0533cbf 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1040,10 +1040,11 @@ static int team_port_add(struct team *team, struct net_device *port_dev)
 		}
 	}
 
-	err = netdev_set_master(port_dev, dev);
+	err = netdev_unique_upper_dev_link(port_dev, dev);
 	if (err) {
-		netdev_err(dev, "Device %s failed to set master\n", portname);
-		goto err_set_master;
+		netdev_err(dev, "Device %s failed to set upper link\n",
+			   portname);
+		goto err_set_upper_link;
 	}
 
 	err = netdev_rx_handler_register(port_dev, team_handle_frame,
@@ -1076,9 +1077,9 @@ err_option_port_add:
 	netdev_rx_handler_unregister(port_dev);
 
 err_handler_register:
-	netdev_set_master(port_dev, NULL);
+	netdev_upper_dev_unlink(port_dev, dev);
 
-err_set_master:
+err_set_upper_link:
 	team_port_disable_netpoll(port);
 
 err_enable_netpoll:
@@ -1121,7 +1122,7 @@ static int team_port_del(struct team *team, struct net_device *port_dev)
 	team_port_disable(team, port);
 	list_del_rcu(&port->list);
 	netdev_rx_handler_unregister(port_dev);
-	netdev_set_master(port_dev, NULL);
+	netdev_upper_dev_unlink(port_dev, dev);
 	team_port_disable_netpoll(port);
 	vlan_vids_del_by_dev(port_dev, dev);
 	dev_close(port_dev);
-- 
1.7.10.4

