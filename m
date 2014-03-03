Return-Path: <mcgrof@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=gDQ1Y9wndA7UI4344gXUV7tagrzkJlQf6jFlCaesT48=;
	b=SEkSNW0svTw3fc+Whd3tHaVlxhnhlr4J1CSJsDlmvTYkwenJcdoyB7Tg8dtMOwD+P0
	9CNCXvPWjKS/MCzE9aBFYrtSj105w8jbeeVRCzcFsR1tFQlq9MgvosuRuzPimWyorQvu
	FJCYkHwgeTlg6ZWW0q/vQ3Dj+bf5fY7qBpRmgZWzhbqBNNK0sPjpHDhE7qygo9hO0Pap
	ky79dpDkplU6H80wyogRQqha8B7SULle37fuiYKj2XEu+wXbE3ZOly75hHM4kW5Og2IB
	MQ9JcdTYy4JKKqz3j77rvFDdpq+2eEe0Y8e+szUXbwybypFX8Roka7AC6pThCRuzS4UU
	U8Cw==
Sender: "Luis R. Rodriguez" <mcgrof@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Mon,  3 Mar 2014 14:47:04 -0800
Message-Id: <1393886825-24323-6-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1393886825-24323-1-git-send-email-mcgrof@do-not-panic.com>
References: <1393886825-24323-1-git-send-email-mcgrof@do-not-panic.com>
Subject: [Bridge] [RFC v3 5/6] xen-netback: use a random MAC address and
	force bridge root block
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: kvm@vger.kernel.org, mcgrof@suse.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, xen-devel@lists.xenproject.org

From: "Luis R. Rodriguez" <mcgrof@suse.com>

The purpose of using a static MAC address of FE:FF:FF:FF:FF:FF
was to prevent our backend interfaces from being used by the
bridge and nominating our interface as a root port on the bridge.
This was possible given that the bridge code will use the lowest MAC
address for a port once a new interface gets added to the bridge.

Sticking to a static MAC address is undesirable for a few reasons:

  a) using a static MAC address by default on all interfaces can
     lead to possible conflicts with IPv6 SLAAC and DAD

  b) The bridge code has a generic bridge port 'root block' feature
     to allow interfaces to opt out from root bridge port nominations.
     We want to help stop spreading the use of a high MAC address
     as a hack to do root port block, and instead get folks to
     use the proper APIs for this.

This modifies xen-netback to use a random MAC address with the xen OUI
prefix and enables the bridge root block feature since initialization.
Although toggling the root block feature requires the iproute2 bridge
tool [0] or sysfs [1] xen-netback users would only need to toggle this
off in the case that the net_device is required to be a candidate for
root port nomination on the bridge. This is an acceptable compromise
in order to avoid the possible conflicts with IPv6 SLAAC and DAD.

[0] bridge link set dev vif2.0 root_block off
[1] echo 1 > /sys/devices/vif-2-0/net/vif2.0/brport/root_block

Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: bridge@lists.linux-foundation.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xenproject.org
Cc: kvm@vger.kernel.org
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 drivers/net/xen-netback/interface.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index 7669d49..79d71ec 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -42,6 +42,8 @@
 #define XENVIF_QUEUE_LENGTH 32
 #define XENVIF_NAPI_WEIGHT  64
 
+static const u8 xen_oui[3] = { 0x00, 0x16, 0x3e };
+
 int xenvif_schedulable(struct xenvif *vif)
 {
 	return netif_running(vif->dev) && netif_carrier_ok(vif->dev);
@@ -346,15 +348,9 @@ struct xenvif *xenvif_alloc(struct device *parent, domid_t domid,
 	for (i = 0; i < MAX_PENDING_REQS; i++)
 		vif->mmap_pages[i] = NULL;
 
-	/*
-	 * Initialise a dummy MAC address. We choose the numerically
-	 * largest non-broadcast address to prevent the address getting
-	 * stolen by an Ethernet bridge for STP purposes.
-	 * (FE:FF:FF:FF:FF:FF)
-	 */
-	memset(dev->dev_addr, 0xFF, ETH_ALEN);
-	dev->dev_addr[0] &= ~0x01;
-
+	eth_hw_addr_random(dev);
+	memcpy(dev->dev_addr, xen_oui, 3);
+	dev->priv_flags |= IFF_BRIDGE_ROOT_BLOCK;
 	netif_napi_add(dev, &vif->napi, xenvif_poll, XENVIF_NAPI_WEIGHT);
 
 	netif_carrier_off(dev);
-- 
1.9.0

