Return-Path: <jnixdorf-oss@avm.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3C08B41935
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5B90541932
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1695281357; bh=JrvLZ3k9m+n64XkQmbpSU7bQlFJHydepu1VAgRC4fjw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NMB2AQTpZscNAsuFSRfZScH0ybRFIyIeR53TSy4h86jjz5qDM+IzU+FIw2oL/NPcl
 zhnc8wxUO+ZdzqqQLZ5HFVD3mlxjE1z4ClyazOPfmM3gJPEuiEQScC5o5xl2i2QhPt
 qFtFi76Fs4cMWLI6YWP2dAXrJ9tB8LL8+dqewJFg=
Date: Thu, 21 Sep 2023 09:29:17 +0200
From: Johannes Nixdorf <jnixdorf-oss@avm.de>
Message-ID: <ZQvwzZrqC7pjaeS1@u-jnixdorf.ads.avm.de>
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-4-39f0293807b8@avm.de>
 <f5aca33e-693f-9d8d-c45a-41ada00a9f03@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5aca33e-693f-9d8d-c45a-41ada00a9f03@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next v4 4/6] net: bridge: Add netlink knobs
 for number / max learned FDB entries
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

On Wed, Sep 20, 2023 at 01:50:32PM +0300, Nikolay Aleksandrov wrote:
> On 9/19/23 11:12, Johannes Nixdorf wrote:
> > [...]
> > diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> > index 505683ef9a26..f5d49a05e61b 100644
> > --- a/net/bridge/br_netlink.c
> > +++ b/net/bridge/br_netlink.c
> > @@ -1267,6 +1267,8 @@ static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
> >   	[IFLA_BR_VLAN_STATS_PER_PORT] = { .type = NLA_U8 },
> >   	[IFLA_BR_MULTI_BOOLOPT] =
> >   		NLA_POLICY_EXACT_LEN(sizeof(struct br_boolopt_multi)),
> > +	[IFLA_BR_FDB_N_LEARNED] = { .type = NLA_U32 },
> 
> hmm? I thought this one was RO.

You are right. I set this to NLA_REJECT locally for v5 now, analogously
to how IFLA_BRPORT_MCAST_N_GROUPS is specified.

> > [...]
