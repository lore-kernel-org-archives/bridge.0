Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 150194182B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7E6E04184D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdWROuxypSVzKqXt30Dg9mYcmstGVwU0v4Aih9zJreM=;
 b=tlsZKrLyEF84EI7xtuVfBV/M/NF+PE+qYlqPfSNDOxUDkupyexgiO9jxv9iQLWi7bfG6i3Hh0D/RcSsi/cE4/UFIUSvwK9t9py+xVFFZD1QzRA4uOyweKfTibpeaEHqrZqOA+HCa50CzuxUWCYZCNNgM6MZak3XKyPOw4Tau5eC28fruLo70uR/F1nHvCWOiBIlEEVRSWMbPLwUaanRV6jLwzz6W2xHhwirr7RICIOPYblkBJrOz4TgAJE0eUye1xPnQwsbjRjZ8ytlQGigJe1YH4agxVtZ8syq5JoHgbSXgQhnSK6WuFTZsRzlecFhMCWIgy2Yt7NCe49VKUUlCvg==
Date: Tue, 18 Oct 2022 09:22:57 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y05GQWYu0vM+bx5t@shredder>
References: <20221009174052.1927483-1-netdev@kapio-technology.com>
 <20221009174052.1927483-4-netdev@kapio-technology.com>
 <Y0gbVoeV/e6wzlbM@shredder>
 <d314ba738b12e28694a955de1301e906@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d314ba738b12e28694a955de1301e906@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v7 net-next 3/9] net: switchdev: add support
 for offloading of the FDB locked flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@kapio-technology.com
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Thu, Oct 13, 2022 at 08:58:57PM +0200, netdev@kapio-technology.com wrote:
> On 2022-10-13 16:06, Ido Schimmel wrote:
> > > diff --git a/net/dsa/port.c b/net/dsa/port.c
> > > index e4a0513816bb..eab32b7a945a 100644
> > > --- a/net/dsa/port.c
> > > +++ b/net/dsa/port.c
> > > @@ -304,7 +304,7 @@ static int dsa_port_inherit_brport_flags(struct
> > > dsa_port *dp,
> > >  					 struct netlink_ext_ack *extack)
> > >  {
> > >  	const unsigned long mask = BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD |
> > > -				   BR_BCAST_FLOOD | BR_PORT_LOCKED;
> > > +				   BR_BCAST_FLOOD;
> > 
> > Not sure how this is related to the patchset.
> > 
> 
> In general it is needed as a fix because of the way learning with locked
> port is handled in the driver,
> so as with MAB and also locked port in the future needing a non-zero Port
> Association Vector (PAV)
> for refresh etc to work, inheritance of the locked port flag is a bad idea
> (say bug) and shouldn't have
> been in the first place.

If it's a fix, then it needs to be submitted to 'net' tree.
