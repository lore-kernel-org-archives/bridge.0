Return-Path: <davem@davemloft.net>
Date: Thu, 06 Aug 2015 23:55:13 -0700 (PDT)
Message-Id: <20150806.235513.1046191182801102990.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1438707993-14561-3-git-send-email-razor@blackwall.org>
References: <1438707993-14561-1-git-send-email-razor@blackwall.org>
	<1438707993-14561-3-git-send-email-razor@blackwall.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net 2/2] bridge: netlink: account for the
 IFLA_BRPORT_PROXYARP_WIFI attribute size and policy
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: razor@blackwall.org
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kyeyoonp@codeaurora.org, jouni@codeaurora.org

From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue,  4 Aug 2015 19:06:33 +0200

> From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> 
> The attribute size wasn't accounted for in the get_slave_size() callback
> (br_port_get_slave_size) when it was introduced, so fix it now. Also add
> a policy entry for it in br_port_policy.
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Fixes: 842a9ae08a25 ("bridge: Extend Proxy ARP design to allow optional rules for Wi-Fi")

Applied.
