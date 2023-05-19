Return-Path: <kuba@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C17D8426A6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 03878426A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684533140;
 bh=DvmYUH8tqNMAZb1R1bVtrDgnSZXt8yxQB+NplK600O0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=V+PBalyhMH6kzH7YzbdKg5bmrrp2uWrT4cWs/gTl+PeG2FdUwVUd3MVbzlXkmyfPP
 TvpT81mfXBRGCwBeZgzJiFRJHghCAabKbdqT6LIUl2W8gws4KPChyDKPiUjnjjGFHM
 r0ISzBsTNS3sZXYU5N6fIVtvNRcuMIYjDCZSVfV+Y07cKxPIg2hjnTQHTUwsHluBPb
 rmrYfrR6doWjBdzdqmXuhbv3ZCCjJFU/ZbTPLiSctHuQGnfpgixfo0woS1TbOP2Xlo
 oF9x1I9Ie92vleZLxtejrBXVkaGbExgilPKUKY6lJdcUPtsXB4cVazzYBRRksG5WhK
 8T5om3gjwH8eA==
Date: Fri, 19 May 2023 14:52:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20230519145218.659b0104@kernel.org>
In-Reply-To: <ZGd+9CUBM+eWG5FR@shredder>
References: <20230518113328.1952135-1-idosch@nvidia.com>
 <20230518113328.1952135-2-idosch@nvidia.com>
 <1ed139d5-6cb9-90c7-323c-22cf916e96a0@blackwall.org>
 <ZGd+9CUBM+eWG5FR@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Ido Schimmel <idosch@nvidia.com>
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, jiri@resnulli.us, taspelund@nvidia.com, leon@kernel.org, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, claudiu.manoil@nxp.com, UNGLinuxDriver@microchip.com, vladimir.oltean@nxp.com, edumazet@google.com, jhs@mojatatu.com, roopa@nvidia.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, saeedm@nvidia.com, davem@davemloft.net

On Fri, 19 May 2023 16:51:48 +0300 Ido Schimmel wrote:
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index fc17b9fd93e6..274e55455b15 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -46,6 +46,8 @@ static int br_pass_frame_up(struct sk_buff *skb)
>          */
>         br_switchdev_frame_unmark(skb);
>  
> +       skb->l2_miss = BR_INPUT_SKB_CB(skb)->miss;
> +
>         /* Bridge is just like any other port.  Make sure the
>          * packet is allowed except in promisc mode when someone
>          * may be running packet capture.
> 
> Ran these changes through the selftest and it seems to work.

Can we possibly put the new field at the end of the CB and then have TC
look at it in the CB? We already do a bit of such CB juggling in strp
(first member of struct sk_skb_cb).
