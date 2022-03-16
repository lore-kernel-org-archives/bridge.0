Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ARERQSDKxTIHCnmFYNI1ElJI4Oo2Aq2UKhPNaAbSNg4=;
 b=Sg3427dW092vAOLJR2XEcQ/K29NB/DZt5twKJ8gVmA9TrPScdCEOtwyPlsi4FCZsiQ
 bN6oZmE9p4etd9Y6inAr5Puw1utDZX1rFnBWQ/Kpw1SJwyJvdV92GzUsabqabxxpvrUw
 SuzDuuIWz9zSPEAhmuwzs5F3vzZwI94orfMmhn15cY4No379IIbQ/JRjSzJKRW3gtKKD
 rxnRnwNQyJvEIEh4HtC9XgiNZGXrJ4PnKGxAYhTfEkNyZz1Hr0L41eJNWrJGUv7Avdcz
 DmvCS0goyAE/O66WKrs1t7lWQet5Au9SV2XSJTjXfMpLlMmnET6Qdd40ZCIJXPmUKBRG
 Fj5A==
Date: Thu, 17 Mar 2022 01:34:47 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220316233447.kwyirxckgancdqmh@skbuf>
References: <20220310142320.611738-1-schultz.hans+netdev@gmail.com>
 <20220310142320.611738-4-schultz.hans+netdev@gmail.com>
 <20220310142836.m5onuelv4jej5gvs@skbuf> <86r17495gk.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86r17495gk.fsf@gmail.com>
Subject: Re: [Bridge] [PATCH net-next 3/3] net: dsa: mv88e6xxx: mac-auth/MAB
 implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, davem@davemloft.net

On Mon, Mar 14, 2022 at 11:46:51AM +0100, Hans Schultz wrote:
> >> @@ -396,6 +414,13 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
> >>  				    "ATU miss violation for %pM portvec %x spid %d\n",
> >>  				    entry.mac, entry.portvec, spid);
> >>  		chip->ports[spid].atu_miss_violation++;
> >> +		if (mv88e6xxx_port_is_locked(chip, chip->ports[spid].port))
> >> +			err = mv88e6xxx_switchdev_handle_atu_miss_violation(chip,
> >> +									    chip->ports[spid].port,
> >> +									    &entry,
> >> +									    fid);
> >
> > Do we want to suppress the ATU miss violation warnings if we're going to
> > notify the bridge, or is it better to keep them for some reason?
> > My logic is that they're part of normal operation, so suppressing makes
> > sense.
> >
> 
> I have been seeing many ATU member violations after the miss violation is
> handled (using ping), and I think it could be considered to suppress the ATU member
> violations interrupts by setting the IgnoreWrongData bit for the
> port (sect 4.4.7). This would be something to do whenever a port is set in locked mode?

So the first packet with a given MAC SA triggers an ATU miss violation
interrupt.

You program that MAC SA into the ATU with a destination port mask of all
zeroes. This suppresses further ATU miss interrupts for this MAC SA, but
now generates ATU member violations, because the MAC SA _is_ present in
the ATU, but not towards the expected port (in fact, towards _no_ port).

Especially if user space decides it doesn't want to authorize this MAC
SA, it really becomes a problem because this is now a vector for denial
of service, with every packet triggering an ATU member violation
interrupt.

So your suggestion is to set the IgnoreWrongData bit on locked ports,
and this will suppress the actual member violation interrupts for
traffic coming from these ports.

So if the user decides to unplug a previously authorized printer from
switch port 1 and move it to port 2, how is this handled? If there isn't
a mechanism in place to delete the locked FDB entry when the printer
goes away, then by setting IgnoreWrongData you're effectively also
suppressing migration notifications.

Oh, btw, my question was: could you consider suppressing the _prints_ on
an ATU miss violation on a locked port?
