Return-Path: <davem@davemloft.net>
Date: Sat, 31 Mar 2018 22:05:16 -0400 (EDT)
Message-Id: <20180331.220516.312380228110627327.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180330104619.31479-1-nikolay@cumulusnetworks.com>
References: <20180330104619.31479-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/2] net: bridge: MTU handling changes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, 3chas3@gmail.com

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Fri, 30 Mar 2018 13:46:17 +0300

> As previously discussed the recent changes break some setups and could lead
> to packet drops. Thus the first patch reverts the behaviour for the bridge
> to follow the minimum MTU but also keeps the ability to set the MTU to the
> maximum (out of all ports) if vlan filtering is enabled. Patch 02 is the
> bigger change in behaviour - we've always had trouble when configuring
> bridges and their MTU which is auto tuning on port events
> (add/del/changemtu), which means config software needs to chase it and fix
> it after each such event, after patch 02 we allow the user to configure any
> MTU (ETH_MIN/MAX limited) but once that is done the bridge stops auto
> tuning and relies on the user to keep the MTU correct.
> This should be compatible with cases that don't touch the MTU (or set it
> to the same value), while allowing to configure the MTU and not worry
> about it changing afterwards.
> 
> The patches are intentionally split like this, so that if they get accepted
> and there are any complaints patch 02 can be reverted.

Series applied, thanks.
