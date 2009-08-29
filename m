MIME-Version: 1.0
Date: Fri, 28 Aug 2009 22:01:42 -0300
Message-ID: <b10f571a0908281801u182096a0m373642afaf0b95cd@mail.gmail.com>
From: Diego Woitasen <diegows@xtech.com.ar>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bridge] Bridging VLANs
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
I'm working on a network where I have 13 VLANs (using 802.1q). I need
to build a transition escenario bridging the VLANs with a Linux
Bridge. My Linux box has the trunk incoming from eth1, so to bridge
them I use:

brctl addbr superbridge
vconfig set_name_type VLAN_PLUS_VID_NO_PAD
for ((i = 200; i <= 212; i++)); do
 vconfig add eth1 $i
 ip link set vlan$i
 brctl addif superbridge vlan$i
done
ip link superbrige up

I think that should work but I want to hear another opinions, advices
or just tell me if that wouldn't work.

Regards,
 Diego

-- 
Diego Woitasen
XTECH
