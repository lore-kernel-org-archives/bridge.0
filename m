Date: Wed, 4 Jan 2006 14:08:53 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] eth0- can't enslave to br0, but eth0 is down and not
	part of a bridge!
Message-ID: <20060104140853.3ff75b77@dxpl.pdx.osdl.net>
In-Reply-To: <dbf855d00512301013g5eafdf8du9556be854480324d@mail.gmail.com>
References: <dbf855d00512300011t6c4c445w2109458b1c036083@mail.gmail.com>
	<20051230094730.14498125@localhost.localdomain>
	<dbf855d00512301013g5eafdf8du9556be854480324d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: wandering.womble@gmail.com
Cc: bridge@lists.osdl.org

On Fri, 30 Dec 2005 10:13:25 -0800
<wandering.womble@gmail.com> wrote:

> Ooops- sorry, kernel versions tried are 2.6.14 & 2.6.14-ck6- both with
> the same results.
> Both are clean installs (i.e. just got the code and compiled), both
> using the same original .config (make oldconfig, then make menuconfig,
> make .... etc)
> 
> Bridging is enabled as a module; the sis 900 (eth0) and tap drivers
> are also modules.
> 
> I didn't notice any errors or other problems with the kernel compiles.
> 
> >From what you're saying, there's some special code #ifdef'd in
> ethernet drivers if bridging is enabled- perhaps the sis900 driver has
> some bugs with regard to handling this?  Any hints on what I should be
> looking for?
> 
> Thanks in advance,
> 
> Julian
> 
> > Need to know. Kernel version, and what kind of device eth0 is.
> > I suspect there is a build problem or module mismatch, since the test
> > for a device being member of a bridge is just a check for pointer in
> > device structure.  If you built bridge separately, and kernel was not configured
> > to enable bridging, then the bridge pointer in the net device structure would not
> > have existed and would be used for something elese.
> >

You could try the following additional tests.

Index: br-2.6/drivers/net/sis900.c
===================================================================
--- br-2.6.orig/drivers/net/sis900.c
+++ br-2.6/drivers/net/sis900.c
@@ -434,7 +434,7 @@ static int __devinit sis900_probe(struct
 	if (ret)
 		goto err_out;
 
-	sis_priv = net_dev->priv;
+	sis_priv = netdev_priv(net_dev);
 	net_dev->base_addr = ioaddr;
 	net_dev->irq = pci_dev->irq;
 	sis_priv->pci_dev = pci_dev;
@@ -538,6 +538,9 @@ static int __devinit sis900_probe(struct
 		printk("%2.2x:", (u8)net_dev->dev_addr[i]);
 	printk("%2.2x.\n", net_dev->dev_addr[i]);
 
+	printk(" dev=%p br_port@%p = %p\n", net_dev, &net_dev->br_port, 
+	       net_dev->br_port);
+
 	return 0;
 
  err_unmap_rx:
@@ -565,7 +568,7 @@ static int __devinit sis900_probe(struct
 
 static int __init sis900_mii_probe(struct net_device * net_dev)
 {
-	struct sis900_private * sis_priv = net_dev->priv;
+	struct sis900_private * sis_priv = netdev_priv(net_dev);
 	const char *dev_name = pci_name(sis_priv->pci_dev);
 	u16 poll_bit = MII_STAT_LINK, status = 0;
 	unsigned long timeout = jiffies + 5 * HZ;
@@ -693,7 +696,7 @@ static int __init sis900_mii_probe(struc
 
 static u16 sis900_default_phy(struct net_device * net_dev)
 {
-	struct sis900_private * sis_priv = net_dev->priv;
+	struct sis900_private * sis_priv = netdev_priv(net_dev);
  	struct mii_phy *phy = NULL, *phy_home = NULL, 
 		*default_phy = NULL, *phy_lan = NULL;
 	u16 status;
@@ -994,7 +997,7 @@ static void sis900_poll(struct net_devic
 static int
 sis900_open(struct net_device *net_dev)
 {
-	struct sis900_private *sis_priv = net_dev->priv;
+	struct sis900_private *sis_priv = netdev_priv(net_dev);
 	long ioaddr = net_dev->base_addr;
 	int ret;
 
@@ -1009,6 +1012,8 @@ sis900_open(struct net_device *net_dev)
 	if (ret)
 		return ret;
 
+	printk("sis900_open br_port= %p\n", net_dev->br_port);
+
 	sis900_init_rxfilter(net_dev);
 
 	sis900_init_tx_ring(net_dev);
@@ -1050,7 +1055,7 @@ sis900_open(struct net_device *net_dev)
 static void
 sis900_init_rxfilter (struct net_device * net_dev)
 {
-	struct sis900_private *sis_priv = net_dev->priv;
+	struct sis900_private *sis_priv = netdev_priv(net_dev);
 	long ioaddr = net_dev->base_addr;
 	u32 rfcrSave;
 	u32 i;
@@ -1088,7 +1093,7 @@ sis900_init_rxfilter (struct net_device 
 static void
 sis900_init_tx_ring(struct net_device *net_dev)
 {
-	struct sis900_private *sis_priv = net_dev->priv;
+	struct sis900_private *sis_priv = netdev_priv(net_dev);
 	long ioaddr = net_dev->base_addr;
 	int i;
 
@@ -1122,7 +1127,7 @@ sis900_init_tx_ring(struct net_device *n
 static void 
 sis900_init_rx_ring(struct net_device *net_dev)
 {
-	struct sis900_private *sis_priv = net_dev->priv;
+	struct sis900_private *sis_priv = netdev_priv(net_dev);
 	long ioaddr = net_dev->base_addr;
 	int i;
 
@@ -1194,7 +1199,7 @@ sis900_init_rx_ring(struct net_device *n
 
 static void sis630_set_eq(struct net_device *net_dev, u8 revision)
 {
-	struct sis900_private *sis_priv = net_dev->priv;
+	struct sis900_private *sis_priv = netdev_priv(net_dev);
 	u16 reg14h, eq_value=0, max_value=0, min_value=0;
 	int i, maxcount=10;
 
@@ -1267,7 +1272,7 @@ static void sis630_set_eq(struct net_dev
 static void sis900_timer(unsigned long data)
 {
 	struct net_device *net_dev = (struct net_device *)data;
-	struct sis900_private *sis_priv = net_dev->priv;
+	struct sis900_private *sis_priv = netdev_priv(net_dev);
 	struct mii_phy *mii_phy = sis_priv->mii;
 	static int next_tick = 5*HZ;
 	u16 status;
@@ -1337,7 +1342,7 @@ static void sis900_timer(unsigned long d
 
 static void sis900_check_mode(struct net_device *net_dev, struct mii_phy *mii_phy)
 {
-	struct sis900_private *sis_priv = net_dev->priv;
+	struct sis900_private *sis_priv = netdev_priv(net_dev);
 	long ioaddr = net_dev->base_addr;
 	int speed, duplex;
 
@@ -1411,7 +1416,7 @@ static void sis900_set_mode (long ioaddr
 
 static void sis900_auto_negotiate(struct net_device *net_dev, int phy_addr)
 {
-	struct sis900_private *sis_priv = net_dev->priv;
+	struct sis900_private *sis_priv = netdev_priv(net_dev);
 	int i = 0;
 	u32 status;
 	
@@ -1446,7 +1451,7 @@ static void sis900_auto_negotiate(struct
 
 static void sis900_read_mode(struct net_device *net_dev, int *speed, int *duplex)
 {
-	struct sis900_private *sis_priv = net_dev->priv;
+	struct sis900_private *sis_priv = netdev_priv(net_dev);
 	struct mii_phy *phy = sis_priv->mii;
 	int phy_addr = sis_priv->cur_phy;
 	u32 status;
@@ -1501,7 +1506,7 @@ static void sis900_read_mode(struct net_
 
 static void sis900_tx_timeout(struct net_device *net_dev)
 {
-	struct sis900_private *sis_priv = net_dev->priv;
+	struct sis900_private *sis_priv = netdev_priv(net_dev);
 	long ioaddr = net_dev->base_addr;
 	unsigned long flags;
 	int i;
@@ -1560,7 +1565,7 @@ static void sis900_tx_timeout(struct net
 static int
 sis900_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
 {
-	struct sis900_private *sis_priv = net_dev->priv;
+	struct sis900_private *sis_priv = netdev_priv(net_dev);
 	long ioaddr = net_dev->base_addr;
 	unsigned int  entry;
 	unsigned long flags;
@@ -1630,7 +1635,7 @@ sis900_start_xmit(struct sk_buff *skb, s
 static irqreturn_t sis900_interrupt(int irq, void *dev_instance, struct pt_regs *regs)
 {
 	struct net_device *net_dev = dev_instance;
-	struct sis900_private *sis_priv = net_dev->priv;
+	struct sis900_private *sis_priv = netdev_priv(net_dev);
 	int boguscnt = max_interrupt_work;
 	long ioaddr = net_dev->base_addr;
 	u32 status;
@@ -1692,7 +1697,7 @@ static irqreturn_t sis900_interrupt(int 
 
 static int sis900_rx(struct net_device *net_dev)
 {
-	struct sis900_private *sis_priv = net_dev->priv;
+	struct sis900_private *sis_priv = netdev_priv(net_dev);
 	long ioaddr = net_dev->base_addr;
 	unsigned int entry = sis_priv->cur_rx % NUM_RX_DESC;
 	u32 rx_status = sis_priv->rx_ring[entry].cmdsts;
@@ -1839,7 +1844,7 @@ static int sis900_rx(struct net_device *
 
 static void sis900_finish_xmit (struct net_device *net_dev)
 {
-	struct sis900_private *sis_priv = net_dev->priv;
+	struct sis900_private *sis_priv = netdev_priv(net_dev);
 
 	for (; sis_priv->dirty_tx != sis_priv->cur_tx; sis_priv->dirty_tx++) {
 		struct sk_buff *skb;
@@ -1908,7 +1913,7 @@ static void sis900_finish_xmit (struct n
 static int sis900_close(struct net_device *net_dev)
 {
 	long ioaddr = net_dev->base_addr;
-	struct sis900_private *sis_priv = net_dev->priv;
+	struct sis900_private *sis_priv = netdev_priv(net_dev);
 	struct sk_buff *skb;
 	int i;
 
@@ -1963,7 +1968,7 @@ static int sis900_close(struct net_devic
 static void sis900_get_drvinfo(struct net_device *net_dev,
 			       struct ethtool_drvinfo *info)
 {
- 	struct sis900_private *sis_priv = net_dev->priv;
+ 	struct sis900_private *sis_priv = netdev_priv(net_dev);
 
 	strcpy (info->driver, SIS900_MODULE_NAME);
 	strcpy (info->version, SIS900_DRV_VERSION);
@@ -1972,26 +1977,26 @@ static void sis900_get_drvinfo(struct ne
 
 static u32 sis900_get_msglevel(struct net_device *net_dev)
 {
-	struct sis900_private *sis_priv = net_dev->priv;
+	struct sis900_private *sis_priv = netdev_priv(net_dev);
 	return sis_priv->msg_enable;
 }
   
 static void sis900_set_msglevel(struct net_device *net_dev, u32 value)
 {
-	struct sis900_private *sis_priv = net_dev->priv;
+	struct sis900_private *sis_priv = netdev_priv(net_dev);
 	sis_priv->msg_enable = value;
 }
 
 static u32 sis900_get_link(struct net_device *net_dev)
 {
-	struct sis900_private *sis_priv = net_dev->priv;
+	struct sis900_private *sis_priv = netdev_priv(net_dev);
 	return mii_link_ok(&sis_priv->mii_info);
 }
 
 static int sis900_get_settings(struct net_device *net_dev,
 				struct ethtool_cmd *cmd)
 {
-	struct sis900_private *sis_priv = net_dev->priv;
+	struct sis900_private *sis_priv = netdev_priv(net_dev);
 	spin_lock_irq(&sis_priv->lock);
 	mii_ethtool_gset(&sis_priv->mii_info, cmd);
 	spin_unlock_irq(&sis_priv->lock);
@@ -2001,7 +2006,7 @@ static int sis900_get_settings(struct ne
 static int sis900_set_settings(struct net_device *net_dev,
 				struct ethtool_cmd *cmd)
 {
-	struct sis900_private *sis_priv = net_dev->priv;
+	struct sis900_private *sis_priv = netdev_priv(net_dev);
 	int rt;
 	spin_lock_irq(&sis_priv->lock);
 	rt = mii_ethtool_sset(&sis_priv->mii_info, cmd);
@@ -2011,7 +2016,7 @@ static int sis900_set_settings(struct ne
 
 static int sis900_nway_reset(struct net_device *net_dev)
 {
-	struct sis900_private *sis_priv = net_dev->priv;
+	struct sis900_private *sis_priv = netdev_priv(net_dev);
 	return mii_nway_restart(&sis_priv->mii_info);
 }
 
@@ -2036,7 +2041,7 @@ static struct ethtool_ops sis900_ethtool
 
 static int mii_ioctl(struct net_device *net_dev, struct ifreq *rq, int cmd)
 {
-	struct sis900_private *sis_priv = net_dev->priv;
+	struct sis900_private *sis_priv = netdev_priv(net_dev);
 	struct mii_ioctl_data *data = if_mii(rq);
 
 	switch(cmd) {
@@ -2068,7 +2073,7 @@ static int mii_ioctl(struct net_device *
 static struct net_device_stats *
 sis900_get_stats(struct net_device *net_dev)
 {
-	struct sis900_private *sis_priv = net_dev->priv;
+	struct sis900_private *sis_priv = netdev_priv(net_dev);
 
 	return &sis_priv->stats;
 }
@@ -2208,7 +2213,7 @@ static inline u16 sis900_mcast_bitnr(u8 
 static void set_rx_mode(struct net_device *net_dev)
 {
 	long ioaddr = net_dev->base_addr;
-	struct sis900_private * sis_priv = net_dev->priv;
+	struct sis900_private * sis_priv = netdev_priv(net_dev);
 	u16 mc_filter[16] = {0};	/* 256/128 bits multicast hash table */
 	int i, table_entries;
 	u32 rx_mode;
@@ -2283,7 +2288,7 @@ static void set_rx_mode(struct net_devic
 
 static void sis900_reset(struct net_device *net_dev)
 {
-	struct sis900_private * sis_priv = net_dev->priv;
+	struct sis900_private * sis_priv = netdev_priv(net_dev);
 	long ioaddr = net_dev->base_addr;
 	int i = 0;
 	u32 status = TxRCMP | RxRCMP;
@@ -2316,7 +2321,7 @@ static void sis900_reset(struct net_devi
 static void __devexit sis900_remove(struct pci_dev *pci_dev)
 {
 	struct net_device *net_dev = pci_get_drvdata(pci_dev);
-	struct sis900_private * sis_priv = net_dev->priv;
+	struct sis900_private * sis_priv = netdev_priv(net_dev);
 	struct mii_phy *phy = NULL;
 
 	while (sis_priv->first_mii) {
@@ -2360,7 +2365,7 @@ static int sis900_suspend(struct pci_dev
 static int sis900_resume(struct pci_dev *pci_dev)
 {
 	struct net_device *net_dev = pci_get_drvdata(pci_dev);
-	struct sis900_private *sis_priv = net_dev->priv;
+	struct sis900_private *sis_priv = netdev_priv(net_dev);
 	long ioaddr = net_dev->base_addr;
 
 	if(!netif_running(net_dev))
Index: br-2.6/net/bridge/br_if.c
===================================================================
--- br-2.6.orig/net/bridge/br_if.c
+++ br-2.6/net/bridge/br_if.c
@@ -348,8 +348,17 @@ int br_add_if(struct net_bridge *br, str
 	if (dev->hard_start_xmit == br_dev_xmit)
 		return -ELOOP;
 
-	if (dev->br_port != NULL)
+	if (dev->br_port != NULL) {
+		const struct net_bridge *b = dev->br_port;
+		if (b->dev && b->dev->hard_start_xmit == br_dev_xmit)
+			printk("br_add_if %s is already member of %s\n",
+			       dev->name, b->dev->name);
+		else
+			printk("br_add_if %s br_port=%p but not a bridge??\n",
+			       dev->name, b);
+	
 		return -EBUSY;
+	}
 
 	if (IS_ERR(p = new_nbp(br, dev, br_initial_port_cost(dev))))
 		return PTR_ERR(p);
