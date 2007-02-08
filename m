Message-ID: <45CACED5.50701@gmail.com>
Date: Thu, 08 Feb 2007 08:18:45 +0100
From: Hotbelgo <hotbelgo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Help: Bridge and NAT through same NIC?
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I am so out of my depth on this one, but I would welcome some help.  I
have the following network and did get it to work with m0n0wall (a BSD
firewall) an option called "transparent bridge".  I've switched to Clark
Connect because of its support for content filtering, and installed
bridge-utils.

I have a home network based a single WAN-facing NIC, eth0, that gets a
public IP address from DHCP and two internal NICs:
	- eth1: that provides simple NAT for several PCs
	- eth2: a cable set-top-box that needs an IP address from a specific,
and separate, DHCP server (that checks MAC addresses so that only STBs
can connect to it).

The diagram summarises:

Internet --- DHCP server ------ eth0 ------- eth1 ---- Home network
              (public IP)     |            |
                              |            |
TV-content --DHCP (server) ---            -- eth2 ---- TV set-top box
              (Private IP)

I tried to set up a bridge of eth0 and eth2 using:
ifconfig eth0 0.0.0.0
ifconfig eth2 0.0.0.0
brctl addbr mybridge
brctl addif mybridge eth2
brctl addif mybridge eth0
ifconfig mybridge up

But that did not enable my STB to connect and meanwhile I had of course
lost connectivity for the PCs.

HB


