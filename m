Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=0pL0SFW/VbdIjcDSz7GHVSOjw0PfFoW5o+bJeK2Eo/k=;
 b=p5ek65fEXaibJJw/nxq2rFr0PEZPQkaW3jTcX1PkHYu+rzPyyiGMngFGtgCNXyuDgB
 AJJCi2TlCduNnvAajMoekwO4oPQccc949RpyXLXMloOX4tAD4G2X6WSZfoZHDGpkGVka
 rtIMynGUDDe3dY1ree2Ys76bObqMv9DUCBC/EV69h8tcP4ARTCL2paK4gmMUyPbRWRGc
 fTLjyq2Zq/rEiiPEK/YAJWQqprlN/yXlIfuwk0Dgq0iSpRVJfUNi4uwBjFPuo+rtLoLA
 AYDwq8dmFkkddeIYoaFbHi/YaWoZHOQtPe6ICLwTw3lZik8pGH93Bs67z27fmtwzZf+L
 COIA==
Date: Fri, 25 Mar 2022 15:21:02 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220325132102.bss26plrk4sifby2@skbuf>
References: <20220317093902.1305816-3-schultz.hans+netdev@gmail.com>
 <86o81whmwv.fsf@gmail.com> <20220323123534.i2whyau3doq2xdxg@skbuf>
 <86wngkbzqb.fsf@gmail.com> <20220323144304.4uqst3hapvzg3ej6@skbuf>
 <86lewzej4n.fsf@gmail.com> <20220324110959.t4hqale35qbrakdu@skbuf>
 <86v8w3vbk4.fsf@gmail.com> <20220324142749.la5til4ys6zva4uf@skbuf>
 <86czia1ned.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86czia1ned.fsf@gmail.com>
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

On Fri, Mar 25, 2022 at 08:50:34AM +0100, Hans Schultz wrote:
> On tor, mar 24, 2022 at 16:27, Vladimir Oltean <olteanv@gmail.com> wrote:
> > On Thu, Mar 24, 2022 at 12:23:39PM +0100, Hans Schultz wrote:
> >> On tor, mar 24, 2022 at 13:09, Vladimir Oltean <olteanv@gmail.com> wrote:
> >> > On Thu, Mar 24, 2022 at 11:32:08AM +0100, Hans Schultz wrote:
> >> >> On ons, mar 23, 2022 at 16:43, Vladimir Oltean <olteanv@gmail.com> wrote:
> >> >> > On Wed, Mar 23, 2022 at 01:49:32PM +0100, Hans Schultz wrote:
> >> >> >> >> Does someone have an idea why there at this point is no option to add a
> >> >> >> >> dynamic fdb entry?
> >> >> >> >> 
> >> >> >> >> The fdb added entries here do not age out, while the ATU entries do
> >> >> >> >> (after 5 min), resulting in unsynced ATU vs fdb.
> >> >> >> >
> >> >> >> > I think the expectation is to use br_fdb_external_learn_del() if the
> >> >> >> > externally learned entry expires. The bridge should not age by itself
> >> >> >> > FDB entries learned externally.
> >> >> >> >
> >> >> >> 
> >> >> >> It seems to me that something is missing then?
> >> >> >> My tests using trafgen that I gave a report on to Lunn generated massive
> >> >> >> amounts of fdb entries, but after a while the ATU was clean and the fdb
> >> >> >> was still full of random entries...
> >> >> >
> >> >> > I'm no longer sure where you are, sorry..
> >> >> > I think we discussed that you need to enable ATU age interrupts in order
> >> >> > to keep the ATU in sync with the bridge FDB? Which means either to
> >> >> > delete the locked FDB entries from the bridge when they age out in the
> >> >> > ATU, or to keep refreshing locked ATU entries.
> >> >> > So it seems that you're doing neither of those 2 things if you end up
> >> >> > with bridge FDB entries which are no longer in the ATU.
> >> >> 
> >> >> Any idea why G2 offset 5 ATUAgeIntEn (bit 10) is set? There is no define
> >> >> for it, so I assume it is something default?
> >> >
> >> > No idea, but I can confirm that the out-of-reset value I see for
> >> > MV88E6XXX_G2_SWITCH_MGMT on 6190 and 6390 is 0x400. It's best not to
> >> > rely on any reset defaults though.
> >> 
> >> I see no age out interrupts, even though the ports Age Out Int is on
> >> (PAV bit 14) on the locked port, and the ATU entries do age out (HoldAt1
> >> is off). Any idea why that can be?
> >> 
> >> I combination with this I think it would be nice to have an ability to
> >> set the AgeOut time even though it is not per port but global.
> >
> > Sorry, I just don't know. Looking at the documentation for IntOnAgeOut,
> > I see it says that for an ATU entry to trigger an age out interrupt, the
> > port it's associated with must have IntOnAgeOut set.
> > But your locked ATU entries aren't associated with any port, they have
> > DPV=0, right? So will they never trigger any age out interrupt according
> > to this? I'm not clear.
> 
> I think that's absolutely right. That leaves two options. Either "port
> 10" if it has IntOnAgeOut setting, or the reason why I wrote my comments
> in this part of the code, that it should be able to add a dynamic entry
> in the bridge module from the driver.

I'm sorry, I wasn't fully aware of the implications of the fact that
your 'locked' FDB entries have a DPV of all zeroes in hardware.
Practically, this means that while the locked bridge FDB entry is
associated with a bridge port, the ATU entry is associated with no port.

In turn, the hardware cannot ever true detect station migrations,
because it doesn't know which port this station migrates _from_ (you're
not telling it that). Every packet with this MAC SA is a station
migration, in effect, which you (for good reason) choose to ignore to
avoid denial of service.

Mark the locked (DPV=0) ATU entry as static, and you'll keep your CPU
clean of any ATU miss or member violation of this MAC SA. Read this as
"you'll need to call IT to ask them to remove it". Undesirable IMHO.

Mark the locked entry as non-static, and the entry will eventually
expire, with no interrupt to signal that - because any ATU age interrupt,
as mentioned, is fundamentally linked to a port.

You see this as a negative, and you're looking for ways to inform the
bridge driver that the locked FDB entry went away. But you aren't
looking at this the right way, I think. Making the mv88e6xxx driver
remove the locked FDB entry from the bridge seems like a non-goal now.

If you'd cache the locked ATU entry in the mv88e6xxx driver, and you'd
notify switchdev only if the entry is new to the cache, then you'd
actually still achieve something major. Yes, the bridge FDB will contain
locked FDB entries that aren't in the ATU. But that's because your
printer has been silent for X seconds. The policy for the printer still
hasn't changed, as far as the mv88e6xxx, or bridge, software drivers are
concerned. If the unauthorized printer says something again after the
locked ATU entry expires, the mv88e6xxx driver will find its MAC SA
in the cache of denied addresses, and reload the ATU. What this achieves
is that the number of ATU violation interrupts isn't proportional to the
number of packets sent by the printer, but with the ageing time you
configure for this ATU entry. You should be able to play with an
entry->state in the range of 1 -> 7 and get a good compromise between
responsiveness on station migrations and number of ATU interrupts to
service once the locked ATU entry is invalidated. In my opinion even the
quickest-to-expire entry->state of 1 is way better than letting every
packet spam the CPU. And you can always keep your cached locked ATU
entry in sync with the port that triggered the violation interrupt, and
figure out station migrations in software this way.

I hope I understood the hardware behavior correctly, I don't have any
direct experience with 802.1X as I mentioned, and only limited and
non-expert experience with Marvell hardware. This is just my
interpretation of some random documentation I found online.
