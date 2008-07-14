Message-ID: <487AFF82.4090707@iki.fi>
Date: Mon, 14 Jul 2008 10:25:54 +0300
From: =?ISO-8859-1?Q?Timo_Ter=E4s?= <timo.teras@iki.fi>
MIME-Version: 1.0
References: <4876FDF0.1030807@iki.fi> <487AA0CD.9090600@snapgear.com>
In-Reply-To: <487AA0CD.9090600@snapgear.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: =?UTF-8?B?VGltbyBUZXLDpHM=?= <timo.teras@gmail.com>
Subject: Re: [Bridge] bridging with gre tunnel
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Philip Craig <philipc@snapgear.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

Philip Craig wrote:
> Timo Ter=E4s wrote:
>> Is there newer/better patches to achieve this? Any thoughts about
>> doing bridging with gre tunnels?
>=20
> Here's a patch I did against 2.6.17.
>=20
> I didn't submit this to mainline though because the userspace ABI
> is ugly.  The basic problem is that the struct used for the ioctl
> isn't extensible.  The only way I can think of to fix it properly
> is to add configuration of gre using netlink, but I never got around
> to doing that. =20

There is an essential difference in this patch compared to the one
I referred to. This patch adds a new way to create GRE devices which
results in ethernet style device whereas the older patch modifies
transmit and receive paths to detect packets coming from bridging
code and does not need userland changes at all.

I kind of like the fact that userland tools work as-is and that
I don't need any special flags for the GRE tunnel creation. However
your patch does look way cleaner.

Any comments on what the solution to merged in should look like?

- Timo

