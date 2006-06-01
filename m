Message-ID: <447E612C.6090309@triplehelix.org>
Date: Wed, 31 May 2006 20:38:20 -0700
From: Joshua Kwan <joshk@triplehelix.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE90E230A2EAF84891F4D91C5"
Subject: [Bridge] Bridging a wireless/wired LAN and a PPPoE connection
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE90E230A2EAF84891F4D91C5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm trying out bridging for my wireless and wired LAN, so that they can
both use my PPPoE connection. Here's the network structure, pretty easy:

darjeeling (192.168.1.7)                    ringo (192.168.1.3)
(mtu 1500)                                       (mtu 1500)
\                                                    /
 \   wlan0      <--br0 (mtu 1500)-->      eth1      /
  -- 802.11 --- influx (192.168.1.1) --- Ethernet --
 /  (mtu 1500)          |                (mtu 1500) \
=2E..                    eth0                         ...
                    (mtu 1500)
                        |
                        v
                  ppp0 (mtu 1492)
                        |
                        v
                  (( Internet ))

My problem is that certain websites are inaccessible from darjeeling and
ringo if I don't set the MTU to 1492 on each client. Changing the MTU to
1492 on eth0 just fubars my PPP connection.

Alternatively, setting up a HTTP proxy on br0 works as well, and is the
solution I'm using for my clients at home right now.

Could somebody explain to me what is going on? What I would prefer to do
is use a solution that doesn't require me to use the proxy or change
everyone's MTU to 1492.

If I'm being unclear please ask me to clarify, I'm not quite sure I have
all this understood myself.

Please CC me as I'm not subscribed to the list.

Thanks!

--=20
Joshua Kwan


--------------enigE90E230A2EAF84891F4D91C5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRH5hLqOILr94RG8mAQLoGA/+PpJntehPSqUMiNIZusnrKwfevm3xME6w
KHgQhQ9V0quYKO6dR7nf0qxMoge3Cgwie4qjQZcBSgUo5mhEMmlr0KY10iGSvLlk
jyAO4GiBkQ/jojrwDMYNffOlcWlMHjkToKTFCU4du81cBkBmvixUNV5MD0XJgzF8
bSCrm29HyOWoHjMEI1K4CCTPHmlMtY3fyMu/h4iEM2i4797dyg7k3Ijpb6IkKuLB
wP1aCARnQVi3SBrq7QyWqGHVAJy7eaR/sV63AoIxQRVdoyWUiQDG8LJ63ew1Y9cL
R7eEuvCWYrRJzWd9yGfzC4pIxEPqTwesJIS1hspzKFALTnTtaAVxWgWsvN0d8feI
l3AaB7WuoABS3Uxpepot3djRU/JLpXJz6wEgYkASNNAbo0Wk7EZu6+nx4Fgqut5B
kCIkMjk7TmLP5lIdCQdhNqRWE/b5QxUDePffOHPZ36+2WzyJhu7TcEIpOAMo5GBC
kzOOCCR489SdZIHvbZXM0Q/38h9Rl3q4mW2E4yNXFtYIOdfshpekjSFNWjwX4DMJ
JQFDPtVcRLvJEtgFV4+HrN18zuoib79hJSZgqgR8/DX9sj9MTGZEoWgTbw8UiJQX
gl5ZD5k/c81h9oNeGVxcc/ceP2M/236/0XvJHFhSn+GQ+IGFOnOe7AtTHXsWdiaf
MtPvAv0dDfk=
=UyJM
-----END PGP SIGNATURE-----

--------------enigE90E230A2EAF84891F4D91C5--
