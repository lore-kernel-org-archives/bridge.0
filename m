Date: Fri, 02 Mar 2007 21:59:05 -0800 (PST)
Message-Id: <20070302.215905.74747266.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <E1HNMxB-0000MP-00@gondolin.me.apana.org.au>
References: <20070302.151803.74748558.davem@davemloft.net>
	<E1HNMxB-0000MP-00@gondolin.me.apana.org.au>
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
To: herbert@gondor.apana.org.au
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sat, 03 Mar 2007 16:38:45 +1100

> This is using packet_bind_spkt which uses a name instead of ifindex.

So it should be just fine, it should be binding to a specific
device (by name instead of ifindex) and therefore it should
only trigger the pt_all hook when the packet arrives on that
specific device.

> As you may recall, I've made a patch to convert it to use the new
> (actually it's not-so-new anymore) AF_PACKET interface.

That's right.

So it's still a mystery why dhcp is causing bridge devices
to trigger the network tap paths on Stephen's machine.
