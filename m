Message-ID: <1101851645.41acebfd196b1@192.168.11.1>
Date: Tue, 30 Nov 2004 22:54:05 +0100
From: Coen Giesberts <coen.giesberts@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Bridge] bridge slow in allowing connection
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi,

I recently upgraded the kernel in my Debian server from 2.4.22 to 2.6.9. This
server acts as router and has an ethernet bridge (br0) that combines eth1 and
eth2. Each of these two network cards is connected to one Windows PC.
Since I booted kernel 2.6.9 it takes more than one minute for a client pc to
receive its IP address when that one starts up. I noticed that the kernel
messages (shown below) are displayed more often than before. Using the 2.4
kernel they were only displayed when unplugging the network cable. Now they are
also displayed after a client PC has shut down.

Can anyone explain why this takes so much time?


Here is the part of syslog that shows the delay time:
Nov 28 19:30:39 servus kernel: br0: port 2(eth2) entering disabled state
Nov 28 19:31:39 servus kernel: br0: port 2(eth2) entering listening state
Nov 28 19:31:54 servus kernel: br0: port 2(eth2) entering learning state
Nov 28 19:32:09 servus kernel: br0: topology change detected, propagating
Nov 28 19:32:09 servus kernel: br0: port 2(eth2) entering forwarding state
Nov 28 19:32:18 servus dhcpd: DHCPDISCOVER from 00:08:a1:19:9e:b1 via br0
Nov 28 19:32:18 servus dhcpd: DHCPOFFER on 192.168.11.2 to
00:08:a1:19:9e:b1 via br0
Nov 28 19:32:18 servus dhcpd: DHCPREQUEST for 192.168.11.2 from
00:08:a1:19:9e:b1 via br0
Nov 28 19:32:18 servus dhcpd: DHCPACK on 192.168.11.2 to
00:08:a1:19:9e:b1 via br0


Thanks,
Coen


----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
