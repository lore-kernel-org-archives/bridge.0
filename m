Date: Tue, 29 Apr 2008 13:22:22 -0400
From: "John W. Linville" <linville@tuxdriver.com>
Message-ID: <20080429172222.GA11866@tuxdriver.com>
References: <481597F3.6060400@sneakemail.com>
	<20080428125307.GB3499@tuxdriver.com>
	<20080428100453.156604um6fopq938@webapps.ghq.linux-wlan.com>
	<4815ED77.3030306@sneakemail.com>
	<20080428162846.GA17786@tuxdriver.com>
	<4816F896.4040802@sneakemail.com>
	<20080429131543.GA4887@tuxdriver.com>
	<48173D49.50608@sneakemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <48173D49.50608@sneakemail.com>
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

On Tue, Apr 29, 2008 at 05:22:49PM +0200, "Peter Valdemar M=F8rch (Lists)" =
wrote:
> Hi all you wonderful people,
>=20
> Srinivas M.A. srinivas.aji-at-gmail.com |Lists| wrote:
>  > The equivalent solution on Linux seems like parprouted
>  > (http://www.hazard.maks.net/parprouted/), which also seems to be
>  > packaged for Debian, etc. I haven't used it, just found it searching
>  > for "arp proxy" and linux. But it seems worth a look.
>=20
> Yes, I tried parprouted. It works well within what it promises to do.
> But broadcast (e.g. for DHCP!) is not supported. It, in turn suggests to
> use dhcrelay to support DHCP with parprouted. But I didn't try that. I
> still hadn't given up on getting a bridge to work.
>=20
> But I have now.

Discussion of parprouted is probably off-topic here, but I'm glad
someone mentioned it because I didn't know about it.  I have, however,
been manually using the techniques it seems to use for some time to
good effect.

I have had trouble getting either dhcrelay or dhcp-fwd to work in
this kind of environment.  If you figure-out how to make it work,
let me know!  I suspect that the authors of those utilities did not
anticipate that sort of usage, and therefore are not using APIs that
direct outgoing frames appropriately.  However, I could be wrong --
I haven't dug very deeply.

> John W. Linville linville-at-tuxdriver.com |Lists| wrote:
> > For now, my previous recommendation (routing w/ or w/o IP NAT) still
> > stands as the simplest and best documented approach.  If that does
> > not appeal to you, I suspect that bridging combined with L2 NAT via
> > ebtables as described in the URL cited above will work...YMMV.
>=20
> I've just purchased a 3Com 3CRUSB10075 based on the zd1211 driver. Like
> always with Linux it seems, buying hardware is a pseudo-man-month job
> understanding the underlying technologies and so forth. Is the zd1211
> driver "good"? No idea. Does it support WDS?  Promiscuous mode? No idea.
> Will I ever need either? No idea.

Unfortunately, I don't think you will see any different (or at least
not better) behavior with that driver either -- it is also based
on mac80211.

> The fact that I'm frustrated is not an indication that I'm less than in
> awe of the response and attention I've gotten here. Thanks a bundle. I'm
> off to enjoying my 3com with parprouted when it arrives and to
> experiment with nat, routing and ebtables just in case.

Good plan... :-)

John
--=20
John W. Linville
linville@tuxdriver.com
