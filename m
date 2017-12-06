Return-Path: <makita.toshiaki@lab.ntt.co.jp>
References: <CAPpVWGuVsUP-4Ty7db4DQueL23yjPBMPG4+1Ui+OBTjfUHmVVg@mail.gmail.com>
	<CAPpVWGtgf1cLBq0fyXKbZnzAgzvoX2mm3sLYm5QS7us5H-0XKQ@mail.gmail.com>
From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Message-ID: <443375f0-f29e-4153-56b0-f17513f19388@lab.ntt.co.jp>
Date: Wed, 6 Dec 2017 13:44:03 +0900
MIME-Version: 1.0
In-Reply-To: <CAPpVWGtgf1cLBq0fyXKbZnzAgzvoX2mm3sLYm5QS7us5H-0XKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Sending 802.1Q packets using AF_PACKET socket on
 filtered bridge forwards with wrong MAC addresses
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Cc: Vlad Yasevich <vyasevic@redhat.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

Hi,
(CC: Vlad)

On 2017/11/30 7:01, Brandon Carpenter wrote:
> I narrowed the search to a memmove() called from
> skb_reorder_vlan_header() in net/core/skbuff.c.
> 
>>     memmove(skb->data - ETH_HLEN, skb->data - skb->mac_len - VLAN_HLEN,
>>        2 * ETH_ALEN);
> 
> Calling skb_reset_mac_len() after skb_reset_mac_header() before
> calling br_allowed_ingress() in net/bridge/br_device.c fixes the
> problem.
> 
> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index af5b8c87f590..e10131e2f68f 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -58,6 +58,7 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct
> net_device *dev)
>         BR_INPUT_SKB_CB(skb)->brdev = dev;
> 
>         skb_reset_mac_header(skb);
> +       skb_reset_mac_len(skb);
>         eth = eth_hdr(skb);
>         skb_pull(skb, ETH_HLEN);

Thanks for debugging this problem.
It seems this has been broken since a6e18ff11170 ("vlan: Fix untag
operations of stacked vlans with REORDER_HEADER off").

Unfortunately this does not always work correctly, since in tx path
drivers assume network header to be set to L3 protocol header offset.
Packet socket (packet_snd()) determines network header by
dev_hard_header which is ETH_HLEN in bridge devices, so this works for
packet socket, but with vlan devices on top of bridge device with
tx-vlan hwaccel disabled we get ETH_HLEN + VLAN_HLEN or longer by mac_len.

Since mac_len can be arbitrarily long if we stack vlan devices on bridge
devices, and since we want to untag the outermost tag, using mac_len to
untag in tx path is probably no longer correct.

I'll think deeper about how to fix it.

> I'll put together an official patch  and submit it. Should I use
> another email account? Are my emails being ignored because of that
> stupid disclaimer my employer attaches to my messages (outside my
> control)?
> 
> Brandon
> 

-- 
Toshiaki Makita

