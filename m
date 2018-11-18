Return-Path: <davem@davemloft.net>
Date: Sat, 17 Nov 2018 21:39:21 -0800 (PST)
Message-Id: <20181117.213921.1707006957061525021.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181116165001.30896-1-nikolay@cumulusnetworks.com>
References: <20181114172703.5795-1-nikolay@cumulusnetworks.com>
	<20181116165001.30896-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v3] net: bridge: fix vlan stats
 use-after-free on destruction
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, syzkaller-bugs@googlegroups.com

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Fri, 16 Nov 2018 18:50:01 +0200

> Syzbot reported a use-after-free of the global vlan context on port vlan
> destruction. When I added per-port vlan stats I missed the fact that the
> global vlan context can be freed before the per-port vlan rcu callback.
> There're a few different ways to deal with this, I've chosen to add a
> new private flag that is set only when per-port stats are allocated so
> we can directly check it on destruction without dereferencing the global
> context at all. The new field in net_bridge_vlan uses a hole.
> 
> v2: cosmetic change, move the check to br_process_vlan_info where the
>     other checks are done
> v3: add change log in the patch, add private (in-kernel only) flags in a
>     hole in net_bridge_vlan struct and use that instead of mixing
>     user-space flags with private flags
> 
> Fixes: 9163a0fc1f0c ("net: bridge: add support for per-port vlan stats")
> Reported-by: syzbot+04681da557a0e49a52e5@syzkaller.appspotmail.com
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied.
