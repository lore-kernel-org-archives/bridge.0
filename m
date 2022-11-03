Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6266240BCE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CC36C40520
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sd6lTwrU7OS5ue6Z4VN6v8iDwezzkp/KTuN1mVW5z+c=;
 b=Dv1aWTVdZdbHuVcSueZ8Z+GUKQu6klKMD06+/EW0enFlWzMW51xnALIRxS+0b6hWIMGDIch/YNfunjSbKBLcm3eAfofxDMVfg+2Bv0urFRNfYHxSIl6E7FCuFPZgLPnooedQ5Nibd3YvYkHfkrUVV4t8PIZACH6/v3z5GAiZQdxfBK0ySaacio1Jzf9OcwlsLWDDhzb5zSoY4UGbZZbxJ18UXL72EiqMYIOHpkBOkJaZhTN96j74cSzXg9j7eh4yLWZADOLolVaxaGdsaOBx7zezDXTvy3p6+uev/BUgtuL7eKdJLUWe+eGakRkKDd6EePy6vgRluMi41y5uSMXc8A==
Date: Fri, 4 Nov 2022 00:54:39 +0200
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y2RGr9ssyMXbNsC+@shredder>
References: <20221025100024.1287157-1-idosch@nvidia.com>
 <20221025100024.1287157-1-idosch@nvidia.com>
 <20221025100024.1287157-11-idosch@nvidia.com>
 <20221025100024.1287157-11-idosch@nvidia.com>
 <20221027233939.x5jtqwiic2kmwonk@skbuf> <Y140a2DqcCaT/5uL@shredder>
 <20221031083210.fxitourrquc4bo6p@skbuf>
 <20221103223151.cnmlvgnz3maj75iv@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103223151.cnmlvgnz3maj75iv@skbuf>
MIME-Version: 1.0
Subject: Re: [Bridge] [RFC PATCH net-next 10/16] mlxsw: spectrum_switchdev:
 Add support for locked FDB notifications
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "petrm@nvidia.com" <petrm@nvidia.com>, "ivecera@redhat.com" <ivecera@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "razor@blackwall.org" <razor@blackwall.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "roopa@nvidia.com" <roopa@nvidia.com>, "netdev@kapio-technology.com" <netdev@kapio-technology.com>, "edumazet@google.com" <edumazet@google.com>, "mlxsw@nvidia.com" <mlxsw@nvidia.com>, "jiri@nvidia.com" <jiri@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>

On Thu, Nov 03, 2022 at 10:31:52PM +0000, Vladimir Oltean wrote:
> Hi Ido,
> 
> On Mon, Oct 31, 2022 at 10:32:10AM +0200, Vladimir Oltean wrote:
> > On Sun, Oct 30, 2022 at 10:23:07AM +0200, Ido Schimmel wrote:
> > > Right. I'm quite reluctant to add the MAB flag to
> > > BR_PORT_FLAGS_HW_OFFLOAD as part of this patchset for the simple reason
> > > that it is not really needed. I'm not worried about someone adding it
> > > later when it is actually needed. We will probably catch the omission
> > > during code review. Worst case, we have a selftest that will break,
> > > notifying us that a bug fix is needed.
> > 
> > For drivers which don't emit SWITCHDEV_FDB_ADD_TO_BRIDGE but do offload
> > BR_PORT_LOCKED (like mv88e6xxx), things will not work correctly on day 1
> > of BR_PORT_MAB because they are not told MAB is enabled, so they have no
> > way of rejecting it until things work properly with the offload in place.
> > 
> > It's the same reason for which we have BR_HAIRPIN_MODE | BR_ISOLATED |
> > BR_MULTICAST_TO_UNICAST in BR_PORT_FLAGS_HW_OFFLOAD, even if nobody acts
> > upon them.
> 
> Do you have any comment on this?

Sorry, forgot to reply... I added a patch (see below) to the offload
set. If the bridge patches are accepted and we have disagreements on the
offload part I can always split out this patch and send it separately so
that mv88e6xxx rejects MAB in 6.2.

commit ebdd7363f8c1802af63c35f74d6922b727617a7d
Author: Ido Schimmel <idosch@nvidia.com>
Date:   Mon Oct 31 19:36:36 2022 +0200

    bridge: switchdev: Reflect MAB bridge port flag to device drivers
    
    Reflect the 'BR_PORT_MAB' flag to device drivers so that:
    
    * Drivers that support MAB could act upon the flag being toggled.
    * Drivers that do not support MAB will prevent MAB from being enabled.
    
    Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Notes:
    v1:
    * New patch.

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 8a0abe35137d..7eb6fd5bb917 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -71,7 +71,7 @@ bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
 }
 
 /* Flags that can be offloaded to hardware */
-#define BR_PORT_FLAGS_HW_OFFLOAD (BR_LEARNING | BR_FLOOD | \
+#define BR_PORT_FLAGS_HW_OFFLOAD (BR_LEARNING | BR_FLOOD | BR_PORT_MAB | \
                                  BR_MCAST_FLOOD | BR_BCAST_FLOOD | BR_PORT_LOCKED | \
                                  BR_HAIRPIN_MODE | BR_ISOLATED | BR_MULTICAST_TO_UNICAST)
