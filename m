Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E3F9681516
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 323E781501
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvCXA51bai7RTgTDCfRmQTygw96aM1yJ/ZWbjaaoWYQ=;
 b=rQS3ZJzJPw+ZpEtUETMDaCcL90CJpGCbqVjGtGBg9Vu9Q+PgFwkk/ypk6pRAwqQ2TC7CscF2iAspYNEYiyuvJXYSaumQrohXydPW0kbBpaaI5fAHS+BN+auaue7jJVyTGRUM+QdIUFsLt09f2RsPxUzY7z710KOExVRx5ZpyqxgFm+jJFJ15v7PWPeD6G1ZH/5wEpPzN84v+vLLXLuyiTix69fSotcJuLVYEqpN6kD1ExOoBFTVkwKh2xRhJTY+KOesdviMH7PFVr92mecpyyGxMBqWN+/mGQoJGIr6clQEVvJicMy1J36nNF95OLmAynx9I1XsqsVV7WIyhq+Zzow==
Date: Sun, 29 Jan 2023 16:58:42 +0200
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y9aJom7VhuqY+1+X@shredder>
References: <cover.1674752051.git.petrm@nvidia.com>
 <1bb4bfeaeb14e4b484c6d71adef0b21686468153.1674752051.git.petrm@nvidia.com>
 <e46f0af5-ef19-5260-5524-e53b4e4438f1@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e46f0af5-ef19-5260-5524-e53b4e4438f1@blackwall.org>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 08/16] net: bridge: Add netlink knobs
 for number / maximum MDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

Thanks for the review, Nik!

On Sun, Jan 29, 2023 at 12:07:31PM +0200, Nikolay Aleksandrov wrote:
> On 26/01/2023 19:01, Petr Machata wrote:
> > +static int
> > +br_multicast_pmctx_ngroups_set_max(struct net_bridge_mcast_port *pmctx,
> > +				   u32 max, struct netlink_ext_ack *extack)
> > +{
> > +	if (max && max < pmctx->mdb_n_entries) {
> > +		NL_SET_ERR_MSG_FMT_MOD(extack, "Can't set mcast_max_groups=%u, which is below mcast_n_groups=%u",
> > +				       max, pmctx->mdb_n_entries);
> 
> Why not? All new entries will be rejected anyway, at most some will expire and make room.

Looking at the code of the global limit ('mcast_hash_max') and also
testing it, I see that the above is not enforced there either so doing
what you suggest will at least make the port and port-vlan limits
consistent with the global limit in this regard.

> 
> > +		return -EINVAL;
> > +	}
> > +
> > +	pmctx->mdb_max_entries = max;
> > +	return 0;
> > +}
