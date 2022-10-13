Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D64584037E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 714A640158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XedxsMWNS3R97E2u0y/azOBtQq3/ET+ktmx8XyMZ93Q=;
 b=JCiiWns9gnhjVAAZGVjytlpsdHkcW4s4fLAV+2kcgBXqxyAT/LGKaxF23NX8fhnZv5ynTPBOztIvjA4MYMmGBse+pxwVm1aTBuHsxtojEsDuk4lpt1zVU+5QYcvPtkpNho4Bn4f4JtRWFu2flK/7+eM5YAwfsqpbp/0AwXfzTEw+Q5+T/y7D9UoDSikRrEP2z/v1FSGZi0fw3YnbSL0fPZhAciA8QK07Z1mLTz8Jkm6Ro0PI95OhF2gJAYt6e1CSk8IiQZ1oP6ljdTWskTNOose51IsEcTj6RazfEHR1Y5ow8sxVYsFriflcnAbEi2xh6EecBYsya4cTaEvoaCqvVQ==
Date: Thu, 13 Oct 2022 21:13:50 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y0hVXgqsihknFOG7@shredder>
References: <20221009174052.1927483-1-netdev@kapio-technology.com>
 <20221009174052.1927483-10-netdev@kapio-technology.com>
 <21f799c5a7a79e2e4b111a95fff6fe3d@kapio-technology.com>
 <Y0ggn5SZnw+4SGLC@shredder>
 <46112084313969f9a6dfdea9fe52b4b1@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46112084313969f9a6dfdea9fe52b4b1@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v7 net-next 9/9] selftests: forwarding: add
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
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Thu, Oct 13, 2022 at 05:17:42PM +0200, netdev@kapio-technology.com wrote:
> What is the schedule for net-next to be open (I guess that it is closed as
> of now)?

After the merge window closes and 6.1-rc1 is released. Probably on
Monday.
