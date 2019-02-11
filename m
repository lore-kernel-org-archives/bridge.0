Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=8dewQ+QRBsLUTDs5tTnXH6nYs5k+9GPCW5qSagw6W4c=;
	b=f+GjWDaeQePi8+Ib9pOjOFVd6dnByWNZtyICJm/t2xhcZCWfy++gjfEvnsX5QxuD6C
	ISBaCa63kgPwKcV2POh5AfLWQ3LagbKNz8woAHUMMjmhY3wK0FfTtmSezhsDTj3ZDDaj
	CkurwgdY9m9HluJDyVoxPrqDnCN9i6Wp6XHNvtYoPF0vGNuIYujRO8B96KOUQufxtjwF
	Wn1pvasdDTk1YZKma4UG0wGAPsRmUrCpR7mays6XIPmP9O7BGMBCHcmgxQJs3vT7AWFK
	Kd4VxnaTq4DsUnQtz3CV2hPrG8yoNv2YPMrs2dMdR8IVOCkJckNZtL08DRyHUHl6o6AE
	JekA==
References: <20190210234007.16173-1-f.fainelli@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <7ece5de8-1bab-0f0e-e7db-ffeef12ba1d7@gmail.com>
Date: Mon, 11 Feb 2019 09:31:42 -0800
MIME-Version: 1.0
In-Reply-To: <20190210234007.16173-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 0/9] net: Remove switchdev_ops
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: devel@driverdev.osuosl.org, andrew@lunn.ch, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, idosch@mellanox.com, jiri@mellanox.com, vivien.didelot@gmail.com

On 2/10/19 3:39 PM, Florian Fainelli wrote:
> Hi all,
> 
> This patch series finishes by the removal of switchdev_ops. To get there
> we need to do a few things:
> 
> - get rid of the one and only call to switchdev_port_attr_get() which is
>   used to fetch the device's bridge port flags capabilities, instead we
>   can just check what flags are being programmed during the prepare
>   phase
> 
> - once we get rid of getting switchdev port attributes we convert the
>   setting of such attributes using a blocking notifier
> 
> And then remove switchdev_ops completely.
> 
> Please review and let me know what you think!
> 
> David, I would like to get Ido's feedback on this to make sure I did not
> miss something, thank you!

David, I will be reposting a v4 with Jiri's Acked-by as well as adding
fallthrough switch/case annotations so we don't regress on that front.
Thank you.

> 
> Changes in v3:
> - dropped patches removing te need to get the attribute since we
>   still need that in order to support different sleeping vs.
>   non-sleeping contexts
> 
> Changes in v2:
> - fixed bisectability issues in patch #15
> - added Acked-by from Jiri where necessary
> - fixed a few minor issues according to Jiri's feedback:
> 	- rename port_attr_event -> port_attr_set_event
> 	- moved SWITCHDEV_PORT_ATTR_SET closer to other blocking events
> 
> Florian Fainelli (9):
>   Documentation: networking: switchdev: Update port parent ID section
>   switchdev: Add SWITCHDEV_PORT_ATTR_SET, SWITCHDEV_PORT_ATTR_GET
>   rocker: Handle SWITCHDEV_PORT_ATTR_GET/SET
>   mlxsw: spectrum_switchdev: Handle SWITCHDEV_PORT_ATTR_GET/SET
>   net: mscc: ocelot: Handle SWITCHDEV_PORT_ATTR_GET/SET
>   staging: fsl-dpaa2: ethsw: Handle SWITCHDEV_PORT_ATTR_GET/SET
>   net: dsa: Handle SWITCHDEV_PORT_ATTR_GET/SET
>   net: switchdev: Replace port attr get/set SDO with a notification
>   net: Remove switchdev_ops
> 
>  Documentation/networking/switchdev.txt        |  10 +-
>  .../net/ethernet/mellanox/mlxsw/spectrum.c    |  12 --
>  .../net/ethernet/mellanox/mlxsw/spectrum.h    |   2 -
>  .../mellanox/mlxsw/spectrum_switchdev.c       |  36 +++---
>  drivers/net/ethernet/mscc/ocelot.c            |  26 ++++-
>  drivers/net/ethernet/rocker/rocker_main.c     |  30 ++++-
>  drivers/staging/fsl-dpaa2/ethsw/ethsw.c       |  30 ++++-
>  include/linux/netdevice.h                     |   3 -
>  include/net/switchdev.h                       |  28 ++---
>  net/dsa/slave.c                               |  30 ++++-
>  net/switchdev/switchdev.c                     | 107 ++++++------------
>  11 files changed, 168 insertions(+), 146 deletions(-)
> 


-- 
Florian
