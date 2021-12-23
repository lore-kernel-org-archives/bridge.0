Return-Path: <repk@triplefau.lt>
From: Remi Pommarel <repk@triplefau.lt>
Date: Thu, 23 Dec 2021 16:31:38 +0100
Message-Id: <20211223153139.7661-2-repk@triplefau.lt>
In-Reply-To: <20211223153139.7661-1-repk@triplefau.lt>
References: <20211223153139.7661-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net 1/2] net: bridge: fix ioctl old_deviceless
	bridge argument
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

Commit 561d8352818f ("bridge: use ndo_siocdevprivate") changed the
source and destination arguments of copy_{to,from}_user in bridge's
old_deviceless() from args[1] to uarg breaking SIOC{G,S}IFBR ioctls.

Commit cbd7ad29a507 ("net: bridge: fix ioctl old_deviceless bridge
argument") fixed only BRCTL_{ADD,DEL}_BRIDGES commands leaving
BRCTL_GET_BRIDGES one untouched.

The fixes BRCTL_GET_BRIDGES as well and has been tested with busybox's
brctl.

Example of broken brctl:
$ brctl show
bridge name     bridge id               STP enabled     interfaces
brctl: can't get bridge name for index 0: No such device or address

Example of fixed brctl:
$ brctl show
bridge name     bridge id               STP enabled     interfaces
br0             8000.000000000000       no

Fixes: 561d8352818f ("bridge: use ndo_siocdevprivate")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index db4ab2c2ce18..891cfcf45644 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -337,7 +337,7 @@ static int old_deviceless(struct net *net, void __user *uarg)
 
 		args[2] = get_bridge_ifindices(net, indices, args[2]);
 
-		ret = copy_to_user(uarg, indices,
+		ret = copy_to_user((void __user *)args[1], indices,
 				   array_size(args[2], sizeof(int)))
 			? -EFAULT : args[2];
 
-- 
2.33.0

