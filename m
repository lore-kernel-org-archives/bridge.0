Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=GTBi80gi5F2VR9w+Zvm88ajdUyEx65vrFR0sYry4q8Q=;
 b=DtWVh5TmAD2IT9LuOpp7i7G53MFrdT92xBuY5mMbt3RrOlvCcWCZuj2bxAaIydwyfV
 KM4UjxR5p00Bkd1i0Y1ChCNJFcG4AH/oOltDhjm1ZVz6QaQjSYBPCKjLncrA30awENzP
 Psu2nV3mlSV+WVhLJi3h5F0VYTaKlh5bcd+V5HJcnxAEzZZq7kz0zovaQd3RC5tjPd5n
 JPi15XAepCOhiCvNqK1Vsc1A76ggIT/UuIo7A88Cdo8GBZ4aColC7gGWBPahQQq3q6WM
 ZkTQ4QZX3OnfZ6N96c95BEj0P0s+HKdNs1HEAxcyXVtLJkg7grYPzcDHvZvtnHWPNpqK
 O7fQ==
Date: Fri, 24 Jul 2020 01:11:51 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20200723221151.qdt4yowfktuddrkd@skbuf>
References: <20200722225253.28848-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722225253.28848-1-f.fainelli@gmail.com>
Subject: Re: [Bridge] [PATCH net-next] Documentation: networking: Clarify
 switchdev devices behavior
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: andrew@lunn.ch, rdunlap@infradead.org, ivan.khoronzhuk@linaro.org, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, vivien.didelot@gmail.com, idosch@mellanox.com, jiri@mellanox.com, ilias.apalodimas@linaro.org, kuba@kernel.org, davem@davemloft.net

On Wed, Jul 22, 2020 at 03:52:53PM -0700, Florian Fainelli wrote:
> This patch provides details on the expected behavior of switchdev
> enabled network devices when operating in a "stand alone" mode, as well
> as when being bridge members. This clarifies a number of things that
> recently came up during a bug fixing session on the b53 DSA switch
> driver.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Since this has been submitted in a while, removing the patch numbering,
> but previous patches and discussions can be found here:
> 
> http://patchwork.ozlabs.org/project/netdev/patch/20190103224702.21541-1-f.fainelli@gmail.com/
> http://patchwork.ozlabs.org/project/netdev/patch/20190109043930.8534-1-f.fainelli@gmail.com/
> http://patchwork.ozlabs.org/project/netdev/patch/20190110193206.9872-1-f.fainelli@gmail.com/
> 
> David, I would like to hear from Vladimir and Ido specifically to make
> sure that the documentation is up to date with expectations or desired
> behavior so we can move forward with Vladimir's DSA rx filtering patch
> series. So don't apply this just yet ;)
> 
> Thanks!
> 

Thanks for giving me the opportunity to speak up.

Your addition to switchdev.rst is more than welcome, and the content is
good. I had opened this file a few days ago searching for a few words on
address filtering, but alas, there were none. And even now, with your
addition - there is something, but it's more focused on multicast, and I
haven't used that nearly enough to have a strong opinion about it. Let
me try to add my 2 cents about what concerns me on this particular topic.

I'm not asking you to add it to your documentation patch - not that you
could even do that, as I'm talking more about how things should be than
how they are, things like IVDF aren't even in mainline.

If people agree at least in principle with my words below, I can make
the necessary changes to the bridge driver to conform to this
interpretation of things.


Address filtering
^^^^^^^^^^^^^^^^^

With regular network interface cards, address filters are used to drop
in hardware the frames that have a destination address different than
what the card is configured to perform termination on.

With switchdev, the hardware is usually geared towards accepting traffic
regardless of destination MAC address, because the primary objective is
forwarding to another host based on that address, and not termination.

Therefore, the address filters of a switchdev interface cannot typically
be implemented at the same hardware layer as they are for a regular
interface. The behavior as seen by the operating system should, however,
be the same.

In the case of a regular NIC, the expectation is that only the frames
having a destination that is present in the RX filtering lists (managed
through dev_uc_add() and dev_mc_add()) are accepted, while the others
are dropped. The filters can be bypassed using the IFF_PROMISC and
IFF_ALLMULTI flags.

A switchdev interface that is capable of offloading the Linux bridge
should have hardware provisioning for flooding unknown destination
addresses and learning from source addresses. Strictly speaking, the
hardware design of such an interface should be promiscuous out of
necessity: as long as flooding is enabled, hardware promiscuity is
implied.

However, this is of no relevance to the operating system. Since flooding
and forwarding happen autonomously, it makes no difference to the end
result whether the forwarded and flooded addresses are, or aren't,
present in the address list of the network interface corresponding to
the switchdev port.

To achieve a similar behavior between switchdev and non-switchdev
interfaces, address filtering for switchdev can be defined in terms of
the frames that the CPU sees.

- Primary MAC address: A driver should deliver to the CPU, and only to
  the CPU, for termination purposes, frames having a destination address
  that matches the MAC address of the ingress interface.

- Secondary MAC addresses: A driver should deliver to the CPU frames
  having a destination address that matches an entry added with
  dev_uc_add() or dev_mc_add(). These typically correspond to upper
  interfaces configured on top of the switchdev interface, such as
  8021q, bridge, macvlan.

- A driver is allowed to not deliver to the CPU frames that don't have a
  match in the ingress interface's primary and secondary address lists.
  An exception to this rule is when the interface is configured as
  promiscuous, or to receive all multicast traffic.

- An interface can be configured as promiscuous when it is required that
  the CPU sees frames with an unknown destination (same as in the
  non-switchdev case). Otherwise said, promiscuous mode manages the
  presence (or the absence) of the CPU in the flooding domain of the
  switch. A similar comment applies to IFF_ALLMULTI, although that case
  applies only to unknown multicast traffic.

- Other layers of the network stack that actively make use of switchdev
  offloads should not request promiscuous mode for the sole purpose of
  accepting ingress frames that will end up reinjected in the hardware
  data path anyway. The switchdev framework can be considered to offload
  the need of promiscuity for this purpose. An example of valid use of
  promiscuous mode for a switchdev driver is when it is bridged with a
  non-switchdev interface, and the CPU needs to perform termination
  (from the hardware's perspective) of unknown-destination traffic, in
  order to forward it in software to the other network interfaces.

- If the hardware supports filtering MAC addresses per VLAN domain, then
  CPU membership of a VLAN could be managed through IVDF (Individual
  Virtual Device Filtering). Namely, the CPU should join the VLAN of all
  IVDF addresses in its filter list, and can exit all VLANs that are not
  there.

>  Documentation/networking/switchdev.rst | 118 +++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
> 
> diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
> index ddc3f35775dc..2e4f50e6c63c 100644
> --- a/Documentation/networking/switchdev.rst
> +++ b/Documentation/networking/switchdev.rst
> @@ -385,3 +385,121 @@ The driver can monitor for updates to arp_tbl using the netevent notifier
>  NETEVENT_NEIGH_UPDATE.  The device can be programmed with resolved nexthops
>  for the routes as arp_tbl updates.  The driver implements ndo_neigh_destroy
>  to know when arp_tbl neighbor entries are purged from the port.
> +
> +Device driver expected behavior
> +-------------------------------
> +
> +Below is a set of defined behavior that switchdev enabled network devices must
> +adhere to.
> +
> +Configuration less state
> +^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Upon driver bring up, the network devices must be fully operational, and the
> +backing driver must configure the network device such that it is possible to
> +send and receive traffic to this network device and it is properly separated
> +from other network devices/ports (e.g.: as is frequent with a switch ASIC). How
> +this is achieved is heavily hardware dependent, but a simple solution can be to
> +use per-port VLAN identifiers unless a better mechanism is available
> +(proprietary metadata for each network port for instance).
> +
> +The network device must be capable of running a full IP protocol stack
> +including multicast, DHCP, IPv4/6, etc. If necessary, it should program the
> +appropriate filters for VLAN, multicast, unicast etc. The underlying device
> +driver must effectively be configured in a similar fashion to what it would do
> +when IGMP snooping is enabled for IP multicast over these switchdev network
> +devices and unsolicited multicast must be filtered as early as possible into
> +the hardware.
> +
> +When configuring VLANs on top of the network device, all VLANs must be working,
> +irrespective of the state of other network devices (e.g.: other ports being part
> +of a VLAN aware bridge doing ingress VID checking). See below for details.
> +
> +If the device implements e.g.: VLAN filtering, putting the interface in
> +promiscuous mode should allow the reception of all VLAN tags (including those
> +not present in the filter(s)).
> +
> +Bridged switch ports
> +^^^^^^^^^^^^^^^^^^^^
> +
> +When a switchdev enabled network device is added as a bridge member, it should
> +not disrupt any functionality of non-bridged network devices and they
> +should continue to behave as normal network devices. Depending on the bridge
> +configuration knobs below, the expected behavior is documented.
> +
> +Bridge VLAN filtering
> +^^^^^^^^^^^^^^^^^^^^^
> +
> +The Linux bridge allows the configuration of a VLAN filtering mode (compile and
> +run time) which must be observed by the underlying switchdev network

s/compile and run time/statically, at interface creation time, and dynamically/

> +device/hardware:
> +
> +- with VLAN filtering turned off: the bridge is strictly VLAN unaware and its
> +  data path will only process untagged Ethernet frames. Frames ingressing the
> +  device with a VID that is not programmed into the bridge/switch's VLAN table
> +  must be forwarded and may be processed using a VLAN device (see below).
> +
> +- with VLAN filtering turned on: the bridge is VLAN aware and frames ingressing
> +  the device with a VID that is not programmed into the bridges/switch's VLAN
> +  table must be dropped (strict VID checking).
> +
> +Non-bridged network ports of the same switch fabric must not be disturbed in any
> +way by the enabling of VLAN filtering on the bridge device(s).
> +
> +VLAN devices configured on top of a switchdev network device (e.g: sw0p1.100)
> +which is a bridge port member must also observe the following behavior:
> +
> +- with VLAN filtering turned off, enslaving VLAN devices into the bridge might
> +  be allowed provided that there is sufficient separation using e.g.: a
> +  reserved VLAN ID (4095 for instance) for untagged traffic. The VLAN data path
> +  is used to pop/push the VLAN tag such that the bridge's data path only
> +  processes untagged traffic.
> +

Why does the bridge's data path only process untagged traffic?
It should process frames that are untagged or have a VLAN ID which does
not match the VLAN ID of any 8021q upper of the ingress interface.
Which brings me to the question: how is a VLAN frame having an unknown
(to 8021q) VLAN ID going to be treated by such a switchdev interface? It
should accept it. Will it? Well, I don't really understand the advice
given here, about the separation, and how does the pvid of 4095 help
with frames that are already VLAN-tagged.

> +- with VLAN filtering turned on, these VLAN devices can be created as long as
> +  there is not an existing VLAN entry into the bridge with an identical VID and
> +  port membership. These VLAN devices cannot be enslaved into the bridge since
> +  because they duplicate functionality/use case with the bridge's VLAN data path
> +  processing.
> +

The way I visualize things for myself, it's not so much that the bridge
and 8021q modules are duplicating functionality, but rather that the
requirements are contradictory. 'bridge vlan add ...' wants to configure
the forwarding data path, while 'ip link add link ... type vlan' wants
to steal frames from the data path and deliver them to the CPU.

> +Because VLAN filtering can be turned on/off at runtime, the switchdev driver
> +must be able to re-configure the underlying hardware on the fly to honor the
> +toggling of that option and behave appropriately.
> +
> +A switchdev driver can also refuse to support dynamic toggling of the VLAN
> +filtering knob at runtime and require a destruction of the bridge device(s) and
> +creation of new bridge device(s) with a different VLAN filtering value to
> +ensure VLAN awareness is pushed down to the HW.
> +
> +Finally, even when VLAN filtering in the bridge is turned off, the underlying
> +switch hardware and driver may still configured itself in a VLAN aware mode
> +provided that the behavior described above is observed.
> +

Otherwise stated: VLAN filtering shall be considered from the
perspective of observable behavior, and not from the perspective of
hardware configuration.

> +Bridge IGMP snooping
> +^^^^^^^^^^^^^^^^^^^^
> +
> +The Linux bridge allows the configuration of IGMP snooping (compile and run
> +time) which must be observed by the underlying switchdev network device/hardware

Same comment about "compile and run time" as above.

> +in the following way:
> +
> +- when IGMP snooping is turned off, multicast traffic must be flooded to all
> +  switch ports within the same broadcast domain. The CPU/management port

I think that if mc_disabled == true, multicast should be flooded only to
the ports which have mc_flood == true.

> +  should ideally not be flooded and continue to learn multicast traffic through

unless the ingress interface has IFF_ALLMULTI or IFF_PROMISC, then I
suppose the CPU should be flooded from that particular port.

> +  the network stack notifications. If the hardware is not capable of doing that
> +  then the CPU/management port must also be flooded and multicast filtering
> +  happens in software.
> +
> +- when IGMP snooping is turned on, multicast traffic must selectively flow
> +  to the appropriate network ports (including CPU/management port) and not be
> +  unnecessarily flooding.
> +

I believe that when mc_disabled == false, unknown multicast should be
flooded only to the ports connected to a multicast router. The local
device may also act as a multicast router.

> +The switch must adhere to RFC 4541 and flood multicast traffic accordingly
> +since that is what the Linux bridge implementation does.
> +

I have a lot of questions in this area.
Mainly, what should a driver do if the hardware can't parse IGMP/MLD but
just route by (maskable) layer 2 destination address?

> +Because IGMP snooping can be turned on/off at runtime, the switchdev driver
> +must be able to re-configure the underlying hardware on the fly to honor the
> +toggling of that option and behave appropriately.
> +
> +A switchdev driver can also refuse to support dynamic toggling of the multicast
> +snooping knob at runtime and require the destruction of the bridge device(s)
> +and creation of a new bridge device(s) with a different multicast snooping
> +value.
> -- 
> 2.17.1
> 

Thanks,
-Vladimir
