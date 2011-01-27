MIME-Version: 1.0
Sender: jarrod.lowe@gmail.com
In-Reply-To: <AANLkTik9i930FMKv4rNajQ2v+ajkdViwFaqrUnw2hD=b@mail.gmail.com>
References: <AANLkTik9i930FMKv4rNajQ2v+ajkdViwFaqrUnw2hD=b@mail.gmail.com>
Date: Thu, 27 Jan 2011 20:32:16 +0000
Message-ID: <AANLkTikQtHi15t9hSck8-p-fhf3QNXfY02PwxQ_4tSNW@mail.gmail.com>
From: J L <lists@rrod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Packet "leakage" between two bridges
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Arun Khan <knura9@gmail.com>
Cc: Linux Bridge <bridge@lists.linux-foundation.org>

Arun,

You have assumed (as I did, when I first tried this) that the first
"-net nic" and "-net tap" are automatically associated with each
other. They aren't - you have to tell KVM explicitly.

I find it easiest to think of it as if there was a (in your example
here) *four* port switch inside the KVM process - with two ports
connected to the host, and two to the guests.

Like a real switch, in order to run two networks through it, you need
to VLAN it.

Add "vlan=3D1" to your first pair of "-net"'s, and "vlan=3D2" to the other.

Hope that helps,
--=20
Jarrod

On 27 January 2011 19:52, Arun Khan <knura9@gmail.com> wrote:
> Host OS/HW: Debian Squeeze (amd64), openSUSE 11.3 (amd64), 6GB RAM,
> Core2Quad 8600
>
> I am trying to create "virtual" networks using bridge, ethernet and
> tap interfaces in my desktop [1]
>
> The network topology that I want to simulate is as follows:
>
> Evaluate LiveCD distros (including GW/Firewall ISOs) using the Linux KVM.
>
> Using brctl and tunctl =C2=A0I have the following setup (brctl show):
>
> bridge name =C2=A0 =C2=A0 bridge id =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 STP enabled =C2=A0 =C2=A0 interfaces
> br0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8000.001cc09b9b54 =C2=A0 =
=C2=A0 =C2=A0 no =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0eth0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tap0
> br1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8000.7e45d3f813b4 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0no =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tap1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tap2
>
> br0 (192.168.1.69) (bridged to eth0) LAN has a DHCP server and it is
> the bridge to the "external" network whereas br1 is supposed to be the
> switch for LAN (isolated).
>
> Through the KVM, the Guest OS is presented two ethernet interfaces
> tap0 for the WAN ethernet port (tap0) and tap1 for the LAN for the
> ethernet port.
>
> The KVM command line for the "GW" VM is:
>
> kvm \
> -vga std \
> -m 256 \
> -boot d \
> -cdrom ${KVM_LIVE_CD} \
> -net nic,model=3Drtl8139,macaddr=3D${nic_mac_addr0} \
> -net tap,ifname=3Dtap0,script=3Dno,downscript=3Dno \
> -net nic,model=3De1000,macaddr=3D${nic_mac_addr1} \
> -net tap,ifname=3Dtap1,script=3Dno,downscript=3Dno \
>
> Variable KVM_LIVE_CD points to the relevant ISO image.
>
> When I boot a LiveCD which acquires IP on *all* =C2=A0the network
> interfaces via DHCP; in the Guest OS, I find that both network
> interfaces have been assigned IP numbers from the 192.168.1.0 network
> from the DHCP server.
>
> For the WAN port, it makes sense as br0 is connected to eth0 and the
> Guest OS acquires an IP address from the DHCP server.
>
> However, I did not expect the "LAN" port, in the Guest OS, to acquire
> and IP number from the same DHCP server. =C2=A0As br1 does not connect to
> any physical interface (like eth0), I expect the second interface eth1
> (tap1 in Host OS) to not have any IP.
>
> From the above, it appears that even though the two bridges are
> defined separately, essentially ethernet frames on either bridge are
> visible to both bridge.
>
> Is it possible to restrict ethernet traffic to it's respective bridge
> only? =C2=A0I am really keen on finding a solution. =C2=A0Any pointers /
> solutions would be highly appreciated.
>
> [1] <http://www.faqs.org/docs/Linux-HOWTO/BRIDGE-STP-HOWTO.html>
>
> TIA,
> -- Arun Khan
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>



--=20
Jarrod Lowe
