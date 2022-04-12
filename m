Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1dMrDnf2iDyG+FBK8NFK2IZWmzgEB0S7YOUIFG78/I=;
 b=kBe9XfUGm4BKDqCdGVtRbRoeeqBqcUe42fyTdaXEzOiaaLR5doZMBjQqOGK7/uX8NIvQG0gHxwxXcweYBgTkv7iRXOEyB61u/7b7qfolkg629ZIXwOGPcoETFOPI8aAlU3P9hPdh10J0UH+4cu7FpIPb+ArYqxZukjVDQQxeWQI=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 12 Apr 2022 13:40:36 +0000
Message-ID: <20220412134032.lm54stqcblahdej2@skbuf>
References: <20220411133837.318876-1-troglobit@gmail.com>
 <20220411133837.318876-8-troglobit@gmail.com>
 <20220411202128.n4dafks4mnkbzr2k@skbuf> <87fsmiburw.fsf@gmail.com>
In-Reply-To: <87fsmiburw.fsf@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <43A5C43A578B114AA2E315EFAE5E28B0@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH RFC net-next 07/13] selftests: forwarding: new
 test, verify bridge flood flags
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joachim Wiberg <troglobit@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On Tue, Apr 12, 2022 at 09:55:31AM +0200, Joachim Wiberg wrote:
> On Mon, Apr 11, 2022 at 20:21, Vladimir Oltean <vladimir.oltean@nxp.com> =
wrote:
> > On Mon, Apr 11, 2022 at 03:38:31PM +0200, Joachim Wiberg wrote:
> >> +# Verify per-port flood control flags of unknown BUM traffic.
> >> +#
> >> +#                     br0
> >> +#                    /   \
> >> +#                  h1     h2
> >
> > I think the picture is slightly inaccurate. From it I understand that h=
1
> > and h2 are bridge ports, but they are stations attached to the real
> > bridge ports, swp1 and swp2. Maybe it would be good to draw all interfa=
ces.
>=20
> Hmm, yeah either that or drop it entirely.  I sort of assumed everyone
> knew about the h<-[veth]->swp (or actual cable) setup, but you're right
> this is a bit unclear.  Me and Tobias have internally used h<-->p (for
> host<-->bridge-port) and other similar nomenclature.  Finding a good
> name that fits easily, and is still readable, in ASCII drawings is hard.
> I'll give it a go in the next drop, thanks!

I wasn't thinking of anything too fancy, this would do I guess.

             br0
            /   \
 h1 --- swp1     swp2 --- h2

> > Also, to be honest, a generic name like "ports" is hard to digest,
> > especially since you have another generic variable name "iface".
> > Maybe "brports" and "station" is a little bit more specific?
>=20
> Is there a common naming standard between bridge tests, or is it more
> important to be consistent the test overview (test heading w/ picture)?
>=20
> Anyway, I'll have a look at the naming for the next drop.

Even if there is a common naming standard in the selftests I wouldn't
know it. I just found the naming here to be vague enough that it is
confusing. If there are other examples of "port" + "iface" please feel
free to disregard.

> >> +declare -A flag1=3D([$swp1]=3Doff [$swp2]=3Doff [br0]=3Doff)
> >> +declare -A flag2=3D([$swp1]=3Doff [$swp2]=3Don  [br0]=3Doff)
> >> +declare -A flag3=3D([$swp1]=3Doff [$swp2]=3Don  [br0]=3Don )
> >> +declare -A flag4=3D([$swp1]=3Doff [$swp2]=3Doff [br0]=3Don )
> > If it's not too much, maybe these could be called "flags_pass1", etc.
> > Again, it was a bit hard to digest on first read.
>=20
> More like flags_pass_fail, but since its the flooding flags, maybe
> flood_patternN would be better?

This works.=
