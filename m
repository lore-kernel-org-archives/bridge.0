From: Alessandro Fiorino <a.fiorino@chibacity.it>
Date: Fri, 12 Mar 2004 14:33:36 +0100
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403121433.36583.a.fiorino@chibacity.it>
Subject: [Bridge] Strange DHCP behaviour with bridging
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Here is the scenario: I have one server with kernel 2.4.24 with a bridge br0 
made of 2 interfaces, eth0 and tap0 (the last is an OpenVPN tunnel), and one 
remote computer connetting through tap0. If I assign a static IP to the 
remote computer, the bridge works perfecly (so I think the problem is not 
OpenVPN-related). If I start a DHCPd on the server and I configure the remote 
client to get the IP from it, something strange happens: if I "sniff" on the 
br0 interface, I can see the DHCP requests coming from the client (from 
0.0.0.0.bootpc to 255.255.255.bootps) and the DHCPd answers going back from 
ip.of.the.server.bootps to 255.255.255.255.bootpc; also sniffing on eth0 
gives the same result, but if I sniff on the tap0 interface, I don't see the 
replies! So the client never get its own IP. What I'm doing wrong? To add 
some mistery, sometimes (one try out of 10)  the reply flows correctly to the 
remote client. All the three interfaces (eth0, br0, tap0) doesn't have  
firewalling enabled, and under /proc ip_forwarding is enabled and rp_filter 
is disabled for all interfaces. brctl showmacs br0 correctly shows the remote 
virtual interface MAC address as not local.Both eth0 and tap0 have been 
configured with ifconfig 0.0.0.0 promisc up.
Thanks in advance.

Alessandro Fiorino


