From: Stuart Luppescu <s-luppescu@uchicago.edu>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-zlxwvf7GSfgrPcCnrTPl"
Message-Id: <1076698275.25835.19.camel@musuko.uchicago.edu>
Mime-Version: 1.0
Date: Fri, 13 Feb 2004 12:51:15 -0600
Subject: [Bridge] Fixed module loading problem, but can't run dhcp
Reply-To: s-luppescu@uchicago.edu
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Bridge List <bridge@lists.osdl.org>


--=-zlxwvf7GSfgrPcCnrTPl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I fixed the problem with loading the bridge module. I tried doing make
clean and remaking the kernel, but that didn't help, so I did make
mrproper and that fixed it.

Now I've got my wireless and wired networks bridged but I can't get dhcp
to start for my wireless network. Here are the commands I run to get the
bridged network up:

ifconfig eth0 down
modprobe bridge
modprobe hostap_pci
iwconfig wlan0 essid SNL
brctl addbr br0
brctl addif br0 eth0
brctl addif br0 wlan0
ifconfig eth0 0.0.0.0
ifconfig wlan0 0.0.0.0
ifconfig br0 192.168.1.1 up

I have this in my dhcpd.conf:

subnet 192.168.1.0 netmask 255.255.255.0 {
ddns-updates on;
range 192.168.1.100 192.168.1.164;
}

But when I try and start dhcpd I get these messages:

Feb 13 18:42:58 brian dhcpd: Wrote 0 leases to leases file.
Feb 13 18:42:58 brian dhcpd:=20
Feb 13 18:42:58 brian dhcpd: No subnet declaration for wlan0 (0.0.0.0).
Feb 13 18:42:58 brian dhcpd: ** Ignoring requests on wlan0.  If this is
not what
Feb 13 18:42:58 brian dhcpd:    you want, please write a subnet
declaration
Feb 13 18:42:58 brian dhcpd:    in your dhcpd.conf file for the network
segment
Feb 13 18:42:58 brian dhcpd:    to which interface wlan0 is attached. **
Feb 13 18:42:58 brian dhcpd:=20
Feb 13 18:42:58 brian dhcpd:=20
Feb 13 18:42:58 brian dhcpd: Not configured to listen on any interfaces!

I even put in 0.0.0.0 in the network segment instead of 192.168.1.0, but
that didn't result in anything different.=20

I've been using Linux for nearly 9 years but have never used dhcp. This
has got me stumped. Can anyone give me some advice?

Thanks.
--=20
Stuart Luppescu -=3D- s-luppescu .at. uchicago.edu       =20
University of Chicago -=3D- CCSR=20
=1B$B:MJ8$HCRF`H~$NIc=1B(B -=3D-    Kernel 2.6.1-gentoo               =20
The only "intuitive" interface is the nipple. After
 that, it's all learned. (Bruce Ediger,
 bediger@teal.csn.org, in comp.os.linux.misc, on X=20
 interfaces.)=20

--=-zlxwvf7GSfgrPcCnrTPl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBALRyiDBHcBS0tWxMRAguGAKDOCIgrFpdKSC8V7gmqWh99woy0OwCfS9Hw
C2xyGssqfLyxnxd5wSAePYc=
=JtDG
-----END PGP SIGNATURE-----

--=-zlxwvf7GSfgrPcCnrTPl--

