Return-Path: <xu.xin.sc@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D81276009C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 434C960F5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681263195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7njyoKzJ51EO5yB+UcKz0vkCXJHgabT0CFKCHzXCCZ8=;
 b=lungnl9bBU45ypPeW/o26colK9OVYNlA2wNxRmSwtzL1no3pCX5s3hsIg4VaWaB15b
 6hrAomvj/CNKp23ARz26ojNunMAK1WYBeJajGFinAztS3AbzNdW3WjN38G2ElhIVBTFD
 WNhIbwI/xday4ZjEzcW6npCAUs0jn6PZ1s78GMQv243LntVclVuJtl/fH+dNdav8/fSi
 zxVPayjMECoCqAoPW0Du8WHFAlfojTmmw3KoxLxlNdPYFHCzQBerjmXxdJNgOBc9pF3U
 sginLIBFiZbq8UC4GotlOQDm8SYUI7UP9a25seCRSWgLhn2+iY7q4zIZH1zjiGMeuVDN
 fvow==
From: xu xin <xu.xin.sc@gmail.com>
Date: Wed, 12 Apr 2023 09:33:10 +0800
Message-Id: <20230412013310.174561-1-xu.xin16@zte.com.cn>
In-Reply-To: <20230407200319.72fd763f@kernel.org>
References: <20230407200319.72fd763f@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next] net/bridge: add drop reasons for
	bridge forwarding
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, yang.yang29@zte.com.cn, edumazet@google.com, zhang.yunkai@zte.com.cn, xu.xin16@zte.com.cn, jiang.xuexin@zte.com.cn, roopa@nvidia.com, pabeni@redhat.com, davem@davemloft.net

>On Thu, 6 Apr 2023 19:30:34 +0800 (CST) yang.yang29@zte.com.cn wrote:
>> From: xu xin <xu.xin16@zte.com.cn>
>> 
>> This creates six drop reasons as follows, which will help users know the
>> specific reason why bridge drops the packets when forwarding.
>> 
>> 1) SKB_DROP_REASON_BRIDGE_FWD_NO_BACKUP_PORT: failed to get a backup
>>    port link when the destination port is down.
>> 
>> 2) SKB_DROP_REASON_BRIDGE_FWD_SAME_PORT: destination port is the same
>>    with originating port when forwarding by a bridge.
>> 
>> 3) SKB_DROP_REASON_BRIDGE_NON_FORWARDING_STATE: the bridge's state is
>>    not forwarding.
>> 
>> 4) SKB_DROP_REASON_BRIDGE_NOT_ALLOWED_EGRESS: the packet is not allowed
>>    to go out through the port due to vlan filtering.
>> 
>> 5) SKB_DROP_REASON_BRIDGE_SWDEV_NOT_ALLOWED_EGRESS: the packet is not
>>    allowed to go out through the port which is offloaded by a hardware
>>    switchdev, checked by nbp_switchdev_allowed_egress().
>> 
>> 6) SKB_DROP_REASON_BRIDGE_BOTH_PORT_ISOLATED: both source port and dest
>>    port are in BR_ISOLATED state when bridge forwarding.
>
>> @@ -338,6 +344,33 @@ enum skb_drop_reason {
>>  	 * for another host.
>>  	 */
>>  	SKB_DROP_REASON_IPV6_NDISC_NS_OTHERHOST,
>> +	/** @SKB_DROP_REASON_BRIDGE_FWD_NO_BACKUP_PORT: failed to get a backup
>> +	 * port link when the destination port is down.
>> +	 */
>
>That's not valid kdoc. Text can be on the same line as the value only
>in one-line comments. Otherwise:
>	/**
>	 * @VALUE: bla bla bla
>	 *	more blas.
>	 */
>

Ok, I didn't notice that.

>> +static inline bool should_deliver(const struct net_bridge_port *p, const struct sk_buff *skb,
>> +					 enum skb_drop_reason *need_reason)
>>  {
>>  	struct net_bridge_vlan_group *vg;
>> +	enum skb_drop_reason reason;
>> 
>>  	vg = nbp_vlan_group_rcu(p);
>> -	return ((p->flags & BR_HAIRPIN_MODE) || skb->dev != p->dev) &&
>> -		p->state == BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&
>> -		nbp_switchdev_allowed_egress(p, skb) &&
>> -		!br_skb_isolated(p, skb);
>> +	if (!(p->flags & BR_HAIRPIN_MODE) && skb->dev == p->dev) {
>> +		reason = SKB_DROP_REASON_BRIDGE_FWD_SAME_PORT;
>> +		goto undeliverable;
>> +	}
>> +	if (p->state != BR_STATE_FORWARDING) {
>> +		reason = SKB_DROP_REASON_BRIDGE_NON_FORWARDING_STATE;
>> +		goto undeliverable;
>> +	}
>> +	if (!br_allowed_egress(vg, skb)) {
>> +		reason = SKB_DROP_REASON_BRIDGE_NOT_ALLOWED_EGRESS;
>> +		goto undeliverable;
>> +	}
>> +	if (!nbp_switchdev_allowed_egress(p, skb)) {
>> +		reason = SKB_DROP_REASON_BRIDGE_SWDEV_NOT_ALLOWED_EGRESS;
>> +		goto undeliverable;
>> +	}
>> +	if (br_skb_isolated(p, skb)) {
>> +		reason = SKB_DROP_REASON_BRIDGE_BOTH_PORT_ISOLATED;
>> +		goto undeliverable;
>> +	}
>> +	return true;
>> +
>> +undeliverable:
>> +	if (need_reason)
>> +		*need_reason = reason;
>> +	return false;
>
>You can return the reason from this function. That's the whole point of
>SKB_NOT_DROPPED_YET existing and being equal to 0.
>

If returning the reasons, then the funtion will have to be renamed because
'should_deliever()' is expected to return a non-zero value  when it's ok to
deliever. I don't want to change the name here, and it's better to keep its
name and use the pointer to store the reasons.

>Which is not to say that I know whether the reasons are worth adding
>here. We'll need to hear from bridge experts on that.
