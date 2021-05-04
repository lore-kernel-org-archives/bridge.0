Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=XS9eVQQm0ICA5clq7aGO+GeBxT02cu0PyE0FYwLbSn0=;
 b=KRZJRmSFkpfNmsXGHBLowNForVyQalqpK2f3Smci2Be07uF52HFbmgCnclGxRYM1Fs
 gJhFFkRrIMe1AVE4ZP+T0MonB3c+o8xTChaJ7EEeWw91ONXnKg26OQumIH7JyaCRLX7E
 2qUJ0eJS8PbhV1+osyUsDALyMB4NJYvfSqxrUXEVjvHM0QuMj1tQyTtrh2u+F0SRhb55
 gb/VNqVd6JYM7ElLiCWM0DUkCpUgV8OYti8XNvLOt85hQEv2qChMjO/Tj/sd6CAcRrnW
 KSl6tx6X1W90X1G3UuWQr25hg17UheGN0HkyBaEh7NJnyCgYodsGME13IN7JD3+Dd7wQ
 LPkQ==
Date: Wed, 5 May 2021 02:04:09 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210504230409.kohxoc4cl7sjpkrg@skbuf>
References: <20210426170411.1789186-1-tobias@waldekranz.com>
 <20210426170411.1789186-7-tobias@waldekranz.com>
 <20210427101747.n3y6w6o7thl5cz3r@skbuf>
 <878s4uo8xc.fsf@waldekranz.com>
 <20210504152106.oppawchuruapg4sb@skbuf>
 <874kfintzh.fsf@waldekranz.com>
 <20210504205823.j5wg547lgyw776rl@skbuf>
 <87y2cum9mo.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2cum9mo.fsf@waldekranz.com>
Subject: Re: [Bridge] [RFC net-next 6/9] net: dsa: Forward offloading
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, vivien.didelot@gmail.com, idosch@idosch.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

On Wed, May 05, 2021 at 12:12:15AM +0200, Tobias Waldekranz wrote:
> > and you create a dependency between the tagger and the switch driver
> > which was supposed by design to not exist.
> 
> Sure, but _why_ should it not exist? Many fields in the tag can only be
> correctly generated/interpreted in combination with knowledge of the
> current configuration, which is the driver's domain. The dependency is
> already there, etched in silicon.

I'm a bit more of a pragmatic person, it's not so much that I think that
Lennert Buytenhek's original DSA design from 2008 was the holy grail and
that we should do everything we can to preserve it intact. Far from it.
But I actually like having the option to inject a DSA-tagged packet
using Spirent TestCenter and measure IP forwarding between dsa_loop
"switch" ports (actually a one-armed router is what it is). I also like,
as a reviewer, to be able to test, if I want to, how a tail tagger
behaves even if I don't own a switch with tail tagging. And this
separation between the switch driver and the tag protocol driver makes
that possible, just see it as a nice perk which we don't want to lose.

As for more advanced features, like "the hardware requires me to invent
a unique number based on a rolling counter, call it a TX timestamp ID,
put it in the DSA header, then when transmission is done, an IRQ will be
raised, and I need to match that TX timestamp that just became available
to me, which is identifiable via the timestamp ID that I put in the DSA
header, with the original skb", of course you can't do that without
communication between the tagger and the driver itself, unless you make
the tagger handle interrupts (and then there's the whole issue that the
tagging protocol driver needs to be instantiated per switch, if it's
going to be stateful), or the switch driver send packets. As a general
rule of thumb, just don't break dsa_loop and we should be fine. For
example, yes, PTP requires driver <-> tagger communication, but PTP
timestamping is also not enabled by default, and guarded by an ioctl
which dsa_loop doesn't implement. So the tagger can never trigger faulty
code, dereferencing a ds->priv pointer which it thinks is "struct
mv88e6xxx_chip" but is actually "struct dsa_loop_priv".
