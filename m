Date: Wed, 3 Dec 2008 11:35:17 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20081203113517.6797fa2d@extreme>
In-Reply-To: <BLU109-W26995AD7CC3C4942D34082A7030@phx.gbl>
References: <BLU109-W26995AD7CC3C4942D34082A7030@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] brctl project
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Christian Salgado =?UTF-8?B?R29uesOhbGV6?= <chrisalga@hotmail.com>
Cc: bridge@linux-foundation.org

On Wed, 3 Dec 2008 18:47:14 +0100
Christian Salgado Gonz=C3=A1lez <chrisalga@hotmail.com> wrote:

>=20
> Hi Stephen,
>=20
> My name is Christian Salgado, I am studying computer engeneering, this is=
 my last year and I am doing my final Project.
> I have sent you a previous email, but I think that you have not understoo=
d my problem. I will try to explain you:=20
> (3 pcs)
> I have a Pc,called "switch" running brctl(3 interfaces: 2 ethernet and on=
e wifi card, ath0, using Mafwifi).=20
> Other Pc,called client Pc, with two interfaces(wlan0 and eth0),at this co=
mputer I have ifenslave bounding both interfaces.=20
> A pc called server.
> When I send a media stream from the server to the client, through the swi=
tch(brctl), Ifenslave makes load balancing (mode 0 is the only one which I =
am able to use). To know when ifenslave change the operation interface I ha=
ve used wireshark. It is very simply, when the client receive a ping reques=
t ifenslave answer it one time on eth0 and the next on wlan0.  Then brctl l=
earn which is the interface to forward the data.
>=20
> I think that changing the interface sending a ping is not a good way of d=
oing things. This is the reason why I am writing to you.
> Please, correct me if I am wrong, but I think that brctl join the interfa=
ces assigning the same port number  to both interfaces.
>   1     00:11:22:33:44:55       yes                0.00
>   1     00:aa:ff:ff:ff:ff       no                 5.81

Two interfaces should never have same port number (at least as far as bridg=
e is
concerned).

>   2     00:11:11:11:11:11       yes                0.00
> =20
>=20
> For example in the previous table there is a connection between the 2 fir=
st interfaces.
>=20
> Could be possible change the port number of   00:aa:....:ff   to 2 ?=20

Port number only matters to STP, which you probably are not using.
 =20
>=20
> In that case it will be on the same network as 00:11...:11,  isn't it??

Two active interfaces on same network with bridge is equivalent to forwardi=
ng
loop. You need to run STP, and have only one active interface.

> I have been looking at the code of brtcl and I have found the struc fdb. =
What do you think that it is the best way of doing it??
>=20

Yes you can go do what you want with the code, but this is really one
of those: "I think I can hack the bridge code to do my own personal
idea of special case routing"

My answer to this is: "have fun, tell us what you find out, don't expect an=
y support"
