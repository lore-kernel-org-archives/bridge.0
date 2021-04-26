Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=ys1pALIVK8EXtzpFIZZmPRxRPFzULoCycqi5M+Q+z9U=;
 b=kONxnZMeg5qi+ye+Uwjhw0msT78kXlYOf6TxAV+uVl9zS9J8zuIedqWDzWv7pJoAB2
 D9akRegpfwmSiiJUldMX47tZqRmdNM+QsGrJ1uVMfJaEd48JI2R8QAbWmfDHKGIKxAut
 +Q34XgNxRZog6usMIWcoFuoOAnj0WCEhoqbUZM39SxfP2m/+UEFDUMWC8EKoz/uqucKZ
 0NP1vvMxeNEMjun6qaO20dbLW2WlblSm3Ad1WZzevdlASolNMKNZURgsSsSE9Lx83xVK
 jyksx4673h9xWYPDJAPXtePISDo/s61O59j07ZRu+9/VvUlYgVoosRoN77IKt85pb8Db
 rEvg==
From: Tobias Waldekranz <tobias@waldekranz.com>
In-Reply-To: <20210426194026.3sr22rqyf2srrwtq@skbuf>
References: <20210426170411.1789186-1-tobias@waldekranz.com>
 <20210426170411.1789186-6-tobias@waldekranz.com>
 <20210426194026.3sr22rqyf2srrwtq@skbuf>
Date: Mon, 26 Apr 2021 22:05:52 +0200
Message-ID: <877dkoq09r.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [RFC net-next 5/9] net: dsa: Track port PVIDs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, vivien.didelot@gmail.com, idosch@idosch.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

On Mon, Apr 26, 2021 at 22:40, Vladimir Oltean <olteanv@gmail.com> wrote:
> Hi Tobias,
>
> On Mon, Apr 26, 2021 at 07:04:07PM +0200, Tobias Waldekranz wrote:
>> In some scenarios a tagger must know which VLAN to assign to a packet,
>> even if the packet is set to egress untagged. Since the VLAN
>> information in the skb will be removed by the bridge in this case,
>> track each port's PVID such that the VID of an outgoing frame can
>> always be determined.
>> 
>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>> ---
>
> Let me give you this real-life example:
>
> #!/bin/bash
>
> ip link add br0 type bridge vlan_filtering 1
> for eth in eth0 eth1 swp2 swp3 swp4 swp5; do
> 	ip link set $eth up
> 	ip link set $eth master br0
> done
> ip link set br0 up
>
> bridge vlan add dev eth0 vid 100 pvid untagged
> bridge vlan del dev swp2 vid 1
> bridge vlan del dev swp3 vid 1
> bridge vlan add dev swp2 vid 100
> bridge vlan add dev swp3 vid 100 untagged
>
> reproducible on the NXP LS1021A-TSN board.
> The bridge receives an untagged packet on eth0 and floods it.
> It should reach swp2 and swp3, and be tagged on swp2, and untagged on
> swp3 respectively.
>
> With your idea of sending untagged frames towards the port's pvid,
> wouldn't we be leaking this packet to VLAN 1, therefore towards ports
> swp4 and swp5, and the real destination ports would not get this packet?

I am not sure I follow. The bridge would never send the packet to
swp{4,5} because should_deliver() rejects them (as usual). So it could
only be sent either to swp2 or swp3. In the case that swp3 is first in
the bridge's port list, it would be sent untagged, but the PVID would be
100 and the flooding would thus be limited to swp{2,3}.

You did make me realize that there is a fatal flaw in the current design
though: Using this approach, it is not possible to have multiple VLANs
configured to egress untagged out of one port. Rare, but allowed.

So the VLAN information will have to remain in the skb somehow. My
initial plan was actually to always send offloaded skbs tagged. I went
this route because I thought we already had all the information we
needed in the driver. It seems reasonable that skb->vlan_tci could
always be set for offloaded frames from a filtering bridge, no?
