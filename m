Message-ID: <41EECDA0.4090909@jbaw.iba.by>
Date: Wed, 19 Jan 2005 23:14:08 +0200
From: "Bogdan B. Rudas" <rudas@jbaw.iba.by>
MIME-Version: 1.0
Subject: Re: [Bridge] bridge with ppp0
References: <41C3675E.1010402@langhofer.at>
In-Reply-To: <41C3675E.1010402@langhofer.at>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC9B0C7395CAD2A537D6D35EE"
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC9B0C7395CAD2A537D6D35EE
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

You should use interfaces with same MTU size. In same situaion I made 
OpenVPN tunel over ppp conntction with MTU 1500 (same as in ethernet 
network)

On Sat, 18 Dec 2004 00:10:22 +0100
armin langhofer <office@langhofer.at> wrote:

> hi there
> 
> i found your project and tried to bridge two ppp devices.
> 
> 
> you say (http://bridge.sourceforge.net/faq.html) that this is possible:
> 
> ... "Linux bridging is very flexible; the LAN's can be either 
> traditional Ethernet device's, or pseudo-devices such as PPP, VPN's or 
> VLAN's. The only restrictions are that the devices:" ...
> 
> 
> i tried this but got "br_add_interface: Invalid argument" when adding a 
> ppp device to the bridge. adding an ethernet device works perfectly!
> 
> 00:07:21 protector ~ # brctl addbr br0
> 00:07:22 protector ~ # brctl addif br0 eth2
> 00:07:30 protector ~ # brctl addif br0 ppp0
> br_add_interface: Invalid argument
> 
> 
> 
> the ppp's are done with pppd and pptpd (poptop)
> 00:09:39 protector ~ # pppd --version
> pppd version 2.4.2
> 00:09:44 protector ~ # pptpd --version
> PoPToP v1.1.4-b4
> 
> 
> any ideas?
> 
> best regards, armin.
> -- 
> armin langhofer
> snail:  fischer von erlachstr. 29
> snail:  a-5020 salzburg
> phone:  +43 699 11648495
> email:  office@langhofer.at
> gnupg:  http://langhofer.at/pubkey.txt
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/bridge

--------------enigC9B0C7395CAD2A537D6D35EE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB7s2gC2VaeYaW2NkRAtvjAJ406NQABiLckt82GOPgS8JKkfOpVgCfQssI
QtHk4CSKwq40AdQCIOAfmJ0=
=4nxX
-----END PGP SIGNATURE-----

--------------enigC9B0C7395CAD2A537D6D35EE--
