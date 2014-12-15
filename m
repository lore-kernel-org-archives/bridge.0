Return-Path: <link@ngc.net.ua>
From: Denis Zinevich <link@ngc.net.ua>
MIME-Version: 1.0
Message-Id: <4650111418650772@web4g.yandex.ru>
Date: Mon, 15 Dec 2014 15:39:32 +0200
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Subject: [Bridge] ipsec + bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello,

Got an issue that seems to be related to few technologies at same time.
My setup:
one eth0 iface, connected to bridge br0. server runs strongswan, nat rules to nat user connections.
Problem:
Clients connects via ipsec and can't ping anything on internet, but can ping gateway.
If i set promisc mode on br0 - traffic goes fine.

Test1:
Disable bridge, use eth0 as main iface - everything works fine, eth0 not in promisc mode.
Test2:
Bridged setup, using tcpdump (-p for non-promisc mode), checking 2 ifaces - eth0 and br0, two modes - promisc/non-promisc.
in all cases ips and macs in packets are all same, flags too. Only difference is:
In br0 non promisc mode I can see responce (responce to ping) on eth0 arrived, but I can't see it on br0
in promisc mode I see this responce on br0.

Any ideas where to digg ?
Thanks in advance.

--
Denis
