Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=ioWEXzquDWHeeiOk5WANDAY/UZxcw0vNdnj9B/3BeGo=;
 b=wr0i6WMsc5NWB3lT4XIYdpN/T5oViy8jhC4Qq7OKe5yVPedC/bYw/k+uEswkOh9v0x
 pjvsaTnbVZ7pF/BvztJniNmJGMciCT4MRWLt1FvV8WjCig/o1tWuHfMuRLPtTy/1wqEK
 NXbfqGB1Jht6f7v5IVU+iEUY7qOhDreTXPJbk/nWq1RgVD6Gd2/WccraK1WiWAfNl/q/
 BhBGxR51HX1fzFNOVGrsZ2Y2aB1vqMMnLyYmlBdr42LASGLxkddTIv6Fo5P78Svkxsr2
 9a0PE2Fu9Ed2M/2FhWoUe/ElqJF4ZOY0xUdgpUWSuozSHjFATLQWHPpTzkgc/NL6MWaL
 tt4g==
Message-ID: <610eb6cc-4df4-f0fc-462a-b33145334a12@blackwall.org>
Date: Thu, 17 Mar 2022 11:00:37 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220316150857.2442916-1-tobias@waldekranz.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220316150857.2442916-1-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v5 net-next 00/15] net: bridge: Multiple
	Spanning Trees
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, Matt Johnston <matt@codeconstruct.com.au>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

On 16/03/2022 17:08, Tobias Waldekranz wrote:
> The bridge has had per-VLAN STP support for a while now, since:
> 
> https://lore.kernel.org/netdev/20200124114022.10883-1-nikolay@cumulusnetworks.com/
> 
> The current implementation has some problems:
> 
> - The mapping from VLAN to STP state is fixed as 1:1, i.e. each VLAN
>   is managed independently. This is awkward from an MSTP (802.1Q-2018,
>   Clause 13.5) point of view, where the model is that multiple VLANs
>   are grouped into MST instances.
> 
>   Because of the way that the standard is written, presumably, this is
>   also reflected in hardware implementations. It is not uncommon for a
>   switch to support the full 4k range of VIDs, but that the pool of
>   MST instances is much smaller. Some examples:
> 
>   Marvell LinkStreet (mv88e6xxx): 4k VLANs, but only 64 MSTIs
>   Marvell Prestera: 4k VLANs, but only 128 MSTIs
>   Microchip SparX-5i: 4k VLANs, but only 128 MSTIs
> 
> - By default, the feature is enabled, and there is no way to disable
>   it. This makes it hard to add offloading in a backwards compatible
>   way, since any underlying switchdevs have no way to refuse the
>   function if the hardware does not support it
> 
> - The port-global STP state has precedence over per-VLAN states. In
>   MSTP, as far as I understand it, all VLANs will use the common
>   spanning tree (CST) by default - through traffic engineering you can
>   then optimize your network to group subsets of VLANs to use
>   different trees (MSTI). To my understanding, the way this is
>   typically managed in silicon is roughly:
> 
>   Incoming packet:
>   .----.----.--------------.----.-------------
>   | DA | SA | 802.1Q VID=X | ET | Payload ...
>   '----'----'--------------'----'-------------
>                         |
>                         '->|\     .----------------------------.
>                            | +--> | VID | Members | ... | MSTI |
>                    PVID -->|/     |-----|---------|-----|------|
>                                   |   1 | 0001001 | ... |    0 |
>                                   |   2 | 0001010 | ... |   10 |
>                                   |   3 | 0001100 | ... |   10 |
>                                   '----------------------------'
>                                                              |
>                                .-----------------------------'
>                                |  .------------------------.
>                                '->| MSTI | Fwding | Lrning |
>                                   |------|--------|--------|
>                                   |    0 | 111110 | 111110 |
>                                   |   10 | 110111 | 110111 |
>                                   '------------------------'
> 
>   What this is trying to show is that the STP state (whether MSTP is
>   used, or ye olde STP) is always accessed via the VLAN table. If STP
>   is running, all MSTI pointers in that table will reference the same
>   index in the STP stable - if MSTP is running, some VLANs may point
>   to other trees (like in this example).
> 
>   The fact that in the Linux bridge, the global state (think: index 0
>   in most hardware implementations) is supposed to override the
>   per-VLAN state, is very awkward to offload. In effect, this means
>   that when the global state changes to blocking, drivers will have to
>   iterate over all MSTIs in use, and alter them all to match. This
>   also means that you have to cache whether the hardware state is
>   currently tracking the global state or the per-VLAN state. In the
>   first case, you also have to cache the per-VLAN state so that you
>   can restore it if the global state transitions back to forwarding.
> 
> This series adds a new mst_enable bridge setting (as suggested by Nik)
> that can only be changed when no VLANs are configured on the
> bridge. Enabling this mode has the following effect:
> 
> - The port-global STP state is used to represent the CST (Common
>   Spanning Tree) (1/15)
> 
> - Ingress STP filtering is deferred until the frame's VLAN has been
>   resolved (1/15)
> 
> - The preexisting per-VLAN states can no longer be controlled directly
>   (1/15). They are instead placed under the MST module's control,
>   which is managed using a new netlink interface (described in 3/15)
> 
> - VLANs can br mapped to MSTIs in an arbitrary M:N fashion, using a
>   new global VLAN option (2/15)
> 
> Switchdev notifications are added so that a driver can track:
> - MST enabled state
> - VID to MSTI mappings
> - MST port states
> 
> An offloading implementation is this provided for mv88e6xxx.
> 
> A proposal for the corresponding iproute2 interface is available here:
> 
> https://github.com/wkz/iproute2/tree/mst
> 

Hi Tobias,
One major missing thing is the selftests for this new feature. Do you
have a plan to upstream them?

Cheers,
 Nik
