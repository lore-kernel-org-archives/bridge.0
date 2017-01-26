Return-Path: <davem@davemloft.net>
Date: Wed, 25 Jan 2017 23:16:25 -0500 (EST)
Message-Id: <20170125.231625.778055316669261176.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170125222950.1352566-1-arnd@arndb.de>
References: <20170125222950.1352566-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] [net-next] bridge: move maybe_deliver_addr()
 inside #ifdef
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: arnd@arndb.de
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, nbd@nbd.name

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 25 Jan 2017 23:29:33 +0100

> The only caller of this new function is inside of an #ifdef checking
> for CONFIG_BRIDGE_IGMP_SNOOPING, so we should move the implementation
> there too, in order to avoid this harmless warning:
> 
> net/bridge/br_forward.c:177:13: error: 'maybe_deliver_addr' defined but not used [-Werror=unused-function]
> 
> Fixes: 6db6f0eae605 ("bridge: multicast to unicast")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thank you.
