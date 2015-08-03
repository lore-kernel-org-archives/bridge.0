Return-Path: <davem@davemloft.net>
Date: Mon, 03 Aug 2015 15:44:07 -0700 (PDT)
Message-Id: <20150803.154407.1641134905324878853.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1438601356-20885-1-git-send-email-razor@blackwall.org>
References: <1438601356-20885-1-git-send-email-razor@blackwall.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: mdb: add/del entry on all
 vlans if vlan_filter is enabled and vid is 0
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
Date: Mon,  3 Aug 2015 13:29:16 +0200

> From: Satish Ashok <sashok@cumulusnetworks.com>
> 
> Before this patch when a vid was not specified, the entry was added with
> vid 0 which is useless when vlan_filtering is enabled. This patch makes
> the entry to be added on all configured vlans when vlan filtering is
> enabled and respectively deleted from all, if the entry vid is 0.
> This is also closer to the way fdb works with regard to vid 0 and vlan
> filtering.
 ...
> Signed-off-by: Satish Ashok <sashok@cumulusnetworks.com>
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied, but as usual if any existing user ends up being broken I will
revert this.

Thanks.
