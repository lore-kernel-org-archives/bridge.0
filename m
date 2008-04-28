Message-ID: <20080428100453.156604um6fopq938@webapps.ghq.linux-wlan.com>
Date: Mon, 28 Apr 2008 10:04:53 -0400
From: "Mark S. Mathews" <mark@linux-wlan.com>
References: <481597F3.6060400@sneakemail.com>
	<20080428125307.GB3499@tuxdriver.com>
In-Reply-To: <20080428125307.GB3499@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
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
To: "John W. Linville" <linville@tuxdriver.com>
Cc: bridge@lists.linux-foundation.org

Heh.  I think the reason most folks think this should 'just work' is =20
because: "hey, it's wireless ethernet, right?", wrong.  You can't =20
ether-bridge natively across rs232, or bluetooth, or [any one of a =20
hundred non-ethernet media]  either.

If your config consists of a STA and an AP, then the most forthright =20
solution (not necessarily easy, mind you...takes a bit of tweaking to =20
get it right) is to tunnel your ethernet frames across that link.  =20
I've used vtun for this purpose in the past.

And, as John pointed out, using routing, with or without NAT, is even easier=
.
Do you _really_ have to have a bridge?

Have fun,
-Mark


Quoting "John W. Linville" <linville@tuxdriver.com>:

> On Mon, Apr 28, 2008 at 11:25:07AM +0200, "Peter Valdemar M=F8rch =20
> (Lists)" wrote:
>
>> http://www.linux-foundation.org/en/Net:Bridge#It_doesn.27t_work_with_my_W=
ireless_card.21
>> tells me to expect this.
>>
>> It says:
>> > FAQ 7.16: It doesn't work with my Wireless card!
>> >
>> > This is a known problem, and it is not caused by the bridge code.
>> > Many wireless cards don't allow spoofing of the source address. It is
>> > a firmware restriction with some chipsets. You might find some
>> > information in the bridge mailing list archives to help.
>>
>> ... HELP! Are the HOWTOs wrong, or is the above FAQ info wrong?
>
> Spoofing the source MAC is actually forbidden by the 802.11 standard.
>
> Bridging between ethernet and wireless is really only possible if
> either your host is an access point or you are using a WDS interface
> (or both).  The upstream mac80211 code does not currently support
> being an access point (although there are patches floating around
> that enable it).  IIRC, a patch to enable using WDS has recently
> been merged.  Whether or not that is useful depends on what equipment
> you have, and honestly I haven't really used it myself.
>
> What is the goal you are trying to achieve?  In many cases it might
> be easier for you to simply setup NAT routing between your ethernet
> and wireless connections.
>
> John
> --
> John W. Linville
> linville@tuxdriver.com
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>



Mark S. Mathews

AbsoluteValue Systems      Web:    http://www.linux-wlan.com
721-D North Drive          e-mail: mark@linux-wlan.com
Melbourne, FL 32934        Phone:  321.259.0737
USA                        Fax:    321.259.0286

