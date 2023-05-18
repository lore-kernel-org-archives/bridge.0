Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BB62E4054B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B6AD040106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1684426131; x=1687018131;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iyuoVXRwAkG96IRjsmBXEWPPWLN9VCCign9YtDLx2cU=;
 b=kzLWYsW5n4uheX6EWn13HctN1sZsIT92orviF9/G5tPKzzsBBJlST4z8e52bJTC48D
 wNd4Qs12HRV/ULmxl+RAaayJilGjmHYnw8h2ijZn/tgAEA1DP74dMTDe5tGnHA/o34BF
 SoQDvdckzQxFjgGgv50++7rmnWea9MrZfITdHZyyyHmW/6CGhqJCYJpRsC6mH19znuo5
 3CVGj1dMhIsaUp5RGhbetdD9KrCAyptFYo7OgI5U+K8MSbc0/tGnSQ2x8aZ8O86H+Oak
 5qpCB8JbjUfkAKY4J4NossABK8ME6WuUYbDc5eA+DWk6AVa5sLW7pG9ucqx9MMuuKwb5
 EnCA==
Message-ID: <1ed139d5-6cb9-90c7-323c-22cf916e96a0@blackwall.org>
Date: Thu, 18 May 2023 19:08:47 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230518113328.1952135-1-idosch@nvidia.com>
 <20230518113328.1952135-2-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230518113328.1952135-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
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
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, jiri@resnulli.us, taspelund@nvidia.com, leon@kernel.org, vladimir.oltean@nxp.com, xiyou.wangcong@gmail.com, claudiu.manoil@nxp.com, UNGLinuxDriver@microchip.com, edumazet@google.com, jhs@mojatatu.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, davem@davemloft.net

On 18/05/2023 14:33, Ido Schimmel wrote:
> Allow the bridge driver to mark packets that did not match a layer 2
> entry during forwarding by adding a 'l2_miss' bit to the skb.
> 
> Clear the bit whenever a packet enters the bridge (received from a
> bridge port or transmitted via the bridge) and set it if the packet did
> not match an FDB/MDB entry.
> 
> Subsequent patches will allow the flower classifier to match on this
> bit. The motivating use case in non-DF (Designated Forwarder) filtering
> where we would like to prevent decapsulated packets from being flooded
> to a multi-homed host.
> 
> Do not allocate the bit if the kernel was not compiled with bridge
> support and place it after the two bit fields in accordance with commit
> 4c60d04c2888 ("net: skbuff: push nf_trace down the bitfield"). The bit
> does not increase the size of the structure as it is placed at an
> existing hole. Layout with allmodconfig:
> 
> struct sk_buff {
> [...]
> 			__u8       csum_not_inet:1;      /*   132: 3  1 */
> 			__u8       l2_miss:1;            /*   132: 4  1 */
> 
> 			/* XXX 3 bits hole, try to pack */
> 			/* XXX 1 byte hole, try to pack */
> 
> 			__u16      tc_index;             /*   134     2 */
> 			u16        alloc_cpu;            /*   136     2 */
> [...]
> } __attribute__((__aligned__(8)));
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  include/linux/skbuff.h  | 4 ++++
>  net/bridge/br_device.c  | 1 +
>  net/bridge/br_forward.c | 3 +++
>  net/bridge/br_input.c   | 1 +
>  4 files changed, 9 insertions(+)
> 
[snip]
>  	while (p || rp) {
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index fc17b9fd93e6..d8ab5890cbe6 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -334,6 +334,7 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
>  		return RX_HANDLER_CONSUMED;
>  
>  	memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
> +	skb->l2_miss = 0;
>  
>  	p = br_port_get_rcu(skb->dev);
>  	if (p->flags & BR_VLAN_TUNNEL)

Overall looks good, only this part is a bit worrisome and needs some additional
investigation because now we'll unconditionally dirty a cache line for every
packet that is forwarded. Could you please check the effect with perf?

Thanks,
 Nik

