MIME-Version: 1.0
Date: Sat, 05 Dec 2009 20:47:19 +0100
From: Sander Klein <roedie@roedie.nl>
In-Reply-To: <4B1AA541.2030500@free.fr>
References: <7a0b4b1b5dc484f5e0c2f619d4bfb804@localhost>
	<4B1AA541.2030500@free.fr>
Message-ID: <b1701dff411230cfdd4137a1275ec32a@localhost>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] Bridge - vlan - bond
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Nicolas_de_Peslo=C3=BCan?= <nicolas.2p.debian@free.fr>
Cc: Bridge <bridge@lists.linux-foundation.org>

Hi,

> Can you please also describe what you try to achieve, and not only your
> setup ?
> 
> What are the expected effects ?

Sorry, I will. What I am trying to achieve is high availability. The host
I'm building this on will be a kvm host with virtual machines which runs
the images from a nfsmount. I need to have multiple vlans on this host
which are then bridged to the virtual machines. What I want is that if the
switch connected to eth0 fails, all traffic will go through eth1. The final
setup will be the following:

+------+   +------+
| core |---|blade |   +-----+
|switch|   |switch|---|eth0 |
+------+   +------+   |     |
   |                  |Host |
+------+   +------+   |     |
| core |---|blade |---|eth1 |
|switch|   |switch|   +-----+
+------+   +------+

> Your bonding setup (active-backup) will lead to one port enabled and one
> disabled.

That's okay with me. I don't need the speed, only the redundancy. I could
use alb or tlb but since I'm testing right now active-backup it easier.

> Why don't you simply use eth0.101 and eth1.101 as two ports of br101,
and
> enable stp ?

Since the switches that connect to eth0 and eth1 have a crappy stp
implementation (its a supermicro blade chassis) it's pain to get it
working. Moreover, converging with stp is a bit slow. Bonding will do this
in 100ms or faster while stp might take 30 seconds or so.

The setup works perfectly as long as I don't use bridging. But I need the
bridging to get the network to the virtual machines.

Greets,

Sander Klein

