Return-Path: <davem@davemloft.net>
Date: Fri, 15 Jan 2016 15:41:45 -0500 (EST)
Message-Id: <20160115.154145.18804969118533519.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1452881034-19128-1-git-send-email-razor@blackwall.org>
References: <1452881034-19128-1-git-send-email-razor@blackwall.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: fix lockdep addr_list_lock false
 positive splat
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: razor@blackwall.org
Cc: vyasevic@redhat.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, gospo@cumulusnetworks.com

From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Fri, 15 Jan 2016 19:03:54 +0100

> From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> 
> After promisc mode management was introduced a bridge device could do
> dev_set_promiscuity from its ndo_change_rx_flags() callback which in
> turn can be called after the bridge's addr_list_lock has been taken
> (e.g. by dev_uc_add). This causes a false positive lockdep splat because
> the port interfaces' addr_list_lock is taken when br_manage_promisc()
> runs after the bridge's addr list lock was already taken.
> To remove the false positive introduce a custom bridge addr_list_lock
> class and set it on bridge init.
> A simple way to reproduce this is with the following:
> $ brctl addbr br0
> $ ip l add l br0 br0.100 type vlan id 100
> $ ip l set br0 up
> $ ip l set br0.100 up
> $ echo 1 > /sys/class/net/br0/bridge/vlan_filtering
> $ brctl addif br0 eth0
> Splat:
 ...
> CC: Vlad Yasevich <vyasevic@redhat.com>
> CC: Stephen Hemminger <stephen@networkplumber.org>
> CC: Bridge list <bridge@lists.linux-foundation.org>
> CC: Andy Gospodarek <gospo@cumulusnetworks.com>
> CC: Roopa Prabhu <roopa@cumulusnetworks.com>
> Fixes: 2796d0c648c9 ("bridge: Automatically manage port promiscuous mode.")
> Reported-by: Andy Gospodarek <gospo@cumulusnetworks.com>
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied and queued up for -stable, thanks Nikolay.
