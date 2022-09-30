Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F278416F9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9B4A24161B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LertkcbjgdOGHDxrwbfYgpUhXa4RjIH8m2oYBaX8Ygw=;
 b=mO08Ba89gdIeN0WF2qF3YlumgEvG+U+KjrR/8Qqr1pXfDW/r3CSarL8cAv78epwVKuQ8rMbOLDaQGKeUj9RfIO3ROEu2YH2spdZqnWPaCF3jCcuYGTL1tEnqyIenCShdeF0hwSSMvCaAuirZPeMBbSMZOz8by4Px9k4PRXyAfTt+56+RBjy+lqM8njVXQQkqLvW3N4/5na2CMA6SbB6ZOANgQILbwXREKFtYhQsG3mmSiYdBrbuFB8YzuUO+YB0dL+/Q2NAtsyaBYMXZ9+wWJy3imGS8y1+8uh1ENSl4oGtTo+6YOTMmH5bLjdFbqv+34AehCjR0h/hgjtM3u9lGkw==
Date: Fri, 30 Sep 2022 18:04:12 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YzcFbH5lX3l1K8Fu@shredder>
References: <20220928150256.115248-1-netdev@kapio-technology.com>
 <20220929091036.3812327f@kernel.org>
 <12587604af1ed79be4d3a1607987483a@kapio-technology.com>
 <20220929112744.27cc969b@kernel.org>
 <ab488e3d1b9d456ae96cfd84b724d939@kapio-technology.com>
 <Yzb3oNGNtq4GCS3M@shredder> <20220930075204.608b6351@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930075204.608b6351@kernel.org>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v6 net-next 0/9] Extend locked port feature
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
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, netdev@kapio-technology.com, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Fri, Sep 30, 2022 at 07:52:04AM -0700, Jakub Kicinski wrote:
> On Fri, 30 Sep 2022 17:05:20 +0300 Ido Schimmel wrote:
> > You can see build issues on patchwork:
> 
> Overall a helpful response, but that part you got wrong.
> 
> Do not point people to patchwork checks, please. It will only encourage
> people to post stuff they haven't build tested themselves.
> 
> It's documented:
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#running-all-the-builds-and-checks-locally-is-a-pain-can-i-post-my-patches-and-have-the-patchwork-bot-validate-them

Did you read my reply? I specifically included this link so that you
won't tell me I'm encouraging people to build test their patches by
posting to netdev.
