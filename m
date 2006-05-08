Date: Mon, 8 May 2006 10:15:47 +0200
From: Tadeusz Andrzej =?iso-8859-2?Q?Kad=B3ubowski?= <yess@hell.org.pl>
Subject: Re: [Bridge] Re: Google SoC proposal (Tadeusz Andrzej Kad?ubowski)
Message-ID: <20060508081547.GA21825@hell.org.pl>
References: <200605071901.k47J09tJ014231@smtp.osdl.org>
	<200605080034.k480YP4i026133@mail.bme.zju.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <200605080034.k480YP4i026133@mail.bme.zju.edu.cn>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: zhangliang <liangzh@mail.bme.zju.edu.cn>
Cc: bridge@lists.osdl.org

Thus wrote zhangliang:
>=20
> I think the prorosal is very good, I also want to do something for it, but
> first we should have some more knowledge about rstp, Now what only I can =
do
> is to read librstp, but I find that is so difficult to understand rstp, c=
an
> u give some more info about it?

Apart from reading librstp (which is considered to be messy etc.) we have t=
wo
main sources:

a) The RSTP standard itself can be downloaded from the IEEE webpage for fre=
e.
It's code-number is 802.1d. Don't be put off by it's technical language.

b) RSTP is based on STP. We have a decent working STP implementation inside=
 the
Linux kernel - it can give a general idea of how to implement some parts of
RSTP.

--=20
tadeusz andrzej kad=B3ubowski
<przekaz podprogowy> kup mi iBooka </przekaz podprogowy>
