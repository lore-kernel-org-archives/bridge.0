Message-ID: <4811ACBC.1080708@sneakemail.com>
Date: Fri, 25 Apr 2008 12:04:44 +0200
From: =?ISO-8859-1?Q?Peter_Valdemar_M=F8rch?= <4ux6as402@sneakemail.com>
MIME-Version: 1.0
References: <480C9FA2.2050805@morch.com> <000701c8a44c$ede7a470$3a00a8c0@info1>
In-Reply-To: <000701c8a44c$ede7a470$3a00a8c0@info1>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] USB device for Layer 2 Wireless Bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Peter M=F8rch wrote:
> Bridging with wireless apparently is not trivial with linux as "Many
> wireless cards don't allow spoofing of the source address" according
> to
>=20
http://www.linux-foundation.org/en/Net:Bridge#It_doesn.27t_work_with_my_Wir=
eless_card.21

To which Becskei Robert replied:
> I did it and it still works bridging with linux + 2 wireless pairs.
>=20
> See my guide=20
> http://www.linuxhelp.net/forums/Channel_Bonding_load_balancing_t8478.html
> ,
>=20
> the important part was
>=20
> NOTE : I've had a hell of time making the 2 wireless links work
> together nicely, in order to make them work in a bonding scenario
> like this, I had to enable a certain option called MAC ADDRESS
> CLONING, and had to use different SSID , and different CHANNEL.

Please excuse my ignorance, but doesn't the above link assume
that brctl and ifconfig will work bridging wireless and ethernet?

I could not get a bridge between my wireless (using the ipw3945 driver)
and eth0 interfaces to work.

As I read
http://www.linux-foundation.org/en/Net:Bridge#It_doesn.27t_work_with_my_Wir=
eless_card.21=20



it seems to me bridging wireless and ethernet won't work in the most
common cases. Is that true at least?

I would really like to create a layer 2 bridge between my ethernet and
wireless networks, but right now have no clue how to continue... brctl
and ifconfig did not work for me with my hardware... Any help or
enlightenment appreciated!

Peter
--=20
Peter Valdemar M=F8rch
http://www.morch.com
