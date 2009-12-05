Message-ID: <4B1AA541.2030500@free.fr>
Date: Sat, 05 Dec 2009 19:24:01 +0100
From: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <7a0b4b1b5dc484f5e0c2f619d4bfb804@localhost>
In-Reply-To: <7a0b4b1b5dc484f5e0c2f619d4bfb804@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge - vlan - bond
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Sander Klein <roedie@roedie.nl>
Cc: Bridge <bridge@lists.linux-foundation.org>

Sander Klein wrote :
> Hi list,
> 
> I have a problem with using bonding, with vlans and bridging. I'm trying
> to create the following situation:

Can you please also describe what you try to achieve, and not only your setup ?

What are the expected effects ?

Your bonding setup (active-backup) will lead to one port enabled and one disabled.

Why don't you simply use eth0.101 and eth1.101 as two ports of br101, and enable stp ?

Enabling stp would achieve the same result : one port in forwarding state and one in the blocked state.

	Nicolas.

> Network overview:
> 
>                +------+
> +--------+     |blade |
> |        |-----|switch| eth0 +------+
> |        |     |      |------|      |
> |        |     +------+      |      |
> | switch |                   | host |
> |        |     +------+      |      |
> |        |     |blade |------|      |
> |        |-----|switch| eth1 +------+
> +--------+     |      |
>                +------+
> 
> Situation on the host:
> 
> +----+
> |eth0|------+
> +----+      |
>          +-----+   +---------+   +-----+
>          |bond0|---|bond0.101|---|br101|
>          +-----+   +---------+   +-----+
> +----+      |
> |eth1|------+
> +----+
> 
> 
> Now, as soon as the bridge comes up I get the error 'bond0.101: received
> packet with  own address as source address'. This happens every time I
> start a new sessioen to a host. Sniffing with tcpdump and wireshark on
> br101 show all arp packets 2 times. I cannot figure out why this is
> happening. When I create this situation without the bridge I do not get
> duplicate traffic, so it's not coming from the network.
> 
> My config is:
> 
> auto bond0
> iface bond0 inet manual
>         slaves eth0 eth1
>         bond_primary eth0
>         bond_mode active-backup
>         bond_miimon 100
> 
> auto bond0.101
> iface bond0.101 inet manual
> 
> auto br0
> iface br0 inet static
>         bridge_ports bond0.101
>         bridge_stp off
>         address 192.168.1.25
>         netmask 255.255.255.0
>         gateway 192.168.1.1
> 
> I've tried this with the stock Debian Lenny kernel (2.6.26) and 2.6.32. Am
> I doing something wrong here?
> 
> Greets,
> 
> Sander Klein
> 
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
> 

