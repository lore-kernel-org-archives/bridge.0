Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 906AE40A58
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0B2FE416E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697547188; x=1698151988;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XLx6w5DXGZb9mtKdzl0gzgCnw3UsE+8g0Kr5B/l31qs=;
 b=RJe7rDlBpIsF0MboZ+fCgaX5DGaZER4DEW49zWkwrFHMF8XQK9I6UOcqn7Kx8ohCAH
 yq+FTcxTuQbVsJ0UZx/BuY743xwVggVAuwyDxoGFUER9tmro3rtlEZfVIkgTRx01LRs5
 d6vKu2Tajsn4Zkho4FtigOkJQI4apGS2QD/APIV5+s4yTn7qfXP57h/jsXW0kLIZxhkd
 FeMFE2PyIIbS8cJ7fllmJieqsvyx8Oe/IBya3PowZJmfyPH2VNrXiixBbSr1xBqIeG7d
 zzseeNKVhhuaNWpbdbhO49zqfgv1GVwMpyxsk8OCCsELJC9k5NaEue8GGzXL6M4+N6lA
 /m7A==
Message-ID: <bb71b086-b60e-c130-8484-5a71d0a07f19@blackwall.org>
Date: Tue, 17 Oct 2023 15:53:05 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-10-idosch@nvidia.com>
 <141f0fc1-f024-d437-dae2-e074523c9bf8@blackwall.org>
 <ZS5qE3ou0iceLsp2@shredder>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZS5qE3ou0iceLsp2@shredder>
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
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, edumazet@google.com, mlxsw@nvidia.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 10/17/23 14:03, Ido Schimmel wrote:
> On Tue, Oct 17, 2023 at 12:24:44PM +0300, Nikolay Aleksandrov wrote:
>> On 10/16/23 16:12, Ido Schimmel wrote:
>>> Implement support for MDB get operation by looking up a matching MDB
>>> entry, allocating the skb according to the entry's size and then filling
>>> in the response. The operation is performed under the bridge multicast
>>> lock to ensure that the entry does not change between the time the reply
>>> size is determined and when the reply is filled in.
>>>
>>> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
>>> ---
>>>    net/bridge/br_device.c  |   1 +
>>>    net/bridge/br_mdb.c     | 154 ++++++++++++++++++++++++++++++++++++++++
>>>    net/bridge/br_private.h |   9 +++
>>>    3 files changed, 164 insertions(+)
>>>
>> [snip]
>>> +int br_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid, u32 seq,
>>> +	       struct netlink_ext_ack *extack)
>>> +{
>>> +	struct net_bridge *br = netdev_priv(dev);
>>> +	struct net_bridge_mdb_entry *mp;
>>> +	struct sk_buff *skb;
>>> +	struct br_ip group;
>>> +	int err;
>>> +
>>> +	err = br_mdb_get_parse(dev, tb, &group, extack);
>>> +	if (err)
>>> +		return err;
>>> +
>>> +	spin_lock_bh(&br->multicast_lock);
>>
>> Since this is only reading, could we use rcu to avoid blocking mcast
>> processing?
> 
> I tried to explain this choice in the commit message. Do you think it's
> a non-issue?
> 

Unless you really need a stable snapshot, I think it's worth
not blocking igmp processing for a read. It's not critical,
if you do need a stable snapshot then it's ok.

>>
>>> +
>>> +	mp = br_mdb_ip_get(br, &group);
>>> +	if (!mp) {
>>> +		NL_SET_ERR_MSG_MOD(extack, "MDB entry not found");
>>> +		err = -ENOENT;
>>> +		goto unlock;
>>> +	}
>>> +
>>> +	skb = br_mdb_get_reply_alloc(mp);
>>> +	if (!skb) {
>>> +		err = -ENOMEM;
>>> +		goto unlock;
>>> +	}
>>> +
>>> +	err = br_mdb_get_reply_fill(skb, mp, portid, seq);
>>> +	if (err) {
>>> +		NL_SET_ERR_MSG_MOD(extack, "Failed to fill MDB get reply");
>>> +		goto free;
>>> +	}
>>> +
>>> +	spin_unlock_bh(&br->multicast_lock);
>>> +
>>> +	return rtnl_unicast(skb, dev_net(dev), portid);
>>> +
>>> +free:
>>> +	kfree_skb(skb);
>>> +unlock:
>>> +	spin_unlock_bh(&br->multicast_lock);
>>> +	return err;
>>> +}
>>

