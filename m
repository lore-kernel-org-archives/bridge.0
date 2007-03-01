Date: Wed, 28 Feb 2007 23:30:34 -0800 (PST)
Message-Id: <20070228.233034.74746721.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <45E6802C.2090708@linux-foundation.org>
References: <45E67B04.2060702@linux-foundation.org>
	<20070228.232224.74746939.davem@davemloft.net>
	<45E6802C.2090708@linux-foundation.org>
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
Cc: netdev@vger.kernel.org, greearb@candelatech.com, bridge@linux-foundation.org

From: Stephen Hemminger <shemminger@linux-foundation.org>
Date: Wed, 28 Feb 2007 23:26:36 -0800

> sounds like a socket option would help, the data is already there. Then 
> the normal
> UDP receive path would work.

That would be perfect for new applications.

But we have to support all the old ones, so we're stuck
providing correctly functioning AF_PACKET handling on
all devices, sorry.

And in fact that effectively makes the new socket option
pointless, since it doesn't buy us anything since we have
to support the old stuff fully anyways.
