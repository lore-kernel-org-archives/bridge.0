Message-ID: <4B81C096.9090106@xs4all.nl>
Date: Mon, 22 Feb 2010 00:24:06 +0100
From: Zoilo Gomez <zoilo@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] using bridges to connect vlans and untagged data
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

I have the following interfaces:
=> vlan22 and vlan2 on eth0
=> vlan23 and untagged traffic on eth1

The essence is that:
=> vlan22@eth0 and vlan23@eth1 need to be bridged, and
=> vlan2@eth0 and the untagged traffic on eth1 need to be bridged.

Software:
=> Gentoo 10.1
=> linux 2.6.32.7 vanilla
=> vconfig 1.9
=> bridge-utils 1.4

===== My implementation:

vconfig add eth0 2
vconfig add eth0 22

vconfig add eth1 23

brctl addbr br0
brctl addif br0 vlan2
brctl addif br0 eth1

brctl addbr br1
brctl addif br1 vlan22
brctl addif br1 vlan23

ebtables -P FORWARD DROP

ebtables -A FORWARD -j ACCEPT -p ! 802_1Q -i eth1 -o vlan2
ebtables -A FORWARD -j ACCEPT -p ! 802_1Q -i vlan2 -o eth1

ebtables -A FORWARD -j ACCEPT -i vlan23 -o vlan22
ebtables -A FORWARD -j ACCEPT -i vlan22 -o vlan23

Unfortunately, the vlan23 interface stops receiving data as soon as eth1 
is connected to br0. It seems that the bridge sucks all data from eth1, 
effectively disabling vlan23; why is this?

How can I get access to the untagged data on eth1, while simultaneously 
using vlan23@eth1 ?

Or should I use a different approach?

Z.

