Date: Fri, 8 May 2009 16:27:19 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20090508162719.6cbc3022@nehalam>
In-Reply-To: <de7adc5e0905081620s69f3e874xa50636b0b6fc65d3@mail.gmail.com>
References: <de7adc5e0905081431v58989abch5e7271de302afd99@mail.gmail.com>
	<20090508155418.7acc7fbf@nehalam>
	<de7adc5e0905081620s69f3e874xa50636b0b6fc65d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] 2.6.27: persistent MAC assignment to bridge not working
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Daniel Robbins <drobbins@funtoo.org>
Cc: bridge@lists.linux-foundation.org

On Fri, 8 May 2009 17:20:08 -0600
Daniel Robbins <drobbins@funtoo.org> wrote:

> This commit is in my 2.6.27-based kernel. It does not appear to be
> working. Can you show me what steps I should take to confirm that this
> sticky code is functioning properly, ie commands and expected results?
>=20
> Thanks.
>=20
> -Daniel
>=20
> On Fri, May 8, 2009 at 4:54 PM, Stephen Hemminger <shemminger@vyatta.com>=
 wrote:
> > On Fri, 8 May 2009 15:31:43 -0600
> > Daniel Robbins <drobbins@funtoo.org> wrote:
> >
> >> Hi All,
> >>
> >> I am trying to figure out how to get a persistent, non-changing MAC
> >> address assigned to a bridge. It looks like there is new functionality
> >> in 2.6.27 to allow this to happen, specifically, in:
> >>
> >> void br_stp_recalculate_bridge_id(struct net_bridge *br)
> >> [...]
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* user has chosen a value so keep it */
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (br->flags & BR_SET_MAC_ADDR)
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> >>
> >> and in..
> >>
> >> static int br_set_mac_address(struct net_device *dev, void *p)
> >> [...]
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 br->flags |=3D BR_SET_MAC_ADDR;
> >>
> >> However, I cannot get this functionality to work as it appears it
> >> should. If I manually set a bridge's MAC address to an arbitrary
> >> value, as follows:
> >>
> >> # ifconfig br0 hw ether "xx:xx:xx:xx:xx:xx"
> >>
> >> Then, subsequent calls such as the following seem to still change the
> >> bridge's MAC address:
> >>
> >> # brctl addif br0 veth100.0
> >> # brctl delif br0 veth100.0
> >>
> >> Am I doing something wrong? What is the proper way to take advantage
> >> of the new code in 2.6.27?
> >>
> >> The only mechanism that I have found that appears to achieve my
> >> desired result is application of Deitmar Maurer's 2.6.24 patch which,
> >> after being applied, seems to disable the dynamic nature of the
> >> bridge's MAC, so that br0 persistently uses the MAC of the first
> >> interface that was added to the bridge. Here is this patch that seems
> >> to be working for me:
> >>
> >> --- linux-2.6.24-openvz.org/net/bridge/br_stp_if.c.org =C2=A02008-06-11
> >> 09:15:16.000000000 +0200
> >> +++ linux-2.6.24-openvz.org/net/bridge/br_stp_if.c =C2=A0 =C2=A0 =C2=
=A02008-06-11
> >> 09:44:53.000000000 +0200
> >> @@ -217,10 +217,7 @@
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct net_bridge_port *p;
> >>
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0list_for_each_entry(p, &br->port_list, list=
) {
> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (addr =3D=3D br_=
mac_zero ||
> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcm=
p(p->dev->dev_addr, addr, ETH_ALEN) < 0)
> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 addr =3D p->dev->dev_addr;
> >> -
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr =3D p->dev->de=
v_addr;
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> >>
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (compare_ether_addr(br->bridge_id.addr, =
addr))
> >> --------------------------
> >>
> >> However, when I look at the 2.6.27 source code, it seems like this
> >> patch should no longer be needed and an "ifconfig br0 hw ether
> >> "xx:xx:xx:xx:xx:xx" should be sufficient. Am I doing something wrong?
> >>
> >> Thanks for your time,
> >>
> >> Daniel Robbins
> >
> > It was fixed by:
> >
> > Author: Stephen Hemminger <shemminger@vyatta.com> =C2=A02008-06-17 16:1=
0:06
> > Committer: David S. Miller <davem@davemloft.net> =C2=A02008-06-17 16:10=
:06
> > Parent: 0b040829952d84bf2a62526f0e24b624e0699447 (net: remove CVS keywo=
rds)
> > Branches: master, remotes/origin/master
> > Follows: v2.6.26-rc6
> > Precedes: v2.6.27-rc1
> >
> > =C2=A0 =C2=A0bridge: make bridge address settings sticky
> >
> > =C2=A0 =C2=A0Normally, the bridge just chooses the smallest mac address=
 as the
> > =C2=A0 =C2=A0bridge id and mac address of bridge device. But if the adm=
inistrator
> > =C2=A0 =C2=A0has explictly set the interface address then don't change =
it.
> >
> > =C2=A0 =C2=A0Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
> > =C2=A0 =C2=A0Signed-off-by: David S. Miller <davem@davemloft.net>
> >
> >

# brctl addbr brex0
# modprobe dummy

# ip li set dev brex0 addr 0c:01:02:03:04:05
# ip li show dev brex0
22: brex0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN=20
    link/ether 0c:01:02:03:04:05 brd ff:ff:ff:ff:ff:ff
# brctl addif brex0 dummy0
# ip li show dev brex0
22: brex0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN=20
    link/ether 0c:01:02:03:04:05 brd ff:ff:ff:ff:ff:ff

--=20
