From: Jeroen Hoek <jeroen.hoek@dcf.nl>
Content-Type: text/plain
Message-Id: <1074096593.12422.1.camel@haruka>
Mime-Version: 1.0
Date: Wed, 14 Jan 2004 17:09:54 +0100
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Freezing bridges
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

I have the following situation:

A Linux 2.4.22 server:

Physical ethernet:
lan1 - Ethernet port (Internet)
lan2 - Ethernet port (Cisco Switch, Trunk port)

Tunnel:
tap1 - OpenVPN in tcp-server mode

VLAN's:
lan2.201
lan2.202
lan2.203
tap1.201
tap1.202
tap1.203

Bridges:
br201 (lan2.201, tap1.201)
br202 (lan2.202, tap1.202)
br203 (lan2.203, tap1.203)

On the other end, the same type of server:

Physical ethernet:
lan1 - Ethernet port (Internet)
lan2 - Ethernet port (LAN)
lan3 - Ethernet port (LAN)
lan4 - Ethernet port (LAN)

Tunnel:
tap1 - OpenVPN in tcp-client mode

VLAN's:
tap1.201
tap1.202
tap1.203

Bridges:
br201 (lan2, tap1.201)
br202 (lan3, tap1.202)
br203 (lan4, tap1.203)

Both servers are connected over Internet. This setup works. The server
with the trunk port actually has more bridges; there are 3 servers that
connect to it thru an OpenVPN tunnel, and all 3 server have 3 unique
VLAN's bridged to it.

The problem is, that although in testing the setup everything runs
stable, in reality, it doesn't. The first server crashes irregularly,
but usually after a day or 2/3. The other servers have the exact same
hardware, and crash aswell, albeit after a longer period of time. There
is no indication as to what goes wrong. The servers still reply to ping
and xinetd-daytime, but ssh is gone, as are the tunnels. The log shows
nothing. The hardware watchdog does not reset and seems to keep
receiving signals from the kernel module to prevent it from rebooting.

I don't know anymore. I replaced vtun with OpenVPN for the ethernet
tunneling, but that does not seem to matter.

Please advice, I am lost. Would upgrading to kernel 2.6.1 be a valid
solution? Am I overreaching the possibilities of the bridging
functionality? Am I overlooking some pitfall?

With kind and desperate regards,

ing. Jeroen Hoek

