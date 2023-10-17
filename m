Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B458480E73
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 22CFE80D37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697534686; x=1698139486;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3tGOFg7H1TmqXBAfJRaJdeyQCiUlN2QreaijLoKRz5c=;
 b=UbumjgmioTOFDwAWAFy/jyTM6C90SeWfV5ksjMqodxQhHWGjMveW0FENQSDJWZMO8N
 i5505UKv5g+ByEvbBVjzKR1gNufeGNdJ5i+5tgag6fAalk26g982Dx5We8UJ6QIdjboe
 rpjcYHff+1k51eZZgS90r59gGLoFrmjugIWQp6+sxuzsGSChWhWkGlKkuqQk+FbxiP5n
 mtmeCy4ybiFR1T2FN43DMThAeEqRYLUaxPjMF14ibcNiV3z5o7FrzkxFwOYYR2iqRFZ7
 H7KudKST7yeb14tDl2AEH/owjXlxlojXPFHghLeIgqSfiuoGoYFBO0buCu91NaDAIKWV
 CYGg==
Message-ID: <141f0fc1-f024-d437-dae2-e074523c9bf8@blackwall.org>
Date: Tue, 17 Oct 2023 12:24:44 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-10-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016131259.3302298-10-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 10/16/23 16:12, Ido Schimmel wrote:
> Implement support for MDB get operation by looking up a matching MDB
> entry, allocating the skb according to the entry's size and then filling
> in the response. The operation is performed under the bridge multicast
> lock to ensure that the entry does not change between the time the reply
> size is determined and when the reply is filled in.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_device.c  |   1 +
>   net/bridge/br_mdb.c     | 154 ++++++++++++++++++++++++++++++++++++++++
>   net/bridge/br_private.h |   9 +++
>   3 files changed, 164 insertions(+)
> 
[snip]
> +int br_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid, u32 seq,
> +	       struct netlink_ext_ack *extack)
> +{
> +	struct net_bridge *br = netdev_priv(dev);
> +	struct net_bridge_mdb_entry *mp;
> +	struct sk_buff *skb;
> +	struct br_ip group;
> +	int err;
> +
> +	err = br_mdb_get_parse(dev, tb, &group, extack);
> +	if (err)
> +		return err;
> +
> +	spin_lock_bh(&br->multicast_lock);

Since this is only reading, could we use rcu to avoid blocking mcast 
processing?

> +
> +	mp = br_mdb_ip_get(br, &group);
> +	if (!mp) {
> +		NL_SET_ERR_MSG_MOD(extack, "MDB entry not found");
> +		err = -ENOENT;
> +		goto unlock;
> +	}
> +
> +	skb = br_mdb_get_reply_alloc(mp);
> +	if (!skb) {
> +		err = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	err = br_mdb_get_reply_fill(skb, mp, portid, seq);
> +	if (err) {
> +		NL_SET_ERR_MSG_MOD(extack, "Failed to fill MDB get reply");
> +		goto free;
> +	}
> +
> +	spin_unlock_bh(&br->multicast_lock);
> +
> +	return rtnl_unicast(skb, dev_net(dev), portid);
> +
> +free:
> +	kfree_skb(skb);
> +unlock:
> +	spin_unlock_bh(&br->multicast_lock);
> +	return err;
> +}

