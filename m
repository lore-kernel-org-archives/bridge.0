Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZmHPk02ecFhhLFxeJX7p5e9amiKU0ZRM+eqQQmDy/pE=;
 b=kguRDLeRsmg0kGdl+ZWTy6seL2aHvT9ZWRaF10F/WQW6w78MYeuwO2vWlGwuAsZada
 BKELLtfd7IiQc+DGwQ8JXXC8saSwI8VTE21x7oWzC+43a30Z2qhUOJRV6BfeGeneW030
 +TPgvGfU2tNNwn9L7ut91IIZAt/Em8ZTS/U8sX9AGk2CpHXNclZg0XE4I4e5ys6BP9Iy
 /Hj9AyeJLAw5gzkf2hqz2XmafU9jN2eOtH87ODe184FGyLBDPffxREJMt1MO4Lui7tTf
 ZX+/+2jebvLsIcOCLtyHF55ypFsS0cD3VJ2Ia1D9/ew0a4TBAlO6g2QNi9j/45N2qpM6
 o34w==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Thu,  5 Aug 2021 11:29:02 +0300
Message-Id: <20210805082903.711396-3-razor@blackwall.org>
In-Reply-To: <20210805082903.711396-1-razor@blackwall.org>
References: <20210805082903.711396-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 2/3] net: bridge: fix ioctl old_deviceless
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
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, arnd@arndb.de, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Commit ad2f99aedf8f ("net: bridge: move bridge ioctls out of .ndo_do_ioctl")
changed the source of the argument copy in bridge's old_deviceless() from
args[1] (user ptr to device name) to uarg (ptr to ioctl arguments) causing
wrong device name to be used.

Example (broken, bridge exists but is up):
$ brctl delbr bridge
bridge bridge doesn't exist; can't delete it

Example (working):
$ brctl delbr bridge
bridge bridge is still up; can't delete it

Fixes: ad2f99aedf8f ("net: bridge: move bridge ioctls out of .ndo_do_ioctl")
Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index 2f848de3e755..793b0db9d9a3 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -351,7 +351,7 @@ static int old_deviceless(struct net *net, void __user *uarg)
 		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
 			return -EPERM;
 
-		if (copy_from_user(buf, uarg, IFNAMSIZ))
+		if (copy_from_user(buf, (void __user *)args[1], IFNAMSIZ))
 			return -EFAULT;
 
 		buf[IFNAMSIZ-1] = 0;
-- 
2.31.1

