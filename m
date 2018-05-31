Return-Path: <davem@davemloft.net>
Date: Thu, 31 May 2018 14:14:12 -0400 (EDT)
Message-Id: <20180531.141412.1289727831618161534.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1527641426.git.petrm@mellanox.com>
References: <cover.1527641426.git.petrm@mellanox.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 0/8] net: bridge: Notify about
	bridge VLANs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: petrm@mellanox.com
Cc: devel@driverdev.osuosl.org, f.fainelli@gmail.com, andrew@lunn.ch, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, gregkh@linuxfoundation.org, vivien.didelot@savoirfairelinux.com, dan.carpenter@oracle.com

From: Petr Machata <petrm@mellanox.com>
Date: Wed, 30 May 2018 02:55:34 +0200

> In commit 946a11e7408e ("mlxsw: spectrum_span: Allow bridge for gretap
> mirror"), mlxsw got support for offloading mirror-to-gretap such that
> the underlay packet path involves a bridge. In that case, the offload is
> also influenced by PVID setting of said bridge. However, changes to VLAN
> configuration of the bridge itself do not generate switchdev
> notifications, so there's no mechanism to prod mlxsw to update the
> offload when these settings change.
> 
> In this patchset, the problem is resolved by distributing the switchdev
> notification SWITCHDEV_OBJ_ID_PORT_VLAN also for configuration changes
> on bridge VLANs. Since stacked devices distribute the notification to
> lower devices, such event eventually reaches the driver, which can
> determine whether it's a bridge or port VLAN by inspecting orig_dev.
> 
> To keep things consistent, the newly-distributed notifications observe
> the same protocol as the existing ones: dual prepare/commit, with
> -EOPNOTSUPP indicating lack of support, even though there's currently
> nothing to prepare for and nothing to support. Correspondingly, all
> switchdev drivers have been updated to return -EOPNOTSUPP for bridge
> VLAN notifications.
> 
> In patches #1 and #2, the code base is changed to support the following
> additions: functions br_switchdev_port_vlan_add() and
> br_switchdev_port_vlan_del() are introduced to simplify sending
> notifications; and br_vlan_add_existing() is introduced to later make it
> simpler to add error-handling code for the case of configuring a
> preexisting VLAN on bridge CPU port.
> 
> In patches #3-#6, respectively for mlxsw, rocker, DSA and DPAA2 ethsw,
> the new notifications (which are not enabled yet) are ignored to
> maintain the current behavior.
> 
> In patch #7, the notification is actually enabled.
> 
> In patch #8, mlxsw is changed to update offloads of mirror-to-gre also
> for bridge-related notifications.
 ...

Series applied, thanks.
