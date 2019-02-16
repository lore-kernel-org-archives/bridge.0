Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=bwa73KKS0GHzhM/Hzm2y4AjhgGLRJoVnB/9q7JdY9I0=;
	b=o7TtJzAovHV0e9HulFcY9NIxhSljIAHEhWWHgYoiqbaxed4QjBlsvgpYv/2J7Bs1OR
	PkdHPub3WNOgbwI9SNj2Ctsi/cO0Qt/McHiB6/wXWvxasbdCt4D7GzE8fuDQE11rP9k4
	UEQISInf0kRzyBQ2u6NmrCJc+lIEHeEnYaI18a8ZD+mAnWzGnyL/NaMDp9ENpqYgXnDg
	KHVd1mynMujvBjFUF9CME2c2LCK+u2zL1XbfFzm27E4HKOY8eg5qcqMM6d5E7SJpXaFx
	A+BlMS/FjIjzOiUtfpfLw25T5FLWri/ptmQtvMe5pUrumXDOXtDNJxTNoxDgaQWYub9r
	xXcw==
References: <20190215225313.32303-1-f.fainelli@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <77c28e2d-cd29-4932-5cfe-64799c730ede@gmail.com>
Date: Fri, 15 Feb 2019 16:37:38 -0800
MIME-Version: 1.0
In-Reply-To: <20190215225313.32303-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 0/9] net: Get rid of
	switchdev_port_attr_get()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, andrew@lunn.ch, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, Ido Schimmel <idosch@mellanox.com>, jiri@mellanox.com, vivien.didelot@gmail.com

On 2/15/19 2:53 PM, Florian Fainelli wrote:
> Hi all,
> 
> This patch series splits the removal of the switchdev_ops that was
> proposed a few times before and first tackles the easy part which is the
> removal of the single call to switchdev_port_attr_get() within the
> bridge code.
> 
> As suggestd by Ido, this patch series adds a
> SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS which is used in the same
> context as the caller of switchdev_port_attr_set(), so not deferred, and
> then the operation is carried out in deferred context with setting a
> support bridge port flag.
> 
> Follow-up patches will do the switchdev_ops removal after introducing
> the proper helpers for the switchdev blocking notifier to work across
> stacked devices (unlike the previous submissions).

David, please ignore this version, I will repost one that actually
builds, need to keep mangling with my kernel configuration and keep
those drivers enabled...

> 
> Changes in v2:
> 
> - differentiate callers not supporting switchdev_port_attr_set() from
>   the driver not being able to support specific bridge flags
> 
> - pass "mask" instead of "flags" for the PRE_BRIDGE_FLAGS check
> 
> - skip prepare phase for PRE_BRIDGE_FLAGS
> 
> - corrected documentation a bit more
> 
> - tested bridge_vlan_aware.sh with veth/VRF
> 
> Florian Fainelli (9):
>   Documentation: networking: switchdev: Update port parent ID section
>   net: switchdev: Add PORT_PRE_BRIDGE_FLAGS
>   mlxsw: spectrum: Handle PORT_PRE_BRIDGE_FLAGS
>   staging: fsl-dpaa2: ethsw: Handle PORT_PRE_BRIDGE_FLAGS
>   net: dsa: Add setter for SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
>   rocker: Check Handle PORT_PRE_BRIDGE_FLAGS
>   net: bridge: Stop calling switchdev_port_attr_get()
>   net: Remove SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
>   net: Get rid of switchdev_port_attr_get()
> 
>  Documentation/networking/switchdev.txt        | 16 ++--
>  .../mellanox/mlxsw/spectrum_switchdev.c       | 38 +++++-----
>  drivers/net/ethernet/rocker/rocker_main.c     | 75 +++++++++++--------
>  drivers/staging/fsl-dpaa2/ethsw/ethsw.c       | 32 ++++----
>  include/net/switchdev.h                       | 13 +---
>  net/bridge/br_switchdev.c                     | 11 ++-
>  net/dsa/dsa_priv.h                            |  6 ++
>  net/dsa/port.c                                | 17 +++++
>  net/dsa/slave.c                               | 24 +++---
>  9 files changed, 128 insertions(+), 104 deletions(-)
> 


-- 
Florian
