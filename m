Message-ID: <481B034B.70606@no-spam.net>
Date: Fri, 02 May 2008 14:04:27 +0200
From: Nicolas <nicolas@no-spam.net>
MIME-Version: 1.0
References: <481597F3.6060400@sneakemail.com>
	<20080428125307.GB3499@tuxdriver.com>
In-Reply-To: <20080428125307.GB3499@tuxdriver.com>
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

John W. Linville a =E9crit :
>=20
> Spoofing the source MAC is actually forbidden by the 802.11 standard.

My two cents :

We all agree about the fact that most current wireless implementations=20
do not permit spoofing the source MAC, probably for many good and=20
several bad reasons.

But wouldn't it be possible, as a temporary and dirty fix, to simply=20
send any outgoing frames with the wireless interface MAC as the source=20
MAC when the bridge send on a wireless interface ?

Of course, this breaks the bridge transparency principle and might cause=20
serious problem with BPDU, but on a simple (or simpler) configuration,=20
without STP, this might work well for most level 3+ services. For=20
example, an ARP answer can come for a different source MAC than the one=20
stated in the ARP payload. So ARP should work well, even if the source=20
MAC might look strange for someone having a close look at the frame.

Also, the bridge global MAC (of br0) might be forced to the MAC of the=20
wireless interface if there is only a single wireless interface in the=20
bridge, probably causing BPDU to work well too.

This is only theoretical and - I admit - a very dirty fix into the=20
bridge code, but... better than noting. And by the way, may be this can=20
be setup using ebtable, which is cleaner !

Any comments ?

	Nicolas.

