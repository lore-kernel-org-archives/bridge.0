Return-Path: <M.Roos@f1-outsourcing.eu>
Date: Sat, 7 Apr 2018 09:59:37 +0200
From: "Marc Roos" <M.Roos@f1-outsourcing.eu>
Message-ID: <"H000007100115254.1523087977.sx.f1-outsourcing.eu*"@MHS>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Bridge] Bridge with 1x eth and 2x tun, adding 2nd eth,
	hosts become unavailable
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge <bridge@lists.linux-foundation.org>



In this situation I can ping a vm from br0 connected to 172.16.1.y



               +-----------+          =20
               |    BR0    |          =20
   172.16.1.y  |           |      172.16.1.x
       --------|ETH2   TUN1|-------          =20
               |           |          =20
               |           |      172.16.1.x
               |       TUN2|-------          =20
               |           |
               +-----------+=20

When only adding a 2nd eth adapter with 'brctl addif br0 eth1' connected=20
to 10.11.12.y. The same ping is not working anymore.


               +-----------+          =20
               |    BR0    |          =20
   172.16.1.y  |           |      172.16.1.x
       --------|ETH2   TUN1|-------          =20
               |           |          =20
               |           |      172.16.1.x
    10.11.12.y |       TUN2|-------          =20
       --------|ETH1       |
               +-----------+          =20
			            =20
When I remove the eth1 again, the ping starts working again.

Can someone explain me why the bridge is behaving like this? And how=20
this can be fixed?

=09

	  =20
