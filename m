Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AleSypaYvGLxF9YwqjeAB9A98Pwe4iYKy7o772RJXHk=;
 b=Nq711Vd97Y+eL8tsYmvxVzEf8W94oBpkAujgT5rHMwG62rl4DDaXBOxirBo1OtTzA6
 7VSGWV8/lTkwhdnWHAXVGvKO0SryKUJszSxu2eHTLyXJ65B3VYQQ95JNeXFDfl5agcLT
 gHQckE4laVQJ/Eond361aHfygg5jVg/GRStAwR6WUDCmRN5ruTQfXwm8OSkD8FvGlXrI
 UifXUDxNAOfgNxFPCjXWSPoeqEBwUCfOn7ewfYloaiHktWv1NZTziq3xVWlCLJMHEulZ
 gX9mfn2Ma4Ln6vxRjgbIcnI5u8+xTKW8yq1FfdvAoT/aEIWzVaZxwNoU8SwEl0XToUCM
 Y/vQ==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Tue, 29 Jun 2021 17:06:54 +0300
Message-Id: <20210629140658.2510288-12-olteanv@gmail.com>
In-Reply-To: <20210629140658.2510288-1-olteanv@gmail.com>
References: <20210629140658.2510288-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v5 net-next 11/15] net: dsa: sync static FDB
	entries on foreign interfaces to hardware
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vladimir Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

DSA is able to install FDB entries towards the CPU port for addresses
which were dynamically learnt by the software bridge on foreign
interfaces that are in the same bridge with a DSA switch interface.
Since this behavior is opportunistic, it is guarded by the
"assisted_learning_on_cpu_port" property which can be enabled by drivers
and is not done automatically (since certain switches may support
address learning of packets coming from the CPU port).

But if those FDB entries added on the foreign interfaces are static
(added by the user) instead of dynamically learnt, currently DSA does
not do anything (and arguably it should).

Because static FDB entries are not supposed to move on their own, there
is no downside in reusing the "assisted_learning_on_cpu_port" logic to
sync static FDB entries to the DSA CPU port unconditionally, even if
assisted_learning_on_cpu_port is not requested by the driver.

For example, this situation:

   br0
   / \
swp0 dummy0

$ bridge fdb add 02:00:de:ad:00:01 dev dummy0 vlan 1 master static

Results in DSA adding an entry in the hardware FDB, pointing this
address towards the CPU port.

The same is true for entries added to the bridge itself, e.g:

$ bridge fdb add 02:00:de:ad:00:01 dev br0 vlan 1 self local

(except that right now, DSA still ignores 'local' FDB entries, this will
be changed in a later patch)

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v4->v5: small fixups to commit message

 net/dsa/slave.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index ac7f4f200ab1..ea9a7c1ce83e 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -2403,9 +2403,12 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 
 			dp = dsa_slave_to_port(dev);
 		} else {
-			/* Snoop addresses learnt on foreign interfaces
-			 * bridged with us, for switches that don't
-			 * automatically learn SA from CPU-injected traffic
+			/* Snoop addresses added to foreign interfaces
+			 * bridged with us, or the bridge
+			 * itself. Dynamically learned addresses can
+			 * also be added for switches that don't
+			 * automatically learn SA from CPU-injected
+			 * traffic.
 			 */
 			struct net_device *br_dev;
 			struct dsa_slave_priv *p;
@@ -2424,7 +2427,8 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 			dp = p->dp;
 			host_addr = true;
 
-			if (!dp->ds->assisted_learning_on_cpu_port)
+			if (!fdb_info->added_by_user &&
+			    !dp->ds->assisted_learning_on_cpu_port)
 				return NOTIFY_DONE;
 
 			/* When the bridge learns an address on an offloaded
-- 
2.25.1

