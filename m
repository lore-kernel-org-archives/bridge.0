Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4E1BB4047D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 67F454016A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=TiSbYoSDE0lMlfqj+l2CCSMOXHr+cfG4LYMnjViLfKg=;
 b=iZgloJtbC+6whSU9AepPlzjoWEwtuEoHIfHnGtNlQ4C7UtGfnEEmVwBmNUQ+hp8QPE
 srctWeLgf/fotpb89l8rI9lg4mQnr87w7+3vinjVE3RJNZRD0kzVD+wvsw7UaK+t8/s1
 st8AI91D07QbVN2WkuVWV8CPl3yJX9BZwJFdkx0W5TdbJV2D1CKOCqCSvlq6wN6RqaPf
 UUjR7td8tkJqcXdBiPbDT5qzW5f7hWK/dJbmdUy1js1wwVwqnvzOz88LxLXf05GrHzur
 AKLeY/3k9Tub41UOdBMxbshm3a3Agu7xGvCJZt+FuehosHVD+1D5nfFrAlxRw5PKNxdD
 XPoQ==
Date: Wed, 6 Jul 2022 11:55:59 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220706085559.oyvzijcikivemfkg@skbuf>
References: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
 <20220524152144.40527-4-schultz.hans+netdev@gmail.com>
 <20220627180557.xnxud7d6ol22lexb@skbuf>
 <CAKUejP7ugMB9d3MVX3m9Brw12_ocFoT+nuJJucYdQH70kzC7=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKUejP7ugMB9d3MVX3m9Brw12_ocFoT+nuJJucYdQH70kzC7=w@mail.gmail.com>
Subject: Re: [Bridge] [PATCH V3 net-next 3/4] net: dsa: mv88e6xxx:
 mac-auth/MAB implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans S <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 02:26:43PM +0200, Hans S wrote:
> > Dumb question: if you only flush the locked entries at fast age if the
> > port is locked, then what happens with the existing locked entries if
> > the port becomes unlocked before an FDB flush takes place?
> > Shouldn't mv88e6xxx_port_set_lock() call mv88e6xxx_atu_locked_entry_flush()
> > too?
> 
> That was my first thought too, but the way the flags are handled with the mask etc, does so that
> mv88e6xxx_port_set_lock() is called when other flags change. It could be done by the transition
> from locked->unlocked by checking if the port is locked already.

Why does mv88e6xxx_port_set_lock() get called when other flags change?

> On the other hand, the timers will timeout and the entries will be removed anyhow.

> > > +static void mv88e6xxx_atu_locked_entry_timer_work(struct atu_locked_entry *ale)
> >
> > Please find a more adequate name for this function.
> 
> Any suggestions?

Not sure. It depends on whether you leave just the logic to delete a
locked ATU entry, or also the switchdev FDB_DEL_TO_BRIDGE notifier.
In any case, pick a name that reflects what it does. Something with
locked_entry_delete() can't be too wrong.

> > From the discussion with Ido and Nikolay I get the impression that
> > you're not doing the right thing here either, notifying a
> > SWITCHDEV_FDB_DEL_TO_BRIDGE from what is effectively the
> > SWITCHDEV_FDB_DEL_TO_DEVICE handler (port_fdb_del).
> 
> Hmm, my experience tells me that much is opposite the normal
> conventions when dealing with
> locked ports, as there was never switchdev notifications from the
> driver to the bridge before, but
> that is needed to keep ATU and FDB entries in sync.

On delete you mean? So the bridge signals switchdev a deletion of a
locked FDB entry (as I pointed out, this function gets indirectly called
from port_fdb_del), but it won't get deleted until switchdev signals it
back, is what you're saying?

> > Why is the rtnl_unlock() outside the switch statement but the rtnl_lock() inside?
> > Not to mention, the dsa_port_to_bridge_port() call needs to be under rtnl_lock().
> 
> Just a small optimization as I also have another case of the switch
> (only one switch case if
> you didn't notice) belonging to the next patch set regarding dynamic
> ATU entries.

What kind of optimization are you even talking about? Please get rid of
coding patterns like this, sorry.

> > Please, no "if (chiplock) mutex_lock()" hacks. Just lockdep_assert_held(&chip->reg_lock),
> > which serves both for documentation and for validation purposes, ensure
> > the lock is always taken at the caller (which in this case is super easy)
> > and move on.
> 
> As I am calling the function in if statement checks, it would make
> that code more messy, while with
> this approach the function can be called from anywhere. I also looked
> at having two functions, with
> one being a wrapper function taking the lock and calling the other...

There are many functions in mv88e6xxx that require the reg_lock to be
held, there's nothing new or special here.

> >
> > > +
> > > +     if (mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_CTL0, &reg))
> > > +             goto out;
> >
> > It would be good to actually propagate the error to the caller and
> > "locked" via a pass-by-reference bool pointer argument, not just say
> > that I/O errors mean that the port is unlocked.
> 
> Again the wish to be able to call it from if statement checks,.
> 
> > > +     reg &= MV88E6XXX_PORT_ASSOC_VECTOR_PAV_MASK;
> > > +     if (locked) {
> > > +             reg |= MV88E6XXX_PORT_ASSOC_VECTOR_IGNORE_WRONG |
> > > +                     MV88E6XXX_PORT_ASSOC_VECTOR_LOCKED_PORT |
> > > +                     MV88E6XXX_PORT_ASSOC_VECTOR_INT_AGE_OUT |
> > > +                     MV88E6XXX_PORT_ASSOC_VECTOR_HOLD_AT_1;
> >
> > I'd suggest aligning these macros vertically.
> 
> They are according to the Linux kernel coding standard wrt indentation afaik.

Compare:

		reg |= MV88E6XXX_PORT_ASSOC_VECTOR_IGNORE_WRONG |
			MV88E6XXX_PORT_ASSOC_VECTOR_LOCKED_PORT |
			MV88E6XXX_PORT_ASSOC_VECTOR_INT_AGE_OUT |
			MV88E6XXX_PORT_ASSOC_VECTOR_HOLD_AT_1;

with:

		reg |= MV88E6XXX_PORT_ASSOC_VECTOR_IGNORE_WRONG |
		       MV88E6XXX_PORT_ASSOC_VECTOR_LOCKED_PORT |
		       MV88E6XXX_PORT_ASSOC_VECTOR_INT_AGE_OUT |
		       MV88E6XXX_PORT_ASSOC_VECTOR_HOLD_AT_1;
