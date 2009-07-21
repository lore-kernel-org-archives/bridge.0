Message-ID: <4A6638A5.208@ipfire.org>
Date: Tue, 21 Jul 2009 23:52:37 +0200
From: Michael Tremer <michael.tremer@ipfire.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Bridging untagged and tagged VLANs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello everybody,
I got a weird problem but don't know if it is expected to work.

brctl addbr br0
vconfig add eth0 30
brctl addif br0 eth0.30

Until here, everythink works well... I can access the VLAN with id 30.
But when I run the following:

brctl addif br0 eth0

Then, I can't access the VLAN any more but the untagged LAN.
But instead of adding eth0:

vconfig add eth0 40
brctl addif br0 eth0.40

It works.

It would be nice if you can me give a short advice...
Is it not possible to bridge an untagged LAN with a tagged VLAN or
is this a bug?

Sincerely,

Michael

Kernel 2.6.29, brctl 1.4

