Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=PZDmTlQU+OEosQWiAssyei/mUKxBwdyXaJFj6v3pPXU=;
	b=FE+L1VBHR9D1ZBeezD2T85/1JTs4JeiiFY9Z+/3KkW60MMb7TEDsLar6LL9XzhyCPT
	Mc3cnjX9/D1j/EbkKdOymERtgnTPthcgRpdJ6M2ezcZ1+fwKap2aOvWViOl0eTZWkDLB
	ygAel3Zf53l1pWs4GbYUbh9zX42922zZHx4HxvzctKZFXj0drVD2mjGT+QaNTCakqAKB
	d6xSRRVTcdvYqQuX8FaYluISHifEcW4YV5NRd1pnM6OFkyng/TBqAX87BCy5mhTtQuCt
	h6mwvzOnzm5460UdCKrn44jOwzrgYwa9lP6e5dWeLdMiEWYX+2qhmHbTDNnlGmsBDUpV
	V5Vg==
Date: Mon, 28 Aug 2017 08:11:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20170828081143.035f0a0c@xeon-e3>
In-Reply-To: <1503780970-10312-1-git-send-email-andrew@lunn.ch>
References: <1503780970-10312-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH RFC WIP 0/5] IGMP snooping for local traffic
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Vivien Didelot <vivien.didelot@savoirfairelinux.com>, nikolay@cumulusnetworks.com, netdev <netdev@vger.kernel.org>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, jiri@mellanox.com

On Sat, 26 Aug 2017 22:56:05 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> This is a WIP patchset i would like comments on from bridge, switchdev
> and hardware offload people.
> 
> The linux bridge supports IGMP snooping. It will listen to IGMP
> reports on bridge ports and keep track of which groups have been
> joined on an interface. It will then forward multicast based on this
> group membership.
> 
> When the bridge adds or removed groups from an interface, it uses
> switchdev to request the hardware add an mdb to a port, so the
> hardware can perform the selective forwarding between ports.
> 
> What is not covered by the current bridge code, is IGMP joins/leaves
> from the host on the brX interface. No such monitoring is
> performed. With a pure software bridge, it is not required. All
> mulitcast frames are passed to the brX interface, and the network
> stack filters them, as it does for any interface. However, when
> hardware offload is involved, things change. We should program the
> hardware to only send multcast packets to the host when the host has
> in interest in them.
> 
> Thus we need to perform IGMP snooping on the brX interface, just like
> any other interface of the bridge. However, currently the brX
> interface is missing all the needed data structures to do this. There
> is no net_bridge_port structure for the brX interface. This strucuture
> is created when an interface is added to the bridge. But the brX
> interface is not a member of the bridge. So this patchset makes the
> brX interface a first class member of the bridge. When the brX
> interface is opened, the interface is added to the bridge. A
> net_bridge_port is allocated for it, and IGMP snooping is performed as
> usual.
> 
> There are some complexities here. Some assumptions are broken, like
> the master interface of a port interface is the bridge interface. The
> brX interface cannot be its own master. The use of
> netdev_master_upper_dev_get() within the bridge code has been changed
> to reflecit this. The bridge receive handler needs to not process
> frames for the brX interface, etc.
> 
> The interface downward to the hardware is also an issue. The code
> presented here is a hack and needs to change. But that is secondary
> and can be solved once it is agreed how the bridge needs to change to
> support this use case.
> 
> Comment welcome and wanted.
> 
> 	Andrew
> 
> Andrew Lunn (5):
>   net: rtnetlink: Handle bridge port without upper device
>   net: bridge: Skip receive handler on brX interface
>   net: bridge: Make the brX interface a member of the bridge
>   net: dsa: HACK: Handle MDB add/remove for none-switch ports
>   net: dsa: Don't include CPU port when adding MDB to a port
> 
>  include/linux/if_bridge.h |  1 +
>  net/bridge/br_device.c    | 12 ++++++++++--
>  net/bridge/br_if.c        | 37 ++++++++++++++++++++++++-------------
>  net/bridge/br_input.c     |  4 ++++
>  net/bridge/br_mdb.c       |  2 --
>  net/bridge/br_multicast.c |  7 ++++---
>  net/bridge/br_private.h   |  1 +
>  net/core/rtnetlink.c      | 23 +++++++++++++++++++++--
>  net/dsa/port.c            | 19 +++++++++++++++++--
>  net/dsa/switch.c          |  2 +-
>  10 files changed, 83 insertions(+), 25 deletions(-)
> 

Sorry you can't change the semantics of the bridge like this.
There are likely to be scripts and management utilities that won't work after this.

Figure out another way. Such as adding IGMP updates in the local packet send/receive path.
