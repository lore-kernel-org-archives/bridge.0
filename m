Date: Thu, 18 Dec 2003 20:13:17 +0100 (CET)
From: Hakan Stensby <hst@nsc.liu.se>
Subject: Re: [Bridge] RH 9 problems iptbles + bridge
In-Reply-To: <200312181935.16344.bdschuym@pandora.be>
Message-ID: <Pine.LNX.4.44.0312182005540.4998-100000@papput.nsc.liu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
Cc: bridge@osdl.org

Ah, so the bridge module shipping with rh kernel dont have support for iptables, 
that explains it all :D
and it was very stupid of me to think that the one thing that at least I would 
like to use with the bridge must be patched in :D

Shouldnt be a problem to build the kernel myself, last time it went very 
smoothly!

Thanks!


On Thu, 18 Dec 2003, Bart De Schuymer wrote:

> On Thursday 18 December 2003 09:46, Hakan Stensby wrote:
> > Hi,
> >
> > I've been running RH 7.2 with a kernel-2.4.9-13brnf0.0.3 for a very long
> > time and works just fine.
> >
> > A couple of weeks ago I thought I'd install a new fresh installation with
> > rh9 and load the bridge module that comes with the rh kernel ( 2.4.20-24.9
> > ).
> >
> > The bridge itself works just fine but the firewalling dont.
> > There is no packets passing the FORWARD chain... Have I missed something
> > really essential here?
> > The same iptable script works just fine on the old box...
> 
> You forgot to apply the appropriate bridge-nf patch, see 
> ebtables.sourceforge.net.
> 
> cheers,
> Bart

