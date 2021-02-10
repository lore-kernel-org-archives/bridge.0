Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkSCqEMIbki/ZQV1uwE6Y+aTejTgyR51Z2ansgi2fl0=;
 b=ntVQEZ0d8Bi7ms99wOlSg3940EJvoKVm34Q7x1mPwNq8W3+YvFcY68xERqUfcIkL8HKCKezRcquTjDKTutdUl6G2FW9Bqgjyu9KOSD0pFynCRYXGvpVett1UtjLKwU0E5bSgGPASZ1tKVS6dDw2Wn1CafskzFz+CQiosqe3VOWs=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Wed, 10 Feb 2021 10:08:31 +0000
Message-ID: <20210210100831.acnycww3wkeb6imt@skbuf>
References: <20210209202112.2545325-1-horatiu.vultur@microchip.com>
In-Reply-To: <20210209202112.2545325-1-horatiu.vultur@microchip.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <90E48C016380FC4182CC031CB1AA155D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v3 0/5] bridge: mrp: Extend
	br_mrp_switchdev_*
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "jiri@resnulli.us" <jiri@resnulli.us>, "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "nikolay@nvidia.com" <nikolay@nvidia.com>, "roopa@nvidia.com" <roopa@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>

Hi Horatiu,

On Tue, Feb 09, 2021 at 09:21:07PM +0100, Horatiu Vultur wrote:
> This patch series extends MRP switchdev to allow the SW to have a better
> understanding if the HW can implement the MRP functionality or it needs
> to help the HW to run it. There are 3 cases:
> - when HW can't implement at all the functionality.
> - when HW can implement a part of the functionality but needs the SW
>   implement the rest. For example if it can't detect when it stops
>   receiving MRP Test frames but it can copy the MRP frames to CPU to
>   allow the SW to determine this.  Another example is generating the MRP
>   Test frames. If HW can't do that then the SW is used as backup.
> - when HW can implement completely the functionality.
>=20
> So, initially the SW tries to offload the entire functionality in HW, if
> that fails it tries offload parts of the functionality in HW and use the
> SW as helper and if also this fails then MRP can't run on this HW.
>=20
> Also implement the switchdev calls for Ocelot driver. This is an example
> where the HW can't run completely the functionality but it can help the S=
W
> to run it, by trapping all MRP frames to CPU.
>=20
> v3:
>  - implement the switchdev calls needed by Ocelot driver.
> v2:
>  - fix typos in comments and in commit messages
>  - remove some of the comments
>  - move repeated code in helper function
>  - fix issue when deleting a node when sw_backup was true
>=20
> Horatiu Vultur (5):
>   switchdev: mrp: Extend ring_role_mrp and in_role_mrp
>   bridge: mrp: Add 'enum br_mrp_hw_support'
>   bridge: mrp: Extend br_mrp_switchdev to detect better the errors
>   bridge: mrp: Update br_mrp to use new return values of
>     br_mrp_switchdev
>   net: mscc: ocelot: Add support for MRP
>=20
>  drivers/net/ethernet/mscc/ocelot_net.c     | 154 +++++++++++++++++++
>  drivers/net/ethernet/mscc/ocelot_vsc7514.c |   6 +
>  include/net/switchdev.h                    |   2 +
>  include/soc/mscc/ocelot.h                  |   6 +
>  net/bridge/br_mrp.c                        |  43 ++++--
>  net/bridge/br_mrp_switchdev.c              | 171 +++++++++++++--------
>  net/bridge/br_private_mrp.h                |  38 +++--
>  7 files changed, 327 insertions(+), 93 deletions(-)
>=20
> --=20
> 2.27.0
>=20

Which net-next commit can these patches be applied to? On the current
master I get:

Applying: switchdev: mrp: Extend ring_role_mrp and in_role_mrp
Applying: bridge: mrp: Add 'enum br_mrp_hw_support'
Applying: bridge: mrp: Extend br_mrp_switchdev to detect better the errors
error: patch failed: net/bridge/br_mrp_switchdev.c:177
error: net/bridge/br_mrp_switchdev.c: patch does not apply
Patch failed at 0004 bridge: mrp: Extend br_mrp_switchdev to detect better =
the errors
hint: Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".=
