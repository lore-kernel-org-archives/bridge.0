In-Reply-To: <OFAE05463C.86F75967-ONC12577D5.0053E748-C12577D5.005430C9@LocalDomain>
References: <OFAE05463C.86F75967-ONC12577D5.0053E748-C12577D5.005430C9@LocalDomain>
Message-ID: <OFAC0EE6D8.11855E53-ONC12577D5.00568BE1-C12577D5.0056A717@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 8 Nov 2010 16:46:28 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Re: [Bridge] rtnl_lock() imbalance
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Cc: bridge@osdl.org

Joakim Tjernlund/Transmode wrote on 2010/11/08 16:19:35:
>
> Trying to hunt down an rtnl_lock bug, br_add_bridge looks funny, it
> takes the rtnl_lock but doesn't release it in case of error. Bug?

ehh, missed that last goto out;
So no imbalance, sorry for the noise

>
> int br_add_bridge(struct net *net, const char *name)
> {
>  struct net_device *dev;
>  int ret;
>
>  dev = new_bridge_dev(net, name);
>  if (!dev)
>   return -ENOMEM;
>
>  rtnl_lock();
>  if (strchr(dev->name, '%')) {
>   ret = dev_alloc_name(dev, dev->name);
>   if (ret < 0)
>    goto out_free;
>  }
>
>  SET_NETDEV_DEVTYPE(dev, &br_type);
>
>  ret = register_netdevice(dev);
>  if (ret)
>   goto out_free;
>
>  ret = br_sysfs_addbr(dev);
>  if (ret)
>   unregister_netdevice(dev);
>  out:
>  rtnl_unlock();
>  return ret;
>
> out_free:
>  free_netdev(dev);
>  goto out;
> }

