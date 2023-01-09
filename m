Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AE93F60C33
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D9F8A60784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=crINwX8GG7oE7iuw+Z+Wz82V7aegfStJZU7gXgsc5Qc=;
 b=P/IIjdLg2bouOSQCv2Z03ysTzM8CtExWpKYVGm7RPVyMZ5cRimFFXovhV98OwKeeVh
 0vaMYwLL5eqTRXLPGb5jcal0YgpDAOPnzOarn3RsCTNO5G71T+I0vcyt+YoXMOml73wH
 L16uIdbW/mUIj2anFkl6Ww8a0UyZS0sRDliaK50B0PKFQGXP+H8rO612B5zsbLM5R5vS
 6OMJflVKJlUYYDqGVpOl5p/UVVqsqxV96XHkJM1QY8pQSU5XbHXPt9ahGS/1zZ5sSMHm
 0ptuSn6+n5+jCFD893QTFZsfZdBiYbY1HCYkDJhx3U600CgdfBJDnCa/untfcTWby19Z
 ucqA==
Date: Mon, 9 Jan 2023 14:29:08 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20230109122908.dn2xlzlbcvfxgeii@skbuf>
References: <20220316150857.2442916-1-tobias@waldekranz.com>
 <20220316150857.2442916-2-tobias@waldekranz.com>
 <Y7vK4T18pOZ9KAKE@shredder> <20230109100236.euq7iaaorqxrun7u@skbuf>
 <Y7v98s8lC1WUvsSO@shredder> <20230109115653.6yjijaj63n2v35lw@skbuf>
 <Y7wGct6VWmbuWs5F@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7wGct6VWmbuWs5F@shredder>
Subject: Re: [Bridge] [PATCH v5 net-next 01/15] net: bridge: mst: Multiple
 Spanning Tree (MST) mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org, Tobias Waldekranz <tobias@waldekranz.com>

On Mon, Jan 09, 2023 at 02:20:02PM +0200, Ido Schimmel wrote:
> On Mon, Jan 09, 2023 at 01:56:53PM +0200, Vladimir Oltean wrote:
> > On Mon, Jan 09, 2023 at 01:43:46PM +0200, Ido Schimmel wrote:
> > > OK, thanks for confirming. Will send a patch later this week if Tobias
> > > won't take care of it by then. First patch will probably be [1] to make
> > > sure we dump the correct MST state to user space. It will also make it
> > > easier to show the problem and validate the fix.
> > > 
> > > [1]
> > > diff --git a/net/bridge/br.c b/net/bridge/br.c
> > > index 4f5098d33a46..f02a1ad589de 100644
> > > --- a/net/bridge/br.c
> > > +++ b/net/bridge/br.c
> > > @@ -286,7 +286,7 @@ int br_boolopt_get(const struct net_bridge *br, enum br_boolopt_id opt)
> > >  	case BR_BOOLOPT_MCAST_VLAN_SNOOPING:
> > >  		return br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED);
> > >  	case BR_BOOLOPT_MST_ENABLE:
> > > -		return br_opt_get(br, BROPT_MST_ENABLED);
> > > +		return br_mst_is_enabled(br);
> > 
> > Well, this did report the correct MST state despite the incorrect static
> > branch state, no? The users of br_mst_is_enabled(br) are broken, not
> > those of br_opt_get(br, BROPT_MST_ENABLED).
> 
> I should have said "actual"/"effective" instead of "correct". IMO, it's
> better to use the same conditional in the both the data and control
> paths to eliminate discrepancies. Without the patch, a user will see
> that MST is supposedly enabled when it is actually disabled in the data
> path.

The discussion is about to get philosophical, but I don't know if it's
necessary to make a bug more widespread before fixing it..
The br_mst_used is an optimization to avoid calling br_opt_get() when
surely MST is not enabled. There should be no discrepancy between using
and not using it, if the static branch works correctly (not the case here).
I would also expect that consolidation to be part of net-next though.

> > Anyway, I see there's a br_mst_is_enabled() and also a br_mst_enabled()?!
> > One is used in the fast path and the other in the slow path. They should
> > probably be merged, I guess. They both exist probably because somebody
> > thought that the "if (!netif_is_bridge_master(dev))" test is redundant
> > in the fast path.
> 
> The single user of br_mst_enabled() (DSA) is not affected by the bug
> (only the SW data path is), so I suggest making this consolidation in
> net-next after the bug is fixed. OK?

Yes, net-next, sure.
