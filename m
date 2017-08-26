Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=QJTI2GnbYGYP+93JM2ymaDq2wr4oxgBIXaeyHeKXVSc=;
	b=VYizjn2xxsqAt+M6jEavaC/xtRHAl0lloEF4hUOlDy5MMepHyobu4sqXVspQAQ+j8j
	FircnYhoc/1fJgczU5xE5BwvnyohwE+jXJFsOdvQyo+ttRIC3MvUv4pQy0c7tkUMqosE
	dM1weHaszmiH5RtGLQ7xT75dobL2ubSaO6/lQ=
References: <1503780970-10312-1-git-send-email-andrew@lunn.ch>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <c3f5050f-7a38-c28c-31d0-df5909259fb1@cumulusnetworks.com>
Date: Sun, 27 Aug 2017 01:17:39 +0300
MIME-Version: 1.0
In-Reply-To: <1503780970-10312-1-git-send-email-andrew@lunn.ch>
Content-Type: text/plain; charset=windows-1252
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
To: Andrew Lunn <andrew@lunn.ch>, netdev <netdev@vger.kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Vivien Didelot <vivien.didelot@savoirfairelinux.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, jiri@mellanox.com

On 26/08/17 23:56, Andrew Lunn wrote:
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

Hi Andrew,

Have you taken a look at mglist (the boolean, probably needs a rename) ? It is for
exactly that purpose, to track which groups the bridge is interested in.
I assume I'm forgetting or missing something here.

> performed. With a pure software bridge, it is not required. All
> mulitcast frames are passed to the brX interface, and the network

If mglist (again the boolean) is false then they won't be passed up.

> stack filters them, as it does for any interface. However, when
> hardware offload is involved, things change. We should program the
> hardware to only send multcast packets to the host when the host has
> in interest in them.

Granted the boolean mglist might need some changes (esp. with host group leave)
but I think it can be used to program switchdev for host join/leave, can't
we adjust its behaviour instead of introducing this complexity and avoid many
headaches ?

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

I have actually discussed this idea long time ago with Vlad and it has very nice
upsides (most important one removing br/port checks everywhere) but it blows up
fast with special cases for the bridge and things look very similar. You'll need
to rework the whole bridge and turn every bridge special case into either a port 
generic one or again bridge-specific special case but with a check for the new flag.
I will not point out every bug that comes out of this, but registering the bridge
rx handler to itself is simply wrong on many levels and breaks many setups.

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

Definitely agree with this statement. :-)

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

