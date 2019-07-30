Return-Path: <rdong.ge@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=4+QxDKECEbt2nsi9n15vlp6tEfk79Z3ydNqFgvycDug=;
	b=lbbXElZcWDWcO7idRfKRT150JkbaE34ZAm5/7WQDWq5VmH58byLnlTttxLjULzGnHi
	juIjzfAjttSH+39RkV37/FitX0rPvUZjgqNlP8vrm00v0kNql78LyEheKW1AkIAmz4Hr
	etUy5fge2yzDyv/fLs3IIaWr4M7LBfGOQVr8BtCESNX+Do6SoDJ2tS0KgeYravub+ozp
	yHOS4INVM3CYGw8okECC5dy8I41Sk1AAsWaLM2PXz3FctBuH69ARB5Ddof1scefU7Gy3
	TODHQ18+YhCJHQC2eSWwGl8MvutnGGuJaIIW9IOdwVbIQkc2oZQz5ap0aAEhFV5qTgRj
	CuAg==
MIME-Version: 1.0
References: <20190730122534.30687-1-rdong.ge@gmail.com>
	<20190730123542.zrsrfvcy7t2n3d4g@breakpoint.cc>
In-Reply-To: <20190730123542.zrsrfvcy7t2n3d4g@breakpoint.cc>
From: Rundong Ge <rdong.ge@gmail.com>
Date: Tue, 30 Jul 2019 21:50:05 +0800
Message-ID: <CAN1LvyqtbzycEggoCXaBu3Zf_jebTWLBXm3js6+r60274a61Tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH] bridge:fragmented packets dropped by bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Westphal <fw@strlen.de>
Cc: yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kadlec@netfilter.org, nikolay@cumulusnetworks.com, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, kuznet@ms2.inr.ac.ru, davem@davemloft.net, Pablo Neira Ayuso <pablo@netfilter.org>

> How can a bridge forward a frame from A/B to mtu1300?
It is free for user to set different MTU for bridge ports. In our case
only tcp traffic between A/B and mtu 1300, and mss negotiation can
make packets less than 1300.

> What happens without netfilter or non-fragmented packets?
Without br_netfilter it works fine, there is no defragmentation and
refragmentation, fragmented packets will egress directly.

Florian Westphal <fw@strlen.de> =E4=BA=8E2019=E5=B9=B47=E6=9C=8830=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=888:35=E5=86=99=E9=81=93=EF=BC=9A
>
> Rundong Ge <rdong.ge@gmail.com> wrote:
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
>
> How can a bridge forward a frame from A/B to mtu1300?
>
> > With netfilter defragmentation/conntrack enabled, fragmented
> > packets from A will be defragmented in prerouting, and refragmented
> > at postrouting.
>
> Yes, but I don't see how that relates to the problem at hand.
>
> > But in this scenario the bridge found the frag_max_size(1500) is
> > larger than the dst mtu stored in the fake_rtable whitch is
> > always equal to the bridge's mtu 1300, then packets will be dopped.
>
> What happens without netfilter or non-fragmented packets?
>
> > This modifies ip_skb_dst_mtu to use the out dev's mtu instead
> > of bridge's mtu in bridge refragment.
>
> It seems quite a hack?  The above setup should use a router, not a bridge=
.
