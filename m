From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 8 Aug 2009 11:44:39 +0200
References: <D2E118A1E7268F449C469EA2F301D92902BC39B2@exil.voltaire.com>
	<0199E0D51A61344794750DC57738F58E6D6A6CD803__29862.6656564467$1249679159$gmane$org@GVW1118EXC.americas.hpqcorp.net>
	<m3d476hepp.fsf@ursa.amorsen.dk>
In-Reply-To: <m3d476hepp.fsf@ursa.amorsen.dk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200908081144.39501.arnd@arndb.de>
Subject: Re: [Bridge] [evb] RE: [PATCH][RFC] net/bridge: add basic VEPA
	support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Benny Amorsen <benny+usenet@amorsen.dk>
Cc: "Fischer, Anna" <anna.fischer@hp.com>, Yaron Haviv <yaronh@voltaire.com>, bridge@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, adobriyan@gmail.com, "Paul Congdon (UC Davis)" <ptcongdon@ucdavis.edu>, netdev@vger.kernel.org, evb@yahoogroups.com, davem@davemloft.net

On Saturday 08 August 2009, Benny Amorsen wrote:
> Would a SRIOV NIC with VEPA support show up as multiple devices? I.e.
> would I get e.g. eth0-eth7 for a NIC with support for 8 virtual
> interfaces? Would they have different MAC addresses?

It could, but the idea of SR-IOV is that it shows up as 8 PCI
devices. One of them is owned by the host and is seen as eth0
there. The other seven PCI devices (virtual functions) are meant
to be assigned to the guest using PCI passthrough and will show
up as the guests eth0, each one with its own MAC address.

An other mode of operation is VMDq, where the host owns all
interfaces and you might see eth0-eth7 there. You can then attach
a qemu process with a raw packet socket or a single macvtap port
for each of those interfaces. This is not yet implemented in Linux,
so how it will be done is still open. It might all be integrated
into macvlan or some new subsystem alternatively.

AFAIK, every SR-IOV adapter can also be operated as a VMDq adapter,
but there are VMDq adapters that do not support SR-IOV.

	Arnd <><

