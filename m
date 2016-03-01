Return-Path: <davem@davemloft.net>
Date: Tue, 01 Mar 2016 16:55:29 -0500 (EST)
Message-Id: <20160301.165529.1496211335348252214.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1456518004-25578-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1456518004-25578-1-git-send-email-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 0/4] bridge: mcast: add support for
 temp router port
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
Date: Fri, 26 Feb 2016 21:20:00 +0100

> This set adds support for temporary router port which doesn't depend only
> on the incoming queries. It can be refreshed by setting multicast_router to
> the same value (3). The first two patches are minor changes that prepare
> the code for the third which adds this new type of router port.
> In order to be able to dump its information the mdb router port format
> is changed in patch 04 and extended similar to how mdb entries format was
> done recently.
> The related iproute2 changes will be posted if this is accepted.
> 
> v2: set val first and adjust router type later in patch 01, patch 03 was
> split in 2

Series applied, thanks Nik.
