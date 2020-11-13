Return-Path: <hkallweit1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:cc:from:subject:message-id:date:user-agent:mime-version
 :content-transfer-encoding;
 bh=9fNbzgPON6KHDunvl15bGkh4oFDVo6Bko7uyvRmoQSc=;
 b=AYiLwogs8kf6Iwr8kXyup8n3ucLyqf1J2I3xU3xc+I5CSgUysu1s/jeDdmUEr9DAmk
 CGnoQAqio8NBSo4ZtYkb62zdsQ8imzawCp11YjTXfAdQiEHmrB9hhsp4dV4X1u16RfHn
 emtHSFbzOuCcrzJ0+MQuPay3vV9HbA7nO5vsYfy2wNqfnTs/mlBvCY68Ea4YWT5+XaZi
 Y9ZbaVys/KtZjrzZ5lhvD2ZTGNF6gtQxP+BZKAxfAwZDkHRuvg5hB+bdnnnCgR35f7RE
 52eL7nOAhsb3KqchDukHYbVutdzmcHne5l/qFg0GRmo6PiAPBRfbUbr2vFoIISwA8t9O
 kG0Q==
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <58ea9963-77ad-a7cf-8dfd-fc95ab95f606@gmail.com>
Date: Fri, 13 Nov 2020 10:27:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH net] net: bridge: add missing counters to
 ndo_get_stats64 callback
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org

In br_forward.c and br_input.c fields dev->stats.tx_dropped and
dev->stats.multicast are populated, but they are ignored in
ndo_get_stats64.

Fixes: 28172739f0a2 ("net: fix 64 bit counters on 32 bit arches")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
Patch will not apply cleanly on kernel versions that don't have
dev_fetch_sw_netstats() yet.
---
 net/bridge/br_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 387403931..77bcc8487 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -207,6 +207,7 @@ static void br_get_stats64(struct net_device *dev,
 {
 	struct net_bridge *br = netdev_priv(dev);
 
+	netdev_stats_to_stats64(stats, &dev->stats);
 	dev_fetch_sw_netstats(stats, br->stats);
 }
 
-- 
2.29.2

