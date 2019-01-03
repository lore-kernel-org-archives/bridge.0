Return-Path: <rdunlap@infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209;
	h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kfRZFnoXmHrbp8JngvdZc+LIcpyFE/0aaMKXtO0m14k=;
	b=P3SQsMZwVgIA3Bo1QrALv/NQmk
	6no9zsGmStTdYvgdXA1E2+aevDwPBnJCKkD5kCibLDDT5gLSxSSYeB4ZFV70g8BAvm/K5tt6KpbnE
	i7EHtuWdWNHl8ZBVq2sbMsqAfAvbNQY3ZYGsUFgNvMgbyNT9TIn8E0N7wTRKU/mtfe6toCPT9pYfl
	d7egusMLZpiufUEu1kEJ/3Xa//nL82yJF1KY3JF8D8/fet6VsRXhvb9Is9p/zQv76PDcN6Cl/l02C
	j8KAJ+A3mNMND1YdUollp3ATBS5TwGJJvTMZ3cMOZwYy1ntbvNhIAVHqndaZGlIjJ9kEVOf3TFmTQ
	FwveUJ4g==;
References: <20190103224702.21541-1-f.fainelli@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7ad992a7-1265-ed86-7679-9e750cac156d@infradead.org>
Date: Thu, 3 Jan 2019 15:26:03 -0800
MIME-Version: 1.0
In-Reply-To: <20190103224702.21541-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2] Documentation: networking: Clarify
 switchdev devices behavior
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Cc: andrew@lunn.ch, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, vivien.didelot@gmail.com, idosch@mellanox.com, jiri@mellanox.com, davem@davemloft.net

Hi,

Comments below.


On 1/3/19 2:47 PM, Florian Fainelli wrote:
> This patch provides details on the expected behavior of switchdev
> enabled network devices when operating in a "stand alone" mode, as well
> as when being bridge members. This clarifies a number of things that
> recently came up during a bug fixing session on the b53 DSA switch
> driver.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Changes in v2:
> 
> - clarified a few parts about VLAN devices wrt. VLAN filtering and their
>   behavior during enslaving.
> 
> Ido, hopefully this captures correctly what we just talked about this
> morning. Thanks!
> 
>  Documentation/networking/switchdev.txt | 95 ++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 
> diff --git a/Documentation/networking/switchdev.txt b/Documentation/networking/switchdev.txt
> index 82236a17b5e6..c0218746a783 100644
> --- a/Documentation/networking/switchdev.txt
> +++ b/Documentation/networking/switchdev.txt
> @@ -392,3 +392,98 @@ switchdev_trans_item_dequeue()
>  
>  If a transaction is aborted during "prepare" phase, switchdev code will handle
>  cleanup of the queued-up objects.
> +
> +Switchdev enabled network device expected behavior
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Below is a set of defined behavior that switchdev enabled network device must be

                                                                     devices must

> +adhering to.

   adhere to.

> +
> +Configuration less state
> +------------------------
> +
> +Upon driver bring up, the network devices must be fully operational, and the
> +backing driver must be configuring the network device such that it is possible

                  must configure the

> +to send and receive to this network device such that it is properly separate
> +from other network devices/ports (e.g: as is frequently with a switch ASIC).

                                    (e.g.:

> +How this is achieved is heavily hardware dependent, but a simple solution can
> +be to use per-port VLAN identifiers unless a better mechanism is available
> +(proprietary metadata for each network ports for instance).

                                          port

> +
> +The network device must be capable of running a full IP protocol stack must be
> +working, including multicast, DHCP, IPv4/6, etc. If necessary, it should be

garbled?  too many verb phrases.

> +programming the appropriate filters for VLAN, multicast, unicast etc. The
> +underlying device driver must effectively be configured in a similar fashion to
> +what it would do when IGMP snooping is enabled for IP multicast over these
> +switchdev network devices and unsollicited multicast must be filtered as early

                                 unsolicited

> +as possible into the hardware.
> +
> +When configuring VLANs on top of the network device, all VLANs must be working,
> +irrespective of the state of other network devices (e.g: other ports being part

                                                      (e.g.:

> +of a VLAN aware bridge doing ingress VID checking). See below for details.
> +
> +Bridged network devices
> +-----------------------
> +
> +When a switchdev enabled network device is added as a bridge member, it should
> +not be disrupting any functionality of non-bridged network devices and they

   not disrupt any

> +should continue to behave as normal network devices. Depending on the bridge
> +configuration knobs below, the expected behavior is documented.
> +
> +VLAN filtering
> +~~~~~~~~~~~~~~
> +
> +The Linux bridge allows the configuration of a VLAN filtering mode (compile and
> +run time) which must be observed by the underlying switchdev network
> +device/hardware:
> +
> +- with VLAN filtering turned off: frames ingressing the device with a VID that
> +  is not programmed into the bridge/switch's VLAN table must be forwarded.
> +
> +- with VLAN filtering turned on: frames ingressing the device with a VID that is
> +  not programmed into the bridges/switch's VLAN table must be dropped.
> +
> +Non-bridged network ports of the same switch fabric must not be disturbed in any
> +way, shape or form by the enabling of VLAN filtering.
> +
> +VLAN devices configured on top of a switchdev network device (e.g: sw0p1.100)
> +which is a bridge port member must also observe the following behavior:
> +
> +- with VLAN filtering turned off, these VLAN devices must be fully functional
> +  since the hardware is allowed VID frames. Enslaving VLAN devices into the
> +  bridge might be allowed provided that there is sufficient separatation using

                                                               separation

> +  e.g: a reserved VLAN ID (4095 for instance) for untagged traffic.

     e.g.:

> +
> +- with VLAN filtering turned on, these VLAN devices should not be allowed to
> +  be created because they duplicate functionality/use case with the bridge's
> +  VLAN functionality.
> +
> +Because VLAN filtering can be turned on/off at runtime, the switchdev driver
> +must be able to re-configure the underlying hardware on the fly to honor the
> +toggling of that option and behave appropriately.
> +
> +A switchdev driver can also refuse to support dynamic toggling of the VLAN
> +filtering knob at runtime and require a destruction of the bridge device(s) and
> +a creation of new bridge device(s) with a different VLAN filtering value to
> +ensure VLAN awareness is pushed down to the HW.
> +
> +IGMP snooping
> +~~~~~~~~~~~~~
> +
> +The Linux bridge allows the configuration of IGMP snooping (compile and run
> +time) which must be observed by the underlying switchdev network device/hardware
> +in the following way:
> +
> +- when IGMP snooping is turned off, multicast traffic must be flooded to all
> +  switch ports within the same broadcast domain, including the CPU/management
> +  port of the switch (if handled separately).
> +
> +- when IGMP snooping is turned on, multicast traffic must be selectively flowing

                                                        must selectively flow

> +  to the appropriate network ports and not flood the entire switch, that must
> +  include the CPU/management port.
> +
> +Because IGMP snooping can be turned on/off at runtime, the switchdev driver must
> +be able to re-configure the underlying hardware on the fly to honor the toggling
> +of that option and behave appropriately.
> +
> +Similarly to VLAN filtering, if dynamic toggling of the IGMP snooping
> 

missing something here??

thanks.
-- 
~Randy
