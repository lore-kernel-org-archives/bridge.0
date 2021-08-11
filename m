Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=oqaYnk/BlOEVZwhZgFl0HlIbiKCRb2HikYJeEVtrpsU=;
 b=G+Jh5JTKtzuPm2ZSNCT48dtg4MkLnPfZn61RKWMryCZuvjJW59wBUJ7GoGVCLpoKju
 drUH7LhE231uHGCesRgD2PLlS1gMSdfavrCZhX5eUKhHQWxu3Kxxfz90aPnv3lz9dp9r
 0tCCpblpht9JAhlaYMfSmiHhrMobuaRPeixBB2PfBrRvxmMeSVa6Qgm/kGnfTGmh9bWF
 M+fq0UxCkAvdn9Uqm0+/NadxcUFbbrHOutGOze2Zd988K+4FXHfQ9omxX0Po2d2AzAr3
 LYWCtAocFksvCF9LYUSQmBjqGOLHk3Ylv1JAKDVWeUSOqFFbGHgUDrjiHOmHEVpytaBh
 U8AQ==
Date: Thu, 12 Aug 2021 00:58:33 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210811215833.yst5tzgfvih2q4y2@skbuf>
References: <20210811135247.1703496-1-dqfext@gmail.com>
 <YRRDcGWaWHgBkNhQ@shredder> <20210811214506.4pf5t3wgabs5blqj@skbuf>
 <YRRGsL60WeDGQOnv@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRRGsL60WeDGQOnv@shredder>
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
To: Ido Schimmel <idosch@idosch.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, "open list:ETHERNET BRIDGE" <netdev@vger.kernel.org>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, DENG Qingfang <dqfext@gmail.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Thu, Aug 12, 2021 at 12:52:48AM +0300, Ido Schimmel wrote:
> On Thu, Aug 12, 2021 at 12:45:06AM +0300, Vladimir Oltean wrote:
> > On Thu, Aug 12, 2021 at 12:38:56AM +0300, Ido Schimmel wrote:
> > > On Wed, Aug 11, 2021 at 09:52:46PM +0800, DENG Qingfang wrote:
> > > > Add BR_ISOLATED flag to BR_PORT_FLAGS_HW_OFFLOAD, to allow switchdev
> > > > drivers to offload port isolation.
> > > >
> > > > Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> > > > Signed-off-by: DENG Qingfang <dqfext@gmail.com>
> > > > ---
> > > >  net/bridge/br_switchdev.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> > > > index 6bf518d78f02..898257153883 100644
> > > > --- a/net/bridge/br_switchdev.c
> > > > +++ b/net/bridge/br_switchdev.c
> > > > @@ -71,7 +71,8 @@ bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
> > > >
> > > >  /* Flags that can be offloaded to hardware */
> > > >  #define BR_PORT_FLAGS_HW_OFFLOAD (BR_LEARNING | BR_FLOOD | \
> > > > -				  BR_MCAST_FLOOD | BR_BCAST_FLOOD)
> > > > +				  BR_MCAST_FLOOD | BR_BCAST_FLOOD | \
> > > > +				  BR_ISOLATED)
> > >
> > > Why add it now and not as part of a patchset that actually makes use of
> > > the flag in a driver that offloads port isolation?
> > 
> > The way the information got transmitted is a bit unfortunate.
> > 
> > Making BR_ISOLATED part of BR_PORT_FLAGS_HW_OFFLOAD is a matter of
> > correctness when switchdev offloads the data path. Since this feature
> > will not work correctly without driver intervention, it makes sense that
> > drivers should reject it currently, which is exactly what this patch
> > accomplishes - it makes the code path go through the
> > SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS driver handlers, which return
> > -EINVAL for everything they don't recognize.
> 
> If the purpose is correctness, then this is not the only flag that was
> missed. BR_HAIRPIN_MODE is also relevant for the data path, for example.

I never wanted to suggest that I'm giving a comprehensive answer, I just
answered Qingfang's punctual question here:
https://lore.kernel.org/netdev/CALW65jbotyW0MSOd-bd1TH_mkiBWhhRCQ29jgn+d12rXdj2pZA@mail.gmail.com/

Tobias also pointed out the same issue about BR_MULTICAST_TO_UNICAST in
conjunction with tx_fwd_offload (although the same is probably true even
without it):
https://patchwork.kernel.org/project/netdevbpf/cover/20210426170411.1789186-1-tobias@waldekranz.com/

> Anyway, the commit message needs to be reworded to reflect the true
> purpose of the patch.

Agree, and potentially extended with all the bridge port flags which are
broken without switchdev driver intervention.
