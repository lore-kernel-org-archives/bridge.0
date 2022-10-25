Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DCBF340893
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AB8D740891
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGfuLh4Ljvp3anWv3cPQDqm3VxfHLE4ggDkGKSJbLeE=;
 b=BV+tLJbE+6cGBPDDWI6oi7Wk+MKVCKjrznXbgY6zH4SLBIxwgJaoRYmeHZyziQQSsC8z0PpAVrYwipEawYn87vCMbDHk0uUATsGpfAUggDrTwU3s0xI260aeFoTwzqdGyXfRLnL+A1Prqox+vwKFXc1hudRSMJLQyKtNDw29WEJ12m7EhVFkjLwo1QR8DlN3iAF7dNS8fFy+Z/sSICMPxK8Zs4WMlX50GfwmXaWueLuBX7+ClajxxNXpUScuDjuw6YLdqBl1jDV7vBapt5rHbikJ2X93lOAQuWm3surQJp1c485GwFaBsbdUGYTyDMolJhRU2jXJVdLCaHTtceiepQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 25 Oct 2022 13:00:13 +0300
Message-Id: <20221025100024.1287157-6-idosch@nvidia.com>
In-Reply-To: <20221025100024.1287157-1-idosch@nvidia.com>
References: <20221025100024.1287157-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 05/16] devlink: Add packet traps for
	802.1X operation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, ivecera@redhat.com, netdev@kapio-technology.com, razor@blackwall.org, roopa@nvidia.com, Ido Schimmel <idosch@nvidia.com>, vladimir.oltean@nxp.com, edumazet@google.com, mlxsw@nvidia.com, jiri@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Add packet traps for 802.1X operation. The "eapol" control trap is used
to trap EAPOL packets and is required for the correct operation of the
control plane. The "locked_port" drop trap can be enabled to gain
visibility into packets that were dropped by the device due to the
locked bridge port check.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 Documentation/networking/devlink/devlink-trap.rst | 13 +++++++++++++
 include/net/devlink.h                             |  9 +++++++++
 net/core/devlink.c                                |  3 +++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-trap.rst b/Documentation/networking/devlink/devlink-trap.rst
index 90d1381b88de..2c14dfe69b3a 100644
--- a/Documentation/networking/devlink/devlink-trap.rst
+++ b/Documentation/networking/devlink/devlink-trap.rst
@@ -485,6 +485,16 @@ be added to the following table:
      - Traps incoming packets that the device decided to drop because
        the destination MAC is not configured in the MAC table and
        the interface is not in promiscuous mode
+   * - ``eapol``
+     - ``control``
+     - Traps "Extensible Authentication Protocol over LAN" (EAPOL) packets
+       specified in IEEE 802.1X
+   * - ``locked_port``
+     - ``drop``
+     - Traps packets that the device decided to drop because they failed the
+       locked bridge port check. That is, packets that were received via a
+       locked port and whose {SMAC, VID} does not correspond to an FDB entry
+       pointing to the port
 
 Driver-specific Packet Traps
 ============================
@@ -589,6 +599,9 @@ narrow. The description of these groups must be added to the following table:
    * - ``parser_error_drops``
      - Contains packet traps for packets that were marked by the device during
        parsing as erroneous
+   * - ``eapol``
+     - Contains packet traps for "Extensible Authentication Protocol over LAN"
+       (EAPOL) packets specified in IEEE 802.1X
 
 Packet Trap Policers
 ====================
diff --git a/include/net/devlink.h b/include/net/devlink.h
index ba6b8b094943..afd9999a9b2a 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -885,6 +885,8 @@ enum devlink_trap_generic_id {
 	DEVLINK_TRAP_GENERIC_ID_ESP_PARSING,
 	DEVLINK_TRAP_GENERIC_ID_BLACKHOLE_NEXTHOP,
 	DEVLINK_TRAP_GENERIC_ID_DMAC_FILTER,
+	DEVLINK_TRAP_GENERIC_ID_EAPOL,
+	DEVLINK_TRAP_GENERIC_ID_LOCKED_PORT,
 
 	/* Add new generic trap IDs above */
 	__DEVLINK_TRAP_GENERIC_ID_MAX,
@@ -921,6 +923,7 @@ enum devlink_trap_group_generic_id {
 	DEVLINK_TRAP_GROUP_GENERIC_ID_ACL_SAMPLE,
 	DEVLINK_TRAP_GROUP_GENERIC_ID_ACL_TRAP,
 	DEVLINK_TRAP_GROUP_GENERIC_ID_PARSER_ERROR_DROPS,
+	DEVLINK_TRAP_GROUP_GENERIC_ID_EAPOL,
 
 	/* Add new generic trap group IDs above */
 	__DEVLINK_TRAP_GROUP_GENERIC_ID_MAX,
@@ -1112,6 +1115,10 @@ enum devlink_trap_group_generic_id {
 	"blackhole_nexthop"
 #define DEVLINK_TRAP_GENERIC_NAME_DMAC_FILTER \
 	"dmac_filter"
+#define DEVLINK_TRAP_GENERIC_NAME_EAPOL \
+	"eapol"
+#define DEVLINK_TRAP_GENERIC_NAME_LOCKED_PORT \
+	"locked_port"
 
 #define DEVLINK_TRAP_GROUP_GENERIC_NAME_L2_DROPS \
 	"l2_drops"
@@ -1165,6 +1172,8 @@ enum devlink_trap_group_generic_id {
 	"acl_trap"
 #define DEVLINK_TRAP_GROUP_GENERIC_NAME_PARSER_ERROR_DROPS \
 	"parser_error_drops"
+#define DEVLINK_TRAP_GROUP_GENERIC_NAME_EAPOL \
+	"eapol"
 
 #define DEVLINK_TRAP_GENERIC(_type, _init_action, _id, _group_id,	      \
 			     _metadata_cap)				      \
diff --git a/net/core/devlink.c b/net/core/devlink.c
index 89baa7c0938b..dc54182f2e57 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -11624,6 +11624,8 @@ static const struct devlink_trap devlink_trap_generic[] = {
 	DEVLINK_TRAP(ESP_PARSING, DROP),
 	DEVLINK_TRAP(BLACKHOLE_NEXTHOP, DROP),
 	DEVLINK_TRAP(DMAC_FILTER, DROP),
+	DEVLINK_TRAP(EAPOL, CONTROL),
+	DEVLINK_TRAP(LOCKED_PORT, DROP),
 };
 
 #define DEVLINK_TRAP_GROUP(_id)						      \
@@ -11659,6 +11661,7 @@ static const struct devlink_trap_group devlink_trap_group_generic[] = {
 	DEVLINK_TRAP_GROUP(ACL_SAMPLE),
 	DEVLINK_TRAP_GROUP(ACL_TRAP),
 	DEVLINK_TRAP_GROUP(PARSER_ERROR_DROPS),
+	DEVLINK_TRAP_GROUP(EAPOL),
 };
 
 static int devlink_trap_generic_verify(const struct devlink_trap *trap)
-- 
2.37.3

