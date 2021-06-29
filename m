Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+VJEpKYFzBJak2d7pHyDTke1vfLEgs3xoQ1r4o4dgZM=;
 b=mc/QbPoqafxS4G4eJ7J2D7LkgO1CV8lFyrq9a/Vb5fCrZ6NqNJGNCp1sVfNMVOmBGJ
 /H8w5DqF7Gyv9+Q4z0pbeeg6nG92z2TcOsn2EfHHfBu5auXz3mbIKl7maiwv+cPCR4HN
 wxt9dZME7jeRZvIRvjcsGNYco3wKx9vBdblLSuW0g0GvQ8m6sqafxJ0xBlDXUVHC04ba
 NRk5Q6xDXz06I+9TRAUEpOESApbLOW615sUtlIdjhC+uJa7EBK1Yhpv2oVFdzu1do8jz
 VPmLCsX0y+DOn5fBGJgF3PuErRCdr1ttpm/nRdqfxybCV6PlzKbvgazZ+QzWhQjiGaaC
 EaSg==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Tue, 29 Jun 2021 17:06:53 +0300
Message-Id: <20210629140658.2510288-11-olteanv@gmail.com>
In-Reply-To: <20210629140658.2510288-1-olteanv@gmail.com>
References: <20210629140658.2510288-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v5 net-next 10/15] net: dsa: install the host MDB
	and FDB entries in the master's RX filter
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

If the DSA master implements strict address filtering, then the unicast
and multicast addresses kept by the DSA CPU ports should be synchronized
with the address lists of the DSA master.

Note that we want the synchronization of the master's address lists even
if the DSA switch doesn't support unicast/multicast database operations,
on the premises that the packets will be flooded to the CPU in that
case, and we should still instruct the master to receive them. This is
why we do the dev_uc_add() etc first, even if dsa_port_notify() returns
-EOPNOTSUPP. In turn, dev_uc_add() and friends return error only if
memory allocation fails, so it is probably ok to check and propagate
that error code and not just ignore it.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v4->v5: do the dev_uc_add before the dsa_port_notify, as was correctly
        hinted by the commit message but not implemented this way
        previously

 net/dsa/port.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index 1b80e0fbdfaa..778b0dc2bb39 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -655,6 +655,12 @@ int dsa_port_host_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 		.addr = addr,
 		.vid = vid,
 	};
+	struct dsa_port *cpu_dp = dp->cpu_dp;
+	int err;
+
+	err = dev_uc_add(cpu_dp->master, addr);
+	if (err)
+		return err;
 
 	return dsa_port_notify(dp, DSA_NOTIFIER_HOST_FDB_ADD, &info);
 }
@@ -668,6 +674,12 @@ int dsa_port_host_fdb_del(struct dsa_port *dp, const unsigned char *addr,
 		.addr = addr,
 		.vid = vid,
 	};
+	struct dsa_port *cpu_dp = dp->cpu_dp;
+	int err;
+
+	err = dev_uc_del(cpu_dp->master, addr);
+	if (err)
+		return err;
 
 	return dsa_port_notify(dp, DSA_NOTIFIER_HOST_FDB_DEL, &info);
 }
@@ -715,6 +727,12 @@ int dsa_port_host_mdb_add(const struct dsa_port *dp,
 		.port = dp->index,
 		.mdb = mdb,
 	};
+	struct dsa_port *cpu_dp = dp->cpu_dp;
+	int err;
+
+	err = dev_mc_add(cpu_dp->master, mdb->addr);
+	if (err)
+		return err;
 
 	return dsa_port_notify(dp, DSA_NOTIFIER_HOST_MDB_ADD, &info);
 }
@@ -727,6 +745,12 @@ int dsa_port_host_mdb_del(const struct dsa_port *dp,
 		.port = dp->index,
 		.mdb = mdb,
 	};
+	struct dsa_port *cpu_dp = dp->cpu_dp;
+	int err;
+
+	err = dev_mc_del(cpu_dp->master, mdb->addr);
+	if (err)
+		return err;
 
 	return dsa_port_notify(dp, DSA_NOTIFIER_HOST_MDB_DEL, &info);
 }
-- 
2.25.1

