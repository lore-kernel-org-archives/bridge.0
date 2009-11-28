Date: Fri, 27 Nov 2009 21:38:24 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20091127213824.53c5a23a@nehalam>
In-Reply-To: <20091127.161957.243886653.davem@davemloft.net>
References: <20091113195201.11184.25766.stgit@mimic.site>
	<20091113132728.0f1db7c5@s6510> <200911280043.58784.arnd@arndb.de>
	<20091127.161957.243886653.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 0/3] macvlan: support for guest vm direct rx/tx
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: arnd@arndb.de, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, alacrityvm-devel@lists.sourceforge.net, pmullaney@novell.com

On Fri, 27 Nov 2009 16:19:57 -0800 (PST)
David Miller <davem@davemloft.net> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> Date: Sat, 28 Nov 2009 00:43:58 +0100
> 
> > On Friday 13 November 2009, Stephen Hemminger wrote:
> >> Also, macvlan should really being calling netif_receive_skb()
> >> not going through another queue/softirq cycle.
> > 
> > I've added a patch for this in my experimental queue now.
> > When I last tried this, I saw a kernel stack overflow
> > but it seems fine now.
> 
> I think it is unwise for any virtual device layer to use netif_receive_skb().
> Just like tunnels they should always use netif_rx().
> 
> Otherwise stack overflow is a very real concern.

Maybe we should figure out a way for protocols to return new skb in netif_receive_skb
to avoid extra softirq, but avoid stack overflow?

-- 
