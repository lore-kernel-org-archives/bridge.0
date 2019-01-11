Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=q1QuEaVKF5GMGGrwKw16MpuvvvBgNlOksJj7hLtPuU8=;
	b=R5Mp/T2tKZSpUxnolMS+G9ASdUooEjbdzEVKPNj5yXP4xpQBnHC0rOrg+8PEBAYTDl
	u6Xqk86SNNtJvHff6ZHC+iFgBJQ0UcrHzQp39dRWF0pEC8Nx2jAJfvAL7RbMTdXJOuuS
	oQCL6pnEJyUiQFM/nndDNX76JvcLc3VGz2jm43Na7aqAQbLYkffzEKI21zDJbaGBrYNc
	h/NjSlXitzlIzM9KwkUryq0/Y6OdaEDDrSGI1CClFx9wUfewBdgaS6LadybsKjBOOGIm
	CGthmwD3UUuyDy21bJ6X1XopgoQMxIiZwPqDMYIU4hdayShXtOzBm5uNUCrKGPfzi0vE
	VQqA==
References: <20190110193206.9872-1-f.fainelli@gmail.com>
	<20190111150637.GA897@splinter.mtl.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <232e03c9-e2c8-9ad1-0a60-183dcbac72a5@gmail.com>
Date: Fri, 11 Jan 2019 10:34:01 -0800
MIME-Version: 1.0
In-Reply-To: <20190111150637.GA897@splinter.mtl.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Ido Schimmel <idosch@mellanox.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "ivan.khoronzhuk@linaro.org" <ivan.khoronzhuk@linaro.org>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, Jiri Pirko <jiri@mellanox.com>, "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, "davem@davemloft.net" <davem@davemloft.net>

On 1/11/19 7:06 AM, Ido Schimmel wrote:
> On Thu, Jan 10, 2019 at 11:32:06AM -0800, Florian Fainelli wrote:
>> This patch provides details on the expected behavior of switchdev
>> enabled network devices when operating in a "stand alone" mode, as well
>> as when being bridge members. This clarifies a number of things that
>> recently came up during a bug fixing session on the b53 DSA switch
>> driver.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>> Changes in v4:
>>
>> - more spelling/grammar/sentence fixes (Randy)
>>
>> Changes in v3:
>>
>> - spell checks, past vs. present use (Randy)
>> - clarified some behaviors a bit more regarding multicast flooding
>> - added some missing sentence about multicast snopping knob being
>>   dynamically turned on/off
>>
>> Changes in v2:
>>
>> - clarified a few parts about VLAN devices wrt. VLAN filtering and their
>>   behavior during enslaving.
>>
>>  Documentation/networking/switchdev.txt | 105 +++++++++++++++++++++++++
>>  1 file changed, 105 insertions(+)
>>
>> diff --git a/Documentation/networking/switchdev.txt b/Documentation/networking/switchdev.txt
>> index 82236a17b5e6..dd58c957c557 100644
>> --- a/Documentation/networking/switchdev.txt
>> +++ b/Documentation/networking/switchdev.txt
>> @@ -392,3 +392,108 @@ switchdev_trans_item_dequeue()
>>  
>>  If a transaction is aborted during "prepare" phase, switchdev code will handle
>>  cleanup of the queued-up objects.
>> +
>> +Switchdev enabled network device expected behavior
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +Below is a set of defined behavior that switchdev enabled network devices must
>> +adhere to.
>> +
>> +Configuration less state
>> +------------------------
>> +
>> +Upon driver bring up, the network devices must be fully operational, and the
>> +backing driver must configure the network device such that it is possible to
>> +send and receive traffic to this network device and it is properly separated
>> +from other network devices/ports (e.g.: as is frequent with a switch ASIC). How
>> +this is achieved is heavily hardware dependent, but a simple solution can be to
>> +use per-port VLAN identifiers unless a better mechanism is available
>> +(proprietary metadata for each network port for instance).
>> +
>> +The network device must be capable of running a full IP protocol stack
>> +including multicast, DHCP, IPv4/6, etc. If necessary, it should be program the
>> +appropriate filters for VLAN, multicast, unicast etc. The underlying device
>> +driver must effectively be configured in a similar fashion to what it would do
>> +when IGMP snooping is enabled for IP multicast over these switchdev network
>> +devices and unsolicited multicast must be filtered as early as possible into
>> +the hardware.
>> +
>> +When configuring VLANs on top of the network device, all VLANs must be working,
>> +irrespective of the state of other network devices (e.g.: other ports being part
>> +of a VLAN aware bridge doing ingress VID checking). See below for details.
>> +
>> +Bridged network devices
>> +-----------------------
>> +
>> +When a switchdev enabled network device is added as a bridge member, it should
>> +not disrupt any functionality of non-bridged network devices and they
>> +should continue to behave as normal network devices. Depending on the bridge
>> +configuration knobs below, the expected behavior is documented.
>> +
>> +VLAN filtering
>> +~~~~~~~~~~~~~~
>> +
>> +The Linux bridge allows the configuration of a VLAN filtering mode (compile and
>> +run time) which must be observed by the underlying switchdev network
>> +device/hardware:
>> +
>> +- with VLAN filtering turned off: frames ingressing the device with a VID that
>> +  is not programmed into the bridge/switch's VLAN table must be forwarded.
> 
> When VLAN filtering is turned off the expectation is that only untagged
> frames will ingress the bridge. Either because they were sent untagged
> or because a VLAN device enslaved to the bridge untagged them.

OK, that makes sense, the statement that I put is not necessarily
contradicting that, but it is better to supplement it with what you
provided.

> 
>> +
>> +- with VLAN filtering turned on: frames ingressing the device with a VID that is
>> +  not programmed into the bridges/switch's VLAN table must be dropped.
>> +
>> +Non-bridged network ports of the same switch fabric must not be disturbed in any
>> +way, shape or form by the enabling of VLAN filtering.
> 
> "shape or form" ?

It's just an expression, I can remove it :)

> 
>> +
>> +VLAN devices configured on top of a switchdev network device (e.g: sw0p1.100)
>> +which is a bridge port member must also observe the following behavior:
> 
> It is not clear where VLAN filtering is on / off. On the bridge the VLAN
> device is enslaved to I believe? Not the bridge the physical port is
> enslaved to.

Actually the later, at least in the hardware that I have access to, VLAN
filtering is global to the entire switch, whether the physical switch
ports are enslaved in a bridge or not.

Once you add support for ndo_rx_vlan_{add,kill}_vid(), which ends up
programming VLAN objects down the physical port, this is not a concern
anymore because you can seamlessly support the following cases:

- 1 or more physical ports enslaved into a VLAN aware bridge, 1 or more
physical ports not enslaved at all with, or without VLAN devices on top
of these non-bridged physical ports

- all ports enslaved into a VLAN aware bridge, or multiple bridges, that
all have the same VLAN filtering attributes (specific to my case here,
obviously)

Does that make sense? Some switches like mv88e6xxx do support a per-port
VLAN filtering/secure/unsecure option.

> 
>> +
>> +- with VLAN filtering turned off, these VLAN devices must be fully functional
>> +  since the hardware is allowed VID frames. Enslaving VLAN devices into the
> 
> "the hardware is allowed VID frames" ?

I meant to write that the hardware is not doing any ingress VID
checking, therefore, it allows any VID frame to ingress the physical
switch port.

> 
>> +  bridge might be allowed provided that there is sufficient separation using
>> +  e.g.: a reserved VLAN ID (4095 for instance) for untagged traffic.
>> +
>> +- with VLAN filtering turned on, these VLAN devices should not be allowed to
>> +  be created because they duplicate functionality/use case with the bridge's
>> +  VLAN functionality.
> 
> We always allow VLAN devices to be created. It is just that we don't
> allow their *enslavement* to VLAN-aware bridges.

If you have a bridge that is VLAN aware (br0), and you have a physical
port enslaved in that bridge (sw0p0) and you create a VLAN device:
sw0p0.100, it is equivalent to doing:

bridge vlan add vid 100 dev sw0p0
bridge vlan add vid 100 dev br0 self
ip link add name br0.100 link eth0 type vlan id 100

and use a VLAN device (br0.100) on top of the bridge, because if you do
either of these two things, it means that you want the host to utilize
those network interfaces.

Would you disagree? The difference is basically in the data path
handling of the VLAN (sort of).

> 
>> +
>> +Because VLAN filtering can be turned on/off at runtime, the switchdev driver
>> +must be able to re-configure the underlying hardware on the fly to honor the
>> +toggling of that option and behave appropriately.
>> +
>> +A switchdev driver can also refuse to support dynamic toggling of the VLAN
>> +filtering knob at runtime and require a destruction of the bridge device(s) and
>> +creation of new bridge device(s) with a different VLAN filtering value to
>> +ensure VLAN awareness is pushed down to the HW.
>> +
>> +IGMP snooping
>> +~~~~~~~~~~~~~
>> +
>> +The Linux bridge allows the configuration of IGMP snooping (compile and run
>> +time) which must be observed by the underlying switchdev network device/hardware
>> +in the following way:
>> +
>> +- when IGMP snooping is turned off, multicast traffic must be flooded to all
>> +  switch ports within the same broadcast domain. The CPU/management port
>> +  should ideally not be flooded and continue to learn multicast traffic through
>> +  the network stack notifications. If the hardware is not capable of doing that
>> +  then the CPU/management port must also be flooded and multicast filtering
>> +  happens in software.
>> +
>> +- when IGMP snooping is turned on, multicast traffic must selectively flow
>> +  to the appropriate network ports (including CPU/management port) and not flood
>> +  the switch.
>> +
>> +Note: reserved multicast addresses (e.g.: BPDUs) as well as Local Network
>> +Control block (224.0.0.0 - 224.0.0.255) do not require IGMP and should always
>> +be flooded.
> 
> I'm not sure that these paragraphs are actually needed. You're basically
> describing RFC 4541 on which the IGMP snooping functionality in the
> Linux bridge is based on.
> 
>> +
>> +Because IGMP snooping can be turned on/off at runtime, the switchdev driver must
>> +be able to re-configure the underlying hardware on the fly to honor the toggling
>> +of that option and behave appropriately.
>> +
>> +A switchdev driver can also refuse to support dynamic toggling of the multicast
>> +snooping knob at runtime and require the destruction of the bridge device(s)
>> +and creation of a new bridge device(s) with a different multicast snooping
>> +value.
> 
> You should probably get the patch that allows this vetoing merged before
> sending this documentation patch.

Well, technically the switchdev attribute allows returning an error, it
is just that we do not act (yet) on it in the bridge code, I can take
that part out fo correctness for now and submit a patch to that
documentation file once I submit the change to the bridge layer.
-- 
Florian
