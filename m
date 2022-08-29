Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 04814400D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 93182400C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4tIL1hpcg1gy7e00Y/TYZiqr8q4n7/NRB6DQoZ6S88=;
 b=MI5JfV/K3fGK/WEX6ahjpqbfi6WgZVY9q+CTHpQnCJqTImb0YiYCtEWcuf2x/Jpeqya4iEx2M4MbdMfnlj3DoYUhZD1Oj+iWi1xqn3bxwYjDF2mFZf/scvZKzxXKYTmHLNubPBYo28To0/MsNt2SStyCtjOO6xRE7mtgMKOvrmQ3mQKWeQb1h/h6EOOQc94Tcy3xDXxmROgzQYah6+j9lzpz/nGxxQGIANptcC0oR3sHN2G555WwNLNErEbbABpfLOMl0/VtdwFMPrBQCbqlZcLNhqKQtWKla2qo36u+975lCDlnFQ2WDhvoE3ZUvt9EfphH7+KLfXnWf1TNEzzhYg==
Date: Mon, 29 Aug 2022 10:40:06 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YwxtVhlPjq+M9QMY@shredder>
References: <20220826114538.705433-1-netdev@kapio-technology.com>
 <20220826114538.705433-7-netdev@kapio-technology.com>
 <YwpgvkojEdytzCAB@shredder>
 <7654860e4d7d43c15d482c6caeb6a773@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7654860e4d7d43c15d482c6caeb6a773@kapio-technology.com>
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

On Sun, Aug 28, 2022 at 02:00:29PM +0200, netdev@kapio-technology.com wrote:
> On 2022-08-27 20:21, Ido Schimmel wrote:
> > On Fri, Aug 26, 2022 at 01:45:38PM +0200, Hans Schultz wrote:
> > > +locked_port_mab()
> > > +{
> > > +	RET=0
> > > +	check_locked_port_support || return 0
> > > +
> > > +	ping_do $h1 192.0.2.2
> > > +	check_err $? "MAB: Ping did not work before locking port"
> > > +
> > > +	bridge link set dev $swp1 locked on
> > > +	bridge link set dev $swp1 learning on
> > 
> > "locked on learning on" is counter intuitive and IMO very much a
> > misconfiguration that we should have disallowed when the "locked" option
> > was introduced. It is my understanding that the only reason we are even
> > talking about it is because mv88e6xxx needs it for MAB for some reason.
> 
> As the way mv88e6xxx implements "learning off" is to remove port association
> for ingress packets on a port, but that breaks many other things such as
> refreshing ATU entries and violation interrupts, so it is needed and the
> question is then what is the worst to have 'learning on' on a locked port or
> to have the locked port enabling learning in the driver silently?
> 
> Opinions seem to differ. Note that even on locked ports without MAB, port
> association on ingress is still needed in future as I have a dynamic ATU
> patch set coming, that uses age out violation and hardware refreshing to let
> the hardware keep the dynamic entries as long as the authorized station is
> sending, but will age the entry out if the station keeps silent for the
> ageing time. But that patch set is dependent on this patch set, and I don't
> think I can send it before this is accepted...

Can you explain how you envision user space to work once everything is
merged? I want to make sure we have the full picture before more stuff
is merged. From what you describe, I expect the following:

1. Create topology, assuming two unauthorized ports:

# ip link add name br0 type bridge no_linklocal_learn 1 (*)
# ip link set dev swp1 master br0
# ip link set dev swp2 master br0
# bridge link set dev swp1 learning on locked on
# bridge link set dev swp2 learning on locked on
# ip link set dev swp1 up
# ip link set dev swp2 up
# ip link set dev br0 up

2. Assuming h1 behind swp1 was authorized using 802.1X:

# bridge fdb replace $H1_MAC dev swp1 master dynamic

3. Assuming 802.1X authentication failed for h2 behind swp2, enable MAB:

# bridge link set dev swp2 mab on

4. Assuming $H2_MAC is in our allow list:

# bridge fdb replace $H2_MAC dev swp2 master dynamic

Learning is on in order to refresh the dynamic entries that user space
installed.

(*) Need to add support for this option in iproute2. Already exposed
over netlink (see 'IFLA_BR_MULTI_BOOLOPT').
