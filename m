Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B547A4010E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D08E340461
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/5ROoTKcst6zjne8g3KvrWeyt5TDJH93dI6IBjClJg=;
 b=R+kTzf7QBbme8S9SaJY0fTOAYQTranVwu3kn0aCdEVHqdZrFwKUY6G+Sje/V4l32ohXKbmZgTE/+hzxEN+a1d5buu9NmPA0UnEHJM+odXsQS13U1gI3V+m2KK1o+NBjNMTjLfM+02zjyUZUuaN8hgSbZn0M5PkVED4L4O8ro4tidajIN0ePyP0pIfVcSA6E4Ghs1+Q+mEfabLekGCD+dnV52Vmkv/zgZpquZKBXT7F+60TalFYLaMR5oafbAEHSEKPGIWuLka1awr5F1uZfBcx0NYeJ0tU+9d7ozNV4S0gKNfsaBgcqXwC158ET+n0cZDM6GxUYqRedAub0Krf45Hw==
Date: Thu, 13 Oct 2022 17:21:35 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y0ge76Afxpc2DOsn@shredder>
References: <20221009174052.1927483-1-netdev@kapio-technology.com>
 <20221009174052.1927483-5-netdev@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009174052.1927483-5-netdev@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v7 net-next 4/9] net: switchdev: support
 offloading of the FDB blackhole flag
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

On Sun, Oct 09, 2022 at 07:40:47PM +0200, Hans J. Schultz wrote:
> Add support for offloading of the FDB blackhole flag.
> 
> Signed-off-by: Hans J. Schultz <netdev@kapio-technology.com>
> ---
>  include/net/dsa.h         |  1 +
>  include/net/switchdev.h   |  1 +
>  net/bridge/br.c           |  3 ++-
>  net/bridge/br_fdb.c       | 19 ++++++++++++++++---
>  net/bridge/br_private.h   |  3 ++-
>  net/bridge/br_switchdev.c |  1 +
>  net/dsa/dsa_priv.h        |  4 ++--
>  net/dsa/port.c            | 22 ++++++++++++----------
>  net/dsa/slave.c           |  6 ++++--
>  9 files changed, 41 insertions(+), 19 deletions(-)

Too many changes at once. I suggest to split into:

1. A patch that allows the bridge driver to be notified about blackhole
entries from device drivers and also notifying it to drivers when added
from user space. These changes:

include/net/switchdev.h   |  1 +
net/bridge/br.c           |  3 ++-
net/bridge/br_fdb.c       | 19 ++++++++++++++++---
net/bridge/br_private.h   |  3 ++-
net/bridge/br_switchdev.c |  1 +

2. The DSA changes
