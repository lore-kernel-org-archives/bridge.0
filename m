Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=scHE9d5ONVOSdnYa8WVWpcK+kRjde55g2yNWIa6qibo=;
 b=CPQwwDj6wiEJ4ZYKqhbT6ssPVv2NYdEHr9dSgGVtQBta259ZuNEfG2J9LqnBJK/7T7
 pkU9xUxcfmEGjcV/XKPguudEmo0wMofRBM+7mhskB2kmCTQ+UMqXIP+l5aaOGOmJqyrs
 RJfMzEOyMB9Sm+SUoQZq8Asp8zPriU6qvuDWXP6ZISSKiW3y5apI4WgqTyjZnrhrWw3t
 cvID5Cbg6ot/dXehrZFKgwUXIux/KiH3Ml5Jotqr+EVfQnUnRQRrFRGYYJsFGqR+w9KT
 hDvvyPCEuzG2X1Qf7XHxhFHUbb7615V/SATrQAe/Jwnomy+RPwANGZQeK9k3fn+7C6zh
 XqOw==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Tue, 29 Jun 2021 17:06:46 +0300
Message-Id: <20210629140658.2510288-4-olteanv@gmail.com>
In-Reply-To: <20210629140658.2510288-1-olteanv@gmail.com>
References: <20210629140658.2510288-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v5 net-next 03/15] net: bridge: allow br_fdb_replay
	to be called for the bridge device
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vladimir Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

When a port joins a bridge which already has local FDB entries pointing
to the bridge device itself, we would like to offload those, so allow
the "dev" argument to be equal to the bridge too. The code already does
what we need in that case.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v4->v5: split in 2 separate checks, one for br_dev and one for dev,
        because it looks better

 net/bridge/br_fdb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index bad7e84d76af..2b862cffc03a 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -760,7 +760,10 @@ int br_fdb_replay(const struct net_device *br_dev, const struct net_device *dev,
 	unsigned long action;
 	int err = 0;
 
-	if (!netif_is_bridge_master(br_dev) || !netif_is_bridge_port(dev))
+	if (!netif_is_bridge_master(br_dev))
+		return -EINVAL;
+
+	if (!netif_is_bridge_port(dev) && !netif_is_bridge_master(dev))
 		return -EINVAL;
 
 	br = netdev_priv(br_dev);
-- 
2.25.1

