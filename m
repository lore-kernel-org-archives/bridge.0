Return-Path: <davem@davemloft.net>
Date: Tue, 27 Nov 2018 15:04:33 -0800 (PST)
Message-Id: <20181127.150433.1840968917758138562.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181124023422.13908-1-nikolay@cumulusnetworks.com>
References: <20181124023422.13908-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 0/3] net: bridge: add an option to
 disabe linklocal learning
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, andrew@lunn.ch

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Sat, 24 Nov 2018 04:34:19 +0200

> This set adds a new bridge option which can control learning from
> link-local packets, by default learning is on to be consistent and avoid
> breaking users expectations. If the new no_linklocal_learn option is
> enabled then the bridge will stop learning from link-local packets.
> 
> In order to save space for future boolean options, patch 01 adds a new
> bool option API that uses a bitmask to control boolean options. The
> bridge is by far the largest netlink attr user and we keep adding simple
> boolean options which waste nl attr ids and space. We're not directly
> mapping these to the in-kernel bridge flags because some might require
> more complex configuration changes (e.g. if we were to add the per port
> vlan stats now, it'd require multiple checks before changing value).
> Any new bool option needs to be handled by both br_boolopt_toggle and get
> in order to be able to retrieve its state later. All such options are
> automatically exported via netlink. The behaviour of setting such
> options is consistent with netlink option handling when a missing
> option is being set (silently ignored), e.g. when a newer iproute2 is used
> on older kernel. All supported options are exported via bm's optmask
> when dumping the new attribute.
> 
> v2: address Andrew Lunn's comments, squash a minor change into patch 01,
>     export all supported options via optmask when dumping, add patch 03,
>     pass down extack so options can return meaningful errors, add
>     WARN_ON on unsupported options (should not happen)

Series applied, thanks Nikolay.
