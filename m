Date: Wed, 28 Feb 2007 23:22:24 -0800 (PST)
Message-Id: <20070228.232224.74746939.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <45E67B04.2060702@linux-foundation.org>
References: <20070228195611.24cf19ee@deepthought>
	<45E650F6.4030404@candelatech.com>
	<45E67B04.2060702@linux-foundation.org>
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
Date: Wed, 28 Feb 2007 23:04:36 -0800

> If an normal application has to use something like raw packet
> filtering, it seems there is a missing API.

I'm loosely following this discussion, but Ben mentions DHCP
and I remember learning the other month that DHCP uses AF_PACKET
and filtering instead of IP RAW sockets because it needs to get
the MAC address and RAW sockets don't provide that.
