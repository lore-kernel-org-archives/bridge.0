Return-Path: <davem@davemloft.net>
Date: Mon, 20 Jul 2015 16:20:37 -0700 (PDT)
Message-Id: <20150720.162037.22945315511431028.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1437426225-28418-1-git-send-email-razor@blackwall.org>
References: <201507210410.H5dNw6Lx%fengguang.wu@intel.com>
	<1437426225-28418-1-git-send-email-razor@blackwall.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: mcast: fix
 br_multicast_dev_del warn when igmp snooping is not defined
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
Date: Mon, 20 Jul 2015 23:03:45 +0200

> Fix:
> net/bridge/br_if.c: In function 'br_dev_delete':
>>> net/bridge/br_if.c:284:2: error: implicit declaration of function
>>> 'br_multicast_dev_del' [-Werror=implicit-function-declaration]
>      br_multicast_dev_del(br);
>      ^
>    cc1: some warnings being treated as errors
> 
> when igmp snooping is not defined.
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
> Apologies for the mess.

Applied, thanks.
