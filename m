From: "Roman Chertov" <rchertov@purdue.edu>
Subject: RE: [Bridge] bridge in 'hub' mode possible?
Date: Tue, 18 Jan 2005 20:35:36 -0500
Message-ID: <001401c4fdc7$2d8b7550$b7cbd20c@raider>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050119013317.GA22664@faith.gentoo.org>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: 'Jody Belka' <lists-bridging@pimb.org>, bridge@osdl.org

> -----Original Message-----
> From: Jody Belka,,,,knew@pimb.org [mailto:jmb@mccarroll.org.uk] On
Behalf
> Of Jody Belka
> Sent: Tuesday, January 18, 2005 8:33 PM
> To: bridge@osdl.org
> Cc: Roman Chertov
> Subject: Re: [Bridge] bridge in 'hub' mode possible?
> 
> On Fri, Dec 03, 2004 at 11:48:35AM -0500, Roman Chertov wrote:
> > > I wonder if it would be worth to introduce some kind of "monitor
> > > interface" for a brigde (as can be found on switches, don't know
if
> > > "monitor port" would be the correct term for it).
> > >
> > I have already made one for the 2.4.20 kernel module and the 1.0.4
> > bridge-utils.  Since I was making this for the Emulab testbed I also
had
> > to change the src/dst MACs that were going to the tap; otherwise,
the
> > underlying switch would drop the mirrored packets as their MAC's
were
> > not registered on the VLAN where the tap sat.
> >
> > If people have any interest in this I can share with the code.
> 
> I'd be interested in something like this. Maybe something along the
lines
> of:
> 
> brctl addtap <bridge> <device>    # only allow 1 tap? i'd guess so,
but if
> not
> brctl deltap <bridge>             # then add a <device> param to
deltap
> 

The tap that I made, allows for only one tap and I have not implemented
the tap removal function.  But it should be trivial to do so.  Also when
the tap is configured the MAC address of the tap has to be specified.
(this was done to get around a certain problem with a switch on
www.emulab.net)

If you want the source code shoot me an email.

Roman


> This would be very useful for me, as it would make hooking up snort
> to a linux bridge very nice and easy.
> 
> 
> J
> 
> --
> Jody Belka
> knew (at) pimb (dot) org

