Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=AuYkbTSQFNb4upfucvLG8R/nTOocXRU0C1GDHR5Jow0=;
	b=fBsQrjoNVLvxHNN2KKGYs9AgfLeemsLP6Y9yQ1RLwaTAxUgavE1yb+Ag9abmP2j0mr
	ziLZZg0OWLmdhEWPHtrL46IY3rdWVCPY11NVym8P7RvsD7ovYRz0VMtnaqsYpljGS6fi
	tINVolwxqIc0Fh2WKulCgAHYKMcNChBrA8DoWi4XaeqpHuZHb4Qj41gXR119Gt0OodU9
	cw0OSVwSXt+86KJxC+DbkXQVkBzSVcEux2gAmfUtdTlF3NQmrRgSvzPr9ayRhCkI89Gg
	mIZ4sV2O8T8Od4XnGwkV1wruVAFo9Cgvf1hxcbq5FtSa6CbtIpZ6k8scJOnIMWhoFsYk
	iaLw==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue,  8 Jan 2019 20:39:30 -0800
Message-Id: <20190109043930.8534-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v3] Documentation: networking: Clarify
	switchdev devices behavior
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch, rdunlap@infradead.org, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, vivien.didelot@gmail.com, idosch@mellanox.com, jiri@mellanox.com, Florian Fainelli <f.fainelli@gmail.com>, davem@davemloft.net

This patch provides details on the expected behavior of switchdev
enabled network devices when operating in a "stand alone" mode, as well
as when being bridge members. This clarifies a number of things that
recently came up during a bug fixing session on the b53 DSA switch
driver.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v3:

- spell checks, past vs. present use (Randy)
- clarified some behaviors a bit more regarding multicast flooding
- added some missing sentence about multicast snopping knob being
  dynamically turned on/off

Changes in v2:

- clarified a few parts about VLAN devices wrt. VLAN filtering and their
  behavior during enslaving.

 Documentation/networking/switchdev.txt | 104 +++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/Documentation/networking/switchdev.txt b/Documentation/networking/switchdev.txt
index 82236a17b5e6..36049f997517 100644
--- a/Documentation/networking/switchdev.txt
+++ b/Documentation/networking/switchdev.txt
@@ -392,3 +392,107 @@ switchdev_trans_item_dequeue()
 
 If a transaction is aborted during "prepare" phase, switchdev code will handle
 cleanup of the queued-up objects.
+
+Switchdev enabled network device expected behavior
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Below is a set of defined behavior that switchdev enabled network devices must
+adhere to.
+
+Configuration less state
+------------------------
+
+Upon driver bring up, the network devices must be fully operational, and the
+backing driver must configure the network device such that it is possible to
+send and receive to this network device such that it is properly separate from
+other network devices/ports (e.g.: as is frequently with a switch ASIC). How
+this is achieved is heavily hardware dependent, but a simple solution can be to
+use per-port VLAN identifiers unless a better mechanism is available
+(proprietary metadata for each network port for instance).
+
+The network device must be capable of running a full IP protocol including
+multicast, DHCP, IPv4/6, etc. If necessary, it should be programming the
+appropriate filters for VLAN, multicast, unicast etc. The underlying device
+driver must effectively be configured in a similar fashion to what it would do
+when IGMP snooping is enabled for IP multicast over these switchdev network
+devices and unsolicited multicast must be filtered as early as possible into
+the hardware.
+
+When configuring VLANs on top of the network device, all VLANs must be working,
+irrespective of the state of other network devices (e.g.: other ports being part
+of a VLAN aware bridge doing ingress VID checking). See below for details.
+
+Bridged network devices
+-----------------------
+
+When a switchdev enabled network device is added as a bridge member, it should
+not disrupt any functionality of non-bridged network devices and they
+should continue to behave as normal network devices. Depending on the bridge
+configuration knobs below, the expected behavior is documented.
+
+VLAN filtering
+~~~~~~~~~~~~~~
+
+The Linux bridge allows the configuration of a VLAN filtering mode (compile and
+run time) which must be observed by the underlying switchdev network
+device/hardware:
+
+- with VLAN filtering turned off: frames ingressing the device with a VID that
+  is not programmed into the bridge/switch's VLAN table must be forwarded.
+
+- with VLAN filtering turned on: frames ingressing the device with a VID that is
+  not programmed into the bridges/switch's VLAN table must be dropped.
+
+Non-bridged network ports of the same switch fabric must not be disturbed in any
+way, shape or form by the enabling of VLAN filtering.
+
+VLAN devices configured on top of a switchdev network device (e.g: sw0p1.100)
+which is a bridge port member must also observe the following behavior:
+
+- with VLAN filtering turned off, these VLAN devices must be fully functional
+  since the hardware is allowed VID frames. Enslaving VLAN devices into the
+  bridge might be allowed provided that there is sufficient separation using
+  e.g.: a reserved VLAN ID (4095 for instance) for untagged traffic.
+
+- with VLAN filtering turned on, these VLAN devices should not be allowed to
+  be created because they duplicate functionality/use case with the bridge's
+  VLAN functionality.
+
+Because VLAN filtering can be turned on/off at runtime, the switchdev driver
+must be able to re-configure the underlying hardware on the fly to honor the
+toggling of that option and behave appropriately.
+
+A switchdev driver can also refuse to support dynamic toggling of the VLAN
+filtering knob at runtime and require a destruction of the bridge device(s) and
+a creation of new bridge device(s) with a different VLAN filtering value to
+ensure VLAN awareness is pushed down to the HW.
+
+IGMP snooping
+~~~~~~~~~~~~~
+
+The Linux bridge allows the configuration of IGMP snooping (compile and run
+time) which must be observed by the underlying switchdev network device/hardware
+in the following way:
+
+- when IGMP snooping is turned off, multicast traffic must be flooded to all
+  switch ports within the same broadcast domain. The CPU/management port
+  should ideally not be flooded and continue to learn multicast traffic through
+  the network stack notifications. If the hardware is not capable of doing that
+  then the CPU/management port must also be flooded and multicast filtering
+  happens in software.
+
+- when IGMP snooping is turned on, multicast traffic must selectively flow
+  to the appropriate network ports (including CPU/management port) and not flood
+  the switch.
+
+Note: reserved multicast addresses (e.g.: BPDUs) as well as Local Network
+Control block (224.0.0.0 - 224.0.0.255) do not require IGMP and should always
+be flooded.
+
+Because IGMP snooping can be turned on/off at runtime, the switchdev driver must
+be able to re-configure the underlying hardware on the fly to honor the toggling
+of that option and behave appropriately.
+
+A switchdev driver can also refuse to support dynamic toggling of the multicast
+snooping knob at runtime and require a destruction of the bridge device(s) and
+a creation of a new bridge device(s) with a different multicast snooping value.
-- 
2.19.1

