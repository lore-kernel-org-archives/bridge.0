Date: Tue, 29 Apr 2008 09:15:43 -0400
From: "John W. Linville" <linville@tuxdriver.com>
Message-ID: <20080429131543.GA4887@tuxdriver.com>
References: <481597F3.6060400@sneakemail.com>
	<20080428125307.GB3499@tuxdriver.com>
	<20080428100453.156604um6fopq938@webapps.ghq.linux-wlan.com>
	<4815ED77.3030306@sneakemail.com>
	<20080428162846.GA17786@tuxdriver.com>
	<4816F896.4040802@sneakemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4816F896.4040802@sneakemail.com>
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

On Tue, Apr 29, 2008 at 12:29:42PM +0200, "Peter Valdemar M=F8rch (Lists)" =
wrote:
> First of all, thank you again for taking the time to consider my
> unsubstantiated wishes.
>=20
> John W. Linville linville-at-tuxdriver.com |Lists| wrote:
> > That is a very specialized device and so it is probably using some
> > form of L2 NAT.  I wonder for example if it even supports multiple
> > devices attached to it's ethernet port?
>=20
> Ok, my wireless expert friend (a windows guy) was surprised that
> bridging between ethernet and wireless wasn't straightforward in linux.
> He says it is trivial and works in Windows, supported by this:
> http://www.microsoft.com/windowsxp/using/networking/expert/crawford_02apr=
il22.mspx
> I'll try it next time I get the chance.

Yes, we all have a friend like that.  I'll try not to speculate on
whether or not your friend is equally as 'knowledgeable' about how
things really work as my Windows-using friends tend to be.  I find
that the "Windows Just Works" mentality breeds (or attracts) a lack
of intellectual curiousity as to "How It Works"...

Unfortunately that article only explains how to turn-on whatever
Windows does (along with some references on what to do if it _does_not_
Just Work), but it doen't go into any technical detail of how Windows
implements it.  Again I assure you that there are technical reasons
why bridging to wireless is not as simple as your friend would seem
to believe it is.

> > It is possible on Linux, but not with a mac80211-based device using
> > a stock kernel.
>=20
> Ok, I can feel I'm getting stubborn now, and if you are beginning to=20
> consider me a troll, just don't reply, and I'll bugger off for now!
>=20
> I just still don't get it. I'll accept that it involves "black magic" in =

> Linux but is trivial with Windows or with Linksys. To my surprise.

It is only 'trivial' in those other cases because someone has written
code to hide the magic.  If I'm not mistaken, current or near-furture
versions of NetworkManager should perform similar magic.  You might
want to see if the version in Fedora 9 can help.

> Otherwise, can you suggest some reading I can do to understand what=20
> Windows and Linksys does but that Linux can not do with a mac80211-based =

> device using a stock kernel? What is "L2 NAT"? Is it acting as an access =

> point (Even though other wireless devices can't connect to it)? WDS=20
> sound to me to have many interoperability problems, that Linksys and=20
> Windows apparently do not suffer from. I'm still clueless, I'm affraid.

Again, I don't know what Windows and Linksys are doing.  As I
suggested, I suspect they are using L2 NAT.  Similar to IP NAT, L2
NAT is a technique for pretending that traffic from other (in this
case L2 aka Ethernet) addresses is actually from you.  I found a
brief discussion of it in section 3.6.2 here:

	http://lwn.net/Articles/145002/

As for WDS, it is the Gold Standard for bridging over wireless.
But as you suggest, for whatever reason many APs (and probably most
end-stations) will not accept WDS frames from just anyone (if they do
so at all).  Given that, it seems an unlikely candidate for the type of
ad-hoc setup that either Windows or the Linksys device is providing.
Still, it is what I would recommend for your (semi-)permanent setup
if the upstream code supported it at this time for your device.
Unfortunately it does not.

For now, my previous recommendation (routing w/ or w/o IP NAT) still
stands as the simplest and best documented approach.  If that does
not appeal to you, I suspect that bridging combined with L2 NAT via
ebtables as described in the URL cited above will work...YMMV.

> Thanks a lot for your attention whatever the outcome.

Good luck!

John
--=20
John W. Linville
linville@tuxdriver.com
