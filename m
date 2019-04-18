Return-Path: <rdong.ge@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=0hn2Wjh784brf5WxXi3weFw+L8yk+6mLW77kQr3FuEY=;
	b=C/c5Y/nDS23q3ZGi5jvlrWrHemrAPXLLcY8iEhiFSckZ9OT62f513w8c0PzfQBdfFS
	+3jcC1yhigr3Em4AEUa855/f+8hWGb4ZR4T67tAPvBoqjXENnrg9ZopE075aJlqsUVw7
	66511MjdorTs1oYQa+/i+xxyOsjyQe4zoSNR54F9E4jieiP0JbCWKTRTVibkh4g8rLjD
	aPjhO1al5F/4ph1jr14J2is3t/I7+Hu/a6zCih6QJ0Mqnf+Ya9Jvd28T0t3N4gz0qZl+
	XXiQqXi7NhfoWVoXYL9gML7zIZknk9Gcat4C1EnAtlZOP/dwQgJ7CBDXItFvLtVUgnZK
	MNUg==
MIME-Version: 1.0
References: <20190402125609.30313-1-rdong.ge@gmail.com>
	<20190403174441.2l7xyk5o2hftrdm3@salvia>
	<CAN1Lvyov_GOjg=1zrgWsV0_ptBGoFfLBsQKU7RswgmzZEjFkmw@mail.gmail.com>
In-Reply-To: <CAN1Lvyov_GOjg=1zrgWsV0_ptBGoFfLBsQKU7RswgmzZEjFkmw@mail.gmail.com>
From: Rundong Ge <rdong.ge@gmail.com>
Date: Thu, 18 Apr 2019 17:58:19 +0800
Message-ID: <CAN1Lvyq7U1fWaGY4j6DTRPXrv_Wm7-K6Vh0fgeHjbOSizm7fGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH] netfilter:bridge: Hold bridge dev for
 fake_rtable to avoid the dangling pointer
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, fw@strlen.de, linux-kernel@vger.kernel.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, kadlec@blackhole.kfki.hu, davem@davemloft.net

friendly ping

Rundong Ge <rdong.ge@gmail.com> =E4=BA=8E2019=E5=B9=B44=E6=9C=889=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=882:33=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Pablo
>
> I've tested on mainline v5.0. The dangling pointer access of fake_rtable
> still exists.
>
> My env is like this: client0--box--client1.
> The box runs ubuntu with v5.0 kernel, br_netfilter and nfnetlink_queue
> are inserted.
>
> Reproduce steps:
> 1.Create a bridge on the box.
> 2.echo 1 >/proc/sys/net/bridge/bridge-nf-call-iptables
> 3.Add a netfilter hook function to queue the packets to nfqueuenum 0.
>   The hook point must between <NF_BR_PRE_ROUTING,NF_BR_PRI_BRNF> and
>   <NF_BR_FORWARD,NF_BR_PRI_BRNF - 1>.
> 4.Add a userspace process "nfqueue_rcv" to continuously read and
>   set_verdict "NF_ACCEPT" to packets from queue 0.
> 5.Continuosly ping client1 from client0
> 6.Send "Ctrl + Z" to pause the "nfqueue_rcv" to simulate the queue
>   congestion.
> 7.Using "ifconfig br0 down&&brctl delbr br0" to delete the bridge.
> 8.At this time the _skb_refdst of skbs in the nfqueue become dangling
>   pointer. If we send "fg" to resume the "nfqueue_rcv", the kernel
>   may try to access the freed memory.
>
> Debug log:
> Here I add debug logs in "netdev_freemem" and "dst_release" to prove
> the freed memory access. As the log shows, the "dst_release" accessed
> bridge's fake_rtable after the bridge was freed.
>
> Apr  8 22:25:14 raydon kernel: [62139.005062] netdev_freemem name:br0,
> fake_rtable:000000009d76cef0
> Apr  8 22:25:21 raydon kernel: [62145.967133] dst_release
> dst:000000009d76cef0 dst->dev->name: =C5=99KU=C2=A1TH
> Apr  8 22:25:21 raydon kernel: [62145.967154] dst_release
> dst:000000009d76cef0 dst->dev->name: =C5=99KU=C2=A1TH
> Apr  8 22:25:21 raydon kernel: [62145.967180] dst_release
> dst:000000009d76cef0 dst->dev->name: =C5=99KU=C2=A1TH
> Apr  8 22:25:21 raydon kernel: [62145.967197] dst_release
> dst:000000009d76cef0 dst->dev->name: =C5=99KU=C2=A1TH
>
>
>
> The reason why the hook point should be after <NF_BR_PRE_ROUTING,
> NF_BR_PRI_BRNF> is skbs reference bridge's fake_rtable in
> "br_nf_pre_routing_finish" hooked at <NF_BR_PRE_ROUTING,NF_BR_PRI_BRNF>.
>
> And the reason why the hook point should be before <NF_BR_FORWARD,
> NF_BR_PRI_BRNF - 1> is "br_nf_forward_ip" will set the state.out to
> bridge dev. After this hook point, the "nfqnl_dev_drop" triggered by
> the bridge's NETDEV_DOWN event can flush the queued skbs before
> bridge's memory is freed, because the state.out now matches the
> bridge's dev.
>
> So the root cause is "nfqnl_dev_drop" didn't flush the skbs properly
> queued between <NF_BR_PRE_ROUTING,NF_BR_PRI_BRNF> and <NF_BR_FORWARD,
> NF_BR_PRI_BRNF - 1>.
>
> As you mentioned, hold the bridge dev for these skbs is not a proper
> solution. I will send another patch to let "nfqnl_dev_drop" can flush
> these skbs.
>
> Thanks
> Rundong
>
>
> Pablo Neira Ayuso <pablo@netfilter.org> =E4=BA=8E2019=E5=B9=B44=E6=9C=884=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=881:44=E5=86=99=E9=81=93=EF=BC=
=9A
> >
> > On Tue, Apr 02, 2019 at 12:56:09PM +0000, Rundong Ge wrote:
> > > Problem:
> > > When bridge-nf-call-iptables is enabled, skb_dst(skb) of packets that
> > > in the nfqueue may be a dangling pointer if user delete the bridge.
> > > Because packets go through the br_nf_pre_routing_finish will set the =
dst
> > > pointer to the br->fake_rtable. But the br struct will be freed
> > > without the reference check for these skbs.
> > >
> > > User impact:
> > > Kernel panic may happen when user delete the bridge if there are
> > > continuous traffics go through the nfqueue.
> > > Here is a panic in my device which using kernel v3.10.
> >
> > This kernel is _very old_.
> >
> > Could you provide the steps to reproduce this issue?
> >
> > Holding the device doesn't seem the way to go to me, we have a of
> > netdevice_notifier that is dropping packets for an interface that is
> > gone in nfnetlink_queue. We also drop packets whenever a hook in gone.
> >
> > So I wonder if this is still a problem in mainline kernels.
