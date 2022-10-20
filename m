Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9EC5F82D07
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F3E37828E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7W92ag0AKiJBJpoYACJvKkZWNE1ZGcagqI+HW9wDrU=;
 b=GyHxvL1MbfwIm5XLS9+oicHdpeWtUXxDVkp45Ns9G5A/OPYGzZLc/Z4jzqlCu2IVR2Ud1oDYyt1a1zwZPE4gu0dmOkZbauID1CoRa46GYBLmz0janab13ARwjR5pRVD4Un5zQEKyNwKdoq38YgGTJQ2Hi5kAFjPhWowYm1C9XjFt06Xjtj0wTsShQa+Y38wEqOLUSnMzauWhe8v0pwSR6z4y9J5ELokizTBwBT/IcL/SR7uPPnqperoi09j3nCZjDE7LAcCHTck8GY0PZEVyAk5N7wgmA5dgXrZHJEBryGYFuu+afZhRyJlf/tj6oL7uf9HpLzTOFj9TX0hsXCPTLQ==
Date: Thu, 20 Oct 2022 18:23:37 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y1Fn+TnbI/uMH0VR@shredder>
References: <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-6-netdev@kapio-technology.com>
 <20221018165619.134535-6-netdev@kapio-technology.com>
 <20221020130224.6ralzvteoxfdwseb@skbuf> <Y1FMAI9BzDRUPi5Y@shredder>
 <20221020133506.76wroc7owpwjzrkg@skbuf> <Y1FTzyPdTbAF+ODT@shredder>
 <20221020141104.7h7kpau6cnpfqvh4@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020141104.7h7kpau6cnpfqvh4@skbuf>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v8 net-next 05/12] net: dsa: propagate the
 locked flag down through the DSA layer
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, "Hans J. Schultz" <netdev@kapio-technology.com>, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, davem@davemloft.net

On Thu, Oct 20, 2022 at 05:11:04PM +0300, Vladimir Oltean wrote:
> On Thu, Oct 20, 2022 at 04:57:35PM +0300, Ido Schimmel wrote:
> > > Right now this packet isn't generated, right?
> > 
> > Right. We don't support BR_PORT_LOCKED so these checks are not currently
> > enabled in hardware. To be clear, only packets received via locked ports
> > are able to trigger the check.
> 
> You mean BR_PORT_MAB, not BR_PORT_LOCKED, right?

I actually meant BR_PORT_LOCKED... The hardware has a single bit per
port that can be used to enable security checks on the port. If security
checks are enabled, then before L2 forwarding the hardware will perform
an FDB lookup with the SMAC and FID (VID), which can have one of three
results:

1. Match. FDB entry found and it points to the ingress port. In this
case the packet continues to the regular L2 pipeline.

2. Mismatch. FDB entry found, but it points to a different port than
ingress port. In this case we want to drop the packet like the software
bridge.

3. Miss. FDB entry not found. Here I was thinking to always tell the
packet to go to the software data path so that it will trigger the
creation of the "locked" entry if MAB is enabled. If MAB is not enabled,
it will simply be dropped by the bridge. We can't control it per port in
hardware, which is why the BR_PORT_MAB flag is not consulted.

> AFAIU, "locked" means drop unknown MAC SA, "mab" means "install
> BR_FDB_LOCKED entry on port" (and also maybe still drop, if "locked"
> is also set on port).

Right, but you can't have "mab" without "locked" (from patch #1):

```
@@ -943,6 +946,13 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
 	br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_SUPPRESS, BR_NEIGH_SUPPRESS);
 	br_set_port_flag(p, tb, IFLA_BRPORT_ISOLATED, BR_ISOLATED);
 	br_set_port_flag(p, tb, IFLA_BRPORT_LOCKED, BR_PORT_LOCKED);
+	br_set_port_flag(p, tb, IFLA_BRPORT_MAB, BR_PORT_MAB);
+
+	if (!(p->flags & BR_PORT_LOCKED) && (p->flags & BR_PORT_MAB)) {
+		NL_SET_ERR_MSG(extack, "MAB cannot be enabled when port is unlocked");
+		p->flags = old_flags;
+		return -EINVAL;
+	}
 
 	changed_mask = old_flags ^ p->flags;
```

> Sad there isn't any good documentation about these flags in the patches
> that Hans is proposing.

Will try to comment with better commit messages for patches #1 and #2.
Not sure I will have time today.
