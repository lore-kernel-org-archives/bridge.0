Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 22F68415BD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4371C402BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RUj1tb4TuSYwUwoIhNOw99sNhzHtGAEfhnWg+uq4J14=;
 b=Asl8uQue9LWo08MaIkIb7jI1hRkLqzzudtQvDBpXIXqQkoxbdF/KLvIZZWQEXwvMPL
 bMvtYu3kDoM3Ub2P8qPZk7gb/iij7N7PVRvrSQ4BysUH7hVGOpm5uyc227mcM/PAEiEZ
 J+uoaJyFsFKUvfSBtY2fmSCxbDemT+ka2phibXCr/SauPiiEtHlXPsH/rhdDDC9Rx3/1
 faQ+ppX0WmhLws/GI1EvYhGEqfcK7VzFbgWjcJirBtrr0FTn56MDjm0W3gTJW7rGi2i3
 WHIoQhSkKqIWXhGqFNZtL0oGmQT8RKffugBYkey/NNNmOsjNTfePuW7lCLVVR72PvZvq
 ZhwA==
MIME-Version: 1.0
References: <20230130173429.3577450-1-netdev@kapio-technology.com>
 <20230130173429.3577450-2-netdev@kapio-technology.com>
 <Y9qrAup9Xt/ZDEG0@shredder>
 <f27dd18d9d0b7ff8b693af8a58ea8616@kapio-technology.com>
 <Y9vgz4x/O+dIp+0/@shredder>
 <766efaf94fcb6362c5ceb176ad7955f1@kapio-technology.com>
 <Y90y9u+4PxWk4b9E@shredder>
In-Reply-To: <Y90y9u+4PxWk4b9E@shredder>
From: Vladimir Oltean <olteanv@gmail.com>
Date: Fri, 3 Feb 2023 18:26:41 +0200
Message-ID: <CA+h21hp5Eh3zF60J2mTZL+xenD7iMBXKG+Ui0t-oUzgwNwSw2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH net-next 1/5] net: bridge: add dynamic flag to
	switchdev notifier
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, netdev@kapio-technology.com, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, davem@davemloft.net

On Fri, 3 Feb 2023 at 18:14, Ido Schimmel <idosch@idosch.org> wrote:
> I *think* this is the change Vladimir asked you to do.

Yup, although instead of "is_dyn", I would still prefer "!is_static",
but again, that's a preference for bridge/switchdev maintainers to
override.
