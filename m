Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=HxUeSdGHysXOMNj7ndmz0JsD2WLzOVjkjS4jpm5x5L4=;
 b=ONBADXpQfFnBwI/HO72Q/6AG/ASMlBgbhoiIT2SEm69C24LsJKyTc/BpLdOG5Fn4v5
 oQtIXjwZwAyp+HL20Z3DUhNe7lFWMhV1dYf1ktKxXp2eYVI/A2yxMRjNnAPHgNAZ1Fff
 VE92MRjmt864SJPDSoH6tXkVZOfIj6a8+4K7SjAvCamIIU73iwF1N2Hqe7iHofTwkq6i
 HtlBzvggVu1+SmmQCUKBhZpITJvbowY8EDpSFYGixhshnkvcO64VrFfOQY83t2txtlCP
 0C/1oMc5QVmSDf05d4pVXGRsMf7R9NxtLpgIA1wz0KCupYrJymTMcXr/aB6XUobdrHjI
 Oufw==
From: Hans Schultz <schultz.hans@gmail.com>
In-Reply-To: <20220317153625.2ld5zgtuhoxbcgvo@skbuf>
References: <20220310142320.611738-1-schultz.hans+netdev@gmail.com>
 <20220310142320.611738-4-schultz.hans+netdev@gmail.com>
 <20220310142836.m5onuelv4jej5gvs@skbuf> <86r17495gk.fsf@gmail.com>
 <20220316233447.kwyirxckgancdqmh@skbuf> <86lex9hsg0.fsf@gmail.com>
 <YjNDgnrYaYfviNTi@lunn.ch> <20220317153625.2ld5zgtuhoxbcgvo@skbuf>
Date: Thu, 17 Mar 2022 17:07:15 +0100
Message-ID: <86ilscr2a4.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Hans Schultz <schultz.hans@gmail.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, davem@davemloft.net, Nikolay Aleksandrov <razor@blackwall.org>

On tor, mar 17, 2022 at 17:36, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Thu, Mar 17, 2022 at 03:19:46PM +0100, Andrew Lunn wrote:
>> On Thu, Mar 17, 2022 at 09:52:15AM +0100, Hans Schultz wrote:
>> > On tor, mar 17, 2022 at 01:34, Vladimir Oltean <olteanv@gmail.com> wrote:
>> > > On Mon, Mar 14, 2022 at 11:46:51AM +0100, Hans Schultz wrote:
>> > >> >> @@ -396,6 +414,13 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
>> > >> >>  				    "ATU miss violation for %pM portvec %x spid %d\n",
>> > >> >>  				    entry.mac, entry.portvec, spid);
>> > >> >>  		chip->ports[spid].atu_miss_violation++;
>> > >> >> +		if (mv88e6xxx_port_is_locked(chip, chip->ports[spid].port))
>> > >> >> +			err = mv88e6xxx_switchdev_handle_atu_miss_violation(chip,
>> > >> >> +									    chip->ports[spid].port,
>> > >> >> +									    &entry,
>> > >> >> +									    fid);
>> > >> >
>> > >> > Do we want to suppress the ATU miss violation warnings if we're going to
>> > >> > notify the bridge, or is it better to keep them for some reason?
>> > >> > My logic is that they're part of normal operation, so suppressing makes
>> > >> > sense.
>> > >> >
>> > >> 
>> > >> I have been seeing many ATU member violations after the miss violation is
>> > >> handled (using ping), and I think it could be considered to suppress the ATU member
>> > >> violations interrupts by setting the IgnoreWrongData bit for the
>> > >> port (sect 4.4.7). This would be something to do whenever a port is set in locked mode?
>> > >
>> > > So the first packet with a given MAC SA triggers an ATU miss violation
>> > > interrupt.
>> > >
>> > > You program that MAC SA into the ATU with a destination port mask of all
>> > > zeroes. This suppresses further ATU miss interrupts for this MAC SA, but
>> > > now generates ATU member violations, because the MAC SA _is_ present in
>> > > the ATU, but not towards the expected port (in fact, towards _no_ port).
>> > >
>> > > Especially if user space decides it doesn't want to authorize this MAC
>> > > SA, it really becomes a problem because this is now a vector for denial
>> > > of service, with every packet triggering an ATU member violation
>> > > interrupt.
>> > >
>> > > So your suggestion is to set the IgnoreWrongData bit on locked ports,
>> > > and this will suppress the actual member violation interrupts for
>> > > traffic coming from these ports.
>> > >
>> > > So if the user decides to unplug a previously authorized printer from
>> > > switch port 1 and move it to port 2, how is this handled? If there isn't
>> > > a mechanism in place to delete the locked FDB entry when the printer
>> > > goes away, then by setting IgnoreWrongData you're effectively also
>> > > suppressing migration notifications.
>> > 
>> > I don't think such a scenario is so realistic, as changing port is not
>> > just something done casually, besides port 2 then must also be a locked
>> > port to have the same policy.
>> 
>> I think it is very realistic. It is also something which does not work
>> is going to cause a lot of confusion. People will blame the printer,
>> when in fact they should be blaming the switch. They will be rebooting
>> the printer, when in fact, they need to reboot the switch etc.
>> 
>> I expect there is a way to cleanly support this, you just need to
>> figure it out.
>
> Hans, why must port 2 also be a locked port? The FDB entry with no
> destinations is present in the ATU, and static, why would just locked
> ports match it?
>
You are right of course, but it was more from a policy standpoint as I
pointed out. If the FDB entry is removed after some timeout and the
device in the meantime somehow is on another port that is not locked
with full access, the device will of course get full access.
But since it was not given access in the first instance, the policy is
not consistent.

>> > The other aspect is that the user space daemon that authorizes catches
>> > the fdb add entry events and checks if it is a locked entry. So it will
>> > be up to said daemon to decide the policy, like remove the fdb entry
>> > after a timeout.
>
> When you say 'timeout', what is the moment when the timer starts counting?
> The last reception of the user space daemon of a packet with this MAC SA,
> or the moment when the FDB entry originally became unlocked?

I think that if the device is not given access, a timer should be
started at that moment. No further FDB add events with the same MAC
address will come of course until the FDB entry is removed, which I
think would be done based on the said timer.
>
> I expect that once a device is authorized, and forwarding towards the
> devices that it wants to talk to is handled in hardware, that the CPU no
> longer receives packets from this device. In other words, are you saying
> that you're going to break networking for the printer every 5 minutes,
> as a keepalive measure?

No, I don't think that would be a good idea, but as we are in userspace,
that is a policy decision of those creating the daemon. The kernel just
facilitates, it does not make those decisions as far as I think.
>
> I still think there should be a functional fast path for authorized
> station migrations.
>
I am not sure in what way you are suggesting that should be, if the
kernel should actively do something there? If a station is authorized,
and somehow is transferred to another port, if that port is not locked it
will get access, if the port is locked a miss violation will occur etc...

>> > > Oh, btw, my question was: could you consider suppressing the _prints_ on
>> > > an ATU miss violation on a locked port?
>> > 
>> > As there will only be such on the first packet, I think it should be
>> > logged and those prints serve that purpose, so I think it is best to
>> > keep the print.
>> > If in the future some tests or other can argue for suppressing the
>> > prints, it is an easy thing to do.
>> 
>> Please use a traffic generator and try to DOS one of your own
>> switches. Can you?
>> 
>> 	  Andrew
