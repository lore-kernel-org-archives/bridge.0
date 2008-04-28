Date: Mon, 28 Apr 2008 12:28:46 -0400
From: "John W. Linville" <linville@tuxdriver.com>
Message-ID: <20080428162846.GA17786@tuxdriver.com>
References: <481597F3.6060400@sneakemail.com>
	<20080428125307.GB3499@tuxdriver.com>
	<20080428100453.156604um6fopq938@webapps.ghq.linux-wlan.com>
	<4815ED77.3030306@sneakemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4815ED77.3030306@sneakemail.com>
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

On Mon, Apr 28, 2008 at 05:29:59PM +0200, "Peter Valdemar M=F8rch (Lists)" =
wrote:

> The ADSL / phone line comes into the house in a very impractical place.
> I have servers + switch in one place, and some other equipment in
> another. I'd like to connect these into a single subnet with a
> wireless+ethernet bridge in each island. Sorta like the Linksys Wet 54
> claims to do:
> http://www.linksys.com/servlet/Satellite?c=3DL_Product_C2&childpagename=
=3DUS%2FLayout&cid=3D1134692497433&pagename=3DLinksys%2FCommon%2FVisitorWra=
pper&lid=3D9743339789B05

That is a very specialized device and so it is probably using some
form of L2 NAT.  I wonder for example if it even supports multiple
devices attached to it's ethernet port?

As for the scenario you describe, I have something similar at my
location.  I use two wrt54g's running OpenWRT, and I establish WDS
connections between them.

> Honestly, from your emails I can hear it is not easy, but I'm still not
> clear whether this is possible under Linux. Apparently it *is* possible
> for the Linksys to do it...

It is possible on Linux, but not with a mac80211-based device using
a stock kernel.

John
--=20
John W. Linville
linville@tuxdriver.com
