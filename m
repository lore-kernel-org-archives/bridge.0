MIME-Version: 1.0
In-Reply-To: <7a0b4b1b5dc484f5e0c2f619d4bfb804@localhost>
References: <7a0b4b1b5dc484f5e0c2f619d4bfb804@localhost>
Date: Sun, 6 Dec 2009 11:17:56 -0600
Message-ID: <2e59e6970912060917j4790f521i6e50b17f92e9daff@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On Sat, Dec 5, 2009 at 10:30 AM, Sander Klein <roedie@roedie.nl> wrote:
> Hi list,
>
> I have a problem with using bonding, with vlans and bridging. I'm trying
> to create the following situation:
>
> Network overview:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +------+
> +--------+ =C2=A0 =C2=A0 |blade |
> | =C2=A0 =C2=A0 =C2=A0 =C2=A0|-----|switch| eth0 +------+
> | =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0|-----=
-| =C2=A0 =C2=A0 =C2=A0|
> | =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 +------+ =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 =C2=A0 =C2=A0|
> | switch | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | host |
> | =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 +------+ =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 =C2=A0 =C2=A0|
> | =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 |blade |------| =C2=A0 =C2=
=A0 =C2=A0|
> | =C2=A0 =C2=A0 =C2=A0 =C2=A0|-----|switch| eth1 +------+
> +--------+ =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0|
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +------+
>
> Situation on the host:
>
> +----+
> |eth0|------+
> +----+ =C2=A0 =C2=A0 =C2=A0|
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 +-----+ =C2=A0 +---------+ =C2=A0 +-----+
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 |bond0|---|bond0.101|---|br101|
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 +-----+ =C2=A0 +---------+ =C2=A0 +-----+
> +----+ =C2=A0 =C2=A0 =C2=A0|
> |eth1|------+
> +----+
>
>
> Now, as soon as the bridge comes up I get the error 'bond0.101: received
> packet with =C2=A0own address as source address'. This happens every time=
 I
> start a new sessioen to a host. Sniffing with tcpdump and wireshark on
> br101 show all arp packets 2 times. I cannot figure out why this is
> happening. When I create this situation without the bridge I do not get
> duplicate traffic, so it's not coming from the network.

I have something very similar.  That message is a warning, not an
error, and over a year of experience suggests that it can be safely
ignored.

(my actual setup is a firewall without enough ports to directly
connect all attached networks -- the switch tags traffic with the
particular port it arrives on and passes it to a trunk port, the linux
box is connected to two such trunk ports in the active-backup bonding
mode, and bridges all the VLANs together forcing the traffic through
iptables/ebtables.  I don't think the warning occurs in this part of
the configuration.  There's also a traffic shaper appliance with a
history of unreliability between the firewall and the main internet
gateway, stp is used to prefer to send traffic through the traffic
shaper, but activate a direct link whenever the shaper fails.  On this
second bridge I encounter the same warning you do, but not for arp
traffic, only stp pdus which are periodically sent to check whether
the shaper appliance is ok.  I guess the issue is that the shaper
appliance passes pdus through unchanged, if it were doing stp
processing then the pdus incoming to the linux box would not have the
linux box's other vlan port as sender and not trigger the warning.)

Are any of your VLANs transparently bridged together elsewhere in the netwo=
rk?

When you see the arp packet twice in wireshark, is it in the same VLAN
both times?

I believe you can also use some of the logging actions in iptables to
list which physical port (of the bonding members) a particular packet
arrived on.


>
> My config is:
>
> auto bond0
> iface bond0 inet manual
> =C2=A0 =C2=A0 =C2=A0 =C2=A0slaves eth0 eth1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bond_primary eth0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bond_mode active-backup
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bond_miimon 100
>
> auto bond0.101
> iface bond0.101 inet manual
>
> auto br0
> iface br0 inet static
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bridge_ports bond0.101
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bridge_stp off
> =C2=A0 =C2=A0 =C2=A0 =C2=A0address 192.168.1.25
> =C2=A0 =C2=A0 =C2=A0 =C2=A0netmask 255.255.255.0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0gateway 192.168.1.1
>
> I've tried this with the stock Debian Lenny kernel (2.6.26) and 2.6.32. A=
m
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
