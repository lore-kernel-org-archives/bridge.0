From: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1213294793.6615.16.camel@localhost>
	(sfid-20080612_202000_504292_98E93460)
References: <1213232760.6645.24.camel@localhost>
	(sfid-20080612_030607_332834_1EFDE126)
	<1213255570.3871.8.camel@johannes.berg>
	<1213294793.6615.16.camel@localhost>
	(sfid-20080612_202000_504292_98E93460)
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-vBkVlkfFN20sIiKrvAks"
Date: Thu, 12 Jun 2008 20:20:52 +0200
Message-Id: <1213294852.3730.31.camel@johannes.berg>
Mime-Version: 1.0
Subject: Re: [Bridge] [RFC] Do not activate promiscuous mode on wlan
	interfaces for	bridging.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Luis Carlos Cobo <luisca@cozybit.com>
Cc: j@w1.fi, bridge@linux-foundation.org, linux-wireless@vger.kernel.org, Linux Netdev List <netdev@vger.kernel.org>


--=-vBkVlkfFN20sIiKrvAks
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> You are right, within the BSS every frame is going to be addressed to
> the AP anyway, so we should not receive more or less frames when
> activating promiscuous mode.
>=20
> When activating promiscuous mode in this device, it stops acknowledging
> frames, and this impairs the association process. The other solution
> would be to ignore the promiscuous mode commands (i.e. never send the
> command to the device) for interfaces in AP mode. If this is the only
> device showing this behavior, maybe that would be the best solution.

Is this a mac80211 driver? When are you activating promisc?

johannes

--=-vBkVlkfFN20sIiKrvAks
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJIUWkAAAoJEKVg1VMiehFYikoP/1oEGzotLqVaEpSmVYb63NR9
DnO73/BgXyvRi4nHYmYZIUcsOJcFPxcNA3l851/1D/B01mhCXeuCMRITiMhfQN4v
KFSBRcO92iFLAjq0ZNabVOZXIAhLbC25qBHIP9Ra8blbKYiYsQc1DDc3LONsL+1A
DlvISHbQjLDQf6G3MZAU21MH8FX6VbC9wJQyfbRVwXeRqGllnYt3zQL1BtxmP4s8
mecJFHTfV4peIN3plf3ZOME2SqcgXunFXvZdxUjKckKEDimouz7TyEMxFZKkUgAg
KPBuOncIECYDTIuV4R7soTKxbt3qDHtpaRucFBtBKCHZBIMM+GFdh2jdWfh8oi96
Ke+9f5B+rhlbAVvMVTCtzNAjMwmA1EnqXxYmLvVJB+eqRkqlafz8/02cPFAOx/Zu
8dVfUg8qbZPBaGLsCLxBFU1Sjr+2OW6u+JnkVED4xNV21uyQGB0crh2WadRLqkgw
1V/fMd3Pg/IweSZcdkNLb25LQCQRzIXI2iTwc8BVmaGb6yTusuFPx3eaF/mZ/L4/
5iiq6x7A6mXdnzxYYfoc+d8BhUznoBAb19JIDgRkiTNcYwWnpIzQK9VdEELakjOA
il6jxnRFmVZr8wGD8QUtVYqN+705yAg3z3yq+bLU576v0ZlIB+YSEe6Tg8hJ6aWi
QaCTLpzJZaZmLg43EJrg
=4oMj
-----END PGP SIGNATURE-----

--=-vBkVlkfFN20sIiKrvAks--

