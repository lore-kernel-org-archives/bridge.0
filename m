Return-Path: <davem@davemloft.net>
Date: Tue, 16 Apr 2019 21:41:35 -0700 (PDT)
Message-Id: <20190416.214135.101870252438058205.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190416131556.27109-1-nikolay@cumulusnetworks.com>
References: <20190416131556.27109-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: fix netlink export of
 vlan_stats_per_port option
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
Date: Tue, 16 Apr 2019 16:15:56 +0300

> Since the introduction of the vlan_stats_per_port option the netlink
> export of it has been broken since I made a typo and used the ifla
> attribute instead of the bridge option to retrieve its state.
> Sysfs export is fine, only netlink export has been affected.
> 
> Fixes: 9163a0fc1f0c0 ("net: bridge: add support for per-port vlan stats")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied and queued up for -stable.
