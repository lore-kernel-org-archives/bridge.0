From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 10 Aug 2009 17:23:10 +0200
References: <0199E0D51A61344794750DC57738F58E67D2DCECBB@GVW1118EXC.americas.hpqcorp.net>
	<200908071329.44437.arnd@arndb.de>
	<005101ca1797$70dcf5b0$5296e110$@edu>
In-Reply-To: <005101ca1797$70dcf5b0$5296e110$@edu>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200908101723.10832.arnd@arndb.de>
Subject: Re: [Bridge] [evb] Re: [PATCH][RFC] net/bridge: add basic VEPA
	support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: evb@yahoogroups.com
Cc: "'Fischer, Anna'" <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 'Or Gerlitz' <ogerlitz@voltaire.com>, adobriyan@gmail.com, davem@davemloft.net

On Friday 07 August 2009, Paul Congdon (UC Davis) wrote:
> 
> I don't think your scheme works too well because broadcast packet coming
> from other interfaces on br0 would get replicated and sent across the wire
> to ethB multiple times.

Right, that won't work. So the bridge patch for the hairpin turn
is still the best solution. Btw, how will that interact with
the bride-netfilter (ebtables) setup? Can you apply any filters
that work on current bridges also between two VEPA ports while
doing the hairpin turn?

	Arnd <><
