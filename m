Return-Path: <davem@davemloft.net>
Date: Wed, 31 Jul 2019 19:04:13 -0400 (EDT)
Message-Id: <20190731.190413.1782006239456872904.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190730112100.18156-1-nikolay@cumulusnetworks.com>
References: <20190730112100.18156-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: mcast: don't delete permanent
 entries when fast leave is enabled
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
Date: Tue, 30 Jul 2019 14:21:00 +0300

> When permanent entries were introduced by the commit below, they were
> exempt from timing out and thus igmp leave wouldn't affect them unless
> fast leave was enabled on the port which was added before permanent
> entries existed. It shouldn't matter if fast leave is enabled or not
> if the user added a permanent entry it shouldn't be deleted on igmp
> leave.
 ...
> Fixes: ccb1c31a7a87 ("bridge: add flags to distinguish permanent mdb entires")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied and queued up for -stable.
