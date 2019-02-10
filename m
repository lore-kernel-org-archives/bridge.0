Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=to:cc:references:from:openpgp:autocrypt:subject:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=pHyluQCGFGfnCES0zIu1o3Vs58aE39GUgQSyodXIYxg=;
	b=NYTRVXhOPlT84MYQje8wiFlZyW9NIv3blUpO1aN7KhI3/Mw+i6W61heVi9CY0j58xq
	HLzoyC8j2KedN7hWqciXZOYXcJD6ABTo8fqNMEwESHyzzBz8fp/V4stJNPYNQtjd1AOb
	gTalVNZOmoDsHn/o20lAqviH6KmuZCdpdQCc7AKgp0Kdfe1yUvJJ48QvO40yQWKVZ1Fj
	VRlSbZUI20/W1GJkNXRw/yHeyuddBGHZpD6ZAKlimV3hldoGhLs1DpfSnrnfzatGIQCO
	QsOZcI+JlwyGJ4Ifcn+4GDN+6fZdFAuO4Gszckk5oZKlt6tpHILR4mhU0dwlClGA9FaC
	HHyw==
References: <20190210175105.31629-1-f.fainelli@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <746bce08-5b5f-70c9-efb7-33b067929198@gmail.com>
Date: Sun, 10 Feb 2019 12:44:47 -0800
MIME-Version: 1.0
In-Reply-To: <20190210175105.31629-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next v2 00/16] net: Remove switchdev_ops
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

Le 2/10/19 à 9:50 AM, Florian Fainelli a écrit :
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

I am going to submit a v3 which moves the port_attr_{get,set} to a
switchdev notifier, but does not yet get rid of
switchdev_port_attr_get() entirely since there is not a clear path yet
to split the setting between non-sleeping and sleeping context.

> 
> Changes in v2:
> - fixed bisectability issues in patch #15
> - added Acked-by from Jiri where necessary
> - fixed a few minor issues according to Jiri's feedback:
> 	- rename port_attr_event -> port_attr_set_event
> 	- moved SWITCHDEV_PORT_ATTR_SET closer to other blocking events
> 
> Florian Fainelli (16):
>   Documentation: networking: switchdev: Update port parent ID section
>   mlxsw: spectrum: Check bridge flags during prepare phase
>   staging: fsl-dpaa2: ethsw: Check bridge port flags during set
>   net: dsa: Add setter for SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
>   rocker: Check bridge flags during prepare phase
>   net: bridge: Stop calling switchdev_port_attr_get()
>   net: Remove SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
>   net: Get rid of switchdev_port_attr_get()
>   switchdev: Add SWITCHDEV_PORT_ATTR_SET
>   rocker: Handle SWITCHDEV_PORT_ATTR_SET
>   net: dsa: Handle SWITCHDEV_PORT_ATTR_SET
>   mlxsw: spectrum_switchdev: Handle SWITCHDEV_PORT_ATTR_SET
>   net: mscc: ocelot: Handle SWITCHDEV_PORT_ATTR_SET
>   staging: fsl-dpaa2: ethsw: Handle SWITCHDEV_PORT_ATTR_SET
>   net: switchdev: Replace port attr set SDO with a notification
>   net: Remove switchdev_ops
> 
>  Documentation/networking/switchdev.txt        | 15 ++-
>  .../net/ethernet/mellanox/mlxsw/spectrum.c    | 12 ---
>  .../net/ethernet/mellanox/mlxsw/spectrum.h    |  2 -
>  .../mellanox/mlxsw/spectrum_switchdev.c       | 69 ++++----------
>  drivers/net/ethernet/mscc/ocelot.c            | 21 +++-
>  drivers/net/ethernet/rocker/rocker_main.c     | 95 ++++++++-----------
>  drivers/staging/fsl-dpaa2/ethsw/ethsw.c       | 48 ++++------
>  include/linux/netdevice.h                     |  3 -
>  include/net/switchdev.h                       | 36 ++-----
>  net/bridge/br_switchdev.c                     | 20 +---
>  net/dsa/dsa_priv.h                            |  3 +
>  net/dsa/port.c                                | 10 ++
>  net/dsa/slave.c                               | 40 ++++----
>  net/switchdev/switchdev.c                     | 92 +++++-------------
>  14 files changed, 170 insertions(+), 296 deletions(-)
> 


-- 
Florian
