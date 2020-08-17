Return-Path: <daniel@makrotopia.org>
Date: Mon, 17 Aug 2020 15:24:38 +0100
From: Daniel Golle <daniel@makrotopia.org>
Message-ID: <20200817142438.GB1299@makrotopia.org>
References: <20200816202424.3526-1-linus.luessing@c0d3.blue>
 <87zh6t650b.fsf@miraculix.mork.no> <1830568.o5y0iYavLQ@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1830568.o5y0iYavLQ@sven-edge>
Subject: Re: [Bridge] [gluon] Re: [RFC PATCH net-next] bridge: Implement MLD
 Querier wake-up calls / Android bug workaround
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, gluon@luebeck.freifunk.net, openwrt-devel@lists.openwrt.org, "David S . Miller" <davem@davemloft.net>, =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>

On Mon, Aug 17, 2020 at 03:17:37PM +0200, Sven Eckelmann wrote:
> On Monday, 17 August 2020 10:39:00 CEST Bj=F8rn Mork wrote:
> > Linus L=FCssing <linus.luessing@c0d3.blue> writes:
> [...]
> > This is not a bug.  They are deliberately breaking IPv6 because they
> > consider this a feature.  You should not try to work around such issues.
> > It is a fight you cannot win.  Any workaround will only encourage them
> > to come up with new ways to break IPv6.
>=20
> Who are "they" and where is this information coming from? And what do the=
y=20
> gain from breaking IPv6? Wouldn't it be easier for them just to disable I=
Pv6=20
> than adding random looking bugs?

They are Google and they want IPv6 to be used in a way which exposes
as much user data as possible to their servers (that's my guess).
Every additional identifying bit is like gold for them (that's their
business model).
Hence they like SLAAC and addressing schemes which reflect the network
topology and are enforcing that direction beyond good reason (that
should be obvious[1] to everyone[2] by now[3], no matter what the
reasons for that are).
You may say, hey, SLAAC also allows me to use Privary Extension and I'm
sure your browser will make use of that. But does the DNS resolver?
And what about all those Google services running in background? I'm not
sure all of them instruct the kernel to open every single socket using
a privacy source address...
Simply, when relying on SLAAC + Privary Extensions it's up to the
(mobile) client to avoid being very easily tracked.
When using DHCPv6 the situation is like it was for v4 (ok, it's still
a bit worse because you can distinguish clients much better).

As a work-around, I've been limiting source EUI-64 addresses from
leaving my local network -- but that's surely not what everyone would
want to make sure their local devices MAC addresses aren't leaked and
also just breaking v6 in yet another way.
I don't consider NAT66 an option and would like to avoid even
connection-tracking on v6 as it was promissed :). Tethering should
work using DHCPv6 prefix delegation imho rather than ND-proxy or
NAT66 which are both quite a burden for the battery-powered device
offering the tethering gateway (ie. each forwarded packet then needs
CPU intervention, I can't see anything great about that).



[1]: https://www.nullzero.co.uk/android-does-not-support-dhcpv6-and-google-=
wont-fix-that/

[2]: https://www.techrepublic.com/article/androids-lack-of-dhcpv6-support-f=
rustrates-enterprise-network-admins/

[3]: https://lostintransit.se/2020/05/22/its-2020-and-androids-ipv6-is-stil=
l-broken/
