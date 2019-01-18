Return-Path: <davem@davemloft.net>
Date: Thu, 17 Jan 2019 21:55:57 -0800 (PST)
Message-Id: <20190117.215557.221214487674861038.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1547689601-21876-1-git-send-email-wangyunjian@huawei.com>
References: <1547689601-21876-1-git-send-email-wangyunjian@huawei.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v4] net: bridge: Fix ethernet header
 pointer before check skb forwardable
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: wangyunjian@huawei.com
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, xudingke@huawei.com

From: wangyunjian <wangyunjian@huawei.com>
Date: Thu, 17 Jan 2019 09:46:41 +0800

> From: Yunjian Wang <wangyunjian@huawei.com>
> 
> The skb header should be set to ethernet header before using
> is_skb_forwardable. Because the ethernet header length has been
> considered in is_skb_forwardable(including dev->hard_header_len
> length).
> 
> To reproduce the issue:
> 1, add 2 ports on linux bridge br using following commands:
> $ brctl addbr br
> $ brctl addif br eth0
> $ brctl addif br eth1
> 2, the MTU of eth0 and eth1 is 1500
> 3, send a packet(Data 1480, UDP 8, IP 20, Ethernet 14, VLAN 4)
> from eth0 to eth1
> 
> So the expect result is packet larger than 1500 cannot pass through
> eth0 and eth1. But currently, the packet passes through success, it
> means eth1's MTU limit doesn't take effect.
> 
> Fixes: f6367b4660dd ("bridge: use is_skb_forwardable in forward path")
> Cc: bridge@lists.linux-foundation.org
> Cc: Nkolay Aleksandrov <nikolay@cumulusnetworks.com>
> Cc: Roopa Prabhu <roopa@cumulusnetworks.com>
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>

Applied and queued up for -stable.
