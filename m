Message-ID: <436BBFC4.2030606@berlin.de>
Date: Fri, 04 Nov 2005 21:08:36 +0100
From: Michael Bueker <m.bueker@berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Bridge Up takes 30s - any remedy?
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi,

In order to be able to use qemu's bridged networking without taking my
network down, I set up my primary network (eth0) to work through a
bridge (br0) right from boot, so that later on the virtual machines can
just connect to the bridge and talk to the outside.

The downside is that it now takes 30s for the network to acquire an IP
from my DHCP server, whereas before, when using only eth0, it took about 3s.

I've collected the messages that bridge prints out in the kernel, and
I'm hoping that you find something I can do about it - maybe specify
some parameters so there's no need for bridge to go trial and error.

Anyways, here's the log (I didn't know if the RPC messages were related,
so I left them in):

> Nov  4 19:29:55 terra kernel: ACPI: PCI Interrupt 0000:02:01.0[A] -> Link=
 [L3CM] -> GSI 11 (level, low) -> IRQ 11
> Nov  4 19:29:56 terra kernel: eth0: Setting promiscuous mode.
> Nov  4 19:29:56 terra kernel: device eth0 entered promiscuous mode
> Nov  4 19:29:56 terra kernel: br0: port 1(eth0) entering learning state
> Nov  4 19:30:03 terra kernel: RPC: sendmsg returned error 101
> Nov  4 19:30:11 terra kernel: br0: topology change detected, propagating
> Nov  4 19:30:11 terra kernel: br0: port 1(eth0) entering forwarding state
> Nov  4 19:30:16 terra kernel: RPC: sendmsg returned error 101
> Fri Nov  4 19:30:24 CET 2005

The last line is from using the command 'dhcpcd br0 && date >>
/var/log/messages', so I knew how long it took (which turned out to be 29s).

Any hints are greatly appreciated.

Cheers,
~Mik

--=20
Pech im Gl=FCck, Spiel in der Liebe.

