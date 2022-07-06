Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 14C2960FF7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8903660AC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=kphskzMlt6EGchsLTLJYN06q4RV+jKzSIlUUJ5f6N/s=;
 b=kiJAEhvyU8HYk7PpSgzHaFLYXTn/7OXVDlOBX47KDJDXj5MslRjw7rn8DBZiBCjLGs
 jcWYTy9wuVMq8e4m2df56ftn1WSNhNzYxL37mxsH9ylvQmoROjQUazszVpsI3wFvwUM2
 dapH4uQdlt9VqamvOhU1sKLiD13AP4iZh0UoHvV8A8CGJpIKfQEzJiKYRnmhI4lky3IJ
 aiyoPJJBOOyqgK6+1tn0iN6t0ci0SqDXIyN7l7AUUMXhWhc+j26o3mEHtWtOlksgpuFb
 qPb8OPa+t4YbgHaFC1Kcl6+iEgSAAz+46mfgF9NrwXkZIN3Y3JCE5oltktYKY/fG0X3K
 7edA==
Date: Wed, 6 Jul 2022 17:33:39 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220706143339.iuwi23ktk53ihhb6@skbuf>
References: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
 <20220524152144.40527-4-schultz.hans+netdev@gmail.com>
 <20220627180557.xnxud7d6ol22lexb@skbuf>
 <CAKUejP7ugMB9d3MVX3m9Brw12_ocFoT+nuJJucYdQH70kzC7=w@mail.gmail.com>
 <20220706085559.oyvzijcikivemfkg@skbuf>
 <CAKUejP7gmULyrjqd3b3PiWwi7TJzF4HNuEbmAf25Cqh3w7a1mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKUejP7gmULyrjqd3b3PiWwi7TJzF4HNuEbmAf25Cqh3w7a1mw@mail.gmail.com>
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

On Wed, Jul 06, 2022 at 12:12:01PM +0200, Hans S wrote:
> On Wed, Jul 6, 2022 at 10:56 AM Vladimir Oltean <olteanv@gmail.com> wrote:
> >
> > On Tue, Jun 28, 2022 at 02:26:43PM +0200, Hans S wrote:
> > > > Dumb question: if you only flush the locked entries at fast age if the
> > > > port is locked, then what happens with the existing locked entries if
> > > > the port becomes unlocked before an FDB flush takes place?
> > > > Shouldn't mv88e6xxx_port_set_lock() call mv88e6xxx_atu_locked_entry_flush()
> > > > too?
> 
> BTW:
> >> @@ -919,6 +920,9 @@ static void mv88e6xxx_mac_link_down(struct dsa_switch *ds, int port,
> >>       if (err)
> >>               dev_err(chip->dev,
> >>                       "p%d: failed to force MAC link down\n", port);
> >> +     else
> >> +             if (mv88e6xxx_port_is_locked(chip, port, true))
> >> +                     mv88e6xxx_atu_locked_entry_flush(ds, port);
> >
> >This is superfluous, is it not? The bridge will transition a port whose
> >link goes down to BR_STATE_DISABLED, which will make dsa_port_set_state()
> >fast-age the dynamic FDB entries on the port, which you've already
> >handled below.
> 
> I removed this code, but then on link down the locked entries were not
> cleared out. Something not as thought?

What was the port's STP state before the link down event, and did it
change after the link down?

The relevant code in DSA is:

int dsa_port_set_state(struct dsa_port *dp, u8 state, bool do_fast_age)
{
	struct dsa_switch *ds = dp->ds;
	int port = dp->index;

	if (!ds->ops->port_stp_state_set)
		return -EOPNOTSUPP;

	ds->ops->port_stp_state_set(ds, port, state);

	if (!dsa_port_can_configure_learning(dp) ||
	    (do_fast_age && dp->learning)) {
		/* Fast age FDB entries or flush appropriate forwarding database
		 * for the given port, if we are moving it from Learning or
		 * Forwarding state, to Disabled or Blocking or Listening state.
		 * Ports that were standalone before the STP state change don't
		 * need to fast age the FDB, since address learning is off in
		 * standalone mode.
		 */

		if ((dp->stp_state == BR_STATE_LEARNING ||
		     dp->stp_state == BR_STATE_FORWARDING) &&
		    (state == BR_STATE_DISABLED ||
		     state == BR_STATE_BLOCKING ||
		     state == BR_STATE_LISTENING))
			dsa_port_fast_age(dp);
	}

	dp->stp_state = state;

	return 0;
}

If the STP state wasn't LEARNING or FORWARDING, there weren't supposed
to be dynamic FDB entries on the port in the first place, so DSA says
there's nothing to flush, and doesn't call dsa_port_fast_age().
Are there dynamic FDB entries being installed on a port that isn't
in a state that's supposed to learn? I guess the answer is yes.
Is that what you want, or should the locked entries be recorded only in
the LEARNING or FORWARDING states, otherwise discarded?

> > > That was my first thought too, but the way the flags are handled with the mask etc, does so that
> > > mv88e6xxx_port_set_lock() is called when other flags change. It could be done by the transition
> > > from locked->unlocked by checking if the port is locked already.
> >
> > Why does mv88e6xxx_port_set_lock() get called when other flags change?
> 
> That is what seems to happen, but maybe I am wrong. Looking at the dsa
> functions dsa_port_inherit_brport_flags() and
> dsa_port_clear_brport_flags(), they set the mask for which underlying
> function is called, and it looks to me that they call once for all the
> flags: BR_LEARNING, BR_FLOOD, BR_MCAST_FLOOD, BR_BCAST_FLOOD,
> BR_PORT_LOCKED?

What you actually want to say is: "mv88e6xxx_port_set_lock() is also
called when the DSA port joins a bridge, due to the switchdev attribute
replay logic present in dsa_port_switchdev_sync_attrs()".

Which, by the way, is logic that you've added yourself, in commit
b9e8b58fd2cb ("net: dsa: Include BR_PORT_LOCKED in the list of synced
brport flags") ;)

You are free to return early from mv88e6xxx_port_set_lock() if nothing has
changed. The DSA layer doesn't keep track of the locked state of the
port so it cannot deduce whether propagating to the switch driver is
necessary or not.

> > > > From the discussion with Ido and Nikolay I get the impression that
> > > > you're not doing the right thing here either, notifying a
> > > > SWITCHDEV_FDB_DEL_TO_BRIDGE from what is effectively the
> > > > SWITCHDEV_FDB_DEL_TO_DEVICE handler (port_fdb_del).
> > >
> > > Hmm, my experience tells me that much is opposite the normal
> > > conventions when dealing with
> > > locked ports, as there was never switchdev notifications from the
> > > driver to the bridge before, but
> > > that is needed to keep ATU and FDB entries in sync.
> >
> > On delete you mean? So the bridge signals switchdev a deletion of a
> > locked FDB entry (as I pointed out, this function gets indirectly called
> > from port_fdb_del), but it won't get deleted until switchdev signals it
> > back, is what you're saying?
> >
> 
> When added they are added with bridge FDB flags: extern_learn offload
> locked, with a SWITCHDEV_FDB_ADD_TO_BRIDGE event. So they are owned by
> the driver.
> When the driver deletes the locked entry the bridge FDB entry is
> removes by the SWITCHDEV_FDB_DEL_TO_BRIDGE event from the driver. That
> seems quite fair?

I'm just pointing out that you left other (probably unintended) code
paths for which the SWITCHDEV_FDB_DEL_TO_BRIDGE notifier is quite
useless. I haven't yet looked at your newest revision to see what
changed there.

> > > > Why is the rtnl_unlock() outside the switch statement but the rtnl_lock() inside?
> > > > Not to mention, the dsa_port_to_bridge_port() call needs to be under rtnl_lock().
> > >
> > > Just a small optimization as I also have another case of the switch
> > > (only one switch case if
> > > you didn't notice) belonging to the next patch set regarding dynamic
> > > ATU entries.
> >
> > What kind of optimization are you even talking about? Please get rid of
> > coding patterns like this, sorry.
> >
> Right!

Right what? I'm genuinely curious what optimization are you talking about.

> > > > > +
> > > > > +     if (mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_CTL0, &reg))
> > > > > +             goto out;
> > > >
> > > > It would be good to actually propagate the error to the caller and
> > > > "locked" via a pass-by-reference bool pointer argument, not just say
> > > > that I/O errors mean that the port is unlocked.
> > >
> > > Again the wish to be able to call it from if statement checks,.
> > >
> > > > > +     reg &= MV88E6XXX_PORT_ASSOC_VECTOR_PAV_MASK;
> > > > > +     if (locked) {
> > > > > +             reg |= MV88E6XXX_PORT_ASSOC_VECTOR_IGNORE_WRONG |
> > > > > +                     MV88E6XXX_PORT_ASSOC_VECTOR_LOCKED_PORT |
> > > > > +                     MV88E6XXX_PORT_ASSOC_VECTOR_INT_AGE_OUT |
> > > > > +                     MV88E6XXX_PORT_ASSOC_VECTOR_HOLD_AT_1;
> > > >
> > > > I'd suggest aligning these macros vertically.
> > >
> > > They are according to the Linux kernel coding standard wrt indentation afaik.
> >
> > Compare:
> >
> >                 reg |= MV88E6XXX_PORT_ASSOC_VECTOR_IGNORE_WRONG |
> >                         MV88E6XXX_PORT_ASSOC_VECTOR_LOCKED_PORT |
> >                         MV88E6XXX_PORT_ASSOC_VECTOR_INT_AGE_OUT |
> >                         MV88E6XXX_PORT_ASSOC_VECTOR_HOLD_AT_1;
> >
> > with:
> >
> >                 reg |= MV88E6XXX_PORT_ASSOC_VECTOR_IGNORE_WRONG |
> >                        MV88E6XXX_PORT_ASSOC_VECTOR_LOCKED_PORT |
> >                        MV88E6XXX_PORT_ASSOC_VECTOR_INT_AGE_OUT |
> >                        MV88E6XXX_PORT_ASSOC_VECTOR_HOLD_AT_1;
> 
> I cannot see the difference here...?

Just out of curiosity, are you even trying, are you looking at the
difference using a monospace font?

> Another issue...
> 
> I have removed the timers as they are superfluous and now just use the
> worker and jiffies. But I have found that the whole ageing time seems
> to be broken on the 5.17 kernel I am running. I don't know if it has
> been fixed, but the ageing timeout is supposed to be given in seconds.
> Here is the output from various functions after the command "ip link
> set dev br0 type bridge ageing_time 1500" (that is nominally 1500
> seconds according to man page!):
> 
> dsa_switch_ageing_time: ageing_time 10000, ageing_time_min 1000,
> ageing_time_max 3825000
> mv88e6xxx_set_ageing_time: set ageing time to 10000
> br0: failed (err=-34) to set attribute (id=6)
> dsa_switch_ageing_time: ageing_time 15000, ageing_time_min 1000,
> ageing_time_max 3825000
> mv88e6xxx_set_ageing_time: set ageing time to 15000
> 
> The 15000 set corresponds to 150 seconds! (I hardcoded the dsa
> ageing_time_min to 1000)

Are you talking about this known problem, that the ageing time values in
seconds need to be scaled up by a factor of USER_HZ when passed to the
kernel?
https://www.spinics.net/lists/netdev/msg672070.html
https://www.spinics.net/lists/netdev/msg567332.html
