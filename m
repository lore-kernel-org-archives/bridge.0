Date: Tue, 21 Apr 2009 07:59:23 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20090421075923.39861576@nehalam>
In-Reply-To: <Pine.LNX.4.64.0904211307060.6460@zuben.voltaire.com>
References: <Pine.LNX.4.64.0904211307060.6460@zuben.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] NIC unicast macs table manipulation by bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Or Gerlitz <ogerlitz@voltaire.com>
Cc: bridge@lists.linux-foundation.org

On Tue, 21 Apr 2009 14:19:00 +0300 (IDT)
Or Gerlitz <ogerlitz@voltaire.com> wrote:

> Using a Linux bridge I see that none of the interfaces is set to promiscuous
> mode but on the other hand I don't see any dev_unicast_xxx calls in the
> bridge code... for the case of one of the interfaces being a physical NIC
> (e.g eth1), what's the magic that makes the NIC RX filtering be willing
> to accept frames whos dest mac isn't the NIC "primary" unicast mac?
> 
> Also is there a method to display dev->uc_list (e.g similar to /proc/net/dev_mcast)?
> 
> Or.
Look closer...

/* called with RTNL */
int br_add_if(struct net_bridge *br, struct net_device *dev)
{
	struct net_bridge_port *p;
	int err = 0;

	if (dev->flags & IFF_LOOPBACK || dev->type != ARPHRD_ETHER)
		return -EINVAL;

	if (dev->netdev_ops->ndo_start_xmit == br_dev_xmit)
		return -ELOOP;

	if (dev->br_port != NULL)
		return -EBUSY;

	p = new_nbp(br, dev);
	if (IS_ERR(p))
		return PTR_ERR(p);

	err = dev_set_promiscuity(dev, 1);

This turns on promiscuous mode (and nests).
