Return-Path: <jnixdorf-oss@avm.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2EA4840992
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 97710410E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1695385116; bh=MB5t/v3/1POR6o/v9qEGKwe4oDvbnw1fKTLa0smSnIA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UgkpCoMm9gpKNSJoMOa4nsPLy54Kenxk7W7YPcWMVxYStCJi3GNg2nIbT64NRTGTs
 kqpIJLNeQlVB1YFRVp3sBHEaWzbJ4DXffxixagYWCI7+OKjAl3zH6MEcLaInukRNIu
 cUghr0zYKg7+jF6xmY2tfsGW2riOpKp+BuuKuHDs=
Date: Fri, 22 Sep 2023 14:18:37 +0200
From: Johannes Nixdorf <jnixdorf-oss@avm.de>
Message-ID: <ZQ2GHS2r1W77iE50@u-jnixdorf.ads.avm.de>
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-2-39f0293807b8@avm.de>
 <1c12b8f2-b28b-f326-b24f-f1ea602832d7@blackwall.org>
 <ZQvvgiz4rE8u6vba@u-jnixdorf.ads.avm.de>
 <ab1130bb-38ce-1804-7981-6a4532d6ff7b@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab1130bb-38ce-1804-7981-6a4532d6ff7b@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next v4 2/6] net: bridge: Set
 strict_start_type for br_policy
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, linux-kernel@vger.kernel.org, Oleksij Rempel <linux@rempel-privat.de>, Vladimir Oltean <vladimir.oltean@nxp.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Thu, Sep 21, 2023 at 01:14:43PM +0300, Nikolay Aleksandrov wrote:
> On 9/21/23 10:23, Johannes Nixdorf wrote:
> > On Wed, Sep 20, 2023 at 01:46:02PM +0300, Nikolay Aleksandrov wrote:
> > > On 9/19/23 11:12, Johannes Nixdorf wrote:
> > > > Set any new attributes added to br_policy to be parsed strictly, to
> > > > prevent userspace from passing garbage.
> > > > 
> > > > Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> > > > ---
> > > >    net/bridge/br_netlink.c | 2 ++
> > > >    1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> > > > index 10f0d33d8ccf..505683ef9a26 100644
> > > > --- a/net/bridge/br_netlink.c
> > > > +++ b/net/bridge/br_netlink.c
> > > > @@ -1229,6 +1229,8 @@ static size_t br_port_get_slave_size(const struct net_device *brdev,
> > > >    }
> > > >    static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
> > > > +	[IFLA_BR_UNSPEC]	= { .strict_start_type =
> > > > +				    IFLA_BR_MCAST_QUERIER_STATE + 1 },
> > > >    	[IFLA_BR_FORWARD_DELAY]	= { .type = NLA_U32 },
> > > >    	[IFLA_BR_HELLO_TIME]	= { .type = NLA_U32 },
> > > >    	[IFLA_BR_MAX_AGE]	= { .type = NLA_U32 },
> > > > 
> > > 
> > > instead of IFLA_BR_MCAST_QUERIER_STATE + 1, why not move around the patch
> > > and just use the new attribute name?
> > > These are uapi, they won't change.
> > 
> > I wanted to avoid having a state between the two commits where the new
> > attributes are already added, but not yet strictly verified. Otherwise
> > they would present a slightly different UAPI at that one commit boundary
> > than after this commit.
> > 
> 
> That's not really a problem, the attribute is the same.
> 
> > This is also not the only place in the kernel where strict_start_type
> > is specified that way. See e.g. commit c00041cf1cb8 ("net: bridge: Set
> > strict_start_type at two policies"), even though that seems mostly be
> > done to turn on strict_start_type preemtively, not in the same series
> > that adds the new attribute.
> 
> Please, just use the new attribute to be more explicit where the strict
> parsing starts.

Ok. I've changed it locally for v5.
