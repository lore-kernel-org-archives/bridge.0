Date: Thu, 31 Jan 2008 08:50:11 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] Bridge not functional after disconnect / connect
Message-ID: <20080131085011.036026ad@extreme>
In-Reply-To: <558132.22783.qm@web60424.mail.yahoo.com>
References: <558132.22783.qm@web60424.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Alex Shnitman <alexta69@yahoo.com>
Cc: bridge@lists.linux-foundation.org

There were some fixes to carrier handling that went into 2.6.24.

commit 21d7f67700ad7a4523d35d43ce95755e40eae5b7
Author: Stephen Hemminger <shemminger@linux-foundation.org>
Date:   Mon Nov 26 11:54:51 2007 -0800

    skge: fiber link up/down fix
    
    The driver would not work over fibre if other end when down then
    came back up (would require reloading driver). The correct way
    to manage the link the same way for both TP and fibre.
    
    Resloves problem described in: 	 http://lkml.org/lkml/2007/11/6/395
    
    Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/drivers/net/skge.c b/drivers/net/skge.c
index b680cb0..73a4246 100644
--- a/drivers/net/skge.c
+++ b/drivers/net/skge.c
@@ -1095,16 +1095,9 @@ static void xm_link_down(struct skge_hw *hw, int port)
 {
 	struct net_device *dev = hw->dev[port];
 	struct skge_port *skge = netdev_priv(dev);
-	u16 cmd = xm_read16(hw, port, XM_MMU_CMD);
 
 	xm_write16(hw, port, XM_IMSK, XM_IMSK_DISABLE);
 
-	cmd &= ~(XM_MMU_ENA_RX | XM_MMU_ENA_TX);
-	xm_write16(hw, port, XM_MMU_CMD, cmd);
-
-	/* dummy read to ensure writing */
-	xm_read16(hw, port, XM_MMU_CMD);
-
 	if (netif_carrier_ok(dev))
 		skge_link_down(skge);
 }
@@ -1194,6 +1187,7 @@ static void genesis_init(struct skge_hw *hw)
 static void genesis_reset(struct skge_hw *hw, int port)
 {
 	const u8 zero[8]  = { 0 };
+	u32 reg;
 
 	skge_write8(hw, SK_REG(port, GMAC_IRQ_MSK), 0);
 
@@ -1209,6 +1203,11 @@ static void genesis_reset(struct skge_hw *hw, int port)
 		xm_write16(hw, port, PHY_BCOM_INT_MASK, 0xffff);
 
 	xm_outhash(hw, port, XM_HSM, zero);
+
+	/* Flush TX and RX fifo */
+	reg = xm_read32(hw, port, XM_MODE);
+	xm_write32(hw, port, XM_MODE, reg | XM_MD_FTF);
+	xm_write32(hw, port, XM_MODE, reg | XM_MD_FRF);
 }
 
 
@@ -1714,6 +1713,12 @@ static void genesis_stop(struct skge_port *skge)
 	struct skge_hw *hw = skge->hw;
 	int port = skge->port;
 	unsigned retries = 1000;
+	u16 cmd;
+
+ 	/* Disable Tx and Rx */
+	cmd = xm_read16(hw, port, XM_MMU_CMD);
+	cmd &= ~(XM_MMU_ENA_RX | XM_MMU_ENA_TX);
+	xm_write16(hw, port, XM_MMU_CMD, cmd);
 
 	genesis_reset(hw, port);
 
