MIME-Version: 1.0
In-Reply-To: <20090218.134852.118040610.davem@davemloft.net>
References: <ae4f76fd0902180241s28458450hd91ebf8da94ceb53@mail.gmail.com>
	<20090218.134852.118040610.davem@davemloft.net>
Date: Thu, 19 Feb 2009 10:45:40 +0100
Message-ID: <ae4f76fd0902190145r7ed5fadbwfca18c97dbfc9ed1@mail.gmail.com>
From: Henk Stegeman <henk.stegeman@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] net_device_ops support in bridging and fec_mpc52xx.c
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linuxppc-dev@ozlabs.org
Cc: netdev@vger.kernel.org, bridge@osdl.org

I must have made a mistake when I tested the previous patch, I
discovered later it still had errors:
- I had accidentally removed the base address in the fec_mpc52xx driver.
- The priv->phydev pointer was sometimes not initialized (NULL) but
still passed by the fec_mpc52xx driver, this pointer is then used
unchecked by the eth_tool_* functions (used by bridging to determine
port priority). As far as I see this depends on whether
mpc52xx_fec_open (or mpc52xx_fec_close) is called which in turn call
mpc52xx_init_phy to initialize priv->phydev. My work around checks the
priv->phydev pointer in the fec_mpc52xx driver and returns -ENODEV to
indicate there's no physical device. Big chance this is not the right
way to handle the problem, but it works, hopefully someone with some
more fundamental Linux network driver experience can pick this up or
give me some hints on this.

At least bridging now works on my board in combination with the
fec_mpc52xx driver.

ifconfig eth0 0.0.0.0 down
ifconfig eth1 0.0.0.0 down
brctl addbr br0
brctl setfd br0 0
brctl stp br0 off
ifconfig br0 192.168.1.30 down
ifconfig br0 up
brctl addif br0 eth0
ifconfig eth0 up
brctl addif br0 eth1
ifconfig eth1 up


diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
index cd8e98b..e228973 100644
--- a/drivers/net/fec_mpc52xx.c
+++ b/drivers/net/fec_mpc52xx.c
@@ -847,24 +847,40 @@ static void mpc52xx_fec_get_drvinfo(struct
net_device *dev,
 static int mpc52xx_fec_get_settings(struct net_device *dev, struct
ethtool_cmd *cmd)
 {
 	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
+
+	if (!priv->phydev)
+			return -ENODEV;
+
 	return phy_ethtool_gset(priv->phydev, cmd);
 }

 static int mpc52xx_fec_set_settings(struct net_device *dev, struct
ethtool_cmd *cmd)
 {
 	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
+
+	if (!priv->phydev)
+			return -ENODEV;
+
 	return phy_ethtool_sset(priv->phydev, cmd);
 }

 static u32 mpc52xx_fec_get_msglevel(struct net_device *dev)
 {
 	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
+	
+	if (!priv->phydev)
+		return 0;
+
 	return priv->msg_enable;
 }

 static void mpc52xx_fec_set_msglevel(struct net_device *dev, u32 level)
 {
 	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
+
+	if (!priv->phydev)
+			return;
+
 	priv->msg_enable = level;
 }

@@ -882,12 +898,31 @@ static int mpc52xx_fec_ioctl(struct net_device
*dev, struct ifreq *rq, int cmd)
 {
 	struct mpc52xx_fec_priv *priv = netdev_priv(dev);

+	if (!priv->phydev)
+			return -ENODEV;
+
 	return mpc52xx_fec_phy_mii_ioctl(priv, if_mii(rq), cmd);
 }

 /* ======================================================================== */
 /* OF Driver                                                                */
 /* ======================================================================== */
+static const struct net_device_ops mpc52xx_fec_netdev_ops = {
+       .ndo_open               = mpc52xx_fec_open,
+       .ndo_stop               = mpc52xx_fec_close,
+       .ndo_start_xmit         = mpc52xx_fec_hard_start_xmit,
+       .ndo_tx_timeout         = mpc52xx_fec_tx_timeout,
+       .ndo_get_stats          = mpc52xx_fec_get_stats,
+       .ndo_set_multicast_list = mpc52xx_fec_set_multicast_list,
+       .ndo_validate_addr      = eth_validate_addr,
+       .ndo_set_mac_address    = mpc52xx_fec_set_mac_address,
+       .ndo_do_ioctl           = mpc52xx_fec_ioctl,
+
+#ifdef CONFIG_NET_POLL_CONTROLLER
+       .ndo_poll_controller     = mpc52xx_fec_poll_controller,
+#endif
+};
+

 static int __devinit
 mpc52xx_fec_probe(struct of_device *op, const struct of_device_id *match)
@@ -929,20 +964,10 @@ mpc52xx_fec_probe(struct of_device *op, const
struct of_device_id *match)
 		return -EBUSY;

 	/* Init ether ndev with what we have */
-	ndev->open		= mpc52xx_fec_open;
-	ndev->stop		= mpc52xx_fec_close;
-	ndev->hard_start_xmit	= mpc52xx_fec_hard_start_xmit;
-	ndev->do_ioctl		= mpc52xx_fec_ioctl;
 	ndev->ethtool_ops	= &mpc52xx_fec_ethtool_ops;
-	ndev->get_stats		= mpc52xx_fec_get_stats;
-	ndev->set_mac_address	= mpc52xx_fec_set_mac_address;
-	ndev->set_multicast_list = mpc52xx_fec_set_multicast_list;
-	ndev->tx_timeout	= mpc52xx_fec_tx_timeout;
 	ndev->watchdog_timeo	= FEC_WATCHDOG_TIMEOUT;
 	ndev->base_addr		= mem.start;
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	ndev->poll_controller = mpc52xx_fec_poll_controller;
-#endif
+	ndev->netdev_ops = &mpc52xx_fec_netdev_ops;

 	priv->t_irq = priv->r_irq = ndev->irq = NO_IRQ; /* IRQ are free for now */



On Wed, Feb 18, 2009 at 10:48 PM, David Miller <davem@davemloft.net> wrote:
> From: Henk Stegeman <henk.stegeman@gmail.com>
> Date: Wed, 18 Feb 2009 11:41:14 +0100
>
> Please CC: netdev, now added, on all networking reports and patches.
>
> Thank you.
>
>> I discovered the hard way that because linux bridging uses
>> net_device_ops, bridging only works with network drivers that publish
>> their device operations trough net_device_ops.
>>
>> In my case running:
>>
>> brctl addif br0 eth0 (where eth0 fec_mpc52xx.c did not yet support
>> net_device_ops) gave me a:
>>
>> Unable to handle kernel paging request...
>>
>> After changing fec_mpc52xx.c to support net_device_ops the problem was fixed.
>>
>> If possible some kind of detection in the bridging software is i think
>> mostly appreciated for early detection of this problem, as it is
>> pretty hard to relate the error message to a not updated driver.
>>
>> cheers,
>>
>> Henk
>>
>> diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
>> index cd8e98b..a2841eb 100644
>> --- a/drivers/net/fec_mpc52xx.c
>> +++ b/drivers/net/fec_mpc52xx.c
>> @@ -888,6 +888,22 @@ static int mpc52xx_fec_ioctl(struct net_device
>> *dev, struct ifreq *rq, int cmd)
>>  /* ======================================================================== */
>>  /* OF Driver                                                                */
>>  /* ======================================================================== */
>> +static const struct net_device_ops mpc52xx_fec_netdev_ops = {
>> +       .ndo_open               = mpc52xx_fec_open,
>> +       .ndo_stop               = mpc52xx_fec_close,
>> +       .ndo_start_xmit         = mpc52xx_fec_hard_start_xmit,
>> +       .ndo_tx_timeout         = mpc52xx_fec_tx_timeout,
>> +       .ndo_get_stats          = mpc52xx_fec_get_stats,
>> +       .ndo_set_multicast_list = mpc52xx_fec_set_multicast_list,
>> +       .ndo_validate_addr      = eth_validate_addr,
>> +       .ndo_set_mac_address    = mpc52xx_fec_set_mac_address,
>> +       .ndo_do_ioctl           = mpc52xx_fec_ioctl,
>> +
>> +#ifdef CONFIG_NET_POLL_CONTROLLER
>> +       .ndo_poll_controller     = mpc52xx_fec_poll_controller,
>> +#endif
>> +};
>> +
>>
>>  static int __devinit
>>  mpc52xx_fec_probe(struct of_device *op, const struct of_device_id *match)
>> @@ -929,20 +945,7 @@ mpc52xx_fec_probe(struct of_device *op, const
>> struct of_device_id *match)
>>               return -EBUSY;
>>
>>       /* Init ether ndev with what we have */
>> -     ndev->open              = mpc52xx_fec_open;
>> -     ndev->stop              = mpc52xx_fec_close;
>> -     ndev->hard_start_xmit   = mpc52xx_fec_hard_start_xmit;
>> -     ndev->do_ioctl          = mpc52xx_fec_ioctl;
>> -     ndev->ethtool_ops       = &mpc52xx_fec_ethtool_ops;
>> -     ndev->get_stats         = mpc52xx_fec_get_stats;
>> -     ndev->set_mac_address   = mpc52xx_fec_set_mac_address;
>> -     ndev->set_multicast_list = mpc52xx_fec_set_multicast_list;
>> -     ndev->tx_timeout        = mpc52xx_fec_tx_timeout;
>> -     ndev->watchdog_timeo    = FEC_WATCHDOG_TIMEOUT;
>> -     ndev->base_addr         = mem.start;
>> -#ifdef CONFIG_NET_POLL_CONTROLLER
>> -     ndev->poll_controller = mpc52xx_fec_poll_controller;
>> -#endif
>> +     ndev->netdev_ops = &mpc52xx_fec_netdev_ops;
>>
>>       priv->t_irq = priv->r_irq = ndev->irq = NO_IRQ; /* IRQ are free for now */
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
