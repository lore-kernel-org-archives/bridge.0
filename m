Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=RVy1HaD1azfOHq3QirPzHTZUWdA8V4OmotoxtL427VU=;
	b=skJj5ccu4Il0Bn4d2w/F6qzDkqp6mZ0Cvg6nhsWOwcE8v8cxTYJUqpL2d7MYPxAvDPIlK+l5S5LkVFidtlY9uyoQILIDCBVpyoZ2fZwThh7qihqYmRI84DXipnrb/JmgWR/+MSy+uAnjcR8FM0pxPSMTsa87czyLoY4J/h0fexM=
From: Petr Machata <petrm@mellanox.com>
References: <cover.1527173527.git.petrm@mellanox.com>
	<61962919-cf93-cd7b-f248-9dfee5c9529d@gmail.com>
Date: Fri, 25 May 2018 13:09:46 +0300
In-Reply-To: <61962919-cf93-cd7b-f248-9dfee5c9529d@gmail.com> (Florian
	Fainelli's message of "Thu, 24 May 2018 10:20:46 -0700")
Message-ID: <wihbmd4gi6t.fsf@dev-r-vrt-156.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next 0/7] net: bridge: Notify about bridge
	VLANs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: devel@driverdev.osuosl.org, andrew@lunn.ch, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, gregkh@linuxfoundation.org, vivien.didelot@savoirfairelinux.com, davem@davemloft.net

Florian Fainelli <f.fainelli@gmail.com> writes:

> You seem to have approached the bridge changes a little differently from
> this series:
>
> https://lists.linux-foundation.org/pipermail/bridge/2016-November/010112.html

It pretty much extends the patchset to also send the notifications for
the CPU port.

I missed this e-mail yesterday and now I see you already found out for
yourself how it behaves.

> Both have the same intent that by targeting the bridge device itself,
> you can propagate that through switchdev to the switch drivers, and in
> turn create configurations where for instance, you have:
>
> - CPU/management port present in specific VLANs that is a subset or
> superset of the VLANs configured on front-panel ports
> - CPU/management port tagged/untagged in specific VLANs which can be a
> different setting from the front-panel ports
>
> One problem we have in DSA at the moment is that we always add the CPU
> port to the VLANs configured to the front-panel port but we do this with
> the same attributes as the front panel ports! For instance, if you add
> Port 0 to VLAN1 untagged, the the CPU port also gets added to that
> VLAN1, also untagged. As long as there is just one VLAN untagged, this
> is not much of a problem. Now do this with another VLAN or another port,
> and the CPU can no longer differentiate the traffic from which VLAN it
> is coming from, no bueno.

Yep, with this patchset you should be able to use the CPU port
notifications to configure things exactly.

> bridge vlan add vid 2 dev port0 pvid untagged
> 	-> port0 (e.g: switch port 0) gets programmed
> 	-> CPU port gets programmed
> bridge vlan add vid 2 dev br0 self
> 	-> CPU port gets programmed
> bridge vlan add vid 2 dev port0
> 	-> port0 (switch port 0) gets programmed
>
> Are these use cases possible with your series? It seems to me like it is
> if we drop the netif_is_bridge_master() checks and resolve orig_dev as
> being a hint for the CPU/management port.

Yeah, that's how it behaves. If you accept the events where
netif_is_bridge_master(orig_dev), you can tell the CPU port-related
events from the rest by BRIDGE_VLAN_INFO_BRENTRY.

Thanks,
Petr
