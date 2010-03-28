Date: Sat, 27 Mar 2010 20:17:52 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20100327201752.51b6f7ad@nehalam>
In-Reply-To: <OFCA30CFD8.BFEED34E-ONC12576F3.003AD4F7-C12576F3.003B8B77@transmode.se>
References: <OFB9EFBBE7.11608167-ONC12576F1.005B0C79-C12576F1.005BBE51@transmode.se>
	<2e59e6971003251003g34f45ccsf7feecbcb2d68cbf@mail.gmail.com>
	<OF55692ECA.4BA1B52C-ONC12576F1.006BA68C-C12576F1.007010C8@transmode.se>
	<4BABCF8A.3040701@free.fr>
	<OFDD80C4DC.137F4F61-ONC12576F2.002B1EE4-C12576F2.002B7EA6@transmode.se>
	<4BAD1B85.6020807@free.fr>
	<OFC6D98D54.CA7D4A8D-ONC12576F2.007212B2-C12576F2.00725708@transmode.se>
	<2e59e6971003261442g77365b55sa624fe184e5003ac@mail.gmail.com>
	<OFCA30CFD8.BFEED34E-ONC12576F3.003AD4F7-C12576F3.003B8B77@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] IP address on physcial interface instead of bridge
 interface?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: bridge@lists.linux-foundation.org

On Sat, 27 Mar 2010 11:50:23 +0100
Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:

> "richardvoigt@gmail.com" <richardvoigt@gmail.com> wrote on 2010/03/26 22:=
42:52:
> >
> > On Fri, Mar 26, 2010 at 3:48 PM, Joakim Tjernlund
> > <joakim.tjernlund@transmode.se> wrote:
> > >
> > >
> > > Nicolas de Peslo=C3=BCan <nicolas.2p.debian@free.fr> wrote on 2010/03=
/26 21:39:33:
> > >
> > >> From: Nicolas de Peslo=C3=BCan <nicolas.2p.debian@free.fr>
> > >> To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
> > >> Cc: bridge@lists.linux-foundation.org
> > >> Date: 2010/03/26 21:39
> > >> Subject: Re: [Bridge] IP address on physcial interface instead of br=
idge interface?
> > >>
> > >> Joakim Tjernlund wrote:
> > >>
> > >> > Figure a small picture will help so here it is:
> > >> >
> > >> > Before adding eth0 to br0:
> > >> > eth0 =C2=A0 =C2=A0br0
> > >> > =C2=A0|
> > >> > =C2=A0|
> > >> > HW controller
> > >> >
> > >> > after adding eth0 to br0:
> > >> > eth0
> > >> > =C2=A0 \
> > >> > =C2=A0 =C2=A0\
> > >> > =C2=A0 =C2=A0 =C2=A0br0
> > >> > =C2=A0 =C2=A0/
> > >> > =C2=A0 /
> > >> > HW controller
> > >>
> > >> I don't understand your ascii art. What is HW controller ? eth0 is a=
n hardware
> > >> controller !?
> > >>
> > >> =C2=A0 =C2=A0Nicolas.
> > >
> > > eth0 is the I/F IP stack will see/use. HW controller is the ethernet =
HW controller,
> > > the PCI HW if you like.
> >
> > No!
> >
> > br0 does NOT sit between eth0 and the NIC.  eth0 still represents the
> > NIC.  br0 sits on top, and represents the combined traffic stream from
> > eth0 and all other bridge ports.  By adding eth0 to the bridge, you
> > told it to forward all incoming frames to br0 which is the next higher
> > layer in the virtual interface hierarchy.
>=20
> Of course the above isn't how the bridge works today. I was trying
> to described a new feature which would let me use eth0 as my normal
> IP interface even after it was added to the bridge.
> The above would emulate connecting the eth0 I/F to an external HW bridge.

If you read the network receive code path in the kernel, you
will see that there is a special hook used. Basically,

  if received_interface_is_part_of_bridge(incoming_interface)
  then process_bridged_packet(packet)

Then bridge looks at packet and decides whether it is local or forwarded.
The problem is with your application if it wants to use eth0 directly.




--=20
