Message-ID: <17657.58029.396742.856781@fisica.ufpr.br>
Date: Sat, 2 Sep 2006 16:59:41 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: carlos@fisica.ufpr.br (Carlos Carvalho)
Subject: [Bridge] problems with bridging and dhcp
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hello,

I'm trying to use bridging in our servers and found a problem with
dhcp. Some clients manage to get an IP from the server, using
DHCPDISCOVER/DHCPREQUEST. However others use BOOTREQUEST and these
don't seem to get an answer. The server sends a BOOTREPLY but the
clients continue to send BOOTREQUEST for ever. There are also some
(occasional) messages from the dhcp server like "ip length 576
disagrees with bytes received 590" followed by "accepting packet with
data after udp payload".

I'm using kernel.org's 2.6.17.11. The bridge is created like this:

ifconfig eth1 up
vconfig set_name_type DEV_PLUS_VID_NO_PAD
brctl addbr br0

for i in <range of vlan tags>; do
   vconfig add eth1 $i
   vconfig set_flag eth1.$i 1 0
   brctl addif br0 eth1.$i
done

for i in <range of vlan tags>; do
   ifconfig eth1.$i up
done   

ifconfig br0 <internal-ip>

Note that eth1 doesn't get an IP.

I also have a question. With the above setup shouldn't the bridge
forward packets between all vlans automatically? ebtables says the
default policy is accept but pinging between machines in different
vlans doesn't work. Does the bridge adjusts the tags (I'd think so)?
If it doesn't the switch will block the frames.
