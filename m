Return-Path: <davem@davemloft.net>
Date: Mon, 17 Apr 2017 13:45:49 -0400 (EDT)
Message-Id: <20170417.134549.136665384930126255.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1492166974-20578-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1492166974-20578-1-git-send-email-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: notify on hw fdb takeover
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, idosch@mellanox.com

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Fri, 14 Apr 2017 13:49:34 +0300

> Recently we added support for SW fdbs to take over HW ones, but that
> results in changing a user-visible fdb flag thus we need to send a
> notification, also it's consistent with how HW takes over SW entries.
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied.
