Return-Path: <rdong.ge@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=zeW2EB44SqLEQGsY2YylFGSCLe2d8d3xyY+7YXzj+uQ=;
	b=hlrwu8/VWPKnAzvYARwUQCB8VjdMpH9Lspg7iRQW8aFjCIvAIhUAvszDuBzJfhC2td
	1vvgpOYxY7+z67ftLvVtHmTU0T0Y0Q3WqpOcRmhSlJ8p7MBH38IvmuT2/7HCWx11Eigy
	x8h7b7SJFQS9XgiSdL4ZuVq300g7MoG3DbKBFr7XIJQTbh2IlOyZBrLmF7r7YvA+WdWu
	BxQPqe36ZMIlSsf7NvWYw30y1K58nrMCX+Gp+sMkrDGYpW5iczkVMllyF05r3K/xSYNW
	x/5wZ4TUtg6+tUp5wj4hF+SR09RkhRjYgufcZ7+c6+0EJ0RKIkGwQHaUTmCxTbNY1FL0
	nIkA==
MIME-Version: 1.0
References: <20190730122534.30687-1-rdong.ge@gmail.com>
	<20190730123542.zrsrfvcy7t2n3d4g@breakpoint.cc>
	<nycvar.YFH.7.76.1908260955400.22383@n3.vanv.qr>
In-Reply-To: <nycvar.YFH.7.76.1908260955400.22383@n3.vanv.qr>
From: Rundong Ge <rdong.ge@gmail.com>
Date: Wed, 28 Aug 2019 17:21:46 +0800
Message-ID: <CAN1Lvyp=pmu4KYbwb9sHcPyc0WXjOfb-JZspizDn1S=Uiu3rbQ@mail.gmail.com>
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
To: Jan Engelhardt <jengelh@inai.de>
Cc: yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, kadlec@netfilter.org, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, kuznet@ms2.inr.ac.ru, davem@davemloft.net, Pablo Neira Ayuso <pablo@netfilter.org>

Jan Engelhardt <jengelh@inai.de> =E4=BA=8E2019=E5=B9=B48=E6=9C=8826=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=883:59=E5=86=99=E9=81=93=EF=BC=9A
>
>
> On Tuesday 2019-07-30 14:35, Florian Westphal wrote:
> >Rundong Ge <rdong.ge@gmail.com> wrote:
> >> Given following setup:
> >> -modprobe br_netfilter
> >> -echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
> >> -brctl addbr br0
> >> -brctl addif br0 enp2s0
> >> -brctl addif br0 enp3s0
> >> -brctl addif br0 enp6s0
> >> -ifconfig enp2s0 mtu 1300
> >> -ifconfig enp3s0 mtu 1500
> >> -ifconfig enp6s0 mtu 1500
> >> -ifconfig br0 up
> >>
> >>                  multi-port
> >> mtu1500 - mtu1500|bridge|1500 - mtu1500
> >>   A                  |            B
> >>                    mtu1300
> >
> >How can a bridge forward a frame from A/B to mtu1300?
>
> There might be a misunderstanding here judging from the shortness of this
> thread.
>
> I understood it such that the bridge ports (eth0,eth1) have MTU 1500, yet=
 br0
> (in essence the third bridge port if you so wish) itself has MTU 1300.
>
> Therefore, frame forwarding from eth0 to eth1 should succeed, since the
> 1300-byte MTU is only relevant if the bridge decides the packet needs to =
be
> locally delivered.

Under this setup when I do "ping B -l 2000" from A, the fragmented
packets will be dropped by bridge.
When the "/proc/sys/net/bridge/bridge-nf-call-iptables" is on, bridge
will do defragment at PREROUTING and re-fragment at POSTROUTING. At
the re-fragment bridge will check if the max frag size is larger than
the bridge's MTU in  br_nf_ip_fragment(), if it is true packets will
be dropped.
And this patch use the outdev's MTU instead of the bridge's MTU to do
the br_nf_ip_fragment.
