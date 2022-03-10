Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QMLpysDwZRJXsNTpOkpDQ0qqZGLPweA1Fp1BJeeZZvI=;
 b=oHPETXL5JN1QV7aFH3+N2eY8CWrcsu+R0DVVt2ZByX/8mu3OLyaeO3eZsUX4BRYU5U
 s41dt5O7HaBXuXjQ1sVNfNGIgc9V9Tkv66jutuNQvQoqm0rRNNCcwcGV1byYwLOuS+XN
 JCLSMsVh/p9p6V1GN6XYnM2K+shhher1ibq8AHXVcpNay8a31yg34Bw6iAT330zV7DmX
 XhaYjQc6DlTo1GINt+ZYWiGh+XfU7uSC72DuqHn1OcycxO0+HxlzCUbjXuYbLKXHRZE+
 otqwrXiBgabxVQliFDJyZnOT0svdPKrkSH9saw2pY1MwOThlgTocR9fZY393LWgNPhkZ
 gXag==
Date: Thu, 10 Mar 2022 18:05:42 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220310160542.dihodbfxnexyjo2d@skbuf>
References: <20220310142320.611738-1-schultz.hans+netdev@gmail.com>
 <20220310142320.611738-4-schultz.hans+netdev@gmail.com>
 <20220310142836.m5onuelv4jej5gvs@skbuf> <865yolg8d7.fsf@gmail.com>
 <20220310150717.h7gaxamvzv47e5zc@skbuf> <86sfrpergs.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86sfrpergs.fsf@gmail.com>
Subject: Re: [Bridge] [PATCH net-next 3/3] net: dsa: mv88e6xxx: mac-auth/MAB
 implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, davem@davemloft.net

On Thu, Mar 10, 2022 at 04:51:15PM +0100, Hans Schultz wrote:
> On tor, mar 10, 2022 at 17:07, Vladimir Oltean <olteanv@gmail.com> wrote:
> > On Thu, Mar 10, 2022 at 04:00:52PM +0100, Hans Schultz wrote:
> >> >> +	brport = dsa_port_to_bridge_port(dp);
> >> >
> >> > Since this is threaded interrupt context, I suppose it could race with
> >> > dsa_port_bridge_leave(). So it is best to check whether "brport" is NULL
> >> > or not.
> >> >
> >> Would something like:
> >> if (dsa_is_unused_port(chip->ds, port))
> >>         return -ENODATA;
> >> 
> >> be appropriate and sufficient for that?
> >
> > static inline
> > struct net_device *dsa_port_to_bridge_port(const struct dsa_port *dp)
> > {
> > 	if (!dp->bridge)
> > 		return NULL;
> >
> > 	if (dp->lag)
> > 		return dp->lag->dev;
> > 	else if (dp->hsr_dev)
> > 		return dp->hsr_dev;
> >
> > 	return dp->slave;
> > }
> >
> > Notice the "dp->bridge" check. The assignments are in dsa_port_bridge_create()
> > and in dsa_port_bridge_destroy(). These functions assume rtnl_mutex protection.
> > The question was how do you serialize with that, and why do you assume
> > that dsa_port_to_bridge_port() returns non-NULL.
> >
> > So no, dsa_is_unused_port() would do absolutely nothing to help.
> 
> I was thinking in indirect terms (dangerous I know :-).

Sorry, I don't understand what you mean by "indirect terms". An "unused
port" is one with 'status = "disabled";' in the device tree. I would
expect that you don't need to handle FDB entries towards such a port!

You have a port receiving traffic with an unknown {MAC SA, VID}.
When the port is configured as locked by the bridge, this traffic will
generate ATU miss interrupts. These will be handled in an interrupt
thread that is scheduled to be handled some time in the future.
In between the moment when the packet is received and the moment when
the interrupt thread runs, a user could run "ip link set lan0 nomaster".
Then the interrupt thread would notify the bridge about these entries,
point during which a bridge port no longer exists => NULL pointer dereference.
By taking the rtnl_lock() and then checking whether dsa_port_to_bridge_port()
is NULL, you figure out whether the interrupt handler ran completely
before dsa_port_bridge_leave(), or completely after dsa_port_bridge_leave().

> 
> But wrt the nl lock, I wonder when other threads could pull the carpet
> away under this, and so I might have to wait till after the last call
> (mv88e6xxx_g1_atu_loadpurge) to free the nl lock?

That might make sense. It means: if the user runs "ip link set lan0 nomaster",
wait until I've notified the bridge and installed the entry to my own
ATU, so that they're in sync. Then, del_nbp() -> br_fdb_delete_by_port()
would come in, find that entry notified by us (I think!) and remove it.
If you call rtnl_unlock() too early, it might be possible that the ATU
entry remains lingering (unless I'm missing some subtle implicit
serialization based on mv88e6xxx_reg_lock() or similar).
