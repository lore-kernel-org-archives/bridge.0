Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=gIoM+pn92FmZ7l7fGywvcoFz7NhbL6+Ajxhl2csuoH4=;
 b=h/DCxncDj/YrNnh8RNeWnko9Hu+QqSLcJ+7SmZtNXPDB6Nh2VR+UlmwFU1HyMbQJw1
 KJpaxslG4hLz5Q2WlS3v+DiLNCf1XQW/+daYTnRGmiGadi9/SDdfUuq19ZdPkYIpXa/V
 9ISJ8Aw/EUuaS1D6Yi7P+RG4Vey6DytR+g5MzCzLY17JH8HqDikcR/POHLDrHJueGY18
 McuL/u8ZtlTcefFr9/Wh3HFlVu4/pNpwWF9wubfLn/AdRkoQrse8PCxfldEQNDn4L411
 eAN/roayikrAn+4ea3s93LZBdXWBt34HBokMNAVG3WTKHTJZOnuMq9lL9wLdBeziGOD1
 UxVQ==
From: Tobias Waldekranz <tobias@waldekranz.com>
Date: Mon, 26 Apr 2021 19:04:07 +0200
Message-Id: <20210426170411.1789186-6-tobias@waldekranz.com>
In-Reply-To: <20210426170411.1789186-1-tobias@waldekranz.com>
References: <20210426170411.1789186-1-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [RFC net-next 5/9] net: dsa: Track port PVIDs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@idosch.org, nikolay@nvidia.com, roopa@nvidia.com, olteanv@gmail.com, vivien.didelot@gmail.com

In some scenarios a tagger must know which VLAN to assign to a packet,
even if the packet is set to egress untagged. Since the VLAN
information in the skb will be removed by the bridge in this case,
track each port's PVID such that the VID of an outgoing frame can
always be determined.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/dsa.h |  1 +
 net/dsa/port.c    | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 507082959aa4..1f9ba9889034 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -270,6 +270,7 @@ struct dsa_port {
 	unsigned int		ageing_time;
 	bool			vlan_filtering;
 	u8			stp_state;
+	u16			pvid;
 	struct net_device	*bridge_dev;
 	struct devlink_port	devlink_port;
 	bool			devlink_port_setup;
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 6379d66a6bb3..02d96aebfcc6 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -651,8 +651,14 @@ int dsa_port_vlan_add(struct dsa_port *dp,
 		.vlan = vlan,
 		.extack = extack,
 	};
+	int err;
+
+	err = dsa_port_notify(dp, DSA_NOTIFIER_VLAN_ADD, &info);
 
-	return dsa_port_notify(dp, DSA_NOTIFIER_VLAN_ADD, &info);
+	if (!err && (vlan->flags & BRIDGE_VLAN_INFO_PVID))
+		dp->pvid = vlan->vid;
+
+	return err;
 }
 
 int dsa_port_vlan_del(struct dsa_port *dp,
@@ -663,8 +669,14 @@ int dsa_port_vlan_del(struct dsa_port *dp,
 		.port = dp->index,
 		.vlan = vlan,
 	};
+	int err;
+
+	err = dsa_port_notify(dp, DSA_NOTIFIER_VLAN_DEL, &info);
 
-	return dsa_port_notify(dp, DSA_NOTIFIER_VLAN_DEL, &info);
+	if (!err && vlan->vid == dp->pvid)
+		dp->pvid = 0;
+
+	return err;
 }
 
 int dsa_port_mrp_add(const struct dsa_port *dp,
-- 
2.25.1

