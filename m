Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=to:cc:references:from:openpgp:autocrypt:subject:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=hwDPACWJhvODejB9rzu9x5vP8FLHbEuAspIxAnGJQp0=;
	b=WeST//9MppAWuMboei532yuV2VjEZUfvzizIldYHx9x1M3QKiPUGutaQin0gtAqAXu
	z1Vkft+cOLxXBaNRawC9bd3+vLm3WwREpgC9d9HHxKvKwO3PBGWko2CgbMU9MU+JT4li
	/nUW4LNt2DtcuF0wZlNLzY+Odi3BV5GdlFh1EPc+K555jTpF6ripQny34FLQd8Lc/w6s
	f8cyuPyrUF/vqlerVY86lMaGQxu6RJPoWnWXitTVnheps5igXJNRbRhv0mZgNqnWxAsS
	H/kSfORGRE9UZmBp/Gr6HZL1vh3YEfnE2Ae5QnS9fEpgatHfM2EWVtaR6AwT2DS3wLk5
	38jA==
References: <20181212230943.757-1-f.fainelli@gmail.com>
	<20181216082517.GA31098@splinter>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <af53dd72-aac6-4b35-933a-17b27d3398ef@gmail.com>
Date: Sun, 16 Dec 2018 09:14:09 -0800
MIME-Version: 1.0
In-Reply-To: <20181216082517.GA31098@splinter>
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

Le 12/16/18 à 12:25 AM, Ido Schimmel a écrit :
> On Wed, Dec 12, 2018 at 03:09:43PM -0800, Florian Fainelli wrote:
>> This patch provides details on the expected behavior of switchdev
>> enabled network devices when operating in a "stand alone" mode, as well
>> as when being bridge members. This clarifies a number of things that
>> recently came up during a bug fixing session on the b53 DSA switch
>> driver.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>> Hi all,
>>
>> Please review carefully, and let me know if you think some of the
>> behaviors described below do not make any sense. Thanks!
>>
>>  Documentation/networking/switchdev.txt | 86 ++++++++++++++++++++++++++
>>  1 file changed, 86 insertions(+)
>>
>> diff --git a/Documentation/networking/switchdev.txt b/Documentation/networking/switchdev.txt
>> index 82236a17b5e6..8c83174b477b 100644
>> --- a/Documentation/networking/switchdev.txt
>> +++ b/Documentation/networking/switchdev.txt
>> @@ -392,3 +392,89 @@ switchdev_trans_item_dequeue()
>>  
>>  If a transaction is aborted during "prepare" phase, switchdev code will handle
>>  cleanup of the queued-up objects.
>> +
>> +Switchdev enabled network device expected behavior
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +Below is a set of defined behavior that switchdev enabled network device must be
>> +adhering to.
>> +
>> +Configuration less state
>> +------------------------
>> +
>> +Upon driver bring up, the network devices must be fully operational, and the
>> +backing driver must be configuring the network device such that it is possible
>> +to send and receive to this network device such that it is properly separate
>> +from other network devices/ports (e.g: as is frequenty with a switch ASIC). How
>> +this is achieved is heavily hardware dependent, but a simple solution can be to
>> +use per-port VLAN identifiers.
>> +
>> +The network device must be capable of running a full IP protocol stack must be
>> +working, including multicast, DHCP, IPv4/6, etc. If necessary, it should be
>> +programming the appropriate filters for VLAN, multicast, unicast etc. The
>> +underlying device driver must effectively be configured in a similar fashion to
>> +what it would do when IGMP snooping is enabled for IP multicast over these
>> +switchdev network devices and unsollicited multicast must be filtered as early
>> +as possible into the hardware.
>> +
>> +When configuring VLANs on top of the network device, all VLANs must be working,
>> +irrespective of the state of other network devices (e.g: other ports being part
>> +of a VLAN aware bridge doing ingress VID checking). See below for details.
>> +
>> +Bridged network devices
>> +-----------------------
>> +
>> +When a switchdev enabled network device is added as a bridge member, it should
>> +not be disrupting any functionality of non-bridged network devices and they
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
> mlxsw doesn't support it. These bridges are mainly used with VLAN
> devices where the packets ingress the bridge untagged. When configured
> over physical ports, we only allow untagged packets into such a bridge.

I suppose I got confused about the meaning of VLAN filtering on a Linux
bridge when offloaded to a switch, VLAN filtering turned off effectively
means: no VLAN awareness, everything untagged.

There are really many misnomers within the bridge code then, like
MC_DISABLED, this really means: flood or do not flood multicast, not
"disable multicast" which would be madness.

> 
>> +
>> +- with VLAN filtering turned on: frames ingressing the device with a VID that is
>> +  not programmed into the bridges/switch's VLAN table must be dropped.
> 
> ack
> 
>> +
>> +Non-bridged network ports of the same switch fabric must not be disturbed in any
>> +way, shape or form by the enabling of VLAN filtering.
>> +
>> +VLAN devices configured on top of a switchdev network device (e.g: sw0p1.100)
>> +which is a bridge port member must also observe the following behavior:
>> +
>> +- with VLAN filtering turned off, these VLAN devices must be fully functional
>> +  since the hardware is allowed VID frames
>> +
>> +- with VLAN filtering turned on, these VLAN devices are not going to be
>> +  functional unless the bridge's VLAN database is also configured to have that
>> +  VID enabled for the underlying network device/port
>> +  (e.g: bridge vlan add vid 100 dev sw0p1)
> 
> mlxsw forbids the enslavement of VLAN devices to VLAN-aware bridges. It
> doesn't really make sense to enable VLAN filtering when all the packets
> are untagged.

Did you mean VLAN-unaware here, otherwise that would contradict the
statement that VLAN-aware bridges mean everything untagged, or am I
incorrectly understanding things here?

> 
> But I disagree with the comment about the underlying port. When you
> configured the VLAN device, it should have enabled the VLAN filters on
> the real device via ndo_vlan_rx_add_vid().

That is really why I submitted this patch, because right now I have a
patch (yet to be submitted) which adds ndo_vlan_rx_{add,kill}_vid() and
if the underlying device is enslaved into a bridge, I just do nothing
and let the bridge control the VLAN membership, hence my comment and
example here.

What you are saying is that we should have these two cases:

1) VLAN devices on top of VLAN unaware bridge: allow the VLAN device and
program VLAN filter on the underlying switch port to permit VLAN tagging

2) VLAN devices on top of a VLAN aware bridge: deny the VLAN device
creation and let the bridge, which is VLAN aware manage the port VLAN
membership

In case 1) or 2) if the desire is to have a VLAN aware network device
this can be either done through a VLAN device on top of the switch port,
or through a VLAN device on top of the bridge master itself, and in
either case, this amounts to doing about the same thing.

Did I get this right?

> 
>> +
>> +Because VLAN filtering can be turned on/off at runtime, the switchdev driver
>> +must be able to re-configure the underlying hardware on the fly to honor the
>> +toggling of that option and behave appropriately.
> 
> Please mention that switchdev drivers can refuse the operation.
> 

Will do, thanks!
-- 
Florian
