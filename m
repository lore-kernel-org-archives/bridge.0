Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=67v6O1NSh3yHMzWcWSRpb4wtkEA6DrqITZmHl0U+8yU=;
	b=maaa6U0Z0xwNceMYNO6K7gy2WoV89k8kqIuB3jAlIPk1YA+E+w9vzkjTQIMFmEsj2G
	wMf4/6nBHzjVorRN6Fwox3tx+1RMpYDpuOWrlzYkReUiPO9T0GZ6Bz6lN65YcywEiPhk
	/3bvr4hQHgnLeiHSGthKYj9UT3GugxMMFLmHTnG/GMWDOdzgoR7l3bRziQQBhz/DMzFc
	fjO18p+EbbzR3OetYnfznxZWJ0bS+X9XvSzQhviqAt5l2rtH/DqTHc+xTxBlMpWokGAw
	6Qkmjr2ZvF6xNK/gsOXbcUogMIsB+0V4mcw8EQyofTvDrwI3iv8niRPjFIhWSBa9h7AJ
	Sqgg==
References: <20181212230943.757-1-f.fainelli@gmail.com>
	<20181216082517.GA31098@splinter>
	<af53dd72-aac6-4b35-933a-17b27d3398ef@gmail.com>
	<20181218070134.GA19817@splinter>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d8c02429-0cab-a798-f1c9-4b8d5cb2dd33@gmail.com>
Date: Tue, 18 Dec 2018 12:13:38 -0800
MIME-Version: 1.0
In-Reply-To: <20181218070134.GA19817@splinter>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Ido Schimmel <idosch@mellanox.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, Jiri Pirko <jiri@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

On 12/17/18 11:01 PM, Ido Schimmel wrote:
> On Sun, Dec 16, 2018 at 09:14:09AM -0800, Florian Fainelli wrote:
>> Le 12/16/18 à 12:25 AM, Ido Schimmel a écrit :
>>> On Wed, Dec 12, 2018 at 03:09:43PM -0800, Florian Fainelli wrote:
>>>> +Non-bridged network ports of the same switch fabric must not be disturbed in any
>>>> +way, shape or form by the enabling of VLAN filtering.
>>>> +
>>>> +VLAN devices configured on top of a switchdev network device (e.g: sw0p1.100)
>>>> +which is a bridge port member must also observe the following behavior:
>>>> +
>>>> +- with VLAN filtering turned off, these VLAN devices must be fully functional
>>>> +  since the hardware is allowed VID frames
>>>> +
>>>> +- with VLAN filtering turned on, these VLAN devices are not going to be
>>>> +  functional unless the bridge's VLAN database is also configured to have that
>>>> +  VID enabled for the underlying network device/port
>>>> +  (e.g: bridge vlan add vid 100 dev sw0p1)
>>>
>>> mlxsw forbids the enslavement of VLAN devices to VLAN-aware bridges. It
>>> doesn't really make sense to enable VLAN filtering when all the packets
>>> are untagged.
>>
>> Did you mean VLAN-unaware here, otherwise that would contradict the
>> statement that VLAN-aware bridges mean everything untagged, or am I
>> incorrectly understanding things here?
> 
> I meant VLAN-aware... In a VLAN-unaware bridge the VLAN is meaningless.
> For example, there is no filtering based on VLAN at ingress/egress and
> FDB entries are only searched based on MAC (VLAN is always 0). This is
> in contrast to a VLAN-aware bridge.
> 
> When you enslave VLAN netdevs to a bridge, the bridge sees untagged
> packets. The VLAN tag is pulled from the packet in Rx path and then the
> packet is injected to the bridge via the Rx handler configured on the
> VLAN netdev. Therefore, there is point in enslaving these device to a
> VLAN-aware bridge.

I see what you describe and that is not quite what I was talking about,
see below.

> 
> Also, mlxsw only supports a single VLAN-aware bridge. You can however,
> configure 1K VLAN-unaware bridges.

OK, how do you enforce that in the driver? I was going to do something
as basic as: loop around all ports that are not the one being changed by
VLAN filtering attribute, if bridge device associated is non-NULL and
br_vlan_enabled() returns true for that bridge and we want to turn off
VLAN filtering, then this is not possible since that would break the
other bridge devices we have which are VLAN filtering enabled.

> 
>>> But I disagree with the comment about the underlying port. When you
>>> configured the VLAN device, it should have enabled the VLAN filters on
>>> the real device via ndo_vlan_rx_add_vid().
>>
>> That is really why I submitted this patch, because right now I have a
>> patch (yet to be submitted) which adds ndo_vlan_rx_{add,kill}_vid() and
>> if the underlying device is enslaved into a bridge, I just do nothing
>> and let the bridge control the VLAN membership, hence my comment and
>> example here.
>>
>> What you are saying is that we should have these two cases:
>>
>> 1) VLAN devices on top of VLAN unaware bridge: allow the VLAN device and
>> program VLAN filter on the underlying switch port to permit VLAN tagging
> 
> When you say "on top" you mean enslaved to?

I meant to write: a VLAN device created on (top of) a switch port, and
this switch port being a bridge member. The VLAN device would not be
added as a bridge member (did not really think about it).

> 
>> 2) VLAN devices on top of a VLAN aware bridge: deny the VLAN device
>> creation and let the bridge, which is VLAN aware manage the port VLAN
>> membership
> 
> mlxsw does not forbid the creation of the VLAN device. It only forbids
> its enslavement to a VLAN-aware bridge.

That's done in mlxsw_sp_netdevice_port_vlan_event() right?

> 
>> In case 1) or 2) if the desire is to have a VLAN aware network device
>> this can be either done through a VLAN device on top of the switch port,
>> or through a VLAN device on top of the bridge master itself, and in
>> either case, this amounts to doing about the same thing.
>>
>> Did I get this right?
> 
> I'm saying that a VLAN-aware bridge with VIDs 10-100 (for example) is
> equivalent to VLAN devices with VIDs 10-100 enslaved to br10-br100,
> respectively. It is up to you if you want to / can support both modes.
> We support both, but most / all users use the VLAN-aware bridge.
> 

Right, and it is also equivalent to have these two things:

- a VLAN aware bridge, adding VIDs 10-100 to sw0p1 through "bridge vlan
add vid .." and creating br0.10..br0.100 devices

and:

- a VLAN aware bridge, creating sw0p1.10..sw0p1.100 (VLAN devices) while
sw0p1 is a bridge port member
-- 
Florian
