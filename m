From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 28 Nov 2009 00:43:58 +0100
References: <4AFAD86A.9070506@trash.net>
	<20091113195201.11184.25766.stgit@mimic.site>
	<20091113132728.0f1db7c5@s6510>
In-Reply-To: <20091113132728.0f1db7c5@s6510>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200911280043.58784.arnd@arndb.de>
Subject: Re: [Bridge] [PATCH 0/3] macvlan: support for guest vm direct rx/tx
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, alacrityvm-devel@lists.sourceforge.net, Patrick Mullaney <pmullaney@novell.com>

On Friday 13 November 2009, Stephen Hemminger wrote:
> Also, macvlan should really being calling netif_receive_skb()
> not going through another queue/softirq cycle.

I've added a patch for this in my experimental queue now.
When I last tried this, I saw a kernel stack overflow
but it seems fine now.

I wonder if we can also return from the macvlan hook with
skb->dev changed to netif_receive_skb rather than calling it
recursively.

	Arnd <><
