Date: Mon, 26 Apr 2004 08:54:38 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Which NICs are the best for bridges?
Message-Id: <20040426085438.048785f5@dell_ss3.pdx.osdl.net>
In-Reply-To: <D5906FCC-9392-11D8-814D-000502CB9573@bauwut.de>
References: <D5906FCC-9392-11D8-814D-000502CB9573@bauwut.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: christian funk <c.funk@bauwut.de>
Cc: bridge@lists.osdl.org

On Wed, 21 Apr 2004 14:53:06 +0200
christian funk <c.funk@bauwut.de> wrote:

> Hello,
> 
> I seem to remember seeing a notice about NICs with RealTek Chips 
> (specifically those using the 8139 Chip) being unstable and slow. This 
> notice has since vanished (removed or reworded?).

They have problems in 2.4 because they have a relatively small receive
buffer (32k), and need to copy the data into socket buffers during the
receive interrupt.  The 2.6 driver uses NAPI, so the interrupt load should
be less, and allocation/copying doesn't happen with interrupts disabled.

> Can someone tell me if this problem has been fixed, or suggest stable 
> (and fast) NICs I could use instead. My options seem to be Intel, 
> VIA-Rhine or RealTek 8139C based models only.
> 
> I'm trying to set up a box that will support multiple independent 
> bridges, i.e. with 4 or more dedicated hardware interfaces. 4 Port NICs 
> would be great for this, but since they are expensive, it would be nice 
> to know if they work, before buying them.

My experience with Intel cards has been good, the new e100 driver is
much cleaner better than the old 2.4 driver. The eepro driver seems to
work as well, but it is pretty much unmaintained.

> Thanks
> 
> Christian Funk
> 
> 
> 
