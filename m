Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E6B9C84293
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AD25084289
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/YiibZtt8oIPE19OVwC3YZXd2YUXxWN5oRvk2v2Dqk=;
 b=oSzow6Qji37ce+/huy5q0r0gc1ZpcltIGcfb0F/r0dAhM0UoYhQk0QBmePWT6Q5lOXcBGM3slpkEOsNJ2f4lU1DHeDeJNE6zuHr+cEYpbE/gg1NTL1ppDjHfRDEEYde4vd0W79k6egBwC7zuIAS9xWLI/BIDHkese9b50Aj5VxF8tQe0/kEVKBpytb45QDUOehmLFM32p+73zi8PhGsAt4gOAwBeg3auy2VtWMPpTF8vlke0v1JK94FardnT99T3vlJ5Tg7bjHeaQA/0vc67rx/FTmhKPG3wrrntUgjBnBQRQfPgxCyxd3QdCKHr4YeIidodwnWu0jsjkxfV7d3D3Q==
Date: Thu, 20 Oct 2022 15:35:22 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y1FAikA8uhjz9hED@shredder>
References: <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-13-netdev@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018165619.134535-13-netdev@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v8 net-next 12/12] selftests: forwarding: add
 MAB tests to locked port tests
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Hans J. Schultz" <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Tue, Oct 18, 2022 at 06:56:19PM +0200, Hans J. Schultz wrote:
> Verify that the MacAuth/MAB mechanism works by adding a FDB entry with
> the locked flag set, denying access until the FDB entry is replaced with
> a FDB entry without the locked flag set. Also verify that FDB entries
> cannot roam from an unlocked port to a locked port.
> 
> Add test of blackhole fdb entries, verifying that there is no forwarding
> to a blackhole entry from any port, and that the blackhole entry can be
> replaced.
> 
> Signed-off-by: Hans J. Schultz <netdev@kapio-technology.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>
