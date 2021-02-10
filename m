Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=LVyB6aVFegjh/BB39Z/3gEanq6lvT/mhc2gjTlbR304=;
 b=Ltsi8EvdBtQvRjoANMJcwrISpAFLvmJ2C8VxRcxriJbvaZ1H9uMjsHWcx4k1KVwIp0
 bEprsSTU/icuARDSY1rU06I6BedOoXhuhcIgJh6jxcQt9ggsbMK3SyzdhcxnWfOWN9gT
 E5PYWDallpyZg5bnCqT7zgXoUxWsagtNa206F8EEFkBmsPO6KcpFz/zIWRjDEVcWBl3U
 m0CKh8UMubbkzKQ1GFQajoSPGu94+hVxEvlymy59SIYbcYLFwtM3w4Yu7fAPflkJsmfG
 LbzrxtfSEmjjRz3SHakXq/z1GCjoceNkpUvScCPt/IKE/L2FAZmjSB2HX9PO1F40u57g
 evTQ==
Date: Thu, 11 Feb 2021 01:23:52 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210210232352.m7nqzvs2g4i74rx4@skbuf>
References: <20210209151936.97382-1-olteanv@gmail.com>
 <20210209151936.97382-5-olteanv@gmail.com>
 <20210209185100.GA266253@shredder.lan>
 <20210209202045.obayorcud4fg2qqb@skbuf>
 <20210209220124.GA271860@shredder.lan>
 <20210209225153.j7u6zwnpdgskvr2v@skbuf>
 <20210210105949.GB287766@shredder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210105949.GB287766@shredder.lan>
Subject: Re: [Bridge] [PATCH v2 net-next 04/11] net: bridge: offload initial
 and final port flags through switchdev
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Taras Chornyi <tchornyi@marvell.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com, "David S. Miller" <davem@davemloft.net>

On Wed, Feb 10, 2021 at 12:59:49PM +0200, Ido Schimmel wrote:
> > > The reverse, during unlinking, would be to refuse unlinking if the upper
> > > has uppers of its own. netdev_upper_dev_unlink() needs to learn to
> > > return an error and callers such as team/bond need to learn to handle
> > > it, but it seems patchable.
> >
> > Again, this was treated prior to my deletion in this series and not by
> > erroring out, I just really didn't think it through.
> >
> > So you're saying that if we impose that all switchdev drivers restrict
> > the house of cards to be constructed from the bottom up, and destructed
> > from the top down, then the notification of bridge port flags can stay
> > in the bridge layer?
>
> I actually don't think it's a good idea to have this in the bridge in
> any case. I understand that it makes sense for some devices where
> learning, flooding, etc are port attributes, but in other devices these
> can be {port,vlan} attributes and then you need to take care of them
> when a vlan is added / deleted and not only when a port is removed from
> the bridge. So for such devices this really won't save anything. I would
> thus leave it to the lower levels to decide.

Just for my understanding, how are per-{port,vlan} attributes such as
learning and flooding managed by the Linux bridge? How can I disable
flooding only in a certain VLAN?
