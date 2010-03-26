In-Reply-To: <4BAD1B85.6020807@free.fr>
References: <OFB9EFBBE7.11608167-ONC12576F1.005B0C79-C12576F1.005BBE51@transmode.se>	<2e59e6971003251003g34f45ccsf7feecbcb2d68cbf@mail.gmail.com>
	<OF55692ECA.4BA1B52C-ONC12576F1.006BA68C-C12576F1.007010C8@transmode.se>
	<4BABCF8A.3040701@free.fr>
	<OFDD80C4DC.137F4F61-ONC12576F2.002B1EE4-C12576F2.002B7EA6@transmode.se>
	<4BAD1B85.6020807@free.fr>
Message-ID: <OFC6D98D54.CA7D4A8D-ONC12576F2.007212B2-C12576F2.00725708@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 26 Mar 2010 21:48:53 +0100
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
1:39:33:

> From: Nicolas de Peslo=FCan <nicolas.2p.debian@free.fr>
> To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
> Cc: bridge@lists.linux-foundation.org
> Date: 2010/03/26 21:39
> Subject: Re: [Bridge] IP address on physcial interface instead of bri=
dge interface?
>
> Joakim Tjernlund wrote:
>
> > Figure a small picture will help so here it is:
> >
> > Before adding eth0 to br0:
> > eth0    br0
> >  |
> >  |
> > HW controller
> >
> > after adding eth0 to br0:
> > eth0
> >   \
> >    \
> >      br0
> >    /
> >   /
> > HW controller
>
> I don't understand your ascii art. What is HW controller ? eth0 is an=
 hardware
> controller !?
>
>    Nicolas.

eth0 is the I/F IP stack will see/use. HW controller is the ethernet HW=
 controller,
the PCI HW if you like.

 Jocke=


