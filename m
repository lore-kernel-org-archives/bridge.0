Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=SuC5RiFfkwX9myE0wNWiGRa7nHKCHfIZUYphgXOL2/g=;
 b=AjS47ErAH5JvMOawIWhBHjxgn6AKW18TcQ/WbkEe8po7PMMHNFvGVMHyNZYDnNpg7J
 jSPaY07X50r5gQlrUl9XaoFZGXggC3TMJfzg5oGGsYKemxNe3SXKgXfgdmHcEbcwmvRi
 38VNYzUN3AulcCeuAdpaStsyEQrONSJiU8lwoHZMpl9u2VwVYqaaLJeH9J+nmu1eg9Pw
 kcUDpYpeEvYds73PEVrhKV7kD8Pn5NM7WilM8O49HZWr87V0LaYljixdVfD64DbCDG3/
 F6KXKWUcx4aKcATCLTf2dC29XdP5fWZiWkUzzL3I26vdAaU1U3f4eQdG6CKzs5KSVn/s
 LZ4A==
Message-ID: <5d597756-2fe1-e7cc-9ef3-c0323e2274f2@blackwall.org>
Date: Tue, 12 Apr 2022 20:37:58 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220411133837.318876-1-troglobit@gmail.com>
 <20220411133837.318876-9-troglobit@gmail.com>
 <ebd182a2-20bc-471c-e649-a2689ea5a5d1@blackwall.org>
 <87v8ve9ppr.fsf@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <87v8ve9ppr.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH RFC net-next 08/13] net: bridge: avoid
 classifying unknown multicast as mrouters_only
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joachim Wiberg <troglobit@gmail.com>, Roopa Prabhu <roopa@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Vladimir Oltean <vladimir.oltean@nxp.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On 12/04/2022 20:27, Joachim Wiberg wrote:
> 
> Hi Nik,
> 
> and thank you for taking the time to respond!
> 
> On Tue, Apr 12, 2022 at 16:59, Nikolay Aleksandrov <razor@blackwall.org> wrote:
>> On 11/04/2022 16:38, Joachim Wiberg wrote:
>>> Unknown multicast, MAC/IPv4/IPv6, should always be flooded according to
>>> the per-port mcast_flood setting, as well as to detected and configured
>>> mcast_router ports.
> 
> I realize I should've included a reference to RFC4541 here.  Will add
> that in the non-RFC patch.
> 
>>> This patch drops the mrouters_only classifier of unknown IP multicast
>>> and moves the flow handling from br_multicast_flood() to br_flood().
>>> This in turn means br_flood() must know about multicast router ports.
>> If you'd like to flood unknown mcast traffic when a router is present please add
>> a new option which defaults to the current state (disabled).
> 
> I don't think we have to add another option, because according to the
> snooping RFC[1], section 2.1.2 Data Forwarding Rules:
> 
>  "3) [..] If a switch receives an unregistered packet, it must forward
>   that packet on all ports to which an IGMP[2] router is attached.  A
>   switch may default to forwarding unregistered packets on all ports.
>   Switches that do not forward unregistered packets to all ports must
>   include a configuration option to force the flooding of unregistered
>   packets on specified ports. [..]"
> 
> From this I'd like to argue that our current behavior in the bridge is
> wrong.  To me it's clear that, since we have a confiugration option, we
> should forward unknown IP multicast to all MCAST_FLOOD ports (as well as
> the router ports).

Definitely not wrong. In fact:
"Switches that do not forward unregistered packets to all ports must
 include a configuration option to force the flooding of unregistered
 packets on specified ports. [..]"

is already implemented because the admin can mark any port as a router and
enable flooding to it.

> 
> Also, and more critically, the current behavior of offloaded switches do
> forwarding like this already.  So there is a discrepancy currently
> between how the bridge forwards unknown multicast and how any underlying
> switchcore does it.
> 
> Sure, we'll break bridge behavior slightly by forwarding to more ports
> than previous (until the group becomes known/registered), but we'd be
> standards compliant, and the behavior can still be controlled per-port.
> 
> [1]: https://www.rfc-editor.org/rfc/rfc4541.html#section-2.1.2
> [2]: Section 3 goes on to explain how this is similar also for MLD
> 

RFC4541 is only recommending, it's not a mandatory behaviour. This default has been placed
for a very long time and a lot of users and tests take it into consideration.
We cannot break such assumptions and start suddenly flooding packets, but we can
leave it up to the admin or distribution/network software to configure it as default.

>>> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
>>> index 02bb620d3b8d..ab5b97a8c12e 100644
>>> --- a/net/bridge/br_forward.c
>>> +++ b/net/bridge/br_forward.c
>>> @@ -199,9 +199,15 @@ static struct net_bridge_port *maybe_deliver(
>>>  void br_flood(struct net_bridge *br, struct sk_buff *skb,
>>>  	      enum br_pkt_type pkt_type, bool local_rcv, bool local_orig)
>>>  {
>>> +	struct net_bridge_mcast *brmctx = &br->multicast_ctx;
>> Note this breaks per-vlan mcast. You have to use the inferred mctx.
> 
> Thank you, this was one of the things I was really unsure about since
> the introduction of per-VLAN support.  I'll extend the prototype and
> include the brmctx from br_handle_frame_finish().  Thanks!
> 
> Best regards
>  /Joachim

