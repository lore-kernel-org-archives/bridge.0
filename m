Date: Fri, 02 Mar 2007 15:41:00 -0800 (PST)
Message-Id: <20070302.154100.30187565.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070302153414.4d8304e0@freekitty>
References: <20070302.144818.99455241.davem@davemloft.net>
	<20070302.151803.74748558.davem@davemloft.net>
	<20070302153414.4d8304e0@freekitty>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC 1/2] bridge: avoid ptype_all packet handling
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
Date: Fri, 2 Mar 2007 15:34:14 -0800

> Can you get FC fixed?

I am not the DHCP package maintainer. :-)

I'm up to my earfulls already dealing with people trying
to slug broken patches into the kernel networking that paper
around application bugs. ;)

> Should we add a warning to kernel log, to make distro's fix it?

Unfortunately it looks like a properly formed sockaddr_ll,
the ifindex is in fact zero, so there is nothing we can do
to warn about this case.

The sockaddr_ll sits after the first sockaddr string in the ifreq, and
the rest remains initialized to zeros, thus the bind() succeeds.
