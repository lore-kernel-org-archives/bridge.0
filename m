Return-Path: <laszlth@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=T4Df+Q5HwXwiX2aivEySh7P8wcwmL5KA5/AYdIlFpOI=;
	b=YBI5nbqgDAB7tr6Qcl+38lcOV+fPQukrms68+Z5HaXLHZIJ7S+TZRDQf/ayCHxDqJi
	0+xUjcy0G1pjk9nRDLzAsUNH5XH5FbY59ShsJbgRvqqe4Pm5cBpHCqTdXXiaBIirhdZY
	VZ+PIzYfjK4/jLLpVMLNMs9bMIZdS0VUYG8rs9Z5TuB6DWt8IbZZ59+44PJ+6xba5PDY
	at6XAz+Zq+7RwYTOOfvS3py3C5wbDPxaUYbPA89gwQpIXoLq1h6Qci84fFF53IQagoGY
	5wSMULfjckYKPTEH+Gh+NWMaPFTjdU+kaS2rZZ3wY0rpIcOGeQfF6tCci20nQHc4f91U
	ZZ+w==
Date: Tue, 10 Apr 2018 19:22:43 +0200
From: Laszlo Toth <laszlth@gmail.com>
Message-ID: <20180410172243.GA4230@laszlth>
References: <20180408174934.GA3895@laszlth>
	<3db78abd-bc13-528f-9da3-cb9a0ce0f617@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3db78abd-bc13-528f-9da3-cb9a0ce0f617@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH] net: bridge: add missing NULL checks
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: Laszlo Toth <laszlth@gmail.com>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org

On Mon, Apr 09, 2018 at 01:25:41AM +0300, Nikolay Aleksandrov wrote:
> On 08/04/18 20:49, Laszlo Toth wrote:
> >br_port_get_rtnl() can return NULL
> >
> >Signed-off-by: Laszlo Toth <laszlth@gmail.com>
> >---
> >  net/bridge/br_netlink.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> 
> Nacked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> More below.
> 
> >diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> >index 015f465c..cbec11f 100644
> >--- a/net/bridge/br_netlink.c
> >+++ b/net/bridge/br_netlink.c
> >@@ -939,14 +939,17 @@ static int br_port_slave_changelink(struct net_device *brdev,
> >  				    struct nlattr *data[],
> >  				    struct netlink_ext_ack *extack)
> >  {
> >+	struct net_bridge_port *port = br_port_get_rtnl(dev);
> >  	struct net_bridge *br = netdev_priv(brdev);
> >  	int ret;
> >  	if (!data)
> >  		return 0;
> >+	if (!port)
> >+		return -EINVAL;
> 
> If we're here, it means the master device of dev is a bridge => dev is a bridge port,
> since we're running with RTNL that cannot change, so this check is unnecessary.
> 
> Have you actually hit a bug with this code ?
> 
> >  	spin_lock_bh(&br->lock);
> >-	ret = br_setport(br_port_get_rtnl(dev), data);
> >+	ret = br_setport(port, data);
> >  	spin_unlock_bh(&br->lock);
> >  	return ret;
> >@@ -956,7 +959,12 @@ static int br_port_fill_slave_info(struct sk_buff *skb,
> >  				   const struct net_device *brdev,
> >  				   const struct net_device *dev)
> >  {
> >-	return br_port_fill_attrs(skb, br_port_get_rtnl(dev));
> >+	struct net_bridge_port *port = br_port_get_rtnl(dev);
> >+
> >+	if (!port)
> >+		return -EINVAL;
> >+
> >+	return br_port_fill_attrs(skb, port);
> 
> Same rationale here, fill_slave_info is called via a master device's ops
> under RTNL, which means dev is a bridge port and that also cannot change.
> 
> If you have hit a bug with this code, can we see the trace ?
> The problem might be elsewhere.

There was a NULL dereference in br_port_fill_attrs(), but on a much
older release w/ a probably buggy and custom driver,
so there is no real problem to trace.
Anyway I thought I'd make a quick patch from it, but you're right,
it's pointless to validate twice. 

Please just ignore the patch.

Laszlo

> 
> Thanks,
>  Nik
> 
> >  }
> >  static size_t br_port_get_slave_size(const struct net_device *brdev,
> >
> 
