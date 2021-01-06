Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yF3rnLTyQNwA21TyP52ciWlNhWGg2itKNaVkTO2/cDA=;
 b=V6RtY4DS+UNCW6fua0p/m79afdROsP11C0PquKtYRn2kbdiNrCrgy7y6M/h+MXGVQP
 q4Dx+GPHMSamQ4qCkjtNGolJEYlY0fDQCEF36qoySnoe2UrtWpBQ5QdSydtSI68Clx5b
 hMaGW05NJvB+f6iNIPZHZensNo0ntRUM4JNk9DZ9tz19cbBEQnvu0LMdFh4ehjOQ/k41
 hMmY4DRE8QMJDh4eErCfywL82gw7kC31uiT/Px/XwK2JW6QK9oHLrwS+UcnrCUmdNSSL
 A4oCXrvEQ4Rukl7UDY3nSBiHsmUGqghaca8EQuWNG08bIwGktNOLZ4kllyQfgJjPQDOT
 L9oA==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Wed,  6 Jan 2021 11:51:34 +0200
Message-Id: <20210106095136.224739-6-olteanv@gmail.com>
In-Reply-To: <20210106095136.224739-1-olteanv@gmail.com>
References: <20210106095136.224739-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v4 net-next 5/7] net: dsa: exit early in
	dsa_slave_switchdev_event if we can't program the FDB
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>
Cc: Jiri Pirko <jiri@resnulli.us>, Alexandra Winter <wintera@linux.ibm.com>, Ido Schimmel <idosch@idosch.org>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Marek Behun <marek.behun@nic.cz>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, UNGLinuxDriver@microchip.com, Tobias Waldekranz <tobias@waldekranz.com>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Right now, the following would happen for a switch driver that does not
implement .port_fdb_add or .port_fdb_del.

dsa_slave_switchdev_event returns NOTIFY_OK and schedules:
-> dsa_slave_switchdev_event_work
   -> dsa_port_fdb_add
      -> dsa_port_notify(DSA_NOTIFIER_FDB_ADD)
         -> dsa_switch_fdb_add
            -> if (!ds->ops->port_fdb_add) return -EOPNOTSUPP;
   -> an error is printed with dev_dbg, and
      dsa_fdb_offload_notify(switchdev_work) is not called.

We can avoid scheduling the worker for nothing and say NOTIFY_DONE.
Because we don't call dsa_fdb_offload_notify, the static FDB entry will
remain just in the software bridge.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
Changes in v4:
None.

Changes in v3:
s/NOTIFY_OK/NOTIFY_DONE/ in commit description.

Changes in v2:
Patch is new.

 net/dsa/slave.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 42ec18a4c7ba..37dffe5bc46f 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -2132,6 +2132,9 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 
 		dp = dsa_slave_to_port(dev);
 
+		if (!dp->ds->ops->port_fdb_add || !dp->ds->ops->port_fdb_del)
+			return NOTIFY_DONE;
+
 		switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
 		if (!switchdev_work)
 			return NOTIFY_BAD;
-- 
2.25.1

