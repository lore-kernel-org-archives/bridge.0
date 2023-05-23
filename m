Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8873B4091C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8150C400D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZueTtt0AD4Zkz6gRNUOVHfwxQzF+RhTeQHA0ozMz2w=;
 b=ch00Fv8UxXQF9fUvTZtiy3k03Ix1EUNor09liRXVU+sUVpE5VDIp83niLgJbTvmMr/aVA5owoUhWAQACcKfDIRsTPz1EoYIasbTeuMSAhKqcjwk+ZohRLbv2WUZLPK2ACCc3800u/G+GwGc1myv54thaUJ2JhldXVKc4ElWtupUvykf6UJqX7CcLm9TwX1Y4CEh8oi8V3rulw1HPPKelkYEQ4BSw0r2bnQvRV2zAlIfTNv7ifkj6Tr33bRJ7PyM8248XKkzY2tOXarkjXzg0wnh9zypePf5l8n7RsgJ/moC21gmuNllPbz8gcf7TskxHy3kAwburMz/kR3qHYkfSGg==
Date: Tue, 23 May 2023 11:10:38 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <ZGx0/hwPmFFN2ivS@shredder>
References: <20230518113328.1952135-1-idosch@nvidia.com>
 <20230518113328.1952135-2-idosch@nvidia.com>
 <1ed139d5-6cb9-90c7-323c-22cf916e96a0@blackwall.org>
 <ZGd+9CUBM+eWG5FR@shredder> <20230519145218.659b0104@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519145218.659b0104@kernel.org>
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
To: Jakub Kicinski <kuba@kernel.org>, razor@blackwall.org
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, jiri@resnulli.us, taspelund@nvidia.com, leon@kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, claudiu.manoil@nxp.com, UNGLinuxDriver@microchip.com, vladimir.oltean@nxp.com, edumazet@google.com, jhs@mojatatu.com, roopa@nvidia.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, saeedm@nvidia.com, davem@davemloft.net

On Fri, May 19, 2023 at 02:52:18PM -0700, Jakub Kicinski wrote:
> On Fri, 19 May 2023 16:51:48 +0300 Ido Schimmel wrote:
> > diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> > index fc17b9fd93e6..274e55455b15 100644
> > --- a/net/bridge/br_input.c
> > +++ b/net/bridge/br_input.c
> > @@ -46,6 +46,8 @@ static int br_pass_frame_up(struct sk_buff *skb)
> >          */
> >         br_switchdev_frame_unmark(skb);
> >  
> > +       skb->l2_miss = BR_INPUT_SKB_CB(skb)->miss;
> > +
> >         /* Bridge is just like any other port.  Make sure the
> >          * packet is allowed except in promisc mode when someone
> >          * may be running packet capture.
> > 
> > Ran these changes through the selftest and it seems to work.
> 
> Can we possibly put the new field at the end of the CB and then have TC
> look at it in the CB? We already do a bit of such CB juggling in strp
> (first member of struct sk_skb_cb).

Using the CB between different layers is very fragile and I would like
to avoid it. Note that the skb can pass various layers until hitting the
classifier, each of which can decide to memset() the CB.

Anyway, I think I have a better alternative. I added the 'l2_miss' bit
to the tc skb extension and adjusted the bridge to mark packets via this
extension. The entire thing is protected by the existing 'tc_skb_ext_tc'
static key, so overhead is kept to a minimum when feature is disabled.
Extended flower to enable / disable this key when filters that match on
'l2_miss' are added / removed.

bridge change to mark the packet:
https://github.com/idosch/linux/commit/3fab206492fcad9177f2340680f02ced1b9a0dec.patch

flow_dissector change to dissect the info from the extension:
https://github.com/idosch/linux/commit/1533c078b02586547817a4e63989a0db62aa5315.patch

flower change to enable / disable the key:
https://github.com/idosch/linux/commit/cf84b277511ec80fe565c41271abc6b2e2f629af.patch

Advantages compared to the previous approach are that we do not need a
new bit in the skb and that overhead is kept to a minimum when feature
is disabled. Disadvantage is that overhead is higher when feature is
enabled.

WDYT?

To be clear, merely asking for feedback on the general approach, not
code review.

Thanks
