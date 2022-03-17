Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=jWX0ErRmdHl2MMr3l9xYOPX3cELcq3q9BO5puqjFVX8=; b=rwgF0iK79Q1WES0TwTF6Ir0PLT
 ZAX1ts7rE4L6FXuSKGFW/iMq3a/kmMpKhRBLRIO8lbMI16pgg+qwNyy5P3rWfM8+zFDH3HL1hE1uB
 BqidmqRKl250oRAnoskdS4eeJbusyXueReOuCmq1m48tLaxWG1KIxLCpg+0Ve1PuwCyw=;
Date: Thu, 17 Mar 2022 15:19:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <YjNDgnrYaYfviNTi@lunn.ch>
References: <20220310142320.611738-1-schultz.hans+netdev@gmail.com>
 <20220310142320.611738-4-schultz.hans+netdev@gmail.com>
 <20220310142836.m5onuelv4jej5gvs@skbuf> <86r17495gk.fsf@gmail.com>
 <20220316233447.kwyirxckgancdqmh@skbuf> <86lex9hsg0.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86lex9hsg0.fsf@gmail.com>
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
Cc: Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Thu, Mar 17, 2022 at 09:52:15AM +0100, Hans Schultz wrote:
> On tor, mar 17, 2022 at 01:34, Vladimir Oltean <olteanv@gmail.com> wrote:
> > On Mon, Mar 14, 2022 at 11:46:51AM +0100, Hans Schultz wrote:
> >> >> @@ -396,6 +414,13 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
> >> >>  				    "ATU miss violation for %pM portvec %x spid %d\n",
> >> >>  				    entry.mac, entry.portvec, spid);
> >> >>  		chip->ports[spid].atu_miss_violation++;
> >> >> +		if (mv88e6xxx_port_is_locked(chip, chip->ports[spid].port))
> >> >> +			err = mv88e6xxx_switchdev_handle_atu_miss_violation(chip,
> >> >> +									    chip->ports[spid].port,
> >> >> +									    &entry,
> >> >> +									    fid);
> >> >
> >> > Do we want to suppress the ATU miss violation warnings if we're going to
> >> > notify the bridge, or is it better to keep them for some reason?
> >> > My logic is that they're part of normal operation, so suppressing makes
> >> > sense.
> >> >
> >> 
> >> I have been seeing many ATU member violations after the miss violation is
> >> handled (using ping), and I think it could be considered to suppress the ATU member
> >> violations interrupts by setting the IgnoreWrongData bit for the
> >> port (sect 4.4.7). This would be something to do whenever a port is set in locked mode?
> >
> > So the first packet with a given MAC SA triggers an ATU miss violation
> > interrupt.
> >
> > You program that MAC SA into the ATU with a destination port mask of all
> > zeroes. This suppresses further ATU miss interrupts for this MAC SA, but
> > now generates ATU member violations, because the MAC SA _is_ present in
> > the ATU, but not towards the expected port (in fact, towards _no_ port).
> >
> > Especially if user space decides it doesn't want to authorize this MAC
> > SA, it really becomes a problem because this is now a vector for denial
> > of service, with every packet triggering an ATU member violation
> > interrupt.
> >
> > So your suggestion is to set the IgnoreWrongData bit on locked ports,
> > and this will suppress the actual member violation interrupts for
> > traffic coming from these ports.
> >
> > So if the user decides to unplug a previously authorized printer from
> > switch port 1 and move it to port 2, how is this handled? If there isn't
> > a mechanism in place to delete the locked FDB entry when the printer
> > goes away, then by setting IgnoreWrongData you're effectively also
> > suppressing migration notifications.
> 
> I don't think such a scenario is so realistic, as changing port is not
> just something done casually, besides port 2 then must also be a locked
> port to have the same policy.

I think it is very realistic. It is also something which does not work
is going to cause a lot of confusion. People will blame the printer,
when in fact they should be blaming the switch. They will be rebooting
the printer, when in fact, they need to reboot the switch etc.

I expect there is a way to cleanly support this, you just need to
figure it out.

> The other aspect is that the user space daemon that authorizes catches
> the fdb add entry events and checks if it is a locked entry. So it will
> be up to said daemon to decide the policy, like remove the fdb entry
> after a timeout.
> 
> >
> > Oh, btw, my question was: could you consider suppressing the _prints_ on
> > an ATU miss violation on a locked port?
> 
> As there will only be such on the first packet, I think it should be
> logged and those prints serve that purpose, so I think it is best to
> keep the print.
> If in the future some tests or other can argue for suppressing the
> prints, it is an easy thing to do.

Please use a traffic generator and try to DOS one of your own
switches. Can you?

	  Andrew
