Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=BlP4513unQUdet+MKvQ2g15uNq4TvoNSOCqk6BEJf7o=;
	b=gJ1Zv7I1MINBx3xVNBcaEWYgqiAI2Hxdpv8UWLgZ1l+KCYj74JMQWldehUfc6SIkAz
	6wAw9qlPZq6SQKIeNsAhxvcBfOZEMvPvAc5Q0LHyJdD4gVZgojW4m+qLNz4GfrBixnVY
	AKPWBhhHasuwPOKwO/HteYm4dTpfSYy2+WL0w=
References: <20190730122534.30687-1-rdong.ge@gmail.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <1dc87e69-628b-fd04-619a-8dbe5bdfa108@cumulusnetworks.com>
Date: Tue, 30 Jul 2019 15:41:23 +0300
MIME-Version: 1.0
In-Reply-To: <20190730122534.30687-1-rdong.ge@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge:fragmented packets dropped by bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Rundong Ge <rdong.ge@gmail.com>, davem@davemloft.net
Cc: yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, fw@strlen.de, linux-kernel@vger.kernel.org, kadlec@netfilter.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, kuznet@ms2.inr.ac.ru, pablo@netfilter.org

On 30/07/2019 15:25, Rundong Ge wrote:
> Given following setup:
> -modprobe br_netfilter
> -echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
> -brctl addbr br0
> -brctl addif br0 enp2s0
> -brctl addif br0 enp3s0
> -brctl addif br0 enp6s0
> -ifconfig enp2s0 mtu 1300
> -ifconfig enp3s0 mtu 1500
> -ifconfig enp6s0 mtu 1500
> -ifconfig br0 up
> 
>                  multi-port
> mtu1500 - mtu1500|bridge|1500 - mtu1500
>   A                  |            B
>                    mtu1300
> 
> With netfilter defragmentation/conntrack enabled, fragmented
> packets from A will be defragmented in prerouting, and refragmented
> at postrouting.
> But in this scenario the bridge found the frag_max_size(1500) is
> larger than the dst mtu stored in the fake_rtable whitch is
> always equal to the bridge's mtu 1300, then packets will be dopped.
> 
> This modifies ip_skb_dst_mtu to use the out dev's mtu instead
> of bridge's mtu in bridge refragment.
> 
> Signed-off-by: Rundong Ge <rdong.ge@gmail.com>
> ---
>  include/net/ip.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/net/ip.h b/include/net/ip.h
> index 29d89de..0512de3 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -450,6 +450,8 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
>  static inline unsigned int ip_skb_dst_mtu(struct sock *sk,
>  					  const struct sk_buff *skb)
>  {
> +	if ((skb_dst(skb)->flags & DST_FAKE_RTABLE) && skb->dev)
> +		return min(skb->dev->mtu, IP_MAX_MTU);
>  	if (!sk || !sk_fullsock(sk) || ip_sk_use_pmtu(sk)) {
>  		bool forwarding = IPCB(skb)->flags & IPSKB_FORWARDED;
>  
> 

I don't think this is correct, there's a reason why the bridge chooses the smallest
possible MTU out of its members and this is simply a hack to circumvent it.
If you really like to do so just set the bridge MTU manually, we've added support
so it won't change automatically to the smallest, but then how do you pass packets
1500 -> 1300 in this setup ?

You're talking about the frag_size check in br_nf_ip_fragment(), right ?

