Return-Path: <davem@davemloft.net>
Date: Thu, 03 May 2018 13:47:02 -0400 (EDT)
Message-Id: <20180503.134702.2067088091608075121.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1525350809.git.petrm@mellanox.com>
References: <cover.1525350809.git.petrm@mellanox.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next mlxsw v2 0/2] bridge: FDB: Notify
 about removal of non-user-added entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: petrm@mellanox.com
Cc: ivecera@redhat.com, f.fainelli@gmail.com, andrew@lunn.ch, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, vivien.didelot@savoirfairelinux.com

From: Petr Machata <petrm@mellanox.com>
Date: Thu, 03 May 2018 14:43:40 +0200

> Device drivers may generally need to keep in sync with bridge's FDB. In
> particular, for its offload of tc mirror action where the mirrored-to
> device is a gretap device, mlxsw needs to listen to a number of events,
> FDB events among the others. SWITCHDEV_FDB_{ADD,DEL}_TO_DEVICE would be
> a natural notification in that case.
> 
> However, for removal of FDB entries added due to device activity (as
> opposed to explicit addition through "bridge fdb add" or similar), there
> are no notifications.
> 
> Thus in patch #1, add the "added_by_user" field to switchdev
> notifications sent for FDB activity. Adapt drivers to ignore activity on
> non-user-added entries, to maintain the current behavior. Specifically
> in case of mlxsw, allow mlxsw_sp_span_respin() call for any and all FDB
> updates.
> 
> In patch #2, change the bridge driver to actually emit notifications for
> these FDB entries. Take care not to send notification for bridge
> updates that itself originate in SWITCHDEV_FDB_*_TO_BRIDGE events.
> 
> Changes from v1 to v2:
> - Instead of introducing a new variant of fdb_delete(), add a new
>   parameter to the existing function.
> - Name the parameter swdev_notify, not notify.

Series applied, thank you.
