MIME-Version: 1.0
Date: Fri, 28 Jan 2011 01:22:29 +0530
Message-ID: <AANLkTik9i930FMKv4rNajQ2v+ajkdViwFaqrUnw2hD=b@mail.gmail.com>
From: Arun Khan <knura9@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bridge] Packet "leakage" between two bridges
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linux Bridge <bridge@lists.linux-foundation.org>

Host OS/HW: Debian Squeeze (amd64), openSUSE 11.3 (amd64), 6GB RAM,
Core2Quad 8600

I am trying to create "virtual" networks using bridge, ethernet and
tap interfaces in my desktop [1]

The network topology that I want to simulate is as follows:

Evaluate LiveCD distros (including GW/Firewall ISOs) using the Linux KVM.

Using brctl and tunctl  I have the following setup (brctl show):

bridge name     bridge id               STP enabled     interfaces
br0             8000.001cc09b9b54       no                  eth0
                                                                           tap0
br1             8000.7e45d3f813b4        no                  tap1
                                                                           tap2

br0 (192.168.1.69) (bridged to eth0) LAN has a DHCP server and it is
the bridge to the "external" network whereas br1 is supposed to be the
switch for LAN (isolated).

Through the KVM, the Guest OS is presented two ethernet interfaces
tap0 for the WAN ethernet port (tap0) and tap1 for the LAN for the
ethernet port.

The KVM command line for the "GW" VM is:

kvm \
-vga std \
-m 256 \
-boot d \
-cdrom ${KVM_LIVE_CD} \
-net nic,model=rtl8139,macaddr=${nic_mac_addr0} \
-net tap,ifname=tap0,script=no,downscript=no \
-net nic,model=e1000,macaddr=${nic_mac_addr1} \
-net tap,ifname=tap1,script=no,downscript=no \

Variable KVM_LIVE_CD points to the relevant ISO image.

When I boot a LiveCD which acquires IP on *all*  the network
interfaces via DHCP; in the Guest OS, I find that both network
interfaces have been assigned IP numbers from the 192.168.1.0 network
from the DHCP server.

For the WAN port, it makes sense as br0 is connected to eth0 and the
Guest OS acquires an IP address from the DHCP server.

However, I did not expect the "LAN" port, in the Guest OS, to acquire
and IP number from the same DHCP server.  As br1 does not connect to
any physical interface (like eth0), I expect the second interface eth1
(tap1 in Host OS) to not have any IP.

From the above, it appears that even though the two bridges are
defined separately, essentially ethernet frames on either bridge are
visible to both bridge.

Is it possible to restrict ethernet traffic to it's respective bridge
only?  I am really keen on finding a solution.  Any pointers /
solutions would be highly appreciated.

[1] <http://www.faqs.org/docs/Linux-HOWTO/BRIDGE-STP-HOWTO.html>

TIA,
-- Arun Khan
