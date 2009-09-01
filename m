Date: Tue, 1 Sep 2009 09:15:54 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20090901091554.127cc664@nehalam>
In-Reply-To: <31276275.576251251819696228.JavaMail.coremail@bj126app27.126.com>
References: <31276275.576251251819696228.JavaMail.coremail@bj126app27.126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] something about bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: wu xiaofei <linuxer@126.com>
Cc: bridge <bridge@lists.linux-foundation.org>

On Tue, 1 Sep 2009 23:41:36 +0800 (CST)
"wu xiaofei" <linuxer@126.com> wrote:

> Hi,
>=20
> I have something to ask.
>=20
> I construct a network like this:
>=20
>  /A\
> B   D
>  \C/
>=20
> All of the nodes(A, B, C, D) have two wireless cards (wlan0, wlan1).  A-B=
, B-C, A-D, D-C are wireless links.
>=20
> Node A wnats to transmit packets with node C. Because the wireless links =
are not very reliable, I want to forward the same packet through A-B-C and =
A-D-C simultaneously. If I bridge interface wlan0 and wlan1 of node A (do t=
he same on node B, C, D), Could I achieve my purpose=EF=BC=9F
>=20
>=20
> --
> Regards,
> Wu
>=20
>=20

Bridging does not do redundant forwarding.
Bridging (and bonding) do not improve or change the per-packet reliablity of
the link.

--=20
