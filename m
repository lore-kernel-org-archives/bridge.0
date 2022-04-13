Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=BuoKK4ZQpOyixi88t54FMVtVUCr5+bIsufKlx4kYhpw=;
 b=QndnMZC+0awTwppISkLvQV3tLtPDwKIPNp1//QeXRe1ypOhSWYZi3KTZPJ37eUeg6E
 6x5X9WkfHdCPw/bd/CIjjLo9+HlPK+E8m9la8g+y7C09Q7Kj7FePXOwQPLzWjBcKnOte
 9ZAqZP4P83uuZy2ThDNRtZq82RAf0aK+fTzifYy/unZk1mM3SLh/vZI7VRJxDwTTD1nn
 Iu84BQzf1s1SymRiW1rJuhkXZ+FxMxew9AVCyUiqz3Vyxjy2RQeCYIcMTS9cdEFKu2gD
 2tJmw1f/H+ioQFv81n+292jQAXDwlU0cJGG98MfD6c7/gY5lJpOvnD9R3i855Cjpfyz5
 MXNQ==
From: Joachim Wiberg <troglobit@gmail.com>
In-Reply-To: <99b0790a-9746-ea08-b57e-52c53436666d@blackwall.org>
References: <20220411133837.318876-1-troglobit@gmail.com>
 <20220411133837.318876-2-troglobit@gmail.com>
 <99b0790a-9746-ea08-b57e-52c53436666d@blackwall.org>
Date: Wed, 13 Apr 2022 11:51:42 +0200
Message-ID: <87k0bt9uq9.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH RFC net-next 01/13] net: bridge: add control of
	bum flooding to bridge itself
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

On Tue, Apr 12, 2022 at 21:27, Nikolay Aleksandrov <razor@blackwall.org> wrote:
> On 11/04/2022 16:38, Joachim Wiberg wrote:
>> @@ -526,6 +526,10 @@ void br_dev_setup(struct net_device *dev)
>>  	br->bridge_ageing_time = br->ageing_time = BR_DEFAULT_AGEING_TIME;
>>  	dev->max_mtu = ETH_MAX_MTU;
>> +	br_opt_toggle(br, BROPT_UNICAST_FLOOD, 1);
> This one must be false by default. It changes current default behaviour.
> Unknown unicast is not currently passed up to the bridge if the port is
> not in promisc mode, this will change it. You'll have to make it consistent
> with promisc (e.g. one way would be for promisc always to enable unicast flood
> and it won't be possible to be disabled while promisc).

Ouch, my bad!  Will look into how to let this have as little impact as
possible.  I like your semantics there, promisc should always win.

>> +	br_opt_toggle(br, BROPT_MCAST_FLOOD, 1);
>> +	br_opt_toggle(br, BROPT_BCAST_FLOOD, 1);
>
> s/1/true/ for consistency

Of course, thanks!

>> @@ -118,7 +118,8 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>>  		/* by definition the broadcast is also a multicast address */
>>  		if (is_broadcast_ether_addr(eth_hdr(skb)->h_dest)) {
>>  			pkt_type = BR_PKT_BROADCAST;
>> -			local_rcv = true;
>> +			if (br_opt_get(br, BROPT_BCAST_FLOOD))
>> +				local_rcv = true;
>>  		} else {
>>  			pkt_type = BR_PKT_MULTICAST;
>>  			if (br_multicast_rcv(&brmctx, &pmctx, vlan, skb, vid))
>> @@ -161,12 +162,16 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>>  			}
>>  			mcast_hit = true;
>>  		} else {
>> -			local_rcv = true;
>> -			br->dev->stats.multicast++;
>> +			if (br_opt_get(br, BROPT_MCAST_FLOOD)) {
>> +				local_rcv = true;
>> +				br->dev->stats.multicast++;
>> +			}
>>  		}
>>  		break;
>>  	case BR_PKT_UNICAST:
>>  		dst = br_fdb_find_rcu(br, eth_hdr(skb)->h_dest, vid);
>> +		if (!dst && br_opt_get(br, BROPT_UNICAST_FLOOD))
>> +			local_rcv = true;
>>  		break;
>
> This adds new tests for all fast paths for host traffic, especially
> the port - port communication which is the most critical one.  Please
> at least move the unicast test to the "else" block of "if (dst)"
> later.

OK, will fix!

> The other tests can be moved to host only code too, but would require
> bigger changes.  Please try to keep the impact on the fast-path at
> minimum.

Interesting, you mean by speculatively setting local_rcv = true and
postpone the decsion to br_pass_frame_up(), right?  Yeah that would
indeed be a bit more work.
