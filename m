Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 61B6341E5C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 046FD41E69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrgqyvCsDQ90YXqCp0MESUdrqOEqG/2gN1pMFaaJBUM=;
 b=du+8bNNVmBsjJ0R4PxRIh8ztdAr1OIG6kIILgGSsAvmiRVZtWOUUFPmvRcBcHzU043QHe0yeuPqdvFSjcnAG5Bh/5MZeI8Znq3WIVqKO3TlK/p0/M6vDLSMlTEglfluO0uwdBlyBn3duEn263OLvnb2WnWTfLdg9yfbECaPjZwqJIEgOcKUJjaGCEW8fg9CHbcEeJB3moDUlzTncA6tvQXnulyB1PFXKd4yuRCHzzx4ZuJ6Rb2RXivQ9DwhH/oZBfTDCmGjcfTzkOBlqSrW4ReiVIcz8ZAjQp+fp147oYbjCw3fVmIfymtUSijjUCzaKKV7tcx9fyRsWKpN9z6uEuA==
References: <9190b2ac-a3f7-d4f5-211a-ea860f09687a@quietfountain.com>
 <20230711215132.77594-1-kuniyu@amazon.com>
From: Petr Machata <petrm@nvidia.com>
Date: Wed, 12 Jul 2023 11:44:12 +0200
In-Reply-To: <20230711215132.77594-1-kuniyu@amazon.com>
Message-ID: <87wmz5v4oz.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] llc needs namespace awareness asap,
 was Re: Patch fixing STP if bridge in non-default namespace.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: bridge@lists.linux-foundation.org, hcoin@quietfountain.com, netdev@vger.kernel.org, andrew@lunn.ch

(CC'ing bridge maintainers.)

Kuniyuki Iwashima <kuniyu@amazon.com> writes:

> From: Harry Coin <hcoin@quietfountain.com>
> Date: Tue, 11 Jul 2023 16:40:03 -0500
>> On 7/11/23 15:44, Andrew Lunn wrote:
>> >>>>>> The current llc_rcv.c around line 166 in net/llc/llc_input.c  has
>> >>>>>>
>> >>>>>>            if (!net_eq(dev_net(dev), &init_net))
>> >>>>>>                    goto drop;
>> >>>>>>
>> >> Thank you!  When you offer your patches, and you hear worries about being
>> >> 'invasive', it's worth asking 'compared to what' -- since the 'status quo'
>> >> is every bridge with STP in a non default namespace with a loop in it
>> >> somewhere will freeze every connected system more solid than ice in
>> >> Antarctica.
>> > https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>> >
>> > say:
>> >
>> > o It must be obviously correct and tested.
>> > o It cannot be bigger than 100 lines, with context.
>> > o It must fix only one thing.
>> > o It must fix a real bug that bothers people (not a, "This could be a problem..." type thing).
>> >
>> > git blame shows:
>> >
>> > commit 721499e8931c5732202481ae24f2dfbf9910f129
>> > Author: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
>> > Date:   Sat Jul 19 22:34:43 2008 -0700
>> >
>> >      netns: Use net_eq() to compare net-namespaces for optimization.
>> >
>> > diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
>> > index 1c45f172991e..57ad974e4d94 100644
>> > --- a/net/llc/llc_input.c
>> > +++ b/net/llc/llc_input.c
>> > @@ -150,7 +150,7 @@ int llc_rcv(struct sk_buff *skb, struct net_device *dev,
>> >          int (*rcv)(struct sk_buff *, struct net_device *,
>> >                     struct packet_type *, struct net_device *);
>> >   
>> > -       if (dev_net(dev) != &init_net)
>> > +       if (!net_eq(dev_net(dev), &init_net))
>> >                  goto drop;
>> >   
>> >          /*
>> >
>> > So this is just an optimization.
>> >
>> > The test itself was added in
>> >
>> > ommit e730c15519d09ea528b4d2f1103681fa5937c0e6
>> > Author: Eric W. Biederman <ebiederm@xmission.com>
>> > Date:   Mon Sep 17 11:53:39 2007 -0700
>> >
>> >      [NET]: Make packet reception network namespace safe
>> >      
>> >      This patch modifies every packet receive function
>> >      registered with dev_add_pack() to drop packets if they
>> >      are not from the initial network namespace.
>> >      
>> >      This should ensure that the various network stacks do
>> >      not receive packets in a anything but the initial network
>> >      namespace until the code has been converted and is ready
>> >      for them.
>> >      
>> >      Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>> >      Signed-off-by: David S. Miller <davem@davemloft.net>
>> >
>> > So that was over 15 years ago.
>> >
>> > It appears it has not bothered people for over 15 years.
>> >
>> > Lets wait until we get to see the actual fix. We can then decide how
>> > simple/hard it is to back port to stable, if it fulfils the stable
>> > rules or not.
>> >
>> >        Andrew
>> 
>> Andrew, fair enough.  In the time until it's fixed, the kernel folks 
>> should publish an advisory and block any attempt to set bridge stp state 
>> to other than 0 if in a non-default namespace. The alternative is a 
>> packet flood at whatever the top line speed is should there be a loop 
>> somewhere in even one connected link.
>
> Like this ?  Someone who didn't notice the issue might complain about
> it as regression.
>
> ---8<---
> diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
> index 75204d36d7f9..a807996ac56b 100644
> --- a/net/bridge/br_stp_if.c
> +++ b/net/bridge/br_stp_if.c
> @@ -201,6 +201,11 @@ int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
>  {
>  	ASSERT_RTNL();
>  
> +	if (!net_eq(dev_net(br->dev), &init_net)) {
> +		NL_SET_ERR_MSG_MOD(extack, "STP can't be enabled in non-root netns");
> +		return -EINVAL;
> +	}
> +
>  	if (br_mrp_enabled(br)) {
>  		NL_SET_ERR_MSG_MOD(extack,
>  				   "STP can't be enabled if MRP is already enabled");
> ---8<---

