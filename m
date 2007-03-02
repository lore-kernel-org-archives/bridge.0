Date: Fri, 02 Mar 2007 13:26:38 -0800 (PST)
Message-Id: <20070302.132638.38710461.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070228171846.679d8733@dxpl.pdx.osdl.net>
References: <20070228171846.679d8733@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: avoid ptype_all packet handling
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: shemminger@linux-foundation.org
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org

From: Stephen Hemminger <shemminger@linux-foundation.org>
Date: Wed, 28 Feb 2007 17:18:46 -0800

> I was measuring bridging/routing performance and noticed this.
> 
> The current code runs the "all packet" type handlers before calling the
> bridge hook.  If an application (like some DHCP clients) is using AF_PACKET,
> this means that each received packet gets run through the Berkeley Packet Filter
> code in sk_run_filter (slow).

I know we closed this out by saying that even though performance
sucks, we can't really apply this without breaking things.

What would be broken is if the DHCP client isn't specifying
a device ifindex when it binds the AF_PACKET socket.  That
would be an easy way to fix this performance problem at the
application level.

The DHCP client should only care about a particular interface's
traffic, the one it wants to listen on.
