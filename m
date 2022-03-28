Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=8j5QTAZfLhwmkKFIt9nilSI/3dPPPzi4f58TnsoEgH8=;
 b=ealUty7SO2YHat48Wm0vOdR5RY6b0HiVR7jHHq4iBQQaNKsQTtA4vPGJ5uiWtqs2If
 yzDF3I6kdy3oTdpQGXIkUVfr0PgXbigd2ujGC87qw6gPuiAyRYFuL3JJPAV6wcILXLZ1
 xCkH+DtVJwDLGeDAFHev9lUp1BL7McWCvgh6PJpi/L0ZAEE4YJGcc6j6AiVOczLMwVC6
 5rZS7mSzEUGPMSo6CrMK8mMTj1v4MzwdtpDBHxubyIgfEMms5epwnzaoudrkL3aCCD+s
 B9uSyrwZwthd7ysvD/pVUucT2EdUVVEl8K+9AgMCpEgE6c0MYUpZOLxVT4IOPMpQhk42
 UoVg==
Date: Mon, 28 Mar 2022 18:12:47 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220328151247.hgub3vuzqbrl6mis@skbuf>
References: <20220324142749.la5til4ys6zva4uf@skbuf> <86czia1ned.fsf@gmail.com>
 <20220325132102.bss26plrk4sifby2@skbuf> <86fsn6uoqz.fsf@gmail.com>
 <20220325140003.a4w4hysqbzmrcxbq@skbuf> <86tubmt408.fsf@gmail.com>
 <20220325203057.vrw5nbwqctluc6u3@skbuf> <86ee2m8r2e.fsf@gmail.com>
 <20220328084828.ergz2h64p7ugebwl@skbuf> <86h77ijudc.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <86h77ijudc.fsf@gmail.com>
Subject: Re: [Bridge] [PATCH v2 net-next 2/4] net: switchdev: add support
 for offloading of fdb locked flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Mon, Mar 28, 2022 at 11:31:43AM +0200, Hans Schultz wrote:
> On m=E5n, mar 28, 2022 at 11:48, Vladimir Oltean <olteanv@gmail.com> wrot=
e:
> > On Mon, Mar 28, 2022 at 09:38:33AM +0200, Hans Schultz wrote:
> >> On fre, mar 25, 2022 at 22:30, Vladimir Oltean <olteanv@gmail.com> wro=
te:
> >> > On Fri, Mar 25, 2022 at 05:01:59PM +0100, Hans Schultz wrote:
> >> >> > An attacker sweeping through the 2^47 source MAC address range is=
 a
> >> >> > problem regardless of the implementations proposed so far, no?
> >> >>=20
> >> >> The idea is to have a count on the number of locked entries in both=
 the
> >> >> ATU and the FDB, so that a limit on entries can be enforced.
> >> >
> >> > I can agree with that.
> >> >
> >> > Note that as far as I understand regular 802.1X, these locked FDB
> >> > entries are just bloatware if you don't need MAC authentication bypa=
ss,
> >> > because the source port is already locked, so it drops all traffic f=
rom
> >> > an unknown MAC SA except for the link-local packets necessary to run
> >> > EAPOL, which are trapped to the CPU.
> >>=20
> >> 802.1X and MAC Auth can be completely seperated by hostapd listning
> >> directly on the locked port interface before entering the bridge.
> >
> > I don't understand this, sorry. What do you mean "before entering the
> > bridge"?
> >
> RAW socket on network slave device.

But as far as the port and its driver are concerned, there is a lot of
unnecessary functionality going on in the background if you don't need
MAC authentication bypass. All non-EAPOL packets could be unauthorized
without CPU intervention by simply not enabling CPU-assisted secure
learning in the first place. You might consider cutting off some of that
overhead by making user space opt into secure learning.

> >> > So maybe user space should opt into the MAC authentication bypass
> >> > process, really, since that requires secure CPU-assisted learning, a=
nd
> >> > regular 802.1X doesn't. It's a real additional burden that shouldn't=
 be
> >> > ignored or enabled by default.
> >> >
> >> >> > If unlimited growth of the mv88e6xxx locked ATU entry cache is a
> >> >> > concern (which it is), we could limit its size, and when we purge=
 a
> >> >> > cached entry in software is also when we could emit a
> >> >> > SWITCHDEV_FDB_DEL_TO_BRIDGE for it, right?
> >> >>=20
> >> >> I think the best would be dynamic entries in both the ATU and the F=
DB
> >> >> for locked entries.
> >> >
> >> > Making locked (DPV=3D0) ATU entries be dynamic (age out) makes sense.
> >> > Since you set the IgnoreWrongData for source ports, you suppress ATU
> >> > interrupts for this MAC SA, which in turn means that a station which=
 is
> >> > unauthorized on port A can never redeem itself when it migrates to p=
ort B,
> >> > for which it does have an authorization, since software never receiv=
es
> >> > any notice that it has moved to a new port.
> >> >
> >> > But making the locked bridge FDB entry be dynamic, why does it matte=
r?
> >> > I'm not seeing this through. To denote that it can migrate, or to de=
note
> >> > that it can age out? These locked FDB entries are 'extern_learn', so
> >> > they aren't aged out by the bridge anyway, they are aged out by whom=
ever
> >> > added them =3D> in our case the SWITCHDEV_FDB_DEL_TO_BRIDGE that I m=
entioned.
> >> >
> >> I think the FDB and the ATU should be as much in sync as possible, and
> >> the FDB definitely should not keep stale entries that only get removed
> >> by link down. The SWITCHDEV_FDB_DEL_TO_BRIDGE route would requre an
> >> interrupt when a entry ages out in the ATU, but we know that that cann=
ot
> >> happen with DPV=3D0. Thus the need to add dynamic entries with
> >> SWITCHDEV_FDB_ADD_TO_BRIDGE.=20
> >
> > So what is your suggestion exactly? You want the driver to notify the
> > locked FDB entry via FDB_ADD_TO_BRIDGE with the dynamic flag, and then
> > rely on the bridge's software ageing timer to delete it? How does that
> > deletion propagate back to the driver then? I'm unclear on the ownership
> > model you propose.
> >
>=20
> As the FDB and the ATU will age out the entry with the same timeout,
> they will stay relatively in sync compared to the situation where the
> switchcore driver will not be able to notify the bridge that a zero DPV
> entry has aged out as it has no port association.

So if the DPV=3D0 ATU entry doesn't get refreshed when a packet hits it
(even to get dropped), then I suppose the drift between software and
hardware ageing timers could be kept more or less under control.

But you still need to change switchdev and the bridge driver to support
this pattern, and you need to make a compelling case for it, because the
lack of a FDB_DEL_TO_BRIDGE notifier _is_ a concern in the general case.

And if you say "well, you know, the reason why I don't need to emit the
FDB_DEL_TO_BRIDGE is because I lied about the FDB entry's port association
in the first place (during FDB_ADD_TO_BRIDGE), it really is associated
with no port rather than with the port I said, just go with it", well,
that might not be the strongest argument for a new kind of externally
learned FDB entry. Anyway I'll defer to bridge and switchdev maintainers.

> >> >> How the two are kept in sync is another question, but if there is a
> >> >> switchcore, it will be the 'master', so I don't think the bridge
> >> >> module will need to tell the switchcore to remove entries in that
> >> >> case. Or?
> >> >
> >> > The bridge will certainly not *need* to tell the switch to delete a
> >> > locked FDB entry, but it certainly *can* (and this is in fact part of
> >> > the authorization process, replace an ATU entry with DPV=3D0 with an=
 ATU
> >> > entry with DPV=3DBIT(port)).
> >>=20
> >> Yes you are right, but I was implicitly only regarding internal
> >> mechanisms in the 'bridge + switchcore', and not userspace netlink
> >> commands.
> >> >
> >> > I feel as if I'm missing the essence of your reply.
