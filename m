Return-Path: <davem@davemloft.net>
Date: Tue, 14 Nov 2017 21:56:07 +0900 (KST)
Message-Id: <20171114.215607.1722773989012260419.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1510590655-20935-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1510590655-20935-1-git-send-email-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: add vlan_tunnel to bridge
 port policies
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon, 13 Nov 2017 18:30:55 +0200

> Found another missing port flag policy entry for IFLA_BRPORT_VLAN_TUNNEL
> so add it now.
> 
> CC: Roopa Prabhu <roopa@cumulusnetworks.com>
> Fixes: efa5356b0d97 ("bridge: per vlan dst_metadata netlink support")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied.
