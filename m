Return-Path: <jp.tosoni@acksys.fr>
From: "Jean-Pierre Tosoni" <jp.tosoni@acksys.fr>
References: <20170102193214.31723-1-linus.luessing@c0d3.blue>
	<20170106191356.43740a26@xeon-e3>
In-Reply-To: <20170106191356.43740a26@xeon-e3>
Date: Mon, 9 Jan 2017 09:36:55 +0100
Message-ID: <002f01d26a53$88c8da60$9a5a8f20$@acksys.fr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: fr
Subject: Re: [Bridge] [PATCH net-next] bridge: multicast to unicast
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: 'Stephen Hemminger' <stephen@networkplumber.org>, =?UTF-8?Q?'Linus_L=C3=BCssing'?= <linus.luessing@c0d3.blue>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, "'David S . Miller'" <davem@davemloft.net>, 'Felix Fietkau' <nbd@nbd.name>

> -----Message d'origine-----
> De : linux-wireless-owner@vger.kernel.org [mailto:linux-wireless-
> owner@vger.kernel.org] De la part de Stephen Hemminger
> Envoy=C3=A9 : samedi 7 janvier 2017 04:14
> =C3=80 : Linus L=C3=BCssing
> Cc : netdev@vger.kernel.org; David S . Miller; bridge@lists.linux-
> foundation.org; linux-kernel@vger.kernel.org; linux-
> wireless@vger.kernel.org; Felix Fietkau
> Objet : Re: [PATCH net-next] bridge: multicast to unicast
>=20
> On Mon,  2 Jan 2017 20:32:14 +0100
> Linus L=C3=BCssing <linus.luessing@c0d3.blue> wrote:
>=20
> > This feature is intended for interface types which have a more
> > reliable and/or efficient way to deliver unicast packets than
> > broadcast ones (e.g. wifi).
>=20
>=20
> Why is this not done in MAC80211 rather than  bridge?

OTOH mac80211 has more information to decide whether it is more economic =
to send one multicast or several unicast.
It depends on the bitrate of each station, number of stations and the =
(not necessarily slower) bitrate of multicasts.

