Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 422DD6079D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 179DE6059B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUO+SBbyTPwDYAvd5O3Zia1JgmcyUAvEUfLW7ShsisQ=;
 b=cICpxOeDiAUKEP5upyh5ViAnkc82nxwdhSYAGNHzLWRm6z6WE8si516PEhlf3PbU56HS5ZahgZMt1xRAqyLO7imWDUhF2AQQKmol++HfYnVDzSl6Xx1xG7VCnE/LvUW70lz0fCQTmkwUHBaGPEu+vuxzuoPidVoCIzz/hk57XC+pc+GZIU3ni+6rUOtwTM01WypaJtj2PhZ1i7MF7FNa344Qph41+3QixPPS//Xuyd27WCxStJ4Yo0nJ1/+TBEl/dFvjkrtQZ3IeQvoOZsXFiQ3dMECKLhPWa6cI6dsq3yaYa+N0HT4VaVO2X6thk1H9rzdbCDQMrKpPcYiQ3YWe7Q==
Date: Mon, 29 Aug 2022 19:03:09 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YwzjPcQjfLPk3q/k@shredder>
References: <20220826114538.705433-1-netdev@kapio-technology.com>
 <20220826114538.705433-7-netdev@kapio-technology.com>
 <YwpgvkojEdytzCAB@shredder>
 <7654860e4d7d43c15d482c6caeb6a773@kapio-technology.com>
 <YwxtVhlPjq+M9QMY@shredder>
 <2967ccc234bb672f5440a4b175b73768@kapio-technology.com>
 <Ywyj1VF1wlYqlHb6@shredder>
 <9e1a9eb218bbaa0d36cb98ff5d4b97d7@kapio-technology.com>
 <YwzPJ2oCYJQHOsXD@shredder>
 <69db7606896c77924c11a6c175c4b1a6@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69db7606896c77924c11a6c175c4b1a6@kapio-technology.com>
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

On Mon, Aug 29, 2022 at 05:08:23PM +0200, netdev@kapio-technology.com wrote:
> On 2022-08-29 16:37, Ido Schimmel wrote:
> > On Mon, Aug 29, 2022 at 02:04:42PM +0200, netdev@kapio-technology.com
> > wrote:
> > > On 2022-08-29 13:32, Ido Schimmel wrote:
> > > Port association is needed for MAB to work at all on mv88e6xxx, but
> > > for
> > > 802.1X port association is only needed for dynamic ATU entries.
> > 
> > Ageing of dynamic entries in the bridge requires learning to be on as
> > well, but in these test cases you are only using static entries and
> > there is no reason to enable learning in the bridge for that. I prefer
> > not to leak this mv88e6xxx implementation detail to user space and
> > instead have the driver enable port association based on whether
> > "learning" or "mab" is on.
> > 
> 
> Then it makes most sense to have the mv88e6xxx driver enable port
> association when then port is locked, as it does now.

As you wish, but like you wrote "802.1X port association is only needed
for dynamic ATU entries" and in this case user space needs to enable
learning (for refresh only) so you can really key off learning on
"learning || mab". User space can decide to lock the port and work with
static entries and then learning is not required.
