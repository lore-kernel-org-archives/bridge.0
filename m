Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=b/kMlA
	G8IMolZ0UfrhzHGd6I6tYuYoL+LatkiibNk+Q=; b=g+obCtFAvt1lG9NrwNpyog
	XdQAdkebpm9UU502Jnij6T+0JlowYfeS8xqiROYPnrkeSUukJqLFCxS3YO7tIIBx
	aHIGwitlzUxUqKRrXGk7aFe3qoY3JgFmoNznd/OArhfR7TtJG35qQUARd6eftrZ2
	xdSHAZG2IEIsfiRBs+Ghfy+GtQcm8SVQZB9a31TbaU+gC5NKROuepn4/WkiS73+9
	MUzsJvv8Vx1QnDZR3yNd2ToNqbS++O0N2JajJsXthYEaawyFnDG/hAo7iBs8yt8L
	j4TQ42Fmd1/LD8KJur0pzaeYFK4DM46rUocJ2jsl6VXxYquSGwYTo3a0v8E+s6Cg
	==
Date: Wed, 12 Dec 2018 11:02:38 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20181212090238.GA1725@splinter.mtl.com>
References: <61ecaa9f-f1ba-f79e-1d8b-4ec2eba5dc11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61ecaa9f-f1ba-f79e-1d8b-4ec2eba5dc11@gmail.com>
Subject: Re: [Bridge] Correct PVID behavior with bridge's VLAN filtering
	on/off?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: andrew@lunn.ch, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, vivien.didelot@gmail.com

On Tue, Dec 11, 2018 at 11:48:21AM -0800, Florian Fainelli wrote:
> Hi Nikolay, Roopa, Jiri, Ido,
> 
> When a bridge has vlan_filtering=0 and notifies a switch driver through
> HOST_OBJ_MDB about MC addresses that the CPU/management port is
> interested in getting MC traffic for, I am seeing that the mdb->vid is
> set to 0 because br_allowed_ingress() checks for BROPT_VLAN_ENABLED
> which is now disabled and so we never populated *vid to anything but 0
> because the caller: br_handle_frame_finish() zeroed it out.

s/br_handle_frame_finish()/br_dev_xmit()/ ? Since you're talking about
HOST_OBJ_MDB

> This creates a problem with the b53 DSA switch driver because in order
> to match the bridge's default_pvid, we did program the switch's "default
> tag" to be 1, which gets used for all untagged frames that ingress the
> switch (which AFAICT is correct behavior for PVID).

Not sure I'm following. If bridge is not VLAN-aware, then where do you
see 'default_pvid' being used?

> Despite having turned off VLAN filtering in the switch such that it does
> allow ingress of packets with a VID that is not present in the VLAN
> table (violation), Multicast addresses do behave differently and we
> really must be strictly matching the programmed PVID in order for MC
> frames to ingress the switch even with VLAN filtering turned off.
> 
> So with all that being written, should the bridge still be sending MDB
> notifications and use the bridge's default_pvid even with
> vlan_filtering=0? And if we did that, what use case could we be possibly
> breaking?
> 
> Let me know if this is not clear so I can provide mode details.

I think you need to provide more details about the device you're working
with. I can explain what we're doing in mlxsw for reference.

When you use a VLAN-unaware bridge w/o VLAN devices, we make sure all
untagged packets get tagged with some arbitrary VLAN (now 1, soon 4095).
You never see this VLAN on the wire, since we remove it before sending
the packets. It is only used because all packets in the ASIC must be
tagged.

After we have a VLAN we classify the packet to a FID (bridge) and it
does {FID,DMAC} lookup in the FDB (MDB).

IIUC, your problem is that you also need to tag all the packets (you
used '1', can be something else), but then you program the MDB entry
according to the VLAN passed in the notification ('0') and not use
('1'). We completely ignore the VID in this case and use the FID which
we lookup based on the ifindex of the bridge.
