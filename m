From: Matthew Hall <matt@ecsc.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-BBKo3hjLrCxbsA/rLlJg"
Date: Fri, 14 May 2004 15:35:29 +0100
Message-Id: <1084545329.3681.65.camel@miyazaki>
Mime-Version: 1.0
Subject: [Bridge] Static arp entries in showmacs?
Reply-To: matt@ecsc.co.uk
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org


--=-BBKo3hjLrCxbsA/rLlJg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi all,
	You'll have to excuse me if i'm replicating questions asked before;
i've googled till I died and couldn't find anything on the list archives
on this subject.

I'm having a little problem with my bridge and its interaction with a
'Windows Load Balanced Server' (whoopee, guess where the problem
lies ;) ). To give a little background, we've got a windows server
hosted on a bridged lan behind our linux firewall (kern: 2.4.21). The ip
of the server itself is an alias shared by 3 load balanced windows
machines.=20
The symptoms of our problem are that incoming web traffic to our
firewall is being dnatted to the internal ip and that traffic is being
passed out of all the bridged interfaces. This is happening because the
bridge does not have a mac address nextentry for what the kernel
believes is the mac address of that machine. The bridge doesn't have a
mac address for it because when our box makes an arp request for the ip
address, all three windows servers' reply at the same time, with the
same arp layer address, but with differing ether addresses; e.g.

  1   0.000000 00:50:c2:11:34:9d ->              ARP Who has 10.0.0.21?  Te=
ll 10.0.0.1
  2   0.000108 00:08:02:a1:e6:a1 ->              ARP 10.0.0.21 is at 03:bf:=
0a:00:00:15
  3   0.000112 00:08:02:47:be:16 ->              ARP 10.0.0.21 is at 03:bf:=
0a:00:00:15
  4   0.000136 00:02:a5:eb:f8:45 ->              ARP 10.0.0.21 is at 03:bf:=
0a:00:00:15

This seems to confuse the bridge somewhat (at least it seems that way to
me, but could be the intended behaviour); as the bridge updates it's arp
tables with the ether source addresses ('pointing' to the correct
physical interface); yet the kernel arp tables contain the arp layer
address (03:bf) 'pointing' to the bridge; e.g:

# brctl showmacs br0
port no mac addr                is local?       ageing timer
  2     00:02:a5:eb:f8:45       no                 0.15
  2     00:08:02:a1:e6:a1       no                 0.12
  2     00:08:02:47:be:16       no                 0.01

# arp -n
Address                  HWtype  HWaddress           Flags Mask            =
Iface
10.0.0.21                ether   03:BF:0A:00:00:15   C                     =
br0


As I see it:
When packets are dnatted to the internal ip, the kernel modifies the
destination ip and ethernet address of the packet to send to 03:bf; it's
then passed to the bridge, the bridge can't correlate the 03:bf hardware
address with any particular interface, fails 'open' and sends the frame
out of all the interfaces on the bridge (to the 03:bf ether address).=20

I think quite obviously, this is the fault of the windows machines
replying in unison with differing ether addresses to arp addresses, but
I was wondering if there was a way to workaround the problem (and moving
away from windows isn't a solution, at least for our client).


The most obvious method I could see is to set a static mac addr entry
for the offending 03:bf address out of the right interface in the
forwarding database; yet I'm unable to find any documentation on how to
do so.
I've gone so far to look at the bridge-utils and kernel bridging code
but alas, could not find that particular functionality; though the
presence of is_static in the forwarding database (struct
net_bridge_fdb_entry) would lead me to believe maybe it's is possible??.
So I ask, whether there is such functionality, if so how so; or if not
has anyone got any good ideas... (doing it this way, would be a 'clean'
solution for me; though i'll probably try ebtables as a last resort, if
I can't figure this out).

Thanks in advance,
Matt

--=-BBKo3hjLrCxbsA/rLlJg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBApNkxw5xT5S6r89URAv8cAJ9HNvGRzn3LyTFzqPfXlOK8jlZlLwCeK963
yBa7QhZHo3NSQeoLGNXloK0=
=Awdj
-----END PGP SIGNATURE-----

--=-BBKo3hjLrCxbsA/rLlJg--

