Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=L+XK7Qk5Y2p36ge4CexpmpUnKhHpaYlCSYaz/IyqAE4=;
 b=tJ7O2fOIjUrVETc7EGgmzQBQ3UFDdaE98MZN1nJj+IqEJ/rF1UpBvXAA8ZgqcXtBrs
 KYvWXKXoA7GZaS7XjPu/leRt1RjiFsJj7pc9QbDX/ZZp0FNSjPihO4mmhmdhGyL3pWT4
 mIAZdYLcjLhdSW4bXZexgkff/bJPt4Co/X3gtNF9Tv/vRScIL16SGCrKOrWwdK7FxEWw
 Wiym9YDBI0Z5yExE16J1HtdCdtPa5VQH73b7gXDb3lCZScqwvMEpkKDH9JHHmowKtuyB
 RCmjmCBl4Fi59fg/2opwQfK+BzvcKcLdnijLKr6GbRGyUcmhORpODelGCgOucwJtjf0O
 crSA==
Date: Thu, 12 Aug 2021 00:45:06 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210811214506.4pf5t3wgabs5blqj@skbuf>
References: <20210811135247.1703496-1-dqfext@gmail.com>
 <YRRDcGWaWHgBkNhQ@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRRDcGWaWHgBkNhQ@shredder>
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

On Thu, Aug 12, 2021 at 12:38:56AM +0300, Ido Schimmel wrote:
> On Wed, Aug 11, 2021 at 09:52:46PM +0800, DENG Qingfang wrote:
> > Add BR_ISOLATED flag to BR_PORT_FLAGS_HW_OFFLOAD, to allow switchdev
> > drivers to offload port isolation.
> >
> > Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> > Signed-off-by: DENG Qingfang <dqfext@gmail.com>
> > ---
> >  net/bridge/br_switchdev.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> > index 6bf518d78f02..898257153883 100644
> > --- a/net/bridge/br_switchdev.c
> > +++ b/net/bridge/br_switchdev.c
> > @@ -71,7 +71,8 @@ bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
> >
> >  /* Flags that can be offloaded to hardware */
> >  #define BR_PORT_FLAGS_HW_OFFLOAD (BR_LEARNING | BR_FLOOD | \
> > -				  BR_MCAST_FLOOD | BR_BCAST_FLOOD)
> > +				  BR_MCAST_FLOOD | BR_BCAST_FLOOD | \
> > +				  BR_ISOLATED)
>
> Why add it now and not as part of a patchset that actually makes use of
> the flag in a driver that offloads port isolation?

The way the information got transmitted is a bit unfortunate.

Making BR_ISOLATED part of BR_PORT_FLAGS_HW_OFFLOAD is a matter of
correctness when switchdev offloads the data path. Since this feature
will not work correctly without driver intervention, it makes sense that
drivers should reject it currently, which is exactly what this patch
accomplishes - it makes the code path go through the
SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS driver handlers, which return
-EINVAL for everything they don't recognize.

(yes, we do still have a problem for drivers that don't catch
SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS at all, switchdev will return
-EOPNOTSUPP for those which is then ignored, but those are in the
minority)
