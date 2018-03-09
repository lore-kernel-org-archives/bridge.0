Return-Path: <davem@davemloft.net>
Date: Fri, 09 Mar 2018 10:57:24 -0500 (EST)
Message-Id: <20180309.105724.519703919967625754.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1520609475.17937.42.camel@infradead.org>
References: <20150306142932.GA15926@salvia>
	<20150306163700.GC20382@breakpoint.cc>
	<1520609475.17937.42.camel@infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH v2] bridge: make it possible for packets to
 traverse the bridge without hitting netfilter
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: dwmw2@infradead.org
Cc: nbd@openwrt.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, fw@strlen.de, linux-kernel@vger.kernel.org, aliguori@amazon.com, rga@amazon.de, pablo@netfilter.org

From: David Woodhouse <dwmw2@infradead.org>
Date: Fri, 09 Mar 2018 15:31:15 +0000

> Eschewing a 15% speedup on the basis that "well, even though we've had
> three of these already for a decade, we're worried that adding a fourth
> might open the floodgates to further patches" does seem a little odd to
> me, FWIW.

The cost we are dealing with is a fundamental one which is a result of
the hook design.

Indirect calls are killer.

Indirect calls are even more killer now in the age of Spectre and
retpolines.

I definitely would rather see the fundamental issue addressed rather
than poking at it randomly with knobs for this case and that.

Thank you.
