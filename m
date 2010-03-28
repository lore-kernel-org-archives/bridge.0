In-Reply-To: <4BAD28AC.1070607@free.fr>
References: <OFB9EFBBE7.11608167-ONC12576F1.005B0C79-C12576F1.005BBE51@transmode.se>	<2e59e6971003251003g34f45ccsf7feecbcb2d68cbf@mail.gmail.com>
	<OF55692ECA.4BA1B52C-ONC12576F1.006BA68C-C12576F1.007010C8@transmode.se>
	<4BABCF8A.3040701@free.fr>
	<OFDD80C4DC.137F4F61-ONC12576F2.002B1EE4-C12576F2.002B7EA6@transmode.se>
	<4BAD1B85.6020807@free.fr>
	<OFC6D98D54.CA7D4A8D-ONC12576F2.007212B2-C12576F2.00725708@transmode.se>
	<4BAD28AC.1070607@free.fr>
Message-ID: <OF2C424739.513900E3-ONC12576F4.00534676-C12576F4.0054282D@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sun, 28 Mar 2010 17:19:13 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-15
Content-transfer-encoding: quoted-printable
Subject: Re: [Bridge] IP address on physcial interface instead of
	bridge	interface?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?ISO-8859-15?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
Cc: bridge@lists.linux-foundation.org

Nicolas de Peslo=FCan <nicolas.2p.debian@free.fr> wrote on 2010/03/26 2=
2:35:40:
>
> Joakim Tjernlund a =E9crit :
> >
> > Nicolas de Peslo=FCan <nicolas.2p.debian@free.fr> wrote on 2010/03/=
26 21:39:33:
> >
> >> From: Nicolas de Peslo=FCan <nicolas.2p.debian@free.fr>
> >> To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
> >> Cc: bridge@lists.linux-foundation.org
> >> Date: 2010/03/26 21:39
> >> Subject: Re: [Bridge] IP address on physcial interface instead of =
bridge interface?
> >>
> >> Joakim Tjernlund wrote:
> >>
> >>> Figure a small picture will help so here it is:
> >>>
> >>> Before adding eth0 to br0:
> >>> eth0    br0
> >>>  |
> >>>  |
> >>> HW controller
> >>>
> >>> after adding eth0 to br0:
> >>> eth0
> >>>   \
> >>>    \
> >>>      br0
> >>>    /
> >>>   /
> >>> HW controller
> >> I don't understand your ascii art. What is HW controller ? eth0 is=
 an hardware
> >> controller !?
> >>
> >>    Nicolas.
> >
> > eth0 is the I/F IP stack will see/use. HW controller is the etherne=
t HW controller,
> > the PCI HW if you like.
>
> I tested the following setup:
>
> # eth0 setup:
>
> ip addr add $IP dev eth0
> ip link set up dev eth0
> ip route add default via $DEF_ROUTE
>
> # bridge setup:
>
> brctl addbr br0
> brctl setfd br0 0
>
> Then I tested the following migration sequence to move the IP address=
e to br0:
>
> ip addr add $IP dev br0
> ip link set up dev br0
>
> brctl addif br0 eth0
> ip addr del $IP dev eth0
> ip route add default via $DEF_ROUTE
>
> Thanks to "brctl setfd br0 0", this migration cause no trouble to act=
ive connections.
>
> So I cannot find a good reason to try and use eth0 as the "main" brid=
ge interface.
>
> Do you have a process really linked to eth0 ?

So I did a quick test and it did seem to work for the simple case. Howe=
ver
there may be other routes connected to eth0 than just the default route=
 so
one have to scan the whole route table. There is also the another probl=
em,
now the I/F is named br0 and all config/status ops related to eth0 must=

be changed to use br0 instead.
The routing daemon(Quagga) also needs to update its config to use br0 i=
nstead.
All in all, using br0 instead of eth0 works on a technical level but
all apps dealing with routes and interfaces needs to be updated and thi=
s
is not trivial nor wanted.

Allowing eth0 be used as I suggested would really help in these
configurations. Would such a change be welcomed and is it
hard to impl. ?

   Jocke=


