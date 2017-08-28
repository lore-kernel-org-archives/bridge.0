Return-Path: <andrew@lunn.ch>
Date: Mon, 28 Aug 2017 15:45:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20170828134529.GC10418@lunn.ch>
References: <1503780970-10312-1-git-send-email-andrew@lunn.ch>
	<b5bf300b-58c1-d7a7-8851-651683a234b0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5bf300b-58c1-d7a7-8851-651683a234b0@gmail.com>
Subject: Re: [Bridge] [PATCH RFC WIP 0/5] IGMP snooping for local traffic
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>, nikolay@cumulusnetworks.com, netdev <netdev@vger.kernel.org>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, jiri@mellanox.com

On Sun, Aug 27, 2017 at 07:44:15PM -0700, Florian Fainelli wrote:
> Hi Andrew,
> 
> On 08/26/2017 01:56 PM, Andrew Lunn wrote:
> > This is a WIP patchset i would like comments on from bridge,
> > switchdev and hardware offload people.
> > 
> > The linux bridge supports IGMP snooping. It will listen to IGMP 
> > reports on bridge ports and keep track of which groups have been 
> > joined on an interface. It will then forward multicast based on this 
> > group membership.
> > 
> > When the bridge adds or removed groups from an interface, it uses 
> > switchdev to request the hardware add an mdb to a port, so the 
> > hardware can perform the selective forwarding between ports.
> > 
> > What is not covered by the current bridge code, is IGMP joins/leaves 
> > from the host on the brX interface. No such monitoring is performed.
> > With a pure software bridge, it is not required. All mulitcast frames
> > are passed to the brX interface, and the network stack filters them,
> > as it does for any interface. However, when hardware offload is
> > involved, things change. We should program the hardware to only send
> > multcast packets to the host when the host has in interest in them.
> 
> OK, so if I understand this right, without a bridge, we have the
> following happen today: with a DSA-enabled setup using any kind of
> switch tagging protocol, if a host is interested in receiving particular
> multicast traffic, we would receive IGMP joins/leaves through sw0p0, and
> the stack should call ndo_set_rx_mode for sw0p0, which would be
> dsa_slave_set_rx_mode() and which would synchronize the DSA master
> network device with the slave network device, everything works fine
> provided that the CPU port is configured to accept multicast traffic.

Hi Florian

That sounds about right, but it is not a use case i've looked at yet.
I do need to look at it though, because there is a chance i break it
with IGMP snooping support.

> Note here that we don't really add a MDB entry for sw0p0 when that
> happens, but it seems like we should for switches that lack IGMP
> snooping and/or multicast filtering.

Yes. But it is not an MDB in the normal sense, at least from the
switches perspective. An MDB passed to a switch using switchdev says
that traffic for the specified group should go out that port. However,
when the host does a join on sw0p0, we want the exact opposite,
multicast traffic coming in that port of the switch which matches the
group should be forwarded to the host. So my second attempt at this
code adds a new switchdev object, SWITCHDEV_OBJ_ID_PORT_HOST_MDB.

> With the current bridge and DSA code, are not we actually always going
> to get the CPU port to be added with the multicast address and therefore
> no filtering is occurring and snooping is pretty much useless?

Correct. At the moment, all multicast traffic gets delivered to the
host.

> While I understand the reasons why you did it that way, I think this is
> going to break a lot of code in bridge that does not expect brX to be a
> bridge port member.

It does. 

Nikolay suggestion works a lot better, and i'm following that now. It
looks good and only requires some minor tweaks to the bridge code.

      Andrew
