Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=QGW13bxNRsVnBURXtUSCumK+fMi1nSAXtkoL/otoEFU=;
	b=d+qeW4eu3zg2oAuJnvuzIvlvEqOLRkTF2yD39UV7gpvvXz62NVLutbpPScld/9UZhZ
	WTZQe60apV7kQxNW9t3+UDv/igFlxIKPvhOBIyzg3NHJOCDjKtHKxrrXcEUtnqcS0HT2
	tl0PAUh2vYfVBtQL6BfFeeTHngMs9dvpPkXo8=
References: <20170119024510.3284-1-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <253b73f3-0db0-4515-8787-2ff87d1e8256@cumulusnetworks.com>
Date: Thu, 19 Jan 2017 10:53:56 +0100
MIME-Version: 1.0
In-Reply-To: <20170119024510.3284-1-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next v4] bridge: multicast to unicast
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>, netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Felix Fietkau <nbd@nbd.name>

On 19/01/17 03:45, Linus Lüssing wrote:
> From: Felix Fietkau <nbd@nbd.name>
> 
> Implements an optional, per bridge port flag and feature to deliver
> multicast packets to any host on the according port via unicast
> individually. This is done by copying the packet per host and
> changing the multicast destination MAC to a unicast one accordingly.
> 
> multicast-to-unicast works on top of the multicast snooping feature of
> the bridge. Which means unicast copies are only delivered to hosts which
> are interested in it and signalized this via IGMP/MLD reports
> previously.
> 
> This feature is intended for interface types which have a more reliable
> and/or efficient way to deliver unicast packets than broadcast ones
> (e.g. wifi).
> 
> However, it should only be enabled on interfaces where no IGMPv2/MLDv1
> report suppression takes place. This feature is disabled by default.
> 
> The initial patch and idea is from Felix Fietkau.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> [linus.luessing@c0d3.blue: various bug + style fixes, commit message]
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> 
> ---
> 
> This feature is used and enabled by default in OpenWRT and LEDE for AP
> interfaces for more than a year now to allow both a more robust multicast
> delivery and multicast at higher rates (e.g. multicast streaming).
> 
> In OpenWRT/LEDE the IGMP/MLD report suppression issue is overcome by
> the network daemon enabling AP isolation and by that separating all STAs.
> Delivery of STA-to-STA IP mulitcast is made possible again by
> enabling and utilizing the bridge hairpin mode, which considers the
> incoming port as a potential outgoing port, too.
> 
> Hairpin-mode is performed after multicast snooping, therefore leading to
> only deliver reports to STAs running a multicast router.
> 
> Changes in v4:
> * readd "From: Felix Fietkau [...]" (missed it again in v3)
> 
> Changes in v3:
> * fix an uninitialized variable bug introduced in br_multicast_flood()
>   in v2, found by kbuild test bot
> 
> Changes in v2:
> * netlink support (thanks Nik!)
> * fixed switching between multicast_to_unicast on/off
>   -> even after toggling an already existing entry would
>      stale in its mode and would never be replaced
>   -> new extra check in br_port_group_equal)
> * reduced checks in br_multicast_flood() from two to one
>   to address fast-path concerns (thanks Nik!)
> * rev-christmas tree ordering (thanks Nik!)
> * removed "net_bridge_port_group::unicast", using
>   ::flags instead (thanks Nik!)
> * BR_MULTICAST_TO_UCAST -> BR_MULTICAST_TO_UNICAST
>   (BR_MULTICAST_FLAST_LEAVE has the same length anyway)
> * simplified maybe_deliver_addr()
>   (no return, no "prev" paramater -> was a NOP anyway)
> * added "From: Felix Fietkau [...]"
> * added "Signed-off-by: Felix Fietkau [...]"
> ---
>  include/linux/if_bridge.h    |  1 +
>  include/uapi/linux/if_link.h |  1 +
>  net/bridge/br_forward.c      | 37 ++++++++++++++++-
>  net/bridge/br_mdb.c          |  2 +-
>  net/bridge/br_multicast.c    | 96 ++++++++++++++++++++++++++++++++------------
>  net/bridge/br_netlink.c      |  5 +++
>  net/bridge/br_private.h      |  8 ++--
>  net/bridge/br_sysfs_if.c     |  2 +
>  8 files changed, 121 insertions(+), 31 deletions(-)
> 

Looks good to me,
Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>


