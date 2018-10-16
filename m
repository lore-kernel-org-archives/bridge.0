Return-Path: <davem@davemloft.net>
Date: Mon, 15 Oct 2018 22:55:32 -0700 (PDT)
Message-Id: <20181015.225532.1743728392191294083.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1539601231-32755-1-git-send-email-lirongqing@baidu.com>
References: <1539601231-32755-1-git-send-email-lirongqing@baidu.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH][net-next][v2] net: bridge: fix a possible
 memory leak in __vlan_add
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: lirongqing@baidu.com
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org

From: Li RongQing <lirongqing@baidu.com>
Date: Mon, 15 Oct 2018 19:00:31 +0800

> After per-port vlan stats, vlan stats should be released
> when fail to add vlan
> 
> Fixes: 9163a0fc1f0c0 ("net: bridge: add support for per-port vlan stats")
> CC: bridge@lists.linux-foundation.org
> cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> CC: Roopa Prabhu <roopa@cumulusnetworks.com>
> Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Applied.
