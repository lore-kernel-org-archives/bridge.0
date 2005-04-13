Date: Wed, 13 Apr 2005 10:09:51 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20050413100951.05bc87fb@dxpl.pdx.osdl.net>
In-Reply-To: <FB1B41082DF4844084E737A58460C49018ED8C@master01.ecofilmes.pt>
References: <FB1B41082DF4844084E737A58460C49018ED8C@master01.ecofilmes.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Re: Linux Bridging
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "Andre Santos (Ecofilmes)" <andre.santos@ecofilmes.pt>, bridge@osdl.org

On Wed, 13 Apr 2005 10:50:15 +0100
"Andre Santos \(Ecofilmes\)" <andre.santos@ecofilmes.pt> wrote:

> Hi there,
> =20
> I want to have a computer betwen the internet and the network to see the =
trafic and control.=20
> I used windows, but its somehow limited, and want to try linux...=20
> I installed Fedora linux in server mode, and now Im trying to put 2 nics =
in bridge.=20
> =20
> First, I tried to do like this (the first part):
> http://www.sjdjweis.com/linux/bridging/ <BLOCKED::http://www.sjdjweis.com=
/linux/bridging/>=20
> =20
> It didnt worked..
> I did  brctl show and not bridge configured...
> =20
> Then I enabled all the services I turned off from this article again.
> =20
> In the file    /etc/sysctl.conf:  =20
> I Xchanged the 0 to 1 ..  net.ipv4.ip_forward =3D 1=20
> =20
> =20
> In the console I wrote:
>  ifconfig eth0 0.0.0.0 up=20
>  ifconfig eth1 0.0.0.0 up=20
>  brctl addbr br0=20
>  brctl addif br0 eth0=20
>  brctl addif br0 eth1=20
>  ifconfig br0 X.X.X.X netmask 255.255.255.0=20
> =20
> For testing I put  Workstation -> Hub -> Bridge -> network=20
> I want to see if bridge works, if the workstation has to be able to ping =
the network its working.
>=20
> I can ping server from the linux , but from the computer behim bridge to =
network it cant ping, and the conection is limited, cant get ip.

Fid you wait for the STP status to change to forwarding?=20
It has to go through a learning period first.

What is the output of 'brctl showstp br0'

> =20
> Tried to instal, bridge-utils-1.0.4.tar , ran configure  and config.statu=
s in console and install-sh in the folder but, I dont know if it had any ef=
fect.. as Im a newie at linux.
> The location  /bridge-utils-1.0.4/    dont know if I had to put in some o=
ther folder...

Latest is 1.0.5

If you do:
	./configure
	make
You will build the utilities.
Then you need to run
	make install
as root.  By default it puts the new brctl in /usr/local/sbin/brctl

You can figure out what version is running by doing 'brctl -V'
Also, unless you have problems, I recommend starting with the bridge-utilit=
ies
included with your linux distribution. The utilities have been stable long =
enough
that little changes.

> =20
> =20
> Could you help me on this?
> =20
> Much apreciated!!
> =20
> Thanks for your time.
> =20
> Best regards,
> Andr=E9 Santos

