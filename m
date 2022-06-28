Return-Path: <schultz.hans@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D395E60EBC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BEF3260759
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BBbAz4nN/kEqq17Hkjd67PQhLHR+U0drfdLc0GuJOK0=;
 b=cxtKJCUSVEzVJj+iL4lJVQDHlo8KUSad6DH1tB6D4RVSogOwanBgqMd0a7/CM6A31q
 YX6ICf9+Kg67EFa+6e3LOOIUc51JeiXLQ9jHtvpbY6f/EeXvVQyNfCSgbsTfp7Tb4+lW
 PQZGbz0YrR5kLAldX7FCEF6OdyAUzit/IVw3pTBMv8kAER4StE17ex6WXGbi2FOm7f6U
 T2ExIT3Za05kRaSn3Aar/nOm+pL/BXFjj19AwqbAneKuNWrj4lX/Yg+V3QSq5GSf65Ux
 FurUnaV109XZAmrnMLufxcIQFk2Mgw1IbIoBETKMpQrcIzsTJkCXK1LjLeSGeyOklGXv
 clqQ==
MIME-Version: 1.0
References: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
 <20220524152144.40527-4-schultz.hans+netdev@gmail.com>
 <20220627180557.xnxud7d6ol22lexb@skbuf>
In-Reply-To: <20220627180557.xnxud7d6ol22lexb@skbuf>
From: Hans S <schultz.hans@gmail.com>
Date: Tue, 28 Jun 2022 14:26:43 +0200
Message-ID: <CAKUejP7ugMB9d3MVX3m9Brw12_ocFoT+nuJJucYdQH70kzC7=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 8:06 PM Vladimir Oltean <olteanv@gmail.com> wrote:
>
> Hi Hans,
>
> On Tue, May 24, 2022 at 05:21:43PM +0200, Hans Schultz wrote:
> > This implementation for the Marvell mv88e6xxx chip series, is
> > based on handling ATU miss violations occurring when packets
> > ingress on a port that is locked. The mac address triggering
> > the ATU miss violation is communicated through switchdev to
> > the bridge module, which adds a fdb entry with the fdb locked
> > flag set. The entry is kept according to the bridges ageing
> > time, thus simulating a dynamic entry.
> >
> > Note: The locked port must have learning enabled for the ATU
> > miss violation to occur.
> >
> > Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
> > ---
>
> I'm sorry that I couldn't focus on the big picture of this patch,
> but locking is an absolute disaster and I just stopped after a while,
> it's really distracting :)

The code works, but I think that we should "undisaster" it. :)

>
> Would you mind addressing the feedback below first, and I'll take
> another look when you send v4?

fine :)

> >       if (err)
> >               dev_err(chip->dev,
> >                       "p%d: failed to force MAC link down\n", port);
> > +     else
> > +             if (mv88e6xxx_port_is_locked(chip, port, true))
> > +                     mv88e6xxx_atu_locked_entry_flush(ds, port);
>
> This is superfluous, is it not? The bridge will transition a port whose
> link goes down to BR_STATE_DISABLED, which will make dsa_port_set_state()
> fast-age the dynamic FDB entries on the port, which you've already
> handled below.

I guess you are right.


> >  }
> >
> >  static void mv88e6xxx_mac_link_up(struct dsa_switch *ds, int port,
> > @@ -1685,6 +1689,9 @@ static void mv88e6xxx_port_fast_age(struct dsa_switch *ds, int port)
> >       struct mv88e6xxx_chip *chip = ds->priv;
> >       int err;
> >
> > +     if (mv88e6xxx_port_is_locked(chip, port, true))
> > +             mv88e6xxx_atu_locked_entry_flush(ds, port);
> > +
>
> Dumb question: if you only flush the locked entries at fast age if the
> port is locked, then what happens with the existing locked entries if
> the port becomes unlocked before an FDB flush takes place?
> Shouldn't mv88e6xxx_port_set_lock() call mv88e6xxx_atu_locked_entry_flush()
> too?

That was my first thought too, but the way the flags are handled with
the mask etc, does so that
mv88e6xxx_port_set_lock() is called when other flags change. It could
be done by the transition
from locked->unlocked by checking if the port is locked already.
On the other hand, the timers will timeout and the entries will be
removed anyhow.

> > +     if (mv88e6xxx_port_is_locked(chip, port, true))
> > +             mv88e6xxx_atu_locked_entry_find_purge(ds, port, addr, vid);
> > +
> >       mv88e6xxx_reg_lock(chip);
> >       err = mv88e6xxx_port_db_load_purge(chip, port, addr, vid,
> > -                                        MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC);
> > +                     MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC);
>
> Unrelated and unjustified change.
>
Ups, missed that one.

> >  static int mv88e6xxx_port_setup(struct dsa_switch *ds, int port)
> >  {
> > -     return mv88e6xxx_setup_devlink_regions_port(ds, port);
> > +     int err;
> > +
> > +     err = mv88e6xxx_setup_devlink_regions_port(ds, port);
> > +     mv88e6xxx_init_violation_handler(ds, port);
>
> What's with this quirky placement? You need to do error checking and
> call mv88e6xxx_teardown_violation_handler() if setting up the devlink
> port regions fails, otherwise the port will fail to probe but no one
> will quiesce its delayed ATU work.

Yes, of course.

> By the way, do all mv88e6xxx switches support 802.1X and MAC Auth Bypass,
> or do we need to initialize these structures depending on some capability?

I will have to look into that, but I think they all do support these features.

> > +     err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_ATU_OP,
> > +                              MV88E6XXX_G1_ATU_OP_BUSY | MV88E6XXX_G1_ATU_OP_GET_CLR_VIOLATION);
>
> Split on 3 lines please.

OK.

> > +     if (err)
> > +             return err;
> > +
> > +     return mv88e6xxx_g1_atu_op_wait(chip);
> > +}
> > +
> >  static int mv88e6xxx_g1_atu_op(struct mv88e6xxx_chip *chip, u16 fid, u16 op)
> >  {
> >       u16 val;
> > @@ -356,11 +370,11 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
> >       int spid;
> >       int err;
> >       u16 val;
> > +     u16 fid;
> >
> >       mv88e6xxx_reg_lock(chip);
> >
> > -     err = mv88e6xxx_g1_atu_op(chip, 0,
> > -                               MV88E6XXX_G1_ATU_OP_GET_CLR_VIOLATION);
> > +     err = mv88e6xxx_g1_read_atu_violation(chip);
>
> I cannot comment on the validity of this change: previously, we were
> writing FID 0 as part of mv88e6xxx_g1_atu_op(), now we are reading back
> the FID. Definitely too much going on in a single change, this needs a
> separate patch with an explanation.

It is of course needed to read the fid and I couldn't really
understand the reasoning behind how it was before,
but I will do as you say as best I can.

>
> >       if (err)
> >               goto out;
> >
> > @@ -368,6 +382,10 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
> >       if (err)
> >               goto out;
> >
> > +     err = mv88e6xxx_g1_read(chip, MV88E6352_G1_ATU_FID, &fid);
> > +     if (err)
> > +             goto out;
>
> Is it ok to read the MV88E6352_G1_ATU_FID register from an IRQ handler
> common for all switches, I wonder?

I don't know about the naming of this define (I probably overlooked
the 6352 part), but it is the same as I have in the
spec for 6097, and I don't see any alternative...

> > +
> >       err = mv88e6xxx_g1_atu_data_read(chip, &entry);
> >       if (err)
> >               goto out;
> > @@ -382,6 +400,11 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
> >               dev_err_ratelimited(chip->dev,
> >                                   "ATU age out violation for %pM\n",
> >                                   entry.mac);
> > +             err = mv88e6xxx_handle_violation(chip,
> > +                                              chip->ports[spid].port,
>
> Dumb question: isn't chip->ports[spid].port == spid?

Probably you are right.

>
> > +                                              &entry,
> > +                                              fid,
> > +                                              MV88E6XXX_G1_ATU_OP_AGE_OUT_VIOLATION);
>
> This fits on 3 lines instead of 5 (and same below).

OK

>
> > +static void mv88e6xxx_atu_locked_entry_timer_work(struct atu_locked_entry *ale)
>
> Please find a more adequate name for this function.

Any suggestions?

>
> > +{
> > +     struct switchdev_notifier_fdb_info info = {
> > +             .addr = ale->mac,
> > +             .vid = ale->vid,
> > +             .added_by_user = false,
> > +             .is_local = false,
>
> No need to have an initializer for the false members.

OK

> > +             .offloaded = true,
> > +             .locked = true,
> > +     };
> > +     struct mv88e6xxx_atu_entry entry;
> > +     struct net_device *brport;
> > +     struct dsa_port *dp;
> > +
> > +     entry.state = MV88E6XXX_G1_ATU_DATA_STATE_UC_UNUSED;
> > +     entry.trunk = false;
> > +     memcpy(&entry.mac, &ale->mac, ETH_ALEN);
>
> ether_addr_copy
>
> > +
> > +     mv88e6xxx_reg_lock(ale->chip);
> > +     mv88e6xxx_g1_atu_loadpurge(ale->chip, ale->fid, &entry);
>
> The portvec will be junk memory that's on stack, is that what you want?
>
Probably not what I want.

> > +     if (brport) {
> > +             if (!rtnl_is_locked()) {
> > +                     rtnl_lock();
>
> No, no, no, no, no, no, no.
>
> As I've explained already:
> https://patchwork.kernel.org/project/netdevbpf/patch/20220317093902.1305816-4-schultz.hans+netdev@gmail.com/#24782974
> dsa_port_to_bridge_port() needs to be called with the rtnl_mutex held.
>
> Please take a moment to figure out which function expects which lock and
> for what operation, then draw a call graph, figure out a consistent lock
> hierarchy where things are always acquired in the same order, and if a
> function needs a locking context but not all callers offer it, put an
> ASSERT_RTNL() (for example) and transfer the locking responsibility to
> the caller.

As I remember it was because mv88e6xxx_atu_locked_entry_flush() was called both
with and without the lock, but there was something I didn't know about
how link down
handling works.

>
> Doing this will also help you name your functions better than
> "locked entry timer work" (which are called from... drum roll...
> mv88e6xxx_port_fdb_del and mv88e6xxx_port_fast_age).
>
> Which by the way, reminds me that.....
> You can't take rtnl_lock() from port_fdb_add() and port_fdb_del(),
> see commits d7d0d423dbaa ("net: dsa: flush switchdev workqueue when
> leaving the bridge") and 0faf890fc519 ("net: dsa: drop rtnl_lock from
> dsa_slave_switchdev_event_work"), as you'll deadlock with
> dsa_port_pre_bridge_leave(). In fact you never could, but for a slightly
> different reason.
>
> From the discussion with Ido and Nikolay I get the impression that
> you're not doing the right thing here either, notifying a
> SWITCHDEV_FDB_DEL_TO_BRIDGE from what is effectively the
> SWITCHDEV_FDB_DEL_TO_DEVICE handler (port_fdb_del).

Hmm, my experience tells me that much is opposite the normal
conventions when dealing with
locked ports, as there was never switchdev notifications from the
driver to the bridge before, but
that is needed to keep ATU and FDB entries in sync.

>
> No inline functions in .c files.

OK

> Nasty lock ordering inversion. In mv88e6xxx_handle_violation() we take
> &dp->locked_entries_list_lock with mv88e6xxx_reg_lock() held.
> Here (in mv88e6xxx_atu_locked_entry_timer_work called from here) we take
> mv88e6xxx_reg_lock() with &dp->locked_entries_list_lock held.
>
I will look into that.

> > +     switch (type) {
> > +     case MV88E6XXX_G1_ATU_OP_MISS_VIOLATION:
> > +             if (atomic_read(&dp->atu_locked_entry_cnt) >= ATU_LOCKED_ENTRIES_MAX) {
> > +                     mv88e6xxx_reg_unlock(chip);
>
> You call mv88e6xxx_reg_lock() from mv88e6xxx_g1_atu_prob_irq_thread_fn()
> and mv88e6xxx_reg_unlock() from mv88e6xxx_handle_violation()? Nice!
>
> And I understand why that is: to avoid a lock ordering inversion with
> rtnl_lock(). Just unlock the mv88e6xxx registers after the last hardware
> access in mv88e6xxx_g1_atu_prob_irq_thread_fn() - after mv88e6xxx_g1_atu_mac_read(),
> and call mv88e6xxx_handle_violation() with the registers unlocked, and
> lock them when you need them.

OK.

> > +             locked_entry = kmalloc(sizeof(*locked_entry), GFP_ATOMIC);
>
> Please be consistent in your naming of struct atu_locked_entry
> variables, be they "locked_entry" or "ale" or otherwise.
> And please create a helper function that creates such a structure and
> initializes it.

OK

> > +             if (!locked_entry)
> > +                     return -ENOMEM;
> > +             timer_setup(&locked_entry->timer, mv88e6xxx_atu_locked_entry_timer_handler, 0);
>
> Does this have to be a dedicated timer per entry, or can you just record
> the "jiffies" at creation time per locked entry, and compare it with the
> current jiffies from the periodic, sleepable mv88e6xxx_atu_locked_entry_cleanup?

I think that approach should be sufficient too.

>
> Why is the rtnl_unlock() outside the switch statement but the rtnl_lock() inside?
> Not to mention, the dsa_port_to_bridge_port() call needs to be under rtnl_lock().

Just a small optimization as I also have another case of the switch
(only one switch case if
you didn't notice) belonging to the next patch set regarding dynamic
ATU entries.

> > +void mv88e6xxx_atu_locked_entry_flush(struct dsa_switch *ds, int port)
> > +{
> > +     struct dsa_port *dp = dsa_to_port(ds, port);
> > +     struct atu_locked_entry *ale, *tmp;
> > +
> > +     mutex_lock(&dp->locked_entries_list_lock);
> > +     list_for_each_entry_safe(ale, tmp, &dp->atu_locked_entries_list, list) {
> > +             mv88e6xxx_atu_locked_entry_purge(ale);
> > +             atomic_dec(&dp->atu_locked_entry_cnt);
> > +     }
> > +     mutex_unlock(&dp->locked_entries_list_lock);
> > +
> > +     if (atomic_read(&dp->atu_locked_entry_cnt) != 0)
> > +             dev_err(ds->dev,
> > +                     "ERROR: Locked entries count is not zero after flush on port %d\n",
> > +                     port);
>
> And generally speaking, why would you expect it to be 0, since there's
> nothing that stops this check from racing with mv88e6xxx_handle_violation?

I guess you are right that when setting the port STP state to BLOCKED, there is
the potential race you mention.

> Also, random fact: no need to say ERROR when printing with the KERN_ERR
> log level. It's kind of implied from the log level.

Of course.

> > +     dp->atu_locked_entry_cnt.counter = 0;
>
> atomic_set()

Right!

> This and mv88e6xxx_switchdev.c are the only source files belonging to
> this driver which have the mv88e6xxx_ prefix (others are "chip.c" etc).
> Can you please follow the convention?

Yes. I think I got that idea from some other driver, thus avoiding
switchdev.h file,
but I will change it.

> > +struct atu_locked_entry {
>
> mv88e6xxx driver specific structure names should be prefixed with mv88e6xxx_.

OK

> > +     u8      mac[ETH_ALEN];
>
> Either align everything with tabs, or nothing.

Ups.

> > +int mv88e6xxx_handle_violation(struct mv88e6xxx_chip *chip,
> > +                            int port,
> > +                            struct mv88e6xxx_atu_entry *entry,
> > +                            u16 fid,
> > +                            u16 type);
>
> Both this and the function definition can easily fit on 3 lines.

OK

> Please, no "if (chiplock) mutex_lock()" hacks. Just lockdep_assert_held(&chip->reg_lock),
> which serves both for documentation and for validation purposes, ensure
> the lock is always taken at the caller (which in this case is super easy)
> and move on.

As I am calling the function in if statement checks, it would make
that code more messy, while with
this approach the function can be called from anywhere. I also looked
at having two functions, with
one being a wrapper function taking the lock and calling the other...

>
> > +
> > +     if (mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_CTL0, &reg))
> > +             goto out;
>
> It would be good to actually propagate the error to the caller and
> "locked" via a pass-by-reference bool pointer argument, not just say
> that I/O errors mean that the port is unlocked.

Again the wish to be able to call it from if statement checks,.

> > +     reg &= MV88E6XXX_PORT_ASSOC_VECTOR_PAV_MASK;
> > +     if (locked) {
> > +             reg |= MV88E6XXX_PORT_ASSOC_VECTOR_IGNORE_WRONG |
> > +                     MV88E6XXX_PORT_ASSOC_VECTOR_LOCKED_PORT |
> > +                     MV88E6XXX_PORT_ASSOC_VECTOR_INT_AGE_OUT |
> > +                     MV88E6XXX_PORT_ASSOC_VECTOR_HOLD_AT_1;
>
> I'd suggest aligning these macros vertically.

They are according to the Linux kernel coding standard wrt indentation afaik.
