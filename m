Return-Path: <rdunlap@infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209;
	h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mFtbL99fqYz2LCA2IbbP0ptUdqM8oazCqwweeIB+16w=;
	b=YAdKSrS7Rk4lH/4cQxKzXFhzcB
	S4+s508DWpBMNmAgsoEyUtl8jxziVfgQzFa5kKqftflACq3bxVOR8Bv7OKHLVqQYJ6xFc6/DEmsgu
	xIbqX6H+lfpttrJJQl0VTxjFtinc2ea0y8Z/jzTMxgLtIl1xamAgmXyUf0RMU7X/hhlFxB7mt7FwS
	CTcmuLcPyDiUUw1Yr/kp5lUkcsP+9JEO8EtknHZaEMG1qRcDd6qMVthXvLxZOts8d3PLFEZ3isnla
	+2zLdBdB803sq1j07hiIFdtWkIWPihZw+88c7GZntkWQ0D9xwxUmY0m4iLJ9voNblnBH/1Ql35fKw
	S/0xthcQ==;
References: <20190110193206.9872-1-f.fainelli@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d507460d-fbb4-90f1-0709-dd3ba6836d0e@infradead.org>
Date: Thu, 10 Jan 2019 13:50:23 -0800
MIME-Version: 1.0
In-Reply-To: <20190110193206.9872-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4] Documentation: networking: Clarify
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
Cc: andrew@lunn.ch, ilias.apalodimas@linaro.org, ivan.khoronzhuk@linaro.org, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, vivien.didelot@gmail.com, idosch@mellanox.com, jiri@mellanox.com, davem@davemloft.net

On 1/10/19 11:32 AM, Florian Fainelli wrote:
> This patch provides details on the expected behavior of switchdev
> enabled network devices when operating in a "stand alone" mode, as well
> as when being bridge members. This clarifies a number of things that
> recently came up during a bug fixing session on the b53 DSA switch
> driver.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> Changes in v4:
> 
> - more spelling/grammar/sentence fixes (Randy)
> 
> Changes in v3:
> 
> - spell checks, past vs. present use (Randy)
> - clarified some behaviors a bit more regarding multicast flooding
> - added some missing sentence about multicast snopping knob being
>   dynamically turned on/off
> 
> Changes in v2:
> 
> - clarified a few parts about VLAN devices wrt. VLAN filtering and their
>   behavior during enslaving.
> 
>  Documentation/networking/switchdev.txt | 105 +++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
> 
> diff --git a/Documentation/networking/switchdev.txt b/Documentation/networking/switchdev.txt
> index 82236a17b5e6..dd58c957c557 100644
> --- a/Documentation/networking/switchdev.txt
> +++ b/Documentation/networking/switchdev.txt
> @@ -392,3 +392,108 @@ switchdev_trans_item_dequeue()
>  
>  If a transaction is aborted during "prepare" phase, switchdev code will handle
>  cleanup of the queued-up objects.
> +
> +Switchdev enabled network device expected behavior
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Below is a set of defined behavior that switchdev enabled network devices must
> +adhere to.
> +
> +Configuration less state
> +------------------------
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
> +including multicast, DHCP, IPv4/6, etc. If necessary, it should be program the
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
> +Bridged network devices
> +-----------------------
> +
> +When a switchdev enabled network device is added as a bridge member, it should
> +not disrupt any functionality of non-bridged network devices and they
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
> +  bridge might be allowed provided that there is sufficient separation using
> +  e.g.: a reserved VLAN ID (4095 for instance) for untagged traffic.
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
> +creation of new bridge device(s) with a different VLAN filtering value to
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
> +  switch ports within the same broadcast domain. The CPU/management port
> +  should ideally not be flooded and continue to learn multicast traffic through
> +  the network stack notifications. If the hardware is not capable of doing that
> +  then the CPU/management port must also be flooded and multicast filtering
> +  happens in software.
> +
> +- when IGMP snooping is turned on, multicast traffic must selectively flow
> +  to the appropriate network ports (including CPU/management port) and not flood
> +  the switch.
> +
> +Note: reserved multicast addresses (e.g.: BPDUs) as well as Local Network
> +Control block (224.0.0.0 - 224.0.0.255) do not require IGMP and should always
> +be flooded.
> +
> +Because IGMP snooping can be turned on/off at runtime, the switchdev driver must
> +be able to re-configure the underlying hardware on the fly to honor the toggling
> +of that option and behave appropriately.
> +
> +A switchdev driver can also refuse to support dynamic toggling of the multicast
> +snooping knob at runtime and require the destruction of the bridge device(s)
> +and creation of a new bridge device(s) with a different multicast snooping
> +value.
> 


-- 
~Randy
