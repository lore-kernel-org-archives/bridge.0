Return-Path: <arnd@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604701103;
 bh=t9jSt2j/mn9d/2bFgxLTxkax2Wz43GPQL/9eJHs6bJg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=owEJfBBOcrGQlW714fU4VJ6j6FJ7Hbh4yW9r1cTx17UAATNaC3SLVafvOptINHA7Z
 EaG/MCPttENxaPec502uc9r6GQTDeceh+9E78jLJgr+LFxYFUEJX4+YgyQEcoZwqtF
 KW286aLoA7zhoG0sXbbFmf0dXeolD6iGldx9DmnE=
From: Arnd Bergmann <arnd@kernel.org>
Date: Fri,  6 Nov 2020 23:17:25 +0100
Message-Id: <20201106221743.3271965-11-arnd@kernel.org>
In-Reply-To: <20201106221743.3271965-1-arnd@kernel.org>
References: <20201106221743.3271965-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [RFC net-next 10/28] appletalk: use ndo_siocdevprivate
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Jakub Kicinski <kuba@kernel.org>, linux-hams@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, Christoph Hellwig <hch@lst.de>, Heiner Kallweit <hkallweit1@gmail.com>

From: Arnd Bergmann <arnd@arndb.de>

appletalk has three SIOCDEVPRIVATE ioctl commands that are
broken in compat mode because the passed structure contains
a pointer.

Change it over to ndo_siocdevprivate for consistency and
make it return an error when called in compat mode. This
could be fixed if there are still users.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/appletalk/ipddp.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/appletalk/ipddp.c b/drivers/net/appletalk/ipddp.c
index 51cf5eca9c7f..812b1c878ae7 100644
--- a/drivers/net/appletalk/ipddp.c
+++ b/drivers/net/appletalk/ipddp.c
@@ -54,11 +54,11 @@ static netdev_tx_t ipddp_xmit(struct sk_buff *skb,
 static int ipddp_create(struct ipddp_route *new_rt);
 static int ipddp_delete(struct ipddp_route *rt);
 static struct ipddp_route* __ipddp_find_route(struct ipddp_route *rt);
-static int ipddp_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd);
+static int ipddp_siocdevprivate(struct net_device *dev, struct ifreq *ifr, void __user *data, int cmd);
 
 static const struct net_device_ops ipddp_netdev_ops = {
 	.ndo_start_xmit		= ipddp_xmit,
-	.ndo_do_ioctl   	= ipddp_ioctl,
+	.ndo_siocdevprivate   	= ipddp_siocdevprivate,
 	.ndo_set_mac_address 	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 };
@@ -268,15 +268,18 @@ static struct ipddp_route* __ipddp_find_route(struct ipddp_route *rt)
         return NULL;
 }
 
-static int ipddp_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+static int ipddp_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
+				void __user *data, int cmd)
 {
-        struct ipddp_route __user *rt = ifr->ifr_data;
         struct ipddp_route rcp, rcp2, *rp;
 
+	if (in_compat_syscall())
+		return -EOPNOTSUPP;
+
         if(!capable(CAP_NET_ADMIN))
                 return -EPERM;
 
-	if(copy_from_user(&rcp, rt, sizeof(rcp)))
+	if(copy_from_user(&rcp, data, sizeof(rcp)))
 		return -EFAULT;
 
         switch(cmd)
@@ -296,7 +299,7 @@ static int ipddp_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 			spin_unlock_bh(&ipddp_route_lock);
 
 			if (rp) {
-				if (copy_to_user(rt, &rcp2,
+				if (copy_to_user(data, &rcp2,
 						 sizeof(struct ipddp_route)))
 					return -EFAULT;
 				return 0;
-- 
2.27.0

