Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DB95B4021C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AE445400D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjBVh9FjHVYSSz8aul7WM9OpX6cO86Kmf8GjigMIvBg=;
 b=gdBxf9qVukuSHhACZ+V+XqErmKpmBHrbD7mca5722mRhcVW6b0l1TnOQ0uxfGqTI5BkAQDaaecV1+xVuv9KRPPlSneAswJRUJY2AgbpVoywrqQqP/rHJn7VafW/U+KWxAQpy8/qOsCAZKLKdbTQiHP/lb3wqQcHGN6VNzIwoiLnpadQlc1vW6+1MZ2/OX87A71MR/o7ehd2W+8KBH7XXuCOZjbzgoeL0rYZbrf1HQec8huwhA9kLwCmzfuZhhd6Ddm6s/8AqPUYB/z/jR1XoExyUpZLRHBJ0tOZ+LbnAGT1Z+S/Q993af1PZdxcyxE4LWr+wISKQYl9XPlwKIBaaeQ==
Date: Thu, 20 Apr 2023 09:23:12 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <ZEDaUOBZL05fIFp8@shredder>
References: <20230418155902.898627-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418155902.898627-1-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v2 net] net: bridge: switchdev: don't notify
 FDB entries with "master dynamic"
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Ivan Vecera <ivecera@redhat.com>, bridge@lists.linux-foundation.org, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, "Hans J. Schultz" <netdev@kapio-technology.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Tue, Apr 18, 2023 at 06:59:02PM +0300, Vladimir Oltean wrote:
> There is a structural problem in switchdev, where the flag bits in
> struct switchdev_notifier_fdb_info (added_by_user, is_local etc) only
> represent a simplified / denatured view of what's in struct
> net_bridge_fdb_entry :: flags (BR_FDB_ADDED_BY_USER, BR_FDB_LOCAL etc).
> Each time we want to pass more information about struct
> net_bridge_fdb_entry :: flags to struct switchdev_notifier_fdb_info
> (here, BR_FDB_STATIC), we find that FDB entries were already notified to
> switchdev with no regard to this flag, and thus, switchdev drivers had
> no indication whether the notified entries were static or not.

[...]

> Fixes: 6b26b51b1d13 ("net: bridge: Add support for notifying devices about FDB add/del")
> Link: https://lore.kernel.org/netdev/20230327115206.jk5q5l753aoelwus@skbuf/
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>
