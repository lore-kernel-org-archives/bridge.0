Return-Path: <fw@strlen.de>
Date: Tue, 30 Jul 2019 14:35:42 +0200
From: Florian Westphal <fw@strlen.de>
Message-ID: <20190730123542.zrsrfvcy7t2n3d4g@breakpoint.cc>
References: <20190730122534.30687-1-rdong.ge@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730122534.30687-1-rdong.ge@gmail.com>
Subject: Re: [Bridge] [PATCH] bridge:fragmented packets dropped by bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Rundong Ge <rdong.ge@gmail.com>
Cc: yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, fw@strlen.de, linux-kernel@vger.kernel.org, kadlec@netfilter.org, nikolay@cumulusnetworks.com, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, kuznet@ms2.inr.ac.ru, davem@davemloft.net, pablo@netfilter.org

Rundong Ge <rdong.ge@gmail.com> wrote:
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

How can a bridge forward a frame from A/B to mtu1300?

> With netfilter defragmentation/conntrack enabled, fragmented
> packets from A will be defragmented in prerouting, and refragmented
> at postrouting.

Yes, but I don't see how that relates to the problem at hand.

> But in this scenario the bridge found the frag_max_size(1500) is
> larger than the dst mtu stored in the fake_rtable whitch is
> always equal to the bridge's mtu 1300, then packets will be dopped.

What happens without netfilter or non-fragmented packets?

> This modifies ip_skb_dst_mtu to use the out dev's mtu instead
> of bridge's mtu in bridge refragment.

It seems quite a hack?  The above setup should use a router, not a bridge.
