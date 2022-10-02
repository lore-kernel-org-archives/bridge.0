Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B9C9D82923
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8641382656
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFqMd4b/TP7ivjoTr5k0gJ7vPmOsDtXTKIF4G9bDt1c=;
 b=IPJr+UbyEHDX4ZuieqcWqueJikP/vN7k5TRX+tucW06nulyXflBFSkUL2GvEaphwc7IJu3Kn9f5/spYFC2wQ4xh7b9MNeh32qNVhsd1GPsnShgoe+rBErvL6ESa1mHo6O+7NkABRJOOsO+QRKyw0pNfQ3Gs7LTNXQzkkH1OSOuhiW+yxgsLLnodZadFeRXaGNe3n0v1/W8r7If2KEW4ZSWSoxZPtoq/aWPDSrGlkO4+ZNdu2rYnqQVRiLcZUfiZuVMRgdok5KVFm6oKwvWYOyDPXf/Bj8/NZO6PDexZCgDTpVbYu0a5jSM0V7GuLFm6HokRmdK4RnSBecOElB5aDlg==
Date: Sun, 2 Oct 2022 10:34:18 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Yzk++rArs1me+gJc@shredder>
References: <20220929152137.167626-1-netdev@kapio-technology.com>
 <YzhV0hU9v7oQ+g+K@shredder>
 <00f5b024d242b948e1e198dfe95d73bc@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00f5b024d242b948e1e198dfe95d73bc@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH iproute2-next 1/2] bridge: link: enable
 MacAuth/MAB feature
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

On Sat, Oct 01, 2022 at 11:32:52PM +0200, netdev@kapio-technology.com wrote:
> On 2022-10-01 16:59, Ido Schimmel wrote:
> > On Thu, Sep 29, 2022 at 05:21:36PM +0200, Hans Schultz wrote:
> > > The MAB feature can be enabled on a locked port with the command:
> > > bridge link set dev <DEV> mab on
> > 
> > Please provide regular and JSON output in the commit message.
> > 
> 
> How would the JSON version look like in this example?

$ bridge -d link show dev dummy10
558: dummy10: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master br0 state disabled priority 32 cost 100 
    hairpin off guard off root_block off fastleave off learning on flood on mcast_flood on mcast_to_unicast off neigh_suppress off vlan_tunnel off isolated off

$ bridge -d -j -p link show dev dummy10
[ {
        "ifindex": 558,
        "ifname": "dummy10",
        "flags": [ "BROADCAST","NOARP","UP","LOWER_UP" ],
        "mtu": 1500,
        "master": "br0",
        "state": "disabled",
        "priority": 32,
        "cost": 100,
        "hairpin": false,
        "guard": false,
        "root_block": false,
        "fastleave": false,
        "learning": true,
        "flood": true,
        "mcast_flood": true,
        "mcast_to_unicast": false,
        "neigh_suppress": false,
        "vlan_tunnel": false,
        "isolated": false
    } ]
