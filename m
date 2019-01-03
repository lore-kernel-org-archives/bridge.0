Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=L2DlwByqXsfkeyANWkmQ9a+YUc8zZQHiXhMaMfr2cXk=;
	b=G89w3lzVjF4A259PbjVW8v3t8l0tWC0JM82RWja6NFdt9TxV2q54vSf+L3wPAUXmyt
	xqH8CIk4WgwAQT5uHBLXlIzhtoTeAs4hKClWHoknc0+UfaN1lXSqDIsaLU/FiggjX6fr
	C1cGkuWMbdobMc8uYWXc4GV4sP1Ra1aNBKFv8sJZTRKroxyfvhl26xscUkeYzzxWKmxl
	HgRcDOfe4Woi141JxzjeqyDETxahJgn8WH8LJ2tVvYmCbGt5z3dER3qDLhxOrm2Q0B5P
	l3WuizBmq3eIPOnVEsq8AypMEqJQ91YWDPCxHYVxxyJqO1G9/39rMJaPVkTuXRDfMzT9
	U37A==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu,  3 Jan 2019 14:47:02 -0800
Message-Id: <20190103224702.21541-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v2] Documentation: networking: Clarify
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
Cc: andrew@lunn.ch, Florian Fainelli <f.fainelli@gmail.com>, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, vivien.didelot@gmail.com, idosch@mellanox.com, jiri@mellanox.com, davem@davemloft.net

This patch provides details on the expected behavior of switchdev
enabled network devices when operating in a "stand alone" mode, as well
as when being bridge members. This clarifies a number of things that
recently came up during a bug fixing session on the b53 DSA switch
driver.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- clarified a few parts about VLAN devices wrt. VLAN filtering and their
  behavior during enslaving.

Ido, hopefully this captures correctly what we just talked about this
morning. Thanks!

 Documentation/networking/switchdev.txt | 95 ++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/Documentation/networking/switchdev.txt b/Documentation/networking/switchdev.txt
index 82236a17b5e6..c0218746a783 100644
--- a/Documentation/networking/switchdev.txt
+++ b/Documentation/networking/switchdev.txt
@@ -392,3 +392,98 @@ switchdev_trans_item_dequeue()
 
 If a transaction is aborted during "prepare" phase, switchdev code will handle
 cleanup of the queued-up objects.
+
+Switchdev enabled network device expected behavior
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Below is a set of defined behavior that switchdev enabled network device must be
+adhering to.
+
+Configuration less state
+------------------------
+
+Upon driver bring up, the network devices must be fully operational, and the
+backing driver must be configuring the network device such that it is possible
+to send and receive to this network device such that it is properly separate
+from other network devices/ports (e.g: as is frequently with a switch ASIC).
+How this is achieved is heavily hardware dependent, but a simple solution can
+be to use per-port VLAN identifiers unless a better mechanism is available
+(proprietary metadata for each network ports for instance).
+
+The network device must be capable of running a full IP protocol stack must be
+working, including multicast, DHCP, IPv4/6, etc. If necessary, it should be
+programming the appropriate filters for VLAN, multicast, unicast etc. The
+underlying device driver must effectively be configured in a similar fashion to
+what it would do when IGMP snooping is enabled for IP multicast over these
+switchdev network devices and unsollicited multicast must be filtered as early
+as possible into the hardware.
+
+When configuring VLANs on top of the network device, all VLANs must be working,
+irrespective of the state of other network devices (e.g: other ports being part
+of a VLAN aware bridge doing ingress VID checking). See below for details.
+
+Bridged network devices
+-----------------------
+
+When a switchdev enabled network device is added as a bridge member, it should
+not be disrupting any functionality of non-bridged network devices and they
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
+  bridge might be allowed provided that there is sufficient separatation using
+  e.g: a reserved VLAN ID (4095 for instance) for untagged traffic.
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
+  switch ports within the same broadcast domain, including the CPU/management
+  port of the switch (if handled separately).
+
+- when IGMP snooping is turned on, multicast traffic must be selectively flowing
+  to the appropriate network ports and not flood the entire switch, that must
+  include the CPU/management port.
+
+Because IGMP snooping can be turned on/off at runtime, the switchdev driver must
+be able to re-configure the underlying hardware on the fly to honor the toggling
+of that option and behave appropriately.
+
+Similarly to VLAN filtering, if dynamic toggling of the IGMP snooping
-- 
2.17.1

