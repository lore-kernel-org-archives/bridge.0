Return-Path: <mbizon@freebox.fr>
From: Maxime Bizon <mbizon@freebox.fr>
Message-ID: <20140626211948.GA7077@sakura.staff.proxad.net>
References: <1403534015-28496-1-git-send-email-mbizon@freebox.fr>
	<20140625161335.11598f09@haswell>
	<1403781352.52578.103.camel@sakura.staff.proxad.net>
	<20140626.133550.975175623908419742.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20140626.133550.975175623908419742.davem@davemloft.net>
Subject: Re: [Bridge] [PATCH] bridge: mark packets sent to any local mac
 address as PACKET_HOST
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Thu, 26 Jun 2014 21:19:52 -0000
To: David Miller <davem@davemloft.net>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org


On Thursday 26 Jun 2014 =E0 13:35:50 (-0700), David Miller wrote:

> > for some reasons, hostapd kept adding and removing the interface from
> > the bridge, triggering a mac address of the bridge change each time (I
> > did not notice that).
>=20
> I think this is what you need to investigate rather than making
> changes to the bridge layer.

Of course I fixed the problem with hostapd, I was just explaining how
I noticed that behaviour in the bridge code.

If that behaviour is intended then just forget that patch.

--=20
Maxime
