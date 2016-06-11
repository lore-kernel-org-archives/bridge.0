Return-Path: <davem@davemloft.net>
Date: Sat, 11 Jun 2016 15:50:16 -0700 (PDT)
Message-Id: <20160611.155016.671585186295613791.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <575C39B1.3010300@cumulusnetworks.com>
References: <1465215613-3468-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<20160610.223512.206489271156278288.davem@davemloft.net>
	<575C39B1.3010300@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2] bridge: Synchronize unicast
 filtering with FDB
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, netdev@bof.de

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Sat, 11 Jun 2016 18:17:53 +0200

> Oops, I almost missed the v2, sorry about that. So, technically it
> looks correct, but I only fear the scalability impact of the
> change. If there're a large number of vlans adding a macvlan (or any
> device that syncs uc addr) might become very slow and every flag
> change will become very slow too without an option to revert to the
> original behaviour so we'll have to wait for the entries to be added
> in order to delete them.  Another common scenario is having 8021q
> interfaces on top of the bridge with different mac addresses for
> some of the configured vlans (or with macvlans on top of them for
> VRR), that use case would suffer as well because their macs need to
> be local only for those vlans, and not the 2000+ other vlans that
> might exist.  On every sync_uc() call all the fdb entries get
> deleted and added again, so even after deleting some manually they
> can come back unexpectedly after some operation and also the message
> storm from all the deletes and adds could be problematic as well.
> 
> 
> E.g. 2000 br0 vlans, 25 macvlans on br0 (adding them took more than 5 minutes, 53k fdb entries):
> $ bridge fdb del de:8e:9f:16:c5:71 dev br0 vlan 289
> $ ip l set br0 multicast on
> $ bridge fdb | grep 289 | grep de:8e:9f:16:c5:71
> de:8e:9f:16:c5:71 dev br0 vlan 1289 master br0 permanent
> de:8e:9f:16:c5:71 dev br0 vlan 289 master br0 permanent
> 
> In fact you can't escape the slow performance even if you delete all
> entries because on the next flag change or interface add, they will
> be added back.

Yeah, I think the performance implications are too severe too, I'm
not applying this.
