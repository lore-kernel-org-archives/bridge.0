Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1947E82C1E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 60BB381F67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1685366258; x=1687958258;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KVHCP9GjMtC8qGNoGPmmcW2n7fokm+mXHG6bkqQl4dY=;
 b=03mfx0ayiG0g5gZAkaaZrOEZcURS53wiLiY5XKrCqoqeWUopFUtoCdP3lSOwwJjq9Y
 F0xuSja3LEukr90mGXgI48sG6D5PypA5AnBDO4iX5qMJRMjW4NxHLk+rKwqzvTYjLbFc
 bY68vk4vmVD89r1EExry645zx5+Sq36ZvbZRixZ62MPHDjxdhHpGuTDngrwV+PNFXkU/
 lQcQed/At5NP1pkIkTPbw7PgMUMdqQdpqm9dUrvsqKnxI6zFV6H2CpCWt4pYdg8eVCbv
 6IiJ7BiojjEnuLXxctttXWi5m+onKPW9J4r8KQCvBxWB4L83ukO0uyC1CxN+VoQl21HN
 2Ytw==
Message-ID: <58d3e95f-ee23-06c7-b690-64fe42b9c56b@blackwall.org>
Date: Mon, 29 May 2023 16:17:35 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230529114835.372140-1-idosch@nvidia.com>
 <20230529114835.372140-2-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230529114835.372140-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 1/8] skbuff: bridge: Add layer 2
 miss indication
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
> For EVPN non-DF (Designated Forwarder) filtering we need to be able to
> prevent decapsulated traffic from being flooded to a multi-homed host.
> Filtering of multicast and broadcast traffic can be achieved using the
> following flower filter:
> 
>  # tc filter add dev bond0 egress pref 1 proto all flower indev vxlan0 dst_mac 01:00:00:00:00:00/01:00:00:00:00:00 action drop
> 
> Unlike broadcast and multicast traffic, it is not currently possible to
> filter unknown unicast traffic. The classification into unknown unicast
> is performed by the bridge driver, but is not visible to other layers
> such as tc.
> 
> Solve this by adding a new 'l2_miss' bit to the tc skb extension. Clear
> the bit whenever a packet enters the bridge (received from a bridge port
> or transmitted via the bridge) and set it if the packet did not match an
> FDB or MDB entry. If there is no skb extension and the bit needs to be
> cleared, then do not allocate one as no extension is equivalent to the
> bit being cleared. The bit is not set for broadcast packets as they
> never perform a lookup and therefore never incur a miss.
> 
> A bit that is set for every flooded packet would also work for the
> current use case, but it does not allow us to differentiate between
> registered and unregistered multicast traffic, which might be useful in
> the future.
> 
> To keep the performance impact to a minimum, the marking of packets is
> guarded by the 'tc_skb_ext_tc' static key. When 'false', the skb is not
> touched and an skb extension is not allocated. Instead, only a
> 5 bytes nop is executed, as demonstrated below for the call site in
> br_handle_frame().
> 
> Before the patch:
> 
> ```
>         memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
>   c37b09:       49 c7 44 24 28 00 00    movq   $0x0,0x28(%r12)
>   c37b10:       00 00
> 
>         p = br_port_get_rcu(skb->dev);
>   c37b12:       49 8b 44 24 10          mov    0x10(%r12),%rax
>         memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
>   c37b17:       49 c7 44 24 30 00 00    movq   $0x0,0x30(%r12)
>   c37b1e:       00 00
>   c37b20:       49 c7 44 24 38 00 00    movq   $0x0,0x38(%r12)
>   c37b27:       00 00
> ```
> 
> After the patch (when static key is disabled):
> 
> ```
>         memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
>   c37c29:       49 c7 44 24 28 00 00    movq   $0x0,0x28(%r12)
>   c37c30:       00 00
>   c37c32:       49 8d 44 24 28          lea    0x28(%r12),%rax
>   c37c37:       48 c7 40 08 00 00 00    movq   $0x0,0x8(%rax)
>   c37c3e:       00
>   c37c3f:       48 c7 40 10 00 00 00    movq   $0x0,0x10(%rax)
>   c37c46:       00
> 
> #ifdef CONFIG_HAVE_JUMP_LABEL_HACK
> 
> static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
> {
>         asm_volatile_goto("1:"
>   c37c47:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>         br_tc_skb_miss_set(skb, false);
> 
>         p = br_port_get_rcu(skb->dev);
>   c37c4c:       49 8b 44 24 10          mov    0x10(%r12),%rax
> ```
> 
> Subsequent patches will extend the flower classifier to be able to match
> on the new 'l2_miss' bit and enable / disable the static key when
> filters that match on it are added / deleted.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     * Use tc skb extension instead of adding a bit to the skb.
>     * Do not mark broadcast packets as they never perform a lookup and
>       therefore never incur a miss.
> 
>  include/linux/skbuff.h  |  1 +
>  net/bridge/br_device.c  |  1 +
>  net/bridge/br_forward.c |  3 +++
>  net/bridge/br_input.c   |  1 +
>  net/bridge/br_private.h | 27 +++++++++++++++++++++++++++
>  5 files changed, 33 insertions(+)
> 

Nice approach.
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


