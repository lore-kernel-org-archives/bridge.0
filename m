Return-Path: <pablo@gnumonks.org>
Date: Wed, 3 Apr 2019 19:44:41 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20190403174441.2l7xyk5o2hftrdm3@salvia>
References: <20190402125609.30313-1-rdong.ge@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402125609.30313-1-rdong.ge@gmail.com>
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
To: Rundong Ge <rdong.ge@gmail.com>
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, fw@strlen.de, linux-kernel@vger.kernel.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, kadlec@blackhole.kfki.hu, davem@davemloft.net

On Tue, Apr 02, 2019 at 12:56:09PM +0000, Rundong Ge wrote:
> Problem:
> When bridge-nf-call-iptables is enabled, skb_dst(skb) of packets that
> in the nfqueue may be a dangling pointer if user delete the bridge.
> Because packets go through the br_nf_pre_routing_finish will set the dst
> pointer to the br->fake_rtable. But the br struct will be freed
> without the reference check for these skbs.
> 
> User impact:
> Kernel panic may happen when user delete the bridge if there are
> continuous traffics go through the nfqueue.
> Here is a panic in my device which using kernel v3.10.

This kernel is _very old_.

Could you provide the steps to reproduce this issue?

Holding the device doesn't seem the way to go to me, we have a of
netdevice_notifier that is dropping packets for an interface that is
gone in nfnetlink_queue. We also drop packets whenever a hook in gone.

So I wonder if this is still a problem in mainline kernels.
