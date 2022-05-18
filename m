Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Content-Disposition:In-Reply-To:References;
 bh=iKPxo6nmawUzIoV5U9tlyCQp6Vw6AUpCRQ4Ur98rVDI=; b=SwCsPL1wVop+erLd9VYQlzxibL
 a0Z+7K0bAwgPvSdzxnQ01eIe9P+DXZpF2J5TXPYikAJUbL6Fpbc0EhUNot5Bn1S7l+pTTvYcPDCWV
 82QeSKh4tkh+Ez/UBuaNtrJY3MnbquXZuQxuzNYKz0E49xZJZt+dmrnFQ7bRhg4YqoGY=;
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 18 May 2022 02:58:40 +0200
Message-Id: <20220518005840.771575-1-andrew@lunn.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v2 net] net: bridge: Clear offload_fwd_mark when
	passing frame up bridge interface.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev <netdev@vger.kernel.org>
Cc: Ido Schimmel <idosch@mellanox.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Andrew Lunn <andrew@lunn.ch>

It is possible to stack bridges on top of each other. Consider the
following which makes use of an Ethernet switch:

       br1
     /    \
    /      \
   /        \
 br0.11    wlan0
   |
   br0
 /  |  \
p1  p2  p3

br0 is offloaded to the switch. Above br0 is a vlan interface, for
vlan 11. This vlan interface is then a slave of br1. br1 also has a
wireless interface as a slave. This setup trunks wireless lan traffic
over the copper network inside a VLAN.

A frame received on p1 which is passed up to the bridge has the
skb->offload_fwd_mark flag set to true, indicating that the switch has
dealt with forwarding the frame out ports p2 and p3 as needed. This
flag instructs the software bridge it does not need to pass the frame
back down again. However, the flag is not getting reset when the frame
is passed upwards. As a result br1 sees the flag, wrongly interprets
it, and fails to forward the frame to wlan0.

When passing a frame upwards, clear the flag. This is the Rx
equivalent of br_switchdev_frame_unmark() in br_dev_xmit().

Fixes: f1c2eddf4cb6 ("bridge: switchdev: Use an helper to clear forward mark")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---

v2:
Extended the commit message with Ido obsersation of the equivelance of
br_dev_xmit().

Fixed up the comment.

This code has passed Ido test setup.

net/bridge/br_input.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 196417859c4a..68b3e850bcb9 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -39,6 +39,13 @@ static int br_pass_frame_up(struct sk_buff *skb)
 	dev_sw_netstats_rx_add(brdev, skb->len);
 
 	vg = br_vlan_group_rcu(br);
+
+	/* Reset the offload_fwd_mark because there could be a stacked
+	 * bridge above, and it should not think this bridge it doing
+	 * that bridge's work forwarding out its ports.
+	 */
+	br_switchdev_frame_unmark(skb);
+
 	/* Bridge is just like any other port.  Make sure the
 	 * packet is allowed except in promisc mode when someone
 	 * may be running packet capture.
-- 
2.36.0

