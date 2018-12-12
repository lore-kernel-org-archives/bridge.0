Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=GlBafHCRiiYh+VZ9K7i0ryh+KhlSGThQQj4TRpIed2M=;
	b=ptKrI7jHBIx/Wg9eWW0zAL0jwfaj4/vut6GIso+XwUMEleLkdKl9z8wkVruogU+NLx
	Y/RfjBcoScfXm9/JaTbOdpOSfSWbX81Y4dSRuDDHAZrMFmHLWUxrCFCSANiPjXVD0kMd
	VdZBFdJmV+CXolqB9FqSHQHC/utu7/4s++LL2UXOhFXkC4FiOogQV4Mvc4XflaCqGfvQ
	t7nzkuhMMvrHXrC5RZkBys+1fF4+aeD/MSPuVTfaVFPTnUNF8QkqJFEQYjzVNmDZzW/h
	+xS72ZVLqlrcQXRm0tszTNn9cah5/9/GbF5S/eRe1cCclgg+hkBM/pyCaUrOjwOolX1l
	t9FA==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 12 Dec 2018 15:09:43 -0800
Message-Id: <20181212230943.757-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next] Documentation: networking: Clarify
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
Hi all,

Please review carefully, and let me know if you think some of the
behaviors described below do not make any sense. Thanks!

 Documentation/networking/switchdev.txt | 86 ++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/Documentation/networking/switchdev.txt b/Documentation/networking/switchdev.txt
index 82236a17b5e6..8c83174b477b 100644
--- a/Documentation/networking/switchdev.txt
+++ b/Documentation/networking/switchdev.txt
@@ -392,3 +392,89 @@ switchdev_trans_item_dequeue()
 
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
+from other network devices/ports (e.g: as is frequenty with a switch ASIC). How
+this is achieved is heavily hardware dependent, but a simple solution can be to
+use per-port VLAN identifiers.
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
+  since the hardware is allowed VID frames
+
+- with VLAN filtering turned on, these VLAN devices are not going to be
+  functional unless the bridge's VLAN database is also configured to have that
+  VID enabled for the underlying network device/port
+  (e.g: bridge vlan add vid 100 dev sw0p1)
+
+Because VLAN filtering can be turned on/off at runtime, the switchdev driver
+must be able to re-configure the underlying hardware on the fly to honor the
+toggling of that option and behave appropriately.
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
-- 
2.17.1

