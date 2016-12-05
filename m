Return-Path: <mirq@rere.qmqm.pl>
Date: Mon, 5 Dec 2016 18:24:36 +0100
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Message-ID: <20161205172436.cpxohof6rggxid74@rere.qmqm.pl>
References: <cfa1f2efae2217b50cbefccbf9ba7f0d24a23c63.1480755768.git.mirq-linux@rere.qmqm.pl>
	<20161203232730.GT3129@ovn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20161203232730.GT3129@ovn.org>
Subject: Re: [Bridge] [ovs-dev] [PATCH net-next] net: remove abuse of VLAN
	DEI/CFI bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ben Pfaff <blp@ovn.org>
Cc: dev@openvswitch.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On Sat, Dec 03, 2016 at 03:27:30PM -0800, Ben Pfaff wrote:
> On Sat, Dec 03, 2016 at 10:22:28AM +0100, Micha=B3 Miros=B3aw wrote:
> > This All-in-one patch removes abuse of VLAN CFI bit, so it can be passed
> > intact through linux networking stack.
> >=20
> > Signed-off-by: Micha=B3 Miros=B3aw <michal.miroslaw@atendesoftware.pl>
> > ---
> >=20
> > Dear NetDevs
> >=20
> > I guess this needs to be split to the prep..convert[]..finish sequence,
> > but if you like it as is, then it's ready.
> >=20
> > The biggest question is if the modified interface and vlan_present
> > is the way to go. This can be changed to use vlan_proto !=3D 0 instead
> > of an extra flag bit.
> >=20
> > As I can't test most of the driver changes, please look at them careful=
ly.
> > OVS and bridge eyes are especially welcome.
>=20
> This appears to change the established Open vSwitch userspace API.  You
> can see that simply from the way that it changes the documentation for
> the userspace API.  If I'm right about that, then this change will break
> all userspace programs that use the Open vSwitch kernel module,
> including Open vSwitch itself.

If I understood the code correctly, it does change expected meaning for
the (unlikely?) case of header truncated just before the VLAN TCI - it will
be impossible to differentiate this case from the VLAN TCI =3D=3D 0.

I guess this is a problem with OVS API, because it doesn't directly show
the "missing" state of elements, but relies on an "invalid" value.

I can probably change the code to mask this change in the OVS code (by keep=
ing
the CFI/DEI bit unusable). This somehow feels wrong, though.

Best Regards,
Micha=B3=A0Miros=B3aw
