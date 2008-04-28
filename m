Message-ID: <4815ED77.3030306@sneakemail.com>
Date: Mon, 28 Apr 2008 17:29:59 +0200
From: =?ISO-8859-1?Q?=22Peter_Valdemar_M=F8rch_=28Lists=29=22?=
	<4ux6as402@sneakemail.com>
MIME-Version: 1.0
References: <481597F3.6060400@sneakemail.com>	<20080428125307.GB3499@tuxdriver.com>
	<20080428100453.156604um6fopq938@webapps.ghq.linux-wlan.com>
In-Reply-To: <20080428100453.156604um6fopq938@webapps.ghq.linux-wlan.com>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Ethernet+Wireless Bridge?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Thank you so much for your replies! REALLY!!!!

Mark S. Mathews mark-at-linux-wlan.com |Lists| wrote:
> Heh.  I think the reason most folks think this should 'just work' is
>  because: "hey, it's wireless ethernet, right?", wrong.  You can't=20
> ether-bridge natively across rs232, or bluetooth, or [any one of a=20
> hundred non-ethernet media]  either.

Ok, thanks! So all the howto's that simply suggest to do brctl and
ifconfig as if there are no problems are simply *wrong*. Glad to get
that cleared up. I thought I was going mad!

> If your config consists of a STA and an AP, then the most forthright
>  solution (not necessarily easy, mind you...takes a bit of tweaking
> to get it right) is to tunnel your ethernet frames across that link.
> I've used vtun for this purpose in the past.
>=20
> And, as John pointed out, using routing, with or without NAT, is even
>  easier. Do you _really_ have to have a bridge?

No, I don't _really_ have to. :-) But it annoys me not knowing *why* it
doesn't work, especially with bozos telling me it is easy.

The ADSL / phone line comes into the house in a very impractical place.
I have servers + switch in one place, and some other equipment in
another. I'd like to connect these into a single subnet with a
wireless+ethernet bridge in each island. Sorta like the Linksys Wet 54
claims to do:
http://www.linksys.com/servlet/Satellite?c=3DL_Product_C2&childpagename=3DU=
S%2FLayout&cid=3D1134692497433&pagename=3DLinksys%2FCommon%2FVisitorWrapper=
&lid=3D9743339789B05

 From http://en.wikipedia.org/wiki/Wi-Fi :
> Wireless network bridges connect a wired network to a wireless
> network. This is different from an access point in the sense that an
> access point connects wireless devices to a wired network at the
> data-link layer.

So now I'm still clueless. The Linksys apparatus seems to do what I=20
need. It seems not to be an Access Point. Does this mean the Linksys=20
above is "using a WDS interface", and does not run as STA?

Honestly, from your emails I can hear it is not easy, but I'm still not
clear whether this is possible under Linux. Apparently it *is* possible
for the Linksys to do it...

Peter
--=20
Peter Valdemar M=F8rch
http://www.morch.com
