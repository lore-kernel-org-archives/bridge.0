Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7191C81CAD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B1417817B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6FJ4mGB08F/bkBA0qBpCPnkDm2wkG0ym/ykj8fmmLo=;
 b=AMaTlI0HDLP+O0vR7Ec2OM/knBQClCOx4+3jEue69n3ZTszbDgawc5idq0J/Zd+5vtEKYcprFgbadgSL/MsE1xgkPv5NW14mXfOBw98iHGxX13eDAvDONQijWzfI1pyw6vUi/f0QqieqFKCNyOAcVSi2vinU9QqSF/EtO8x4Q5Qb8HCjsLiWrQoXrkwEsrQ+SJP/pFs0PUCaIwLe1HctfuFSCJV/M1EB8CK7/qj09WpAdhHkezQWvhJzhHTw4hhwh7Ko+Rx3NG6Qlbpw91l3iUmNInhc+Q8mdwtLz61+J6gQvwmB+U5bR5RJKJTxuGiIuBjkkCxbX18QCrjWzZMAYQ==
Date: Mon, 29 Aug 2022 14:32:37 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Ywyj1VF1wlYqlHb6@shredder>
References: <20220826114538.705433-1-netdev@kapio-technology.com>
 <20220826114538.705433-7-netdev@kapio-technology.com>
 <YwpgvkojEdytzCAB@shredder>
 <7654860e4d7d43c15d482c6caeb6a773@kapio-technology.com>
 <YwxtVhlPjq+M9QMY@shredder>
 <2967ccc234bb672f5440a4b175b73768@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2967ccc234bb672f5440a4b175b73768@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v5 net-next 6/6] selftests: forwarding: add
 test of MAC-Auth Bypass to locked port tests
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@kapio-technology.com
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, bridge@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Mon, Aug 29, 2022 at 10:01:18AM +0200, netdev@kapio-technology.com wrote:
> On 2022-08-29 09:40, Ido Schimmel wrote:
> > On Sun, Aug 28, 2022 at 02:00:29PM +0200, netdev@kapio-technology.com
> > wrote:
> > > On 2022-08-27 20:21, Ido Schimmel wrote:
> > > > On Fri, Aug 26, 2022 at 01:45:38PM +0200, Hans Schultz wrote:
> > > > > +locked_port_mab()
> > > > > +{
> > > > > +	RET=0
> > > > > +	check_locked_port_support || return 0
> > > > > +
> > > > > +	ping_do $h1 192.0.2.2
> > > > > +	check_err $? "MAB: Ping did not work before locking port"
> > > > > +
> > > > > +	bridge link set dev $swp1 locked on
> > > > > +	bridge link set dev $swp1 learning on
> > > >
> > > > "locked on learning on" is counter intuitive and IMO very much a
> > > > misconfiguration that we should have disallowed when the "locked" option
> > > > was introduced. It is my understanding that the only reason we are even
> > > > talking about it is because mv88e6xxx needs it for MAB for some reason.
> > > 
> > > As the way mv88e6xxx implements "learning off" is to remove port
> > > association
> > > for ingress packets on a port, but that breaks many other things
> > > such as
> > > refreshing ATU entries and violation interrupts, so it is needed and
> > > the
> > > question is then what is the worst to have 'learning on' on a locked
> > > port or
> > > to have the locked port enabling learning in the driver silently?
> > > 
> > > Opinions seem to differ. Note that even on locked ports without MAB,
> > > port
> > > association on ingress is still needed in future as I have a dynamic
> > > ATU
> > > patch set coming, that uses age out violation and hardware
> > > refreshing to let
> > > the hardware keep the dynamic entries as long as the authorized
> > > station is
> > > sending, but will age the entry out if the station keeps silent for
> > > the
> > > ageing time. But that patch set is dependent on this patch set, and
> > > I don't
> > > think I can send it before this is accepted...
> > 
> > Can you explain how you envision user space to work once everything is
> > merged? I want to make sure we have the full picture before more stuff
> > is merged. From what you describe, I expect the following:
> > 
> > 1. Create topology, assuming two unauthorized ports:
> > 
> > # ip link add name br0 type bridge no_linklocal_learn 1 (*)
> > # ip link set dev swp1 master br0
> > # ip link set dev swp2 master br0
> > # bridge link set dev swp1 learning on locked on
> > # bridge link set dev swp2 learning on locked on
> 
> The final decision on this rests with you I would say.

If the requirement for this feature (with or without MAB) is to work
with dynamic entries (which is not what is currently implemented in the
selftests), then learning needs to be enabled for the sole reason of
refreshing the dynamic entries added by user space. That is, updating
'fdb->updated' with current jiffies value.

So, is this the requirement? I checked the hostapd fork you posted some
time ago and I get the impression that the answer is yes [1], but I want
to verify I'm not missing something.

[1] https://github.com/westermo/hostapd/commit/95dc96f9e89131b2319f5eae8ae7ac99868b7cd0#diff-338b6fad34b4bdb015d7d96930974bd96796b754257473b6c91527789656d6edR11


> Actually I forgot to remove the port association in the driver in this
> version.
> 
> > # ip link set dev swp1 up
> > # ip link set dev swp2 up
> > # ip link set dev br0 up
> > 
> > 2. Assuming h1 behind swp1 was authorized using 802.1X:
> > 
> > # bridge fdb replace $H1_MAC dev swp1 master dynamic
> 
> With the new MAB flag 'replace' is not needed when MAB is not enabled.

Yes, but replace works in both cases.

> 
> > 
> > 3. Assuming 802.1X authentication failed for h2 behind swp2, enable MAB:
> > 
> > # bridge link set dev swp2 mab on
> > 
> > 4. Assuming $H2_MAC is in our allow list:
> > 
> > # bridge fdb replace $H2_MAC dev swp2 master dynamic
> > 
> > Learning is on in order to refresh the dynamic entries that user space
> > installed.
> 
> Yes, port association is needed for those reasons. :-)

Given that the current tests use "static" entries that cannot age, is
there a reason to have "learning on"?

> 
> > 
> > (*) Need to add support for this option in iproute2. Already exposed
> > over netlink (see 'IFLA_BR_MULTI_BOOLOPT').
> 
> Should I do that in this patch set?

No, I'm saying that this option is already exposed over netlink, but
missing iproute2 support. No kernel changes needed.
