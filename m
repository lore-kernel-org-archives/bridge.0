Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CE55840382
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C21D940114
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vq8M55z8aydnSsAX2Cifi63WqCfi3ou09nDZiaWuytk=;
 b=TkSOcfBgf8dSzwUnHTAV1RQZzopeTbr50rirH+fu26OLVrKSYEXqEvhVd/q8wYfJXVo7a3rmvDGhjydiUdL8msii8WZAbP7l5326XNK61c2LXN85iJaOo0wMm6JF3uCZVQhBEhKfPGiBdz2jkU92O3w276YmxkgNI+kAL2Q5MAMhQHN+FiFi99Nhe4ZKLXxQbmS6tMF8DKQv/cspU0ge3EjB26aKllqLX6B7xn1L22eOB11NNimTsMLZjuXiksMjNKFpTmG8USzPrHH8vok/jgOnPnzm6sg4tDD7GoOZ6YUHPFrfB90kP4wKcS1SOX4DwMS5JAi8vw5xB8qTMuoJ2g==
Date: Fri, 19 May 2023 17:10:58 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <ZGeDcp2A7qrKZlLk@shredder>
References: <20230518113328.1952135-1-idosch@nvidia.com>
 <20230518113328.1952135-4-idosch@nvidia.com>
 <ZGdebBM8mxGOTovV@corigine.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGdebBM8mxGOTovV@corigine.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 3/5] flow_offload: Reject matching on
 layer 2 miss
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Simon Horman <simon.horman@corigine.com>, nbd@nbd.name
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, jiri@resnulli.us, taspelund@nvidia.com, leon@kernel.org, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, claudiu.manoil@nxp.com, UNGLinuxDriver@microchip.com, vladimir.oltean@nxp.com, xiyou.wangcong@gmail.com, edumazet@google.com, jhs@mojatatu.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, davem@davemloft.net

On Fri, May 19, 2023 at 01:33:00PM +0200, Simon Horman wrote:
> On Thu, May 18, 2023 at 02:33:26PM +0300, Ido Schimmel wrote:
> > Adjust drivers that support the 'FLOW_DISSECTOR_KEY_META' key to reject
> > filters that try to match on the newly added layer 2 miss option. Add an
> > extack message to clearly communicate the failure reason to user space.
> 
> Hi Ido,
> 
> FLOW_DISSECTOR_KEY_META is also used in the following.
> Perhaps they don't need updating. But perhaps it is worth mentioning why.

Good point.

> 
>  * drivers/net/ethernet/mediatek/mtk_ppe_offload.c

This driver does not seem to do anything with this key. TBH, I'm not
sure what is the purpose of this hunk:

if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_META)) {
	struct flow_match_meta match;

	flow_rule_match_meta(rule, &match);
} else {
	return -EOPNOTSUPP;
}

Felix, can you comment?
Original patch:
https://lore.kernel.org/netdev/20230518113328.1952135-4-idosch@nvidia.com/

>  * drivers/net/ethernet/netronome/nfp/flower/conntrack.c

My understanding is that this code is for netfilter offload (not tc)
which does not use the new bit. Adding a check would therefore be dead
code. I don't mind adding a check or mentioning in the commit message
why I didn't add one. Let me know what you prefer.

Thanks
