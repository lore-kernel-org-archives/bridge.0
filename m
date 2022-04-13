Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=b0Q7eIUJvll8Zc2Wicyz8swgbwUiW9Yb1yMGEPB9veY=;
 b=iVn8i3xa3MWY4ELY/Y28Hb05tecqhBRCBGWJu520Pj6jhRfitI1VWQDEr/x1hVnQoo
 r82cbejX0ajDHqpPKanbUIRK9Y99VmAZ/c604Fn2slcSotYfqkHYi7DrTpCCDZOpO4Cf
 ovVRF2EC45La2qlHJz3b44nNP70nL+fARxZEuMmr2BBMjCBa4pKuGdnOWzd77Zj6FUXf
 MlemZs+QugZFfhqxnl7vp6nLdl5zClsiMomEFZ+LQWJ8g/fUbiI1Y6CBaJPltBYv5ebD
 Ebe3d8jGsHGfpQbWi/zugGzz44Vp6IcwgQXiIHewvvPIbXqNHdDJP/0GCvojTSBPrfiZ
 Q0ZQ==
From: Joachim Wiberg <troglobit@gmail.com>
In-Reply-To: <37bb2846-6371-1e49-9a7e-7c27a7a8b9c4@blackwall.org>
References: <20220411133837.318876-1-troglobit@gmail.com>
 <20220411133837.318876-5-troglobit@gmail.com>
 <37bb2846-6371-1e49-9a7e-7c27a7a8b9c4@blackwall.org>
Date: Wed, 13 Apr 2022 12:04:09 +0200
Message-ID: <87h76x9u5i.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH RFC net-next 04/13] net: bridge: netlink
	support for controlling BUM flooding to bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Vladimir Oltean <vladimir.oltean@nxp.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On Tue, Apr 12, 2022 at 21:24, Nikolay Aleksandrov <razor@blackwall.org> wrote:
> On 11/04/2022 16:38, Joachim Wiberg wrote:
>> The messy part is in br_setport(), which re-indents a large block of
>> code for the port settings.  To reduce code duplication a few new
>> variables have been added; new_flags and dev.  The latter is used for
>> the recently renamed br_switchdev_set_dev_flag(), which can now be used
>> by underlying switching fabric drivers as another source of information
>> when controlling flooding of unknown BUM traffic to the CPU port.
> Absolutely not. This is just wrong on a few levels and way too hacky.
> Please separate the bridge handling altogether and make it clean.
> No need to integrate it with the port handling,

OK, I'll have a go at it.

> also I think you've missed a few things about bool options, more
> below...
>
> For boolopts examples you can check BR_BOOLOPT_NO_LL_LEARN,
> BR_BOOLOPT_MCAST_VLAN_SNOOPING and BR_BOOLOPT_MST_ENABLE.

Ah yes, will read up on those, thanks!

>> +		if (nla_put_u8(skb, IFLA_BRPORT_UNICAST_FLOOD,
>> +			       br_opt_get(br, BROPT_UNICAST_FLOOD)) ||
>> +		    nla_put_u8(skb, IFLA_BRPORT_MCAST_FLOOD,
>> +			       br_opt_get(br, BROPT_MCAST_FLOOD)) ||
>> +		    nla_put_u8(skb, IFLA_BRPORT_BCAST_FLOOD,
>> +			       br_opt_get(br, BROPT_BCAST_FLOOD)))
>> +			return -EMSGSIZE;
> No. Bool opts are already exposed through IFLA_BR_MULTI_BOOLOPT.

Aha, there it is, awesome!

>> +static void br_set_bropt(struct net_bridge *br, struct nlattr *tb[],
>> +			 int attrtype, enum net_bridge_opts opt)
>> +{
>> +	if (!tb[attrtype])
>> +		return;
>> +
>> +	br_opt_toggle(br, opt, !!nla_get_u8(tb[attrtype]));
>> +}
> These must be controlled via the boolopt api and attributes, not through
> additional nl attributes.

Understood.

>> @@ -1058,9 +1144,9 @@ int br_setlink(struct net_device *dev, struct nlmsghdr *nlh, u16 flags,
>>  				return err;
>>  
>>  			spin_lock_bh(&br->lock);
>> -			err = br_setport(p, tb, extack);
>> +			err = br_setport(br, p, tb, extack);
> setport is for *port* only...

A-firm.

Thank you for the honest review.  Netlink is still much of a mystery in
many ways to me.

Best regards
 /Joachim
