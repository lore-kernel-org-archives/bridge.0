Message-ID: <5B94B429B59C4ACC8A376D25A268AD95@lzheng>
From: "Lv Zheng" <lv.zheng@soliton.com.cn>
References: <0598BD8415F140D9BE986E3AB9FFF35F@lzheng>
	<49639295.9060309@candelatech.com>
	<83475D0A79834C4C964DFE7F73FABFFD@lzheng>
	<49640E77.2090108@candelatech.com>
	<66223B09B0EC4F6EA1D9B74E39C0E215@lzheng>
	<20090108075852.GU10913@via.ecp.fr>
	<2E0FC4E549A74D6A836D12FCC08A3E59@lzheng>
	<20090108124525.GV10913@via.ecp.fr>
In-Reply-To: <20090108124525.GV10913@via.ecp.fr>
Date: Mon, 12 Jan 2009 12:41:45 +0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-15";
	reply-type=original
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] vlan and bond integration in bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Boris Dores <babal@via.ecp.fr>
Cc: Bridge Linux <bridge@lists.linux-foundation.org>

>  I was talking about regular data packets. Usually, when refering to
> "port based" VLAN, we mean that the host (or the hosts) connected to
> that port has no knowledge whatsoever of what a VLAN is.
> 
>  If (and only if) this is what you want, then br0 should be directly
> connected to the physical port (bond or eth), and not on top of a vlan
> layer which will filter out untagged incoming packets, and tag outgoing
> packets.

Greetings.

802.1Q defines that each bridge port

shall support following parameters:
1. acceptable frame types, one of the following:
  A. admit only VLAN tagged frames
  B. admit only untagged and priority-tagged frames
  C. admit all frames (default)
2. a PVID for port based VLAN classification
may support following parameters:
3. a VID set for port and protocol based classification

For port based VLAN, a netdevice might still be
VLAN-aware and at least 1 & 2 should be configurable
for the netdevice (known as EISS support).

I noticed following differences are exist between
802.1Q compatible switch chip's MAC port devices
and a normal NIC devices:

Switch port do support 802.1Q parameters will
1. drop untagged frames if it is configured to admit
  only VLAN tagged frames and drop frames not
  admitted
2. drop any tagged frames whose tag is not in the
  VID set if it is configured to admit only VLAN
  tagged frames and drop frames not admitted
3. handle any untagged frames as PVID tagged frames
  if it is configured to admit untagged and
  priority-tagged frames and handle such frames as
  if they are coming from the default vlan
4. handle any tagged frames whose tag is not in the
  VID set as PVID tagged frames if it is configured
  to admit untagged and priority-tagged frames and
  handle such frames as if they are coming from the
  default vlan

While Linux does not support such features.

Should following attributes be added to netdevice
to support port based VLAN?
1. pvid
2. admit_frame_types
  VLAN ioctl command may be added for all
  netdevice (like ADD_VLAN_CMD) to
  manipulate above 2 vlan specific parameters:
  SET_PVID_CMD
  SET_FRAME_TYPES_CMD
  SET_FRAME_ACTIONS_CMD
  Addtional hooks might also be added to
  netdevice:
  vlan_set_pvid
  vlan_set_admit_frames (types & actions)
  if frames is not admitted, actions might be configured
  to allow:
  2.1 DROP: drop the frame
  2.2 DEF_VLAN: handle the frame as if it is pvid tagged
3. vlan_nr_groups:
  set by NIC driver, its default value might be a Kconfig
  option such as CONFIG_VLAN_8021Q_GROUPS
4. vlan_gid_map
  GID enabling bits, might be BITMAP(vlan_nr_groups)
5. vlan_groups
  VID <-> GID mappings, might be u16[vlan_nr_groups]
  register_vlan_device / unregister_vlan_device
  might maintain this map and gid array

If hardware do support 802.1Q parameters, it might
report vlan_nr_groups on registration.
Hardware vlan_gid_map and vlan_groups might be
synchronized by supporting
vlan_rx_add_vid / vlan_rx_kill_vid.
Hardware PVID and admit_frame_types might be
synchronized by supporting
vlan_set_pvid / vlan_set_admit_frames.

If PVID in netdevice was implemented, there might be
tow options we could choose:
1. ensure there is always a ethx.pvid device exist
  might be suitable for tag based switch applications
2. ensure there is always not a ethx.pvid device exist
  might be suitable for port based switch applications

vlan_skb_recv might be modified to support EISS features
because this function will handle all VLAN-tagged frames

netif_recv_skb might be modified to support EISS features
because this function will handle all VLAN-untagged frames

dev_hard_start_xmit might be modified to support EISS
feauturs to do tagging on outgoing packets before hard_xmit
if pvid is set and no ethx.pvid device exists.

If I were wrong, pls let me know. Thanks in advance.

Best regards/Lv Zheng
