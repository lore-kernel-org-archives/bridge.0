Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C8CC340919
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9882B40915
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ai2oauCroFY3HI0rg2Y//XDMlglyEEmP2GfZg1UJh5s=;
 b=IuMyU952YfUyi0KeaB/eD/3HiQsILevxacsSVQGbnYn9xuak7n4AD2rMEG83i7dYJU6QmeioTHLMX3JudcELHc3Eb+Psea9cHf1cTlBBD+NU/gbsgL5x/Alnax1gywJQzGuzfS/sD8VmyHsj2k24fF3Os/7RkxeYbOzF4MycBQgWU/P38mema87RFI2FRRhgjaHgkOCTWdQsVu1grOnUNOuOQCsiWnzGO1vQoeJKTwQ6XEO7SIz1ErMzsenrkVBpJxXWbUvG396eCJ3TQAvkWuShtyJLN7ar6N9s90wp8DdciprBm6AncZJjLZ3KXnCeRZwAGxsfGlVlusHjQg/Bpw==
From: Petr Machata <petrm@nvidia.com>
Date: Tue, 8 Nov 2022 11:47:10 +0100
Message-ID: <ec42c7bf37d9a5e05096c409dd96c1c582747b24.1667902754.git.petrm@nvidia.com>
In-Reply-To: <cover.1667902754.git.petrm@nvidia.com>
References: <cover.1667902754.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 04/15] devlink: Add packet traps for
	802.1X operation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, mlxsw@nvidia.com, Jiri Pirko <jiri@nvidia.com>, "Hans J . Schultz" <netdev@kapio-technology.com>

From: Ido Schimmel <idosch@nvidia.com>

Add packet traps for 802.1X operation. The "eapol" control trap is used
to trap EAPOL packets and is required for the correct operation of the
control plane. The "locked_port" drop trap can be enabled to gain
visibility into packets that were dropped by the device due to the
locked bridge port check.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
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
index fa6e936af1a5..611a23a3deb2 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -894,6 +894,8 @@ enum devlink_trap_generic_id {
 	DEVLINK_TRAP_GENERIC_ID_ESP_PARSING,
 	DEVLINK_TRAP_GENERIC_ID_BLACKHOLE_NEXTHOP,
 	DEVLINK_TRAP_GENERIC_ID_DMAC_FILTER,
+	DEVLINK_TRAP_GENERIC_ID_EAPOL,
+	DEVLINK_TRAP_GENERIC_ID_LOCKED_PORT,
 
 	/* Add new generic trap IDs above */
 	__DEVLINK_TRAP_GENERIC_ID_MAX,
@@ -930,6 +932,7 @@ enum devlink_trap_group_generic_id {
 	DEVLINK_TRAP_GROUP_GENERIC_ID_ACL_SAMPLE,
 	DEVLINK_TRAP_GROUP_GENERIC_ID_ACL_TRAP,
 	DEVLINK_TRAP_GROUP_GENERIC_ID_PARSER_ERROR_DROPS,
+	DEVLINK_TRAP_GROUP_GENERIC_ID_EAPOL,
 
 	/* Add new generic trap group IDs above */
 	__DEVLINK_TRAP_GROUP_GENERIC_ID_MAX,
@@ -1121,6 +1124,10 @@ enum devlink_trap_group_generic_id {
 	"blackhole_nexthop"
 #define DEVLINK_TRAP_GENERIC_NAME_DMAC_FILTER \
 	"dmac_filter"
+#define DEVLINK_TRAP_GENERIC_NAME_EAPOL \
+	"eapol"
+#define DEVLINK_TRAP_GENERIC_NAME_LOCKED_PORT \
+	"locked_port"
 
 #define DEVLINK_TRAP_GROUP_GENERIC_NAME_L2_DROPS \
 	"l2_drops"
@@ -1174,6 +1181,8 @@ enum devlink_trap_group_generic_id {
 	"acl_trap"
 #define DEVLINK_TRAP_GROUP_GENERIC_NAME_PARSER_ERROR_DROPS \
 	"parser_error_drops"
+#define DEVLINK_TRAP_GROUP_GENERIC_NAME_EAPOL \
+	"eapol"
 
 #define DEVLINK_TRAP_GENERIC(_type, _init_action, _id, _group_id,	      \
 			     _metadata_cap)				      \
diff --git a/net/core/devlink.c b/net/core/devlink.c
index 40fcdded57e6..1c2cb6fc29c3 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -11731,6 +11731,8 @@ static const struct devlink_trap devlink_trap_generic[] = {
 	DEVLINK_TRAP(ESP_PARSING, DROP),
 	DEVLINK_TRAP(BLACKHOLE_NEXTHOP, DROP),
 	DEVLINK_TRAP(DMAC_FILTER, DROP),
+	DEVLINK_TRAP(EAPOL, CONTROL),
+	DEVLINK_TRAP(LOCKED_PORT, DROP),
 };
 
 #define DEVLINK_TRAP_GROUP(_id)						      \
@@ -11766,6 +11768,7 @@ static const struct devlink_trap_group devlink_trap_group_generic[] = {
 	DEVLINK_TRAP_GROUP(ACL_SAMPLE),
 	DEVLINK_TRAP_GROUP(ACL_TRAP),
 	DEVLINK_TRAP_GROUP(PARSER_ERROR_DROPS),
+	DEVLINK_TRAP_GROUP(EAPOL),
 };
 
 static int devlink_trap_generic_verify(const struct devlink_trap *trap)
-- 
2.35.3

