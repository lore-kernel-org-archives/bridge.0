Date: Tue, 25 Jan 2005 22:05:58 -0800
From: "David S. Miller" <davem@davemloft.net>
Message-Id: <20050125220558.6e824f8a.davem@davemloft.net>
In-Reply-To: <1106496509.1085.1.camel@tux.rsn.bth.se>
References: <1131604877.20041218092730@mail.ru.suse.lists.linux.kernel>
	<p73zn0ccaee.fsf@verdi.suse.de>
	<1105117559.11753.34.camel@baythorne.infradead.org>
	<20050107100017.454ddadc@dxpl.pdx.osdl.net>
	<1105133241.3375.16.camel@localhost.localdomain>
	<20050118135735.4b77d38d.davem@davemloft.net>
	<1106433059.4486.11.camel@localhost.localdomain>
	<1106436153.20995.42.camel@tux.rsn.bth.se>
	<1106484019.3376.5.camel@localhost.localdomain>
	<1106496509.1085.1.camel@tux.rsn.bth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH/RFC] Reduce call chain length in netfilter
 (was: Re: do_IRQ: stack overflow: 872..)
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: netdev@oss.sgi.com, bridge@osdl.org, snort2004@mail.ru, bdschuym@pandora.be, rusty@rustcorp.com.au, dwmw2@infradead.org, ak@suse.de, shemminger@osdl.org

On Sun, 23 Jan 2005 17:08:29 +0100
Martin Josefsson <gandalf@wlug.westbo.se> wrote:

> I'm now running a kernel with this patch and everything seems to still
> be working.
> So unless someone else has something to comment I think this should be
> applied.
> The decrease in call-depth is important.

I would like to see at least one ACK from the netfilter
folks.  Bart or Rusty, could you forward to patch to
netfilter-devel for review?

I have some other ideas about how bridging might be able
to save some call chain depth... but I need to think about
it some more before proposing or even trying to implement.
(basically something akin to how we do route level packet
 output, via dst_output(), but instead we're doing this
 at ->hard_start_xmit() time)
