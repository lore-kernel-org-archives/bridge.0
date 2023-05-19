Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A130783B3D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E80D83B3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LejE3WAnl9Y6W66fvDvFQkIFnGTgR2dh7xS9sL2n9N4=;
 b=KEMaKlIXUHu/9RKNdLPUTL65so9GWtu2T/ncG2N7pCPwCO4PbXhM1US5fD/7YKgsb+ZWbgKfVuU9l66mEYedFi7fqjt2ceOGErysCx1U0wKrKPlZOwsSLR8I5WfD4woQkoFaaUNqAOgZU4j7JRzjV4Nh4GCcweNyYexNyWCF007mmUI4tsaQe/i8IyLBXEY0uEWH3274I5FG42HVgX0AhTeIat633QQpWpNwdy7k6CDeqir2SKCCXaPCutezH2R6QGsaIvfUfZq2jNwH/tMx0Bs2EVbitFL2zTS8J34HcGnAZpMaiRQYZjnrOMbzN5u6QfLBZxEh873zjXyrZ7BpjA==
Date: Fri, 19 May 2023 16:51:48 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <ZGd+9CUBM+eWG5FR@shredder>
References: <20230518113328.1952135-1-idosch@nvidia.com>
 <20230518113328.1952135-2-idosch@nvidia.com>
 <1ed139d5-6cb9-90c7-323c-22cf916e96a0@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ed139d5-6cb9-90c7-323c-22cf916e96a0@blackwall.org>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 1/5] skbuff: bridge: Add layer 2 miss
	indication
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, jiri@resnulli.us, taspelund@nvidia.com, leon@kernel.org, netdev@vger.kernel.org, xiyou.wangcong@gmail.com, bridge@lists.linux-foundation.org, claudiu.manoil@nxp.com, UNGLinuxDriver@microchip.com, vladimir.oltean@nxp.com, edumazet@google.com, jhs@mojatatu.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, davem@davemloft.net

On Thu, May 18, 2023 at 07:08:47PM +0300, Nikolay Aleksandrov wrote:
> On 18/05/2023 14:33, Ido Schimmel wrote:
> > diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> > index fc17b9fd93e6..d8ab5890cbe6 100644
> > --- a/net/bridge/br_input.c
> > +++ b/net/bridge/br_input.c
> > @@ -334,6 +334,7 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
> >  		return RX_HANDLER_CONSUMED;
> >  
> >  	memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
> > +	skb->l2_miss = 0;
> >  
> >  	p = br_port_get_rcu(skb->dev);
> >  	if (p->flags & BR_VLAN_TUNNEL)
> 
> Overall looks good, only this part is a bit worrisome and needs some additional
> investigation because now we'll unconditionally dirty a cache line for every
> packet that is forwarded. Could you please check the effect with perf?

To eliminate it I tried the approach we discussed yesterday:

First, add the miss indication to the bridge's control block which is
zeroed for every skb entering the bridge:

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 2119729ded2b..bd5c18286a40 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -581,6 +581,7 @@ struct br_input_skb_cb {
 #endif
        u8 proxyarp_replied:1;
        u8 src_port_isolated:1;
+       u8 miss:1;      /* FDB or MDB lookup miss */
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
        u8 vlan_filtered:1;
 #endif

And set this bit upon misses instead of skb->l2_miss:

@@ -203,6 +205,8 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
        struct net_bridge_port *prev = NULL;
        struct net_bridge_port *p;
 
+       BR_INPUT_SKB_CB(skb)->miss = 1;
+
        list_for_each_entry_rcu(p, &br->port_list, list) {
                /* Do not flood unicast traffic to ports that turn it off, nor
                 * other traffic if flood off, except for traffic we originate
@@ -295,6 +299,7 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
                        allow_mode_include = false;
        } else {
                p = NULL;
+               BR_INPUT_SKB_CB(skb)->miss = 1;
        }
 
        while (p || rp) {

Then copy it to skb->l2_miss at the very end where the cache line
containing this field is already written to:

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 84d6dd5e5b1a..89f65564e338 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -50,6 +50,8 @@ int br_dev_queue_push_xmit(struct net *net, struct sock *sk, struct sk_buff *skb
 
        br_switchdev_frame_set_offload_fwd_mark(skb);
 
+       skb->l2_miss = BR_INPUT_SKB_CB(skb)->miss;
+
        dev_queue_xmit(skb);
 
        return 0;

Also for locally received packets:

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index fc17b9fd93e6..274e55455b15 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -46,6 +46,8 @@ static int br_pass_frame_up(struct sk_buff *skb)
         */
        br_switchdev_frame_unmark(skb);
 
+       skb->l2_miss = BR_INPUT_SKB_CB(skb)->miss;
+
        /* Bridge is just like any other port.  Make sure the
         * packet is allowed except in promisc mode when someone
         * may be running packet capture.

Ran these changes through the selftest and it seems to work.

WDYT?
