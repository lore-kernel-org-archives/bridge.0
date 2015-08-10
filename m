Return-Path: <davem@davemloft.net>
Date: Mon, 10 Aug 2015 13:36:53 -0700 (PDT)
Message-Id: <20150810.133653.2183665032933289268.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1438965645-7841-1-git-send-email-razor@blackwall.org>
References: <1438964658-2904-1-git-send-email-razor@blackwall.org>
	<1438965645-7841-1-git-send-email-razor@blackwall.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2] bridge: netlink: add support for
 vlan_filtering attribute
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: razor@blackwall.org
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, nikolay@cumulusnetworks.com

From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Fri,  7 Aug 2015 19:40:45 +0300

> From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> 
> This patch adds the ability to toggle the vlan filtering support via
> netlink. Since we're already running with rtnl in .changelink() we don't
> need to take any additional locks.
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied, thanks.
