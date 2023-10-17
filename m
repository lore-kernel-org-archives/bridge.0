Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 066FC60F9B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A8A6260F94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55mdjusYF663YzVJ3TgxUcChKRycUmG/jhJsxCN9K3A=;
 b=MM8SwEUgxK88ADOUhPhkzS3Na/tiLgiE+VmTpmZzqiHR83U9A384EvpcDFYCRpcWpm46LDWC9RcQ/mUM59YBFTYFALSy2ok/8HUVqjl5HSUL27nMQwpVngwZYDnJ7euBSTMmzmEDqnHRge9W94bXh6CdkDtdjjjdIwTI0ZMTZPtiJ8cPIHk8Id7utDblgDcIR1Ks9IwJnaa3d0WVCZqLtrvuVKg+Bwp0AieOlXa1pz65FOhTuXQXFBBaaojKWq0qKGQMgnXbHvgDaBeGVK5tVo2u+DhFTlqF8jqZUSo4JnCbQuaP+8/HhfS47koCMV7vPs7JhNuew9aCbPWBQ7r+yw==
Date: Tue, 17 Oct 2023 14:03:47 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <ZS5qE3ou0iceLsp2@shredder>
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-10-idosch@nvidia.com>
 <141f0fc1-f024-d437-dae2-e074523c9bf8@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <141f0fc1-f024-d437-dae2-e074523c9bf8@blackwall.org>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 09/13] bridge: mcast: Add MDB get
	support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, edumazet@google.com, mlxsw@nvidia.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On Tue, Oct 17, 2023 at 12:24:44PM +0300, Nikolay Aleksandrov wrote:
> On 10/16/23 16:12, Ido Schimmel wrote:
> > Implement support for MDB get operation by looking up a matching MDB
> > entry, allocating the skb according to the entry's size and then filling
> > in the response. The operation is performed under the bridge multicast
> > lock to ensure that the entry does not change between the time the reply
> > size is determined and when the reply is filled in.
> > 
> > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> > ---
> >   net/bridge/br_device.c  |   1 +
> >   net/bridge/br_mdb.c     | 154 ++++++++++++++++++++++++++++++++++++++++
> >   net/bridge/br_private.h |   9 +++
> >   3 files changed, 164 insertions(+)
> > 
> [snip]
> > +int br_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid, u32 seq,
> > +	       struct netlink_ext_ack *extack)
> > +{
> > +	struct net_bridge *br = netdev_priv(dev);
> > +	struct net_bridge_mdb_entry *mp;
> > +	struct sk_buff *skb;
> > +	struct br_ip group;
> > +	int err;
> > +
> > +	err = br_mdb_get_parse(dev, tb, &group, extack);
> > +	if (err)
> > +		return err;
> > +
> > +	spin_lock_bh(&br->multicast_lock);
> 
> Since this is only reading, could we use rcu to avoid blocking mcast
> processing?

I tried to explain this choice in the commit message. Do you think it's
a non-issue?

> 
> > +
> > +	mp = br_mdb_ip_get(br, &group);
> > +	if (!mp) {
> > +		NL_SET_ERR_MSG_MOD(extack, "MDB entry not found");
> > +		err = -ENOENT;
> > +		goto unlock;
> > +	}
> > +
> > +	skb = br_mdb_get_reply_alloc(mp);
> > +	if (!skb) {
> > +		err = -ENOMEM;
> > +		goto unlock;
> > +	}
> > +
> > +	err = br_mdb_get_reply_fill(skb, mp, portid, seq);
> > +	if (err) {
> > +		NL_SET_ERR_MSG_MOD(extack, "Failed to fill MDB get reply");
> > +		goto free;
> > +	}
> > +
> > +	spin_unlock_bh(&br->multicast_lock);
> > +
> > +	return rtnl_unicast(skb, dev_net(dev), portid);
> > +
> > +free:
> > +	kfree_skb(skb);
> > +unlock:
> > +	spin_unlock_bh(&br->multicast_lock);
> > +	return err;
> > +}
> 
