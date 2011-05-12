Date: Thu, 12 May 2011 09:57:49 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20110512095749.016610a1@nehalam>
In-Reply-To: <1305217747.5214.17.camel@bwh-desktop>
References: <20110507114803.0D80A13A6B@rere.qmqm.pl>
	<20110512160640.2A0B713A6B@rere.qmqm.pl>
	<1305217747.5214.17.camel@bwh-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH v2] net: fold dev_disable_lro() into
 netdev_fix_features()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ben Hutchings <bhutchings@solarflare.com>
Cc: "Pekka Savola (ipv6)" <pekkas@netcore.fi>, Eric Dumazet <eric.dumazet@gmail.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, James Morris <jmorris@namei.org>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, "David S. Miller" <davem@davemloft.net>, Tom Herbert <therbert@google.com>

On Thu, 12 May 2011 17:29:07 +0100
Ben Hutchings <bhutchings@solarflare.com> wrote:

> >  	dev->priv_flags |= IFF_BRIDGE_PORT;
> >  
> > -	dev_disable_lro(dev);
> > -
> >  	list_add_rcu(&p->list, &br->port_list);
> >  
> > -	netdev_update_features(br->dev);
> > +	netdev_change_features(dev);
> >  
> >  	spin_lock_bh(&br->lock);
> >  	changed_addr = br_stp_recalculate_bridge_id(br);  
> 
> Why netdev_change_features() here?  I thought that was primarily for use
> when vlan_features may have been changed.

Setting IFF_BRIDGE_PORT in priv_flags causes change_features
to disable LRO.

-- 
