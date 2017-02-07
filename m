Return-Path: <davem@davemloft.net>
Date: Tue, 07 Feb 2017 14:14:30 -0500 (EST)
Message-Id: <20170207.141430.837924902975646212.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1486478603-38776-1-git-send-email-roopa@cumulusnetworks.com>
References: <1486478603-38776-1-git-send-email-roopa@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: remove unnecessary check for
 vtbegin in br_fill_vlan_tinfo_range
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: roopa@cumulusnetworks.com
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, dan.carpenter@oracle.com

From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Tue,  7 Feb 2017 06:43:23 -0800

> From: Roopa Prabhu <roopa@cumulusnetworks.com>
> 
> vtbegin should not be NULL in this function, Its already checked by the
> caller.
> 
> this should silence the below smatch complaint:
>   net/bridge/br_netlink_tunnel.c:144 br_fill_vlan_tinfo_range()
>     error: we previously assumed 'vtbegin' could be null (see line 130)
> 
> net/bridge/br_netlink_tunnel.c
>    129
>    130      if (vtbegin && vtend && (vtend->vid - vtbegin->vid) > 0) {
>                     ^^^^^^^
> Check for NULL.
> 
> Fixes: efa5356b0d97 ("bridge: per vlan dst_metadata netlink support")
> Reported-By: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>

Applied.
