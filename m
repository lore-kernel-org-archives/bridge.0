Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0076460D61
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 72D3B60C21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPEFtBZAzwiUajtMxvjOEuCLKwkEocj6qxTW3LRTvaU=;
 b=o7SzomlP+TxTBd6PrRmqXGpxrn1y7EBB6qWHbu6xaunclxqy2K9m+6oN7z1dC4gzROICoR3GAwh8uC4AzIYUhaq/QnFSHv4UvyB64aJ1pfpDWD/yG1XbH/wXtVK/7uZ1RmXhKPLadChGI91OzoL8A9cVphkSHgMc7WNZ+AfcIVrK0K7TXHV9bLjHr2j7TGMvjbYdCACRuCEgWwUrwXBfCA55hwIALs7qH6Q3PFRvlUBPOpFCmtrHKc4VZqyOzumSK43moVvfMQbyAP3h+4rSQZc8zP9VmJlqCGxXGC05O9kGrfJUa79qgtGy2PQdMek2AShtZcKSmsX1oPvUNSzLxw==
Date: Thu, 20 Oct 2022 12:55:27 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y1EbD4gp7MuTb8lu@shredder>
References: <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221019115809.552812a5@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019115809.552812a5@kernel.org>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v8 net-next 00/12] Extend locked port feature
 with FDB locked flag (MAC-Auth/MAB)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, "Hans J. Schultz" <netdev@kapio-technology.com>, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Wed, Oct 19, 2022 at 11:58:09AM -0700, Jakub Kicinski wrote:
> FWIW half of this posting got stuck on the "email pipes" for a day..
> somehow. Let's give Ido and others a chance to have a look but you'll
> need to repost even if it's flawless because the build bots can't deal
> with a delay that long :(

Will review today
