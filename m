MIME-Version: 1.0
Date: Sun, 30 Aug 2009 20:10:32 -0300
Message-ID: <b10f571a0908301610v246a7ce2v8d43a98fda2242cd@mail.gmail.com>
From: Diego Woitasen <diegows@xtech.com.ar>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bridge] bnx2 doesn't transmit BPDU or Blade switches don't forward
	them?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bridge@lists.linux-foundation.org

Hi,
 I have two Blades in one enclosure. They receive the same VLAN trunk
to bridge the VLANs and I want to have two bridges enabled in each
server. I've configured the bridge and enabled STP but I don' t see
the BPDU multicast incoming from the interface (I see the outging
packets).

xen198:~# tcpdump -i peth0 -enn ether dst 0180c2000000
tcpdump: WARNING: peth0: no IPv4 address assigned
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on peth0, link-type EN10MB (Ethernet), capture size 96 bytes
20:07:27.150902 00:23:7d:37:1a:82 > 01:80:c2:00:00:00, 802.3, length
52: LLC, dsap STP (0x42) Individual, ssap STP (0x42) Command, ctrl
0x03: STP 802.1d, Config, Flags [none], bridge-id
0001.00:23:7d:37:1a:82.8001, length 35
20:07:29.150876 00:23:7d:37:1a:82 > 01:80:c2:00:00:00, 802.3, length
52: LLC, dsap STP (0x42) Individual, ssap STP (0x42) Command, ctrl
0x03: STP 802.1d, Config, Flags [none], bridge-id
0001.00:23:7d:37:1a:82.8001, length 35
20:07:31.150879 00:23:7d:37:1a:82 > 01:80:c2:00:00:00, 802.3, length
52: LLC, dsap STP (0x42) Individual, ssap STP (0x42) Command, ctrl
0x03: STP 802.1d, Config, Flags [none], bridge-id
0001.00:23:7d:37:1a:82.8001, length 35

xen199:~# tcpdump -i peth0 -enn ether dst 0180c2000000
tcpdump: WARNING: peth0: no IPv4 address assigned
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on peth0, link-type EN10MB (Ethernet), capture size 96 bytes
20:07:35.115593 00:23:7d:37:08:78 > 01:80:c2:00:00:00, 802.3, length
52: LLC, dsap STP (0x42) Individual, ssap STP (0x42) Command, ctrl
0x03: STP 802.1d, Config, Flags [none], bridge-id
0002.00:23:7d:37:08:78.8001, length 35
20:07:37.115618 00:23:7d:37:08:78 > 01:80:c2:00:00:00, 802.3, length
52: LLC, dsap STP (0x42) Individual, ssap STP (0x42) Command, ctrl
0x03: STP 802.1d, Config, Flags [none], bridge-id
0002.00:23:7d:37:08:78.8001, length 35
20:07:39.115613 00:23:7d:37:08:78 > 01:80:c2:00:00:00, 802.3, length
52: LLC, dsap STP (0x42) Individual, ssap STP (0x42) Command, ctrl
0x03: STP 802.1d, Config, Flags [none], bridge-id
0002.00:23:7d:37:08:78.8001, length 35

Blade MACs are:
00:23:7d:37:08:78
00:23:7d:37:1a:82

Is there some issue with bnx2 or Blade switches and Linux bridge?

Regards,
 Diego
-- 
Diego Woitasen
XTECH
