Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 8 Sep 2015 13:22:47 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20150908112247.GE1562@odroid>
Reply-To: bridge@lists.linux-foundation.org
References: <55ED8723.9070501@googlemail.com> <20150908022303.GA1562@odroid>
	<55EE81D2.1040002@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55EE81D2.1040002@googlemail.com>
Subject: Re: [Bridge] net: Export IGMP/MLD message validation code
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Powalowski <tobias.powalowski@googlemail.com>
Cc: bridge@lists.linux-foundation.org

Hi Tobias,

On Tue, Sep 08, 2015 at 08:36:02AM +0200, Tobias Powalowski wrote:
> Am 08.09.2015 um 04:24 schrieb Linus Lüssing:
> > Hi tpowa,
> >
> > Thanks for your feedback.
> >
> >
> > On Mon, Sep 07, 2015 at 02:46:27PM +0200, Tobias Powalowski wrote:
> >> Hi,
> >> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=9afd85c9e4552b276e2f4cfefd622bdeeffbbf26
> >>
> >> This commit introduces a weird behaviour on my dlna server.
> > Did you experience this on the released 4.2 kernel or on a 4.2 release
> > candidate?
> This was on 4.2 final release.

Ok.

> >> This commit was merged into 4.2 series, which makes my dlna services
> >> disappear real soon after starting from discovering from other clients.
> >> Localhost seems not to be affected but every external discovery is broken.
> >> The dlna services run on a bridge device. Mythtv and Minidlna both
> >> disappear after some minutes of running.
> >> Git bisect shows first commit as reason, trying now a 4.2 with those 3
> >> patches reverted:
> >> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=a516993f0ac1694673412eb2d16a091eafa77d2a
> >> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=fcba67c94abe83e0e69a65737000ccbb16a4fa03
> >> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=9afd85c9e4552b276e2f4cfefd622bdeeffbbf26
> >>
> >> Do you need any more information to get this really weird bug fixed?
> > If you have this issue with the vanilla, released 4.2 kernel, then
> > a "tcpdump -i br0 'icmp6 or ip6 proto 0'" for about five minutes and
> > a "bridge mdb show" would be helpful.
> Here comes the next interesting thing:
> If I run
> tcpdump -i br0 'ip6 proto 0'
> all is working fine.

This rings a bell. Somebody told me about such weird behaviour
back in March already on IRC, so way before 4.2 or any commits you've
cited. Unfortunately I wasn't able to reproduce it back then and
didn't hear from him on this issue anymore - I'll try to get an update
from him.

br_multicast.c has no knowledge about promiscious mode. Maybe
someone else from the bridge mailinglist might have an idea how
prom. mode on the bridge interface could affect things?

> 
> If I stop this task it stops showing the dlna services.
> promiscious mode enabled doesn't make it fail.
> [ 1212.138260] device br0 entered promiscuous mode
> works
> [ 1246.908027] device br0 left promiscuous mode
> does not work
> 
> bridge mdb show
> dev br0 port enp2s0 grp 224.0.1.60 temp
> dev br0 port enp2s0 grp 239.255.255.250 temp
> 
> > Also which distros are the dlna server and dlna client running,
> > how are they connected?
> I have only archlinux environments, all external connections are affected.
> My Panasonic TV is not working and my Sony Xperia Z1 compact mobile
> phones are also not working.
> VLC on Windows 7 shows the same. So this is a generic issue I guess.

Just to check two (sometimes too) "obvious" points: No ebtables or iptables
on the device with the bridge? DLNA server isn't bound to enp2s0
and is either unbound (binds to 0.0.0.0) or binds to br0?

> 
> greetings
> tpowa
> 

Cheers, Linus

PS: Please keep the bridge mailinglist added, thanks :).

> -- 
> Tobias Powalowski
> Archlinux Developer & Package Maintainer (tpowa)
> http://www.archlinux.org
> tpowa@archlinux.org
> 
> 


