Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QKSZMx3tYUS3bL0IF6JnGJC/q4lllMMZybPbkde8fbY=;
 b=uKS8E3WYxYhuLOuJuTONzYsxliI8X8JiM9JMzHFbTpTHKW/S23UfEzKgb63Nfq0dMc
 5VTwTGgUUTsloLIAGMIupEqq4WhD3NnG023l4d9RtwNSxiJqyFzeCLqUFchwGo0U/gXo
 BRkalXCiFJELZ0eS13IYNrdFuuUZDRT7gDITAbFZFm9fX3ZNGjixYHD3xRFCo4xqXtq7
 CReob6vyHWlZhJ8+unXnpbmqKOSCXgW+m5Pfug9dmg9tWufViCzLaP2o9mRGL2OdhxSr
 EdtXav5bsBmGero1Xk2SKjI/n28hpL0M9YcduNbD5rWbzuHh8h23f11leebnUt35XMla
 KjMQ==
Date: Thu, 12 Aug 2021 13:17:03 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210812101703.lwp7y7dq6pnmnj3b@skbuf>
References: <20210811135247.1703496-1-dqfext@gmail.com>
 <YRRDcGWaWHgBkNhQ@shredder> <20210811214506.4pf5t3wgabs5blqj@skbuf>
 <YRRGsL60WeDGQOnv@shredder> <20210811215833.yst5tzgfvih2q4y2@skbuf>
 <20210812060410.1848228-1-dqfext@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812060410.1848228-1-dqfext@gmail.com>
Subject: Re: [Bridge] [PATCH net-next] net: bridge: switchdev: allow port
 isolation to be offloaded
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: DENG Qingfang <dqfext@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, "open list:ETHERNET BRIDGE" <netdev@vger.kernel.org>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Thu, Aug 12, 2021 at 02:04:10PM +0800, DENG Qingfang wrote:
> On Thu, Aug 12, 2021 at 12:58:33AM +0300, Vladimir Oltean wrote:
> > On Thu, Aug 12, 2021 at 12:52:48AM +0300, Ido Schimmel wrote:
> > >
> > > If the purpose is correctness, then this is not the only flag that was
> > > missed. BR_HAIRPIN_MODE is also relevant for the data path, for example.
> >
> > I never wanted to suggest that I'm giving a comprehensive answer, I just
> > answered Qingfang's punctual question here:
> > https://lore.kernel.org/netdev/CALW65jbotyW0MSOd-bd1TH_mkiBWhhRCQ29jgn+d12rXdj2pZA@mail.gmail.com/
> >
> > Tobias also pointed out the same issue about BR_MULTICAST_TO_UNICAST in
> > conjunction with tx_fwd_offload (although the same is probably true even
> > without it):
> > https://patchwork.kernel.org/project/netdevbpf/cover/20210426170411.1789186-1-tobias@waldekranz.com/
> >
> > > Anyway, the commit message needs to be reworded to reflect the true
> > > purpose of the patch.
> >
> > Agree, and potentially extended with all the bridge port flags which are
> > broken without switchdev driver intervention.
>
> So, what else flags should be added to BR_PORT_FLAGS_HW_OFFLOAD?

I can't think of others beside these 3, BR_ISOLATED, BR_HAIRPIN_MODE and BR_MULTICAST_TO_UNICAST.
