Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=WGnOG0JpJKzUjl5Bwk2bg29FCQEPzjElbHjoFVQYAww=;
	b=HsW3CfYklay0PABbmjUCf54EUhZVmkQMYHHIkwDl4rTla0VtF616tXiHnYajxKh3Zr
	ssWqxm+zGDdP1fvp87QrEAwvtkHByNoG8SYjqVps97d83ak4W6gwHJWl0UjVAZ74uFXP
	lLdKn57GBKARpXk52uDKw/5QiaqewBi6vJj0Wu7vy2P8QuecSJr1z4D0dFBzsdVnUtWh
	9WasyMMsRDqlYTLO6wwTxWSG/cmNRGZXiq8axl+bmfJVGfvOdbzZfTUt3iQ0Brfx5iEh
	F5lduggF7fwZZDBkHgITk9V68ECY92/JhUyFlet97BcvB0sNjFgtz/75FvKBf3QEMWRL
	6zqQ==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 16 Jan 2015 09:56:02 -0800
Message-Id: <1421430962-18119-3-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1421430962-18119-1-git-send-email-f.fainelli@gmail.com>
References: <1421430962-18119-1-git-send-email-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v2 2/2] net: bridge: reject DSA-enabled
	master netdevices as bridge members
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, bridge@lists.linux-foundation.org, kaber@trash.net, davem@davemloft.net, buytenh@wantstofly.org

DSA-enabled master network devices with a switch tagging protocol should
strip the protocol specific format before handing the frame over to
higher layer.

When adding such a DSA master network device as a bridge member, we go
through the following code path when receiving a frame:

__netif_receive_skb_core
	-> first ptype check against ptype_all is not returning any
	   handler for this skb

	-> check and invoke rx_handler:
		-> deliver frame to the bridge layer: br_handle_frame

DSA registers a ptype handler with the fake ETH_XDSA ethertype, which is
called *after* the bridge-layer rx_handler has run. br_handle_frame()
tries to parse the frame it received from the DSA master network device,
and will not be able to match any of its conditions and jumps straight
at the end of the end of br_handle_frame() and returns
RX_HANDLER_CONSUMED there.

Since we returned RX_HANDLER_CONSUMED, __netif_receive_skb_core() stops
RX processing for this frame and returns NET_RX_SUCCESS, so we never get
a chance to call our switch tag packet processing logic and deliver
frames to the DSA slave network devices, and so we do not get any
functional bridge members at all.

Instead of cluttering the bridge receive path with DSA-specific checks,
and rely on assumptions about how __netif_receive_skb_core() is
processing frames, we simply deny adding the DSA master network device
(conduit interface) as a bridge member, leaving only the slave DSA
network devices to be bridge members, since those will work correctly in
all circumstances.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/bridge/br_if.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 81e49fb73169..b087d278c679 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -436,10 +436,16 @@ int br_add_if(struct net_bridge *br, struct net_device *dev)
 	int err = 0;
 	bool changed_addr;
 
-	/* Don't allow bridging non-ethernet like devices */
+	/* Don't allow bridging non-ethernet like devices, or DSA-enabled
+	 * master network devices since the bridge layer rx_handler prevents
+	 * the DSA fake ethertype handler to be invoked, so we do not strip off
+	 * the DSA switch tag protocol header and the bridge layer just return
+	 * RX_HANDLER_CONSUMED, stopping RX processing for these frames.
+	 */
 	if ((dev->flags & IFF_LOOPBACK) ||
 	    dev->type != ARPHRD_ETHER || dev->addr_len != ETH_ALEN ||
-	    !is_valid_ether_addr(dev->dev_addr))
+	    !is_valid_ether_addr(dev->dev_addr) ||
+	    netdev_uses_dsa(dev))
 		return -EINVAL;
 
 	/* No bridging of bridges */
-- 
2.1.0

