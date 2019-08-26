Return-Path: <rdong.ge@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Ng3r5ONd1UXk9XbKRQ/zQ2B6srwD/ZPTNQ4V19/Kj9k=;
	b=bnUIMT7JohUlW4Oahlrsf7w9EBYZqsvNo09J+X+VLhDwVpX6jTeQWC6IN6sIQAq7fp
	0a54HgDv5nhu19OUAynDvvP15aLc44u6qo11gYC5RnNCo0J3lGtNAqhB7eWX8kzNEk/r
	hRrg9fGUKL9FK97XUN+qWd2ptbq0ggMlaPw9C9ifvDxMrj9ox9RBsmdJDuINDmZ+2Qut
	yvN3RnEFO8fuxwRn8FSXkieO1xxa/17uHZz9eIBgCTs0py11lO5bPabcGqwRMFnmeZ3C
	mOH/WFKR23C0xMfMtYjDn5R3uHjgc0j7kKQa5+LCkhqbZY3Fsx7eSvmew0cspGOTaZtD
	TsUQ==
MIME-Version: 1.0
References: <20190730122534.30687-1-rdong.ge@gmail.com>
	<1dc87e69-628b-fd04-619a-8dbe5bdfa108@cumulusnetworks.com>
In-Reply-To: <1dc87e69-628b-fd04-619a-8dbe5bdfa108@cumulusnetworks.com>
From: Rundong Ge <rdong.ge@gmail.com>
Date: Mon, 26 Aug 2019 10:45:52 +0800
Message-ID: <CAN1LvyoL3YUot0JAfz1BwN9LBxM0XUgSkYHhWJ75DFHW_-6+zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH] bridge:fragmented packets dropped by bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, kadlec@netfilter.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, kuznet@ms2.inr.ac.ru, davem@davemloft.net, Pablo Neira Ayuso <pablo@netfilter.org>

On Tue, Jul 30, 2019 at 8:41 PM Nikolay Aleksandrov
<nikolay@cumulusnetworks.com> wrote:
>
> On 30/07/2019 15:25, Rundong Ge wrote:
> > Given following setup:
> > -modprobe br_netfilter
> > -echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
> > -brctl addbr br0
> > -brctl addif br0 enp2s0
> > -brctl addif br0 enp3s0
> > -brctl addif br0 enp6s0
> > -ifconfig enp2s0 mtu 1300
> > -ifconfig enp3s0 mtu 1500
> > -ifconfig enp6s0 mtu 1500
> > -ifconfig br0 up
> >
> >                  multi-port
> > mtu1500 - mtu1500|bridge|1500 - mtu1500
> >   A                  |            B
> >                    mtu1300
> >
> > With netfilter defragmentation/conntrack enabled, fragmented
> > packets from A will be defragmented in prerouting, and refragmented
> > at postrouting.
> > But in this scenario the bridge found the frag_max_size(1500) is
> > larger than the dst mtu stored in the fake_rtable whitch is
> > always equal to the bridge's mtu 1300, then packets will be dopped.
> >
> > This modifies ip_skb_dst_mtu to use the out dev's mtu instead
> > of bridge's mtu in bridge refragment.
> >
> > Signed-off-by: Rundong Ge <rdong.ge@gmail.com>
> > ---
> >  include/net/ip.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/include/net/ip.h b/include/net/ip.h
> > index 29d89de..0512de3 100644
> > --- a/include/net/ip.h
> > +++ b/include/net/ip.h
> > @@ -450,6 +450,8 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
> >  static inline unsigned int ip_skb_dst_mtu(struct sock *sk,
> >                                         const struct sk_buff *skb)
> >  {
> > +     if ((skb_dst(skb)->flags & DST_FAKE_RTABLE) && skb->dev)
> > +             return min(skb->dev->mtu, IP_MAX_MTU);
> >       if (!sk || !sk_fullsock(sk) || ip_sk_use_pmtu(sk)) {
> >               bool forwarding = IPCB(skb)->flags & IPSKB_FORWARDED;
> >
> >
>
> I don't think this is correct, there's a reason why the bridge chooses the smallest
> possible MTU out of its members and this is simply a hack to circumvent it.
> If you really like to do so just set the bridge MTU manually, we've added support
> so it won't change automatically to the smallest, but then how do you pass packets
> 1500 -> 1300 in this setup ?
>
> You're talking about the frag_size check in br_nf_ip_fragment(), right ?
>

Hi Nikolay
My setup may not be common. And may I know if there is any reason to
use output port's MTU
to do the re-fragment check but then use the bridge's MTU to do the re-fragment?
Is it the expected behavior that the bridge's MTU will affect the
FORWARD traffic re-fragment,
because I used to think the bridge's MTU will only effect the OUTPUT
traffic sent from "br0".
And the modification in this patch will replace the MTU in the
fake_rtable which is only
used in the FORWARD re-fragment and won't affect the local traffic from "br0".

TKS
Raydodn
