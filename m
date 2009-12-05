Message-ID: <4B1A911B.5000808@dd-wrt.com>
Date: Sat, 05 Dec 2009 17:58:03 +0100
From: "Sebastian Gottschall (DD-WRT)" <s.gottschall@dd-wrt.com>
MIME-Version: 1.0
References: <7a0b4b1b5dc484f5e0c2f619d4bfb804@localhost>
In-Reply-To: <7a0b4b1b5dc484f5e0c2f619d4bfb804@localhost>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
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

Sander Klein schrieb:
> Hi list,
>
> I have a problem with using bonding, with vlans and bridging. I'm trying
> to create the following situation:
>
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
>  =20
i dont think that you can do with bonding what you want, because you=20
just connected them to a switch
you can only bond interface together which are bonded on the opposite=20
site too

so your local eth0 and eth1 is bonded and the remote site input must be=20
bonded too. a switch cannot bond, a switch only switches, so it outputs=20
the same packets on all ethernet connectors
so

remote:                                        local
bond0 --- eth0   ------------- eth0 --- bond0
       |  ---- eth1  ------------- eth1 --- |


i hope you understand what i mean. so bond0 is the local usable=20
interface on each site which splits the traffic on 2 ethernet interfaces=20
depending on your bonding algorithm. a switch only duplicates packets



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
>  =20


--=20
Mit freundlichen Gr=FCssen / Regards

Sebastian Gottschall / CTO=20

NewMedia-NET GmbH - DD-WRT=20
Firmensitz:  Wormser Stra=DFe 5 - 7, 64625 Bensheim
Registergericht: Amtsgericht Darmstadt, HRB 25473
Gesch=E4ftsf=FChrer: Peter Steinh=E4user, Christian Scheele
http://www.dd-wrt.com
email: s.gottschall@dd-wrt.com
Tel.: +496251-582650 / Fax: +496251-5826565=20


