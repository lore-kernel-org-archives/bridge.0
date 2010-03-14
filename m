Date: Sat, 13 Mar 2010 16:19:23 -0800 (PST)
Message-Id: <20100313.161923.106760717.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1268514611-7930-1-git-send-email-henne@nachtwindheim.de>
References: <[PATCH]:_CONFIG_BRIDGE_IGMP_SNOOPING_must_depend_on_CONFIG_INET>
	<1268514611-7930-1-git-send-email-henne@nachtwindheim.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] [PATCH]: CONFIG_BRIDGE_IGMP_SNOOPING must
 depend on CONFIG_INET
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: henne@nachtwindheim.de
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>
Date: Sat, 13 Mar 2010 22:10:11 +0100

> Linking the kernel fails with the the following error message,
> if CONFIG_BRIDGE_IGMP_SNOOPING is set and CONFIG_INET is not set.
> 
> net/built-in.o: In function `br_multicast_alloc_query':
> br_multicast.c:(.text+0x52045): undefined reference to `ip_send_check'
> 
> This patch is tested.
> 
> Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

This has been fixed for some time in the net-2.6 tree
and now Linus just pulled that tree in so his tree
has the fix too.
