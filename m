Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=6HryAfYx3/zRXSaYfBE41paZ2g8+TvoZJzNvgMqI3p0=;
 b=samMgfVtK07V7kktgrg6kYx5HKlNUtfR+kqEs4e832tnWwHxUpdT1WUviBRKrk5Sc0
 P5VCd4DirH9sZlY49wNWi2YmzfYatnXc4deNz92XfvhebmAMxv/JUhgNmTPewmDwDr+P
 7bIOudiJqvMV5aYSi0wET0rr4d7OfFBG0bDVkyR4lfItpXXJMkdEE1kAwYorh/gNPlGz
 G3qS1JHwbJEMTySYXm+LFmDxgY9ZUs/N9bDg0JoaGmGKIt5Ta4Jx9nRUngo2u++hap9i
 y9vuN6P/S0guspjhiUuNZBuvUt5+PpTwrTYd0WSxcmX4zQ0CuckqlBHLWmP4SHZRI1+p
 iLUg==
Date: Mon, 26 Apr 2021 23:28:00 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210426202800.y4hfurf5k3hrbvqf@skbuf>
References: <20210426170411.1789186-1-tobias@waldekranz.com>
 <20210426170411.1789186-6-tobias@waldekranz.com>
 <20210426194026.3sr22rqyf2srrwtq@skbuf>
 <877dkoq09r.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dkoq09r.fsf@waldekranz.com>
Subject: Re: [Bridge] [RFC net-next 5/9] net: dsa: Track port PVIDs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, vivien.didelot@gmail.com, idosch@idosch.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

On Mon, Apr 26, 2021 at 10:05:52PM +0200, Tobias Waldekranz wrote:
> On Mon, Apr 26, 2021 at 22:40, Vladimir Oltean <olteanv@gmail.com> wrote:
> > Hi Tobias,
> >
> > On Mon, Apr 26, 2021 at 07:04:07PM +0200, Tobias Waldekranz wrote:
> >> In some scenarios a tagger must know which VLAN to assign to a packet,
> >> even if the packet is set to egress untagged. Since the VLAN
> >> information in the skb will be removed by the bridge in this case,
> >> track each port's PVID such that the VID of an outgoing frame can
> >> always be determined.
> >> 
> >> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> >> ---
> >
> > Let me give you this real-life example:
> >
> > #!/bin/bash
> >
> > ip link add br0 type bridge vlan_filtering 1
> > for eth in eth0 eth1 swp2 swp3 swp4 swp5; do
> > 	ip link set $eth up
> > 	ip link set $eth master br0
> > done
> > ip link set br0 up
> >
> > bridge vlan add dev eth0 vid 100 pvid untagged
> > bridge vlan del dev swp2 vid 1
> > bridge vlan del dev swp3 vid 1
> > bridge vlan add dev swp2 vid 100
> > bridge vlan add dev swp3 vid 100 untagged
> >
> > reproducible on the NXP LS1021A-TSN board.
> > The bridge receives an untagged packet on eth0 and floods it.
> > It should reach swp2 and swp3, and be tagged on swp2, and untagged on
> > swp3 respectively.
> >
> > With your idea of sending untagged frames towards the port's pvid,
> > wouldn't we be leaking this packet to VLAN 1, therefore towards ports
> > swp4 and swp5, and the real destination ports would not get this packet?
> 
> I am not sure I follow. The bridge would never send the packet to
> swp{4,5} because should_deliver() rejects them (as usual). So it could
> only be sent either to swp2 or swp3. In the case that swp3 is first in
> the bridge's port list, it would be sent untagged, but the PVID would be
> 100 and the flooding would thus be limited to swp{2,3}.

Sorry, _I_ don't understand.

When you say that the PVID is 100, whose PVID is it, exactly? Is it the
pvid of the source port (aka eth0 in this example)? That's not what I
see, I see the pvid of the egress port (the Marvell device)...

So to reiterate: when you transmit a packet towards your hardware switch
which has br0 inside the sb_dev, how does the switch know in which VLAN
to forward that packet? As far as I am aware, when the bridge had
received the packet as untagged on eth0, it did not insert VLAN 100 into
the skb itself, so the bridge VLAN information is lost when delivering
the frame to the egress net device. Am I wrong?
