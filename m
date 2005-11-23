Message-ID: <4e85b8310511231107s6a074a09g333a39f0fb47f9b5@mail.gmail.com>
Date: Wed, 23 Nov 2005 11:07:31 -0800
From: Bob Snyder <oceansidebob@gmail.com>
Subject: Re: [Bridge] Long delays through bridge
In-Reply-To: <20051123093340.2a016785@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
References: <4e85b8310511230910p44aa27b8uab8f1a2f9fa6388f@mail.gmail.com>
	<20051123093340.2a016785@dxpl.pdx.osdl.net>
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Bridge@lists.osdl.org

On 11/23/05, Stephen Hemminger <shemminger@osdl.org> wrote:
> On Wed, 23 Nov 2005 09:10:56 -0800
> Bob Snyder <oceansidebob@gmail.com> wrote:
>
> > Hello,
> >
> > I have built a data link system (i.e. microwave radio) with bridges at
> > both ends of the link (sort of back-to-back). The data link boxes have
> > highly asymetrical RS-422 serial interfaces which are interfaced to
> > the bridges with dscc4/hdlc/syncppp modules. Also, the bridges each
> > have one regular ethernet port. The intention is to have the ethernet
> > at one end appear to be connected to the ethernet at the other end.
> > Also, one end is usually connected to a busy lan with lots of
> > broadcast traffic. The bridges are running on 266 MHz Pentiums with no
> > other load.
> >
> > The system works in general, but sometimes there are very long and
> > erratic delay times (up to  several seconds) when pinging through the
> > link. If the radio link is brought up before the bridges are started,
> > things seem to work well (ping times of ~10-15 ms). The problem seems
> > to occur if the bridges are started before the radio link is brought
> > up. Once the problem appears it will persist until the bridge is
> > restarted.
> >
> > I wondered if the problems is that the MAC table was getting too big.
> > I reduced the ageing time from 300 to 30 seconds, and this seemed to
> > help (the MAC table got smaller), but the problem persists. Also the
> > problem can be seen sometimes when not connected to the lan, so maybe
> > I just don't have the bridge configured properly.
> >
> > Any help or suggestions appreciated.
> >
>
> Does the interface implement broadcast/muliticast?
>
> Also the bridge takes 30 seconds to go through the learning phase
> when interface is attached per STP spec.
>
> --
> Stephen Hemminger <shemminger@osdl.org>
> OSDL http://developer.osdl.org/~shemminger
>

Well, I think so, since ARPs work, and I see lots of the lan's MACs on
the side that isn't connected to the lan. (Don't know about
multicast).

The learning phase is observed (seems shorter than 30 seconds) but I
don't know how that would relate to the problem.

Bob Snyder

