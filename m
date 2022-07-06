Return-Path: <schultz.hans@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8CBFC405BC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EFC33405B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZWNwOHmzSgkdv+jrzNwG3Jf3HDC0HOWhdAu3xXOwiQw=;
 b=UEc387REzaegIG1aRLLdB1AzsmZrVh+gNiHXsWTjXhdaIXBEbre+rDmlWSOlAA1Vld
 n0Fi365KWeLYSBX+ZvnFHrszQbK0H3fENyDsVj1hNCs1nA60BSBR2hEDFNqr5DQRjKky
 dQKlek0AHq7Iep3BhUVCSwjiS+C95AgzcEwlAsJQvMVK2qZDZM1KmmTjrIw1aetJCxLn
 9L0cwUYbN20ajoFd3P7SpdD0MsHuxGIv6DPo+SgijUWVjFMnK9PPyc3BzzpQLmRv+gnh
 BqfJl560A56QoLNEj+y/JpdM6c5AO2jOgPr1mZ33w/p+3qq1lggpAA1ynHhqol0/4hZO
 yzWQ==
MIME-Version: 1.0
References: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
 <20220524152144.40527-4-schultz.hans+netdev@gmail.com>
 <20220627180557.xnxud7d6ol22lexb@skbuf>
 <CAKUejP7ugMB9d3MVX3m9Brw12_ocFoT+nuJJucYdQH70kzC7=w@mail.gmail.com>
 <20220706085559.oyvzijcikivemfkg@skbuf>
 <CAKUejP7gmULyrjqd3b3PiWwi7TJzF4HNuEbmAf25Cqh3w7a1mw@mail.gmail.com>
 <20220706143339.iuwi23ktk53ihhb6@skbuf>
In-Reply-To: <20220706143339.iuwi23ktk53ihhb6@skbuf>
From: Hans S <schultz.hans@gmail.com>
Date: Wed, 6 Jul 2022 17:38:27 +0200
Message-ID: <CAKUejP6NG_X-Bh_xeA2y4Wru2=pxgHaRMdsvMu8NATNxPVeQ7A@mail.gmail.com>
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

On Wed, Jul 6, 2022 at 4:33 PM Vladimir Oltean <olteanv@gmail.com> wrote:
>
> > >> @@ -919,6 +920,9 @@ static void mv88e6xxx_mac_link_down(struct dsa_switch *ds, int port,
> > >>       if (err)
> > >>               dev_err(chip->dev,
> > >>                       "p%d: failed to force MAC link down\n", port);
> > >> +     else
> > >> +             if (mv88e6xxx_port_is_locked(chip, port, true))
> > >> +                     mv88e6xxx_atu_locked_entry_flush(ds, port);
> > >
> > >This is superfluous, is it not? The bridge will transition a port whose
> > >link goes down to BR_STATE_DISABLED, which will make dsa_port_set_state()
> > >fast-age the dynamic FDB entries on the port, which you've already
> > >handled below.
> >
> > I removed this code, but then on link down the locked entries were not
> > cleared out. Something not as thought?
>
> What was the port's STP state before the link down event, and did it
> change after the link down?

The stp state is FORWARDING.

>
> If the STP state wasn't LEARNING or FORWARDING, there weren't supposed
> to be dynamic FDB entries on the port in the first place, so DSA says
> there's nothing to flush, and doesn't call dsa_port_fast_age().
> Are there dynamic FDB entries being installed on a port that isn't
> in a state that's supposed to learn? I guess the answer is yes.
> Is that what you want, or should the locked entries be recorded only in
> the LEARNING or FORWARDING states, otherwise discarded?
>
Learning is off as has been discussed, and I do want the locked
entries to be dynamic in the sense that the driver removes them after
the system ageing time has passed.

>
> What you actually want to say is: "mv88e6xxx_port_set_lock() is also
> called when the DSA port joins a bridge, due to the switchdev attribute
> replay logic present in dsa_port_switchdev_sync_attrs()".
>
> Which, by the way, is logic that you've added yourself, in commit
> b9e8b58fd2cb ("net: dsa: Include BR_PORT_LOCKED in the list of synced
> brport flags") ;)
>
> You are free to return early from mv88e6xxx_port_set_lock() if nothing has
> changed. The DSA layer doesn't keep track of the locked state of the
> port so it cannot deduce whether propagating to the switch driver is
> necessary or not.
>

I think I can safely call mv88e6xxx_atu_locked_entry_flush() from
mv88e6xxx_port_set_lock() when locked is off as the port setup for the
respective port must have been completed successfully.

> > When added they are added with bridge FDB flags: extern_learn offload
> > locked, with a SWITCHDEV_FDB_ADD_TO_BRIDGE event. So they are owned by
> > the driver.
> > When the driver deletes the locked entry the bridge FDB entry is
> > removes by the SWITCHDEV_FDB_DEL_TO_BRIDGE event from the driver. That
> > seems quite fair?
>
> I'm just pointing out that you left other (probably unintended) code
> paths for which the SWITCHDEV_FDB_DEL_TO_BRIDGE notifier is quite
> useless. I haven't yet looked at your newest revision to see what
> changed there.
>

I guess I should add a boolean to tell if
mv88e6xxx_atu_locked_entry_purge() should send a notification or not.
So that port_fdb_del() will not cause a SWITCHDEV_FDB_DEL_TO_BRIDGE
event.

> > > > > Why is the rtnl_unlock() outside the switch statement but the rtnl_lock() inside?
> > > > > Not to mention, the dsa_port_to_bridge_port() call needs to be under rtnl_lock().
> > > >
> > > > Just a small optimization as I also have another case of the switch
> > > > (only one switch case if
> > > > you didn't notice) belonging to the next patch set regarding dynamic
> > > > ATU entries.
> > >
> > > What kind of optimization are you even talking about? Please get rid of
> > > coding patterns like this, sorry.
> > >
> > Right!
>
> Right what? I'm genuinely curious what optimization are you talking about.
>

I am just confirming that what you wrote is correct, e.g. the
"Right!". So I have fixed that. :-)

>
> Just out of curiosity, are you even trying, are you looking at the
> difference using a monospace font?
>
> > Another issue...
> >
> > I have removed the timers as they are superfluous and now just use the
> > worker and jiffies. But I have found that the whole ageing time seems
> > to be broken on the 5.17 kernel I am running. I don't know if it has
> > been fixed, but the ageing timeout is supposed to be given in seconds.
> > Here is the output from various functions after the command "ip link
> > set dev br0 type bridge ageing_time 1500" (that is nominally 1500
> > seconds according to man page!):
> >
> > dsa_switch_ageing_time: ageing_time 10000, ageing_time_min 1000,
> > ageing_time_max 3825000
> > mv88e6xxx_set_ageing_time: set ageing time to 10000
> > br0: failed (err=-34) to set attribute (id=6)
> > dsa_switch_ageing_time: ageing_time 15000, ageing_time_min 1000,
> > ageing_time_max 3825000
> > mv88e6xxx_set_ageing_time: set ageing time to 15000
> >
> > The 15000 set corresponds to 150 seconds! (I hardcoded the dsa
> > ageing_time_min to 1000)
>
> Are you talking about this known problem, that the ageing time values in
> seconds need to be scaled up by a factor of USER_HZ when passed to the
> kernel?
> https://www.spinics.net/lists/netdev/msg672070.html
> https://www.spinics.net/lists/netdev/msg567332.html

It might be so, but there is another factor 10 which might be
regarding topology change as I understand. If I want a ageing timeout
of say 15 or 30 seconds, that hardly seems possible?
