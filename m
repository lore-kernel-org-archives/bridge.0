Message-ID: <564DE4477544D411AD2C00508BDF0B6A1F2EC006@USAHM018.amer.corp.eds.com>
From: "Small, Jim" <jim.small@eds.com>
Subject: RE: [Bridge] Which NICs are the best for bridges?
Date: Wed, 21 Apr 2004 10:04:09 -0400
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: christian funk <c.funk@bauwut.de>, bridge@lists.osdl.org

I believe that the best NICs and driver for Linux Bridging would be the
Intel Gigabit cards and the Intel Gigabit driver.  IMHO, these are simply
the best cards and drivers for any O/S.  Even if you're only doing 100Mbps,
the technology advances and buffering in the Gigabit cards still make them
better.  If you're looking for something a little cheaper, you could try the
Intel 100 Mbps cards which are also excellent.  I do full-duplex 100Mbps
bridging through my Intel 100 Mbps cards and my system hardly breaks a sweat
(only 550 MHz PIII).  I can also tell you that most of the networking
appliances I deal with also use the Intel 100 Mbps cards or chipsets or the
Intel Gigabit ones.  I can tell you from talking with the vendors that this
is not a coincidence.  The Intel products are more expense, but I believe
they're worth it.

As for the RealTek chips, it depends on the card, but I use cards based on
the 8139 and don't have problems with them.  They just don't offer the same
level of performance as the Intel cards.  They are slower and use up more
CPU power.  A lot of people complain about them (not just in Linux) because
of poor documentation and support, but like I said, they work for me.

I can't speak to the VIA-Rhine models, I've never used them.

<> Jim

> -----Original Message-----
> I seem to remember seeing a notice about NICs with RealTek Chips
> (specifically those using the 8139 Chip) being unstable and slow. This
> notice has since vanished (removed or reworded?).
> 
> Can someone tell me if this problem has been fixed, or suggest stable
> (and fast) NICs I could use instead. My options seem to be Intel,
> VIA-Rhine or RealTek 8139C based models only.
> 
> I'm trying to set up a box that will support multiple independent
> bridges, i.e. with 4 or more dedicated hardware interfaces. 4 Port NICs
> would be great for this, but since they are expensive, it would be nice
> to know if they work, before buying them.

