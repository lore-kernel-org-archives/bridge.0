Return-Path: <davem@davemloft.net>
Date: Sun, 26 Jul 2015 21:20:13 -0700 (PDT)
Message-Id: <20150726.212013.1442025487679238031.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1437652853-941-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1437652853-941-1-git-send-email-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: mdb: notify on router port
	add and del
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Thu, 23 Jul 2015 05:00:53 -0700

> From: Satish Ashok <sashok@cumulusnetworks.com>
> 
> Send notifications on router port add and del/expire, re-use the already
> existing MDBA_ROUTER and send NEWMDB/DELMDB netlink notifications
> respectively.
> 
> Signed-off-by: Satish Ashok <sashok@cumulusnetworks.com>
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied, thanks.
