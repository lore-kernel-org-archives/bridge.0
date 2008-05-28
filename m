Message-ID: <44844.195.55.244.106.1211964939.squirrel@www.arcoscom.com>
Date: Wed, 28 May 2008 10:55:39 +0200 (CEST)
From: "ArcosCom Linux User" <linux@arcoscom.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Problem accessing to Windows Terminal Server in load
	balancing.
Reply-To: linux@arcoscom.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi guys, I have this configuration:


LAN -- LINUX BRIDGE -- LINUX BRIDGE -- TS

The linux's bridges are for wifi purposes (2 centos machines) and is
working fine.

The problem I have is that the TS are 3 windows TS in load balancing
configuration. There is 1 IP for general purposes and every TS has its own
IP.
For example, the configuration is:

    192.168.0.1/24  TS1
    192.168.0.2/24  TS2
    192.168.0.3/24  TS3
    192.168.0.10/24 (TS server IP for load balancing)

The problem I encountered is that every PC into the LAN has access from
the LAN to every TS (tested with ping), but them have no access to the IP
for load balancing.

I observed that all TSn IP's has their ARP entry in the ARP table, but the
IP for load balancing not.

How can I solve this problem at the bridge level? I think that there is
something that the bridges are filtering and perhaps is because the TS
load balancing software uses various "virtual macs" for the load balancing
IP.

Perhaps I must change any /proc/sys/net/ipv4/conf/<dev>/ file to bypass
this filter, I'm thinking in "arp_ignore", put a "1" into it, but is a
production environment and I don't want to loss the access to the devices.

Any help?

