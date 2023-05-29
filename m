Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 306FB8128D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4CC72821F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1685366337; x=1687958337;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/vKSVewvvgNmBaS2m89L7HPH8tzhUP9OKuLAcv7eBrA=;
 b=C8HQzWxLngDUWXWbOKeK6W+9+VQlAZu8nbLFYw9lmw75B5y/D+Kvvw0MuIfnEk6JjA
 oBFn4pw/SmXtgL5VNY6i3BxzvYtVbJCLycd2QR1VoXp2jA6iYnQLVumnPY4GT2iIIfYL
 ZMSxLWYf0CQl08haYhgjxGguMPcpqE75T2GwIZHNQvC8H02mHYNn2OPSc3GmY98ha2oB
 InKxNqdaSG2IvB+Und5d1cqintkU9/4Ib5IP25vgEIiUEOwuwAjA95KCf7PcvHd7NuVI
 UcKbNwG5VGEQc1o2DFiGzxR6/UIjexYMM7XsI67iWwXT/DTaDj+yv5jeqon5lVup6Ydc
 y+Hw==
Message-ID: <753ea732-2016-36b7-bcc3-4536fa5cd6a4@blackwall.org>
Date: Mon, 29 May 2023 16:18:55 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230529114835.372140-1-idosch@nvidia.com>
 <20230529114835.372140-4-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230529114835.372140-4-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 3/8] net/sched: flower: Allow
 matching on layer 2 miss
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, jiri@resnulli.us, leon@kernel.org, vladimir.oltean@nxp.com, roopa@nvidia.com, claudiu.manoil@nxp.com, UNGLinuxDriver@microchip.com, edumazet@google.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com, simon.horman@corigine.com, kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, davem@davemloft.net

On 29/05/2023 14:48, Ido Schimmel wrote:
> Add the 'TCA_FLOWER_L2_MISS' netlink attribute that allows user space to
> match on packets that encountered a layer 2 miss. The miss indication is
> set as metadata in the tc skb extension by the bridge driver upon FDB or
> MDB lookup miss and dissected by the flow dissector to the
> 'FLOW_DISSECTOR_KEY_META' key.
> 
> The use of this skb extension is guarded by the 'tc_skb_ext_tc' static
> key. As such, enable / disable this key when filters that match on layer
> 2 miss are added / deleted.
> 
> Tested:
> 
>  # cat tc_skb_ext_tc.py
>  #!/usr/bin/env -S drgn -s vmlinux
> 
>  refcount = prog["tc_skb_ext_tc"].key.enabled.counter.value_()
>  print(f"tc_skb_ext_tc reference count is {refcount}")
> 
>  # ./tc_skb_ext_tc.py
>  tc_skb_ext_tc reference count is 0
> 
>  # tc filter add dev swp1 egress proto all handle 101 pref 1 flower src_mac 00:11:22:33:44:55 action drop
>  # tc filter add dev swp1 egress proto all handle 102 pref 2 flower src_mac 00:11:22:33:44:55 l2_miss true action drop
>  # tc filter add dev swp1 egress proto all handle 103 pref 3 flower src_mac 00:11:22:33:44:55 l2_miss false action drop
> 
>  # ./tc_skb_ext_tc.py
>  tc_skb_ext_tc reference count is 2
> 
>  # tc filter replace dev swp1 egress proto all handle 102 pref 2 flower src_mac 00:01:02:03:04:05 l2_miss false action drop
> 
>  # ./tc_skb_ext_tc.py
>  tc_skb_ext_tc reference count is 2
> 
>  # tc filter del dev swp1 egress proto all handle 103 pref 3 flower
>  # tc filter del dev swp1 egress proto all handle 102 pref 2 flower
>  # tc filter del dev swp1 egress proto all handle 101 pref 1 flower
> 
>  # ./tc_skb_ext_tc.py
>  tc_skb_ext_tc reference count is 0
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     * Split flow_dissector changes to a previous patch.
>     * Use tc skb extension instead of 'skb->l2_miss'.
> 
>  include/uapi/linux/pkt_cls.h |  2 ++
>  net/sched/cls_flower.c       | 30 ++++++++++++++++++++++++++++--
>  2 files changed, 30 insertions(+), 2 deletions(-)

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


