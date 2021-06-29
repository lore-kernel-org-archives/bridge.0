Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HDFzCNuLgKoVL4N8qSF6ScaYL/eIkjL+npECoBu/hQ0=;
 b=Z+NmDbbOoqNFyAwTX/7hrCXLKPpKucfwvLs1E044CuiTg/WIh0FYHdH3XTFuXnIv8T
 jRQDJ4YGn3SLh05g7zy0X/k9AJTezaa/SQWIQ60e4oHXcx/9UPYivMmE29B5pR650rKR
 biGvahr0LHELWmuXBXzXz0cZk2+pfVAZ+2HiF1kQrGpfnIQK42VV7p9MEfF20VeO7NUV
 u7UmFBF6mAiSqXP3DVxfH88PM54TJrkbQGaWU8yhUqu991q9ZVBnCQH+6nUZS6ScjuM5
 mYZZMT1/EV5dIbbYTIjV4p6jkUi3yqN49KvE7y+WhSjl+MBV3olCOIVrpqpHG09ZmRoy
 RVcA==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Tue, 29 Jun 2021 17:06:48 +0300
Message-Id: <20210629140658.2510288-6-olteanv@gmail.com>
In-Reply-To: <20210629140658.2510288-1-olteanv@gmail.com>
References: <20210629140658.2510288-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v5 net-next 05/15] net: dsa: introduce
	dsa_is_upstream_port and dsa_switch_is_upstream_of
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

In preparation for the new cross-chip notifiers for host addresses,
let's introduce some more topology helpers which we are going to use to
discern switches that are in our path towards the dedicated CPU port
from switches that aren't.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v4->v5: none

 include/net/dsa.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index ea47783d5695..5f632cfd33c7 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -491,6 +491,32 @@ static inline unsigned int dsa_upstream_port(struct dsa_switch *ds, int port)
 	return dsa_towards_port(ds, cpu_dp->ds->index, cpu_dp->index);
 }
 
+/* Return true if this is the local port used to reach the CPU port */
+static inline bool dsa_is_upstream_port(struct dsa_switch *ds, int port)
+{
+	if (dsa_is_unused_port(ds, port))
+		return false;
+
+	return port == dsa_upstream_port(ds, port);
+}
+
+/* Return true if @upstream_ds is an upstream switch of @downstream_ds, meaning
+ * that the routing port from @downstream_ds to @upstream_ds is also the port
+ * which @downstream_ds uses to reach its dedicated CPU.
+ */
+static inline bool dsa_switch_is_upstream_of(struct dsa_switch *upstream_ds,
+					     struct dsa_switch *downstream_ds)
+{
+	int routing_port;
+
+	if (upstream_ds == downstream_ds)
+		return true;
+
+	routing_port = dsa_routing_port(downstream_ds, upstream_ds->index);
+
+	return dsa_is_upstream_port(downstream_ds, routing_port);
+}
+
 static inline bool dsa_port_is_vlan_filtering(const struct dsa_port *dp)
 {
 	const struct dsa_switch *ds = dp->ds;
-- 
2.25.1

