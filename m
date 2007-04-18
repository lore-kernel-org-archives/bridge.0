Date: Wed, 18 Apr 2007 07:44:39 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070418074439.1ba41718@localhost.localdomain>
In-Reply-To: <20070418.012804.95897126.davem@davemloft.net>
References: <20070417.130929.59470175.davem@davemloft.net>
	<20070417133723.00031f82@mini> <4625BE2C.1030801@sw.ru>
	<20070418.012804.95897126.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [BRIDGE] Unaligned access on IA64 when comparing
 ethernet addresses
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, xemul@sw.ru, devel@openvz.org, bridge@lists.osdl.org

On Wed, 18 Apr 2007 01:28:04 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Pavel Emelianov <xemul@sw.ru>
> Date: Wed, 18 Apr 2007 10:43:56 +0400
> 
> > [snip]
> > 
> > > --- linux-2.6.orig/net/bridge/br_private.h	2007-04-17
> > > 13:26:48.000000000 -0700 +++ linux-2.6/net/bridge/br_private.h
> > > 2007-04-17 13:30:29.000000000 -0700 @@ -36,7 +36,7 @@
> > >  {
> > >  	unsigned char	prio[2];
> > >  	unsigned char	addr[6];
> > > -};
> > > +} __attribute__((aligned(8)));
> > 
> > Why "8"? Mustn't it be "16"? Address is to be 2-bytes aligned...
> 
> Actually it could be made "2", the aligned() attribute is
> in bytes, not bits.

It could be 2 but 8 might allow a compiler on a 64 bit platform
to be smarter in comparisons and assignments. For 2.6.22, I'll make
a nicer version similar to ktime_t.
