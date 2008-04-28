Date: Mon, 28 Apr 2008 08:53:07 -0400
From: "John W. Linville" <linville@tuxdriver.com>
Message-ID: <20080428125307.GB3499@tuxdriver.com>
References: <481597F3.6060400@sneakemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <481597F3.6060400@sneakemail.com>
Subject: Re: [Bridge] Ethernet+Wireless Bridge?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Peter Valdemar =?iso-8859-1?Q?M=F8rch_=28Lists=29?= <4ux6as402@sneakemail.com>
Cc: bridge@lists.linux-foundation.org

On Mon, Apr 28, 2008 at 11:25:07AM +0200, "Peter Valdemar M=F8rch (Lists)" =
wrote:

> http://www.linux-foundation.org/en/Net:Bridge#It_doesn.27t_work_with_my_W=
ireless_card.21
> tells me to expect this.
>=20
> It says:
> > FAQ 7.16: It doesn't work with my Wireless card!
> >=20
> > This is a known problem, and it is not caused by the bridge code.
> > Many wireless cards don't allow spoofing of the source address. It is
> > a firmware restriction with some chipsets. You might find some
> > information in the bridge mailing list archives to help.
>=20
> ... HELP! Are the HOWTOs wrong, or is the above FAQ info wrong?

Spoofing the source MAC is actually forbidden by the 802.11 standard.

Bridging between ethernet and wireless is really only possible if
either your host is an access point or you are using a WDS interface
(or both).  The upstream mac80211 code does not currently support
being an access point (although there are patches floating around
that enable it).  IIRC, a patch to enable using WDS has recently
been merged.  Whether or not that is useful depends on what equipment
you have, and honestly I haven't really used it myself.

What is the goal you are trying to achieve?  In many cases it might
be easier for you to simply setup NAT routing between your ethernet
and wireless connections.

John
--=20
John W. Linville
linville@tuxdriver.com
