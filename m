Return-Path: <arnd@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604701154;
 bh=OjKky2mcuT3PPhvnL2N1n9WJjuGKW1fEUioqpsDSDNw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=piTqh36/Ayd8rKuc3zcxxLUXwu8coawnGzadmDxmNVwyht5LsFJxbKKpvbei6ZwB5
 i4Xivr2LHHwHyaH25bXiALK3Cu/8c5VDnYA8drwte5C9rzrbOpBOhdg19zecSP7Ss6
 iishXpi6LYmi5ZVVAqz5r5CZz+uIbP+0EafwU9MI=
From: Arnd Bergmann <arnd@kernel.org>
Date: Fri,  6 Nov 2020 23:17:43 +0100
Message-Id: <20201106221743.3271965-29-arnd@kernel.org>
In-Reply-To: <20201106221743.3271965-1-arnd@kernel.org>
References: <20201106221743.3271965-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [RFC net-next 28/28] net: socket: return changed ifreq
	from SIOCDEVPRIVATE
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

Some drivers that use SIOCDEVPRIVATE ioctl commands modify
the ifreq structure and expect it to be passed back to user
space, which has never really happened for compat mode
because the calling these drivers through ndo_do_ioctl
requires overwriting the ifr_data pointer.

Now that all drivers are converted to ndo_siocdevprivate,
change it to handle this correctly in both compat and
native mode.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/core/dev_ioctl.c | 4 +---
 net/socket.c         | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 99efe8e2e0ce..0c058c3dc89a 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -296,9 +296,7 @@ static int dev_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 			return -ENODEV;
 	}
 
-	/* fall back to do_ioctl for drivers not yet converted */
-	ifr->ifr_data = data;
-	return dev_do_ioctl(dev, ifr, cmd);
+	return -EOPNOTSUPP;
 }
 
 /*
diff --git a/net/socket.c b/net/socket.c
index 1e077182d0fd..6edf3f4d9dca 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3206,7 +3206,7 @@ static int compat_sock_ioctl_trans(struct file *file, struct socket *sock,
 	struct net *net = sock_net(sk);
 
 	if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15))
-		return compat_ifr_data_ioctl(net, cmd, argp);
+		return sock_ioctl(file, cmd, (unsigned long)argp);
 
 	switch (cmd) {
 	case SIOCSIFBR:
-- 
2.27.0

