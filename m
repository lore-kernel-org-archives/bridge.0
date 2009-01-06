Message-ID: <0598BD8415F140D9BE986E3AB9FFF35F@lzheng>
From: "Lv Zheng" <lv.zheng@soliton.com.cn>
Date: Tue, 6 Jan 2009 17:53:40 +0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Subject: [Bridge] vlan and bond integration in bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bridge Linux <bridge@lists.linux-foundation.org>

Hi, all

I'm new to this list.

I'm trying to build a 5 ports ethernet switch using Linux.
There's hardware VLAN aware switch engine in the appliance
forwarding packets between these ports, link aggregation
is also supported in the switch chip.

Following functionalities should is required for the appliance:

802.1D: require userspace RSTP
802.1Q: MSTP/tag based VLAN is not required currently,
        but port based VLAN is required
802.3ad: auto negotiated link aggregation

Since VLAN device in Linux cannot support VID duplication
across multiple lowers, that is, following commands will fail:

vconfig set_name_type DEV_PLUS_VID_NO_PAD
vconfig add eth0 1
vconfig add eth1 1 <--- failure

I have to create netdevices as follows:
+--------------------+-------------+
| vlan1              | vlan2       |
+--------------------+-------------+
|          br0       :             |
+-------------+------+------+------+
| bond0       | eth2 | eth3 | eth4 |
+------+------+      |      |      |
| eth0 | eth1 |      |      |      |
+------+------+------+------+------+
vlans are built on top of br, eth0/1/2 should be assigned
to vlan1, eth3/4 should be assigned to vlan2, eth0/1 may
be manually aggregated.

I have encountered following problems:

1. Are there any hw-accel mechanism that allows
   replacement of the software FDB in br with switch
   chip's MAC table.
   As you may know, without hw-accel, problems will occur
   to learn frames.
   When MAC based authentication (802.1X, etc.) support is
   required, every learn frames received by switch chip
   should also be copied to CPU.  If br handled every
   learn frame, br module's FDB might grow too large to
   maintain in case that the switch chip is running in a
   limited memory system.
2. There's VLAN packet hw-accel in VLAN module, which is
   supported by bond. But without VLAN hw-accel support
   in br, the hw-accel will be broken in the br layer.
3. br do not support auto negotiated link aggregation.
   IMO, br should be bond aware, LACP may be handled by
   br through a hook between br and bond.  br then can
   dynamically combine multiple physical eth devices to
   single logical bond device.

Are there any existing implementations that can solve
these issues, or any other solutions to avoid such
problems?

Best regards/Lv Zheng
