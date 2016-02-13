Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 13 Feb 2016 03:35:28 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160213023528.GC7093@otheros>
References: <56A2993B.4070307@gmail.com> <20160122131046.6f141681@xeon-e3>
	<56A2AF73.2090204@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56A2AF73.2090204@gmail.com>
Subject: Re: [Bridge] hw csum failure introduced in linux-4.2
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?utf-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>
Cc: bridge@lists.linux-foundation.org, davem@davemloft.net

Hi Alvaro,

Did you have a chance to narrow it down to that commit yet? Would
be great if you could check whether reverting the following
commits helps:

c2d4fbd2163e ("bridge: fix igmpv3 / mldv2 report parsing")
a516993f0ac1 ("net: fix wrong skb_get() usage / crash in IGMP/MLD parsing code")
9afd85c9e455 ("net: Export IGMP/MLD message validation code")

Or reverting all of the above plus:

3c9e4f870012 ("bridge: multicast: call skb_checksum_{simple_, }validate")


Will try to get my hands on a Pi 2, too.

Regards, Linus


PS: 4.4.0 did not have c2d4fb yet, that was added with 4.4.1. While
missing it does cause trouble, it should not cause a csum error.


On Fri, Jan 22, 2016 at 11:38:43PM +0100, Álvaro Fernández Rojas wrote:
> Yes, I could reproduce it on OpenWrt using linux-4.4 on a Raspberry Pi 2.
> https://gist.github.com/Noltari/5b1cfdecce5ed4bc08fd
> 
> No, I didn't open any issue on the kernel bugzilla.
> If you want me to report it somewhere else I don't have any problem with it.
> 
> Regards,
> Álvaro.
> 
> El 22/01/2016 a las 22:10, Stephen Hemminger escribió:
> > On Fri, 22 Jan 2016 22:03:55 +0100
> > Álvaro Fernández Rojas <noltari@gmail.com> wrote:
> >
> >>   From linux-4.2 there's a "hw csum failure" for bridges using hardware
> >> checksums when IPv6 multicast traffic is received.
> >>
> >> Here are some reports:
> >> https://lkml.org/lkml/2015/12/1/699
> >> https://bugzilla.redhat.com/show_bug.cgi?id=1266601
> >> https://discourse.osmc.tv/t/hw-csum-failure/9990
> >> https://github.com/raspberrypi/linux/issues/1259
> >>
> >> I think it may have been introduced in commit
> >> 9afd85c9e4552b276e2f4cfefd622bdeeffbbf26 (net: Export IGMP/MLD message
> >> validation code) but I haven't done any tests to confirm it.
> >> Any help on this issue would be really appreciated.
> >>
> >> Regards,
> >> Álvaro.
> > What hardware? You missed the kernel bugzilla? If it was reported
> > there I would have forwarded it to netdev@vger.kernel.org.
> >
> > Can you reproduce it with 4.4?
> 
