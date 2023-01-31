Return-Path: <idosch@idosch.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F334660D71
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0695860D6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1675193129; x=1675279529; bh=STVqW/t1lXxI625WVmdd6J2DgvpW
 tytdItQfHKSXdqQ=; b=pvAHIV0eM4+QKb+ejy+48wcuW96qZLg2LoWcO+Sf7Lxg
 VZJoYSj82GhuCyozzLD3KFXWvHH40MBt/bexAGwdIa1LJMHTELW4cOg5ZnmocBi8
 3cwzJE2SUtQGCpVwade+fsQHhXDgnzkG+Qda6Rvx5LViZXs2fDZ6po75kbTeZ2UE
 yhLV1AaFpX6Qc/SGWfw9rlnaByzqqgIRlLlVrYLrmCQfVhtGFQ/H5fjr1Z82BnNX
 TotUIg0IysmBL8f1+ecvs++8qjZbuEqTGxc7re/XUExAz3oGsfgg74wDzLhTSx/o
 CIl94gUrzR4CTdz5AOShMN0Fy9bpSlcwqGo8mkAqwQ==
Date: Tue, 31 Jan 2023 21:25:21 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <Y9lrIWMnWLqGreZL@shredder>
References: <20230130173429.3577450-1-netdev@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130173429.3577450-1-netdev@kapio-technology.com>
Subject: Re: [Bridge] [PATCH net-next 0/5] ATU and FDB synchronization on
	locked ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Hans J. Schultz" <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Mon, Jan 30, 2023 at 06:34:24PM +0100, Hans J. Schultz wrote:
> This patch set makes it possible to have synchronized dynamic ATU and FDB
> entries on locked ports. As locked ports are not able to automatically
> learn, they depend on userspace added entries, where userspace can add
> static or dynamic entries. The lifetime of static entries are completely
> dependent on userspace intervention, and thus not of interest here. We
> are only concerned with dynamic entries, which can be added with a
> command like:
> 
> bridge fdb replace ADDR dev <DEV> master dynamic
> 
> We choose only to support this feature on locked ports, as it involves
> utilizing the CPU to handle ATU related switchcore events (typically
> interrupts) and thus can result in significant performance loss if
> exposed to heavy traffic.

Not sure I understand this reasoning. I was under the impression that
hostapd is installing dynamic entries instead of static ones since the
latter are not flushed when carrier is lost. Therefore, with static
entries it is possible to unplug a host (potentially plugging a
different one) and not lose authentication.

> 
> On locked ports it is important for userspace to know when an authorized
> station has become silent, hence not breaking the communication of a
> station that has been authorized based on the MAC-Authentication Bypass
> (MAB) scheme. Thus if the station keeps being active after authorization,
> it will continue to have an open port as long as it is active. Only after
> a silent period will it have to be reauthorized. As the ageing process in
> the ATU is dependent on incoming traffic to the switchcore port, it is
> necessary for the ATU to signal that an entry has aged out, so that the
> FDB can be updated at the correct time.

Why mention MAB at all? Don't you want user space to always use dynamic
entries to authenticate hosts regardless of 802.1X/MAB?

> 
> This patch set includes a solution for the Marvell mv88e6xxx driver, where
> for this driver we use the Hold-At-One feature so that an age-out
> violation interrupt occurs when a station has been silent for the
> system-set age time. The age out violation interrupt allows the switchcore
> driver to remove both the ATU and the FDB entry at the same time.
> 
> It is up to the maintainers of other switchcore drivers to implement the
> feature for their specific driver.
> 
> Hans J. Schultz (5):
>   net: bridge: add dynamic flag to switchdev notifier
>   net: dsa: propagate flags down towards drivers
>   drivers: net: dsa: add fdb entry flags incoming to switchcore drivers
>   net: bridge: ensure FDB offloaded flag is handled as needed
>   net: dsa: mv88e6xxx: implementation of dynamic ATU entries

Will try to review tomorrow, but it looks like this set is missing
selftests. What about extending bridge_locked_port.sh?
