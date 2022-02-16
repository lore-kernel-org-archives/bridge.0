Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ew1arzHTuKB2Dk0aDjj9WdWXGJ7HDJOPRSZGhhw+UgM=;
 b=KqMdGUOGGiLUwCuPsgAg8bWqkE4cz37WcPsCEPH8GjjOWK9upcCS9iV3EfOpGsxYdfmk8nUV2QxO0JMy83v6NVxJd1QKkYKjJr1ZMACl9Gy4eV3S8FWGS5nsLn4r2U9lY6+qmANIyA0+/YuRf+VrfOoSn3lOvIeW45Ej7uUNxq3nujLeDMEtbcD7AwkyAayTaxPN9lV4zXygfs3F2uMw/Q92JxgPwKuEPqFYRODW90Ti1yqRo1NaLNcvzswrGMFtt8q0qeTmG9b5Zu5m5/wKIwp6ByxxMAi+7LtmMc+gJkWhNHKzs2sbYlxVVBo+L8kifs9LGGczWCpp5xoA6PjGLA==
Message-ID: <d59ee33c-79f9-2622-cec2-987a35f4ec1e@nvidia.com>
Date: Wed, 16 Feb 2022 17:28:58 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220216132934.1775649-1-tobias@waldekranz.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <20220216132934.1775649-1-tobias@waldekranz.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC net-next 0/9] net: bridge: vlan: Multiple
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
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

On 16/02/2022 15:29, Tobias Waldekranz wrote:
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
> This series adds support for an arbitrary M:N mapping of VIDs to
> MSTIs, proposing one solution to the first issue. An example of an
> offload implementation for mv88e6xxx is also provided. Offloading is
> done on a best-effort basis, i.e. notifications of the relevant events
> are generated, but there is no way for the user to see whether the
> per-VLAN state has been offloaded or not. There is also no handling of
> the relationship between the port-global state the the per-VLAN ditto.
> 
> If I was king of net/bridge/*, I would make the following additional
> changes:
> 
> - By default, when a VLAN is created, assign it to MSTID 0, which
>   would mean that no per-VLAN state is used and that packets belonging
>   to this VLAN should be filtered according to the port-global state.
> 
>   This way, when a VLAN is configured to use a separate tree (setting
>   a non-zero MSTID), an underlying switchdev could oppose it if it is
>   not supported.
> 
>   Obviously, this adds an extra step for existing users of per-VLAN
>   STP states and would thus not be backwards compatible. Maybe this
>   means that that is impossible to do, maybe not.
> 
> - Swap the precedence of the port-global and the per-VLAN state,
>   i.e. the port-global state only applies to packets belonging to
>   VLANs that does not make use of a per-VLAN state (MSTID != 0).
> 
>   This would make the offloading much more natural, as you avoid all
>   of the caching stuff described above.
> 
>   Again, this changes the behavior of the kernel so it is not
>   backwards compatible. I suspect that this is less of an issue
>   though, since my guess is that very few people rely on the old
>   behavior.
> 
> Thoughts?
> 

Interesting! Would adding a new (e.g. vlan_mst_enable) option which changes the behaviour
as described help? It can require that there are no vlans present to change 
similar to the per-port vlan stats option. Also based on that option you can alter
how the state checks are performed. For example, you can skip the initial port state
check, then in br_vlan_allowed_ingress() you can use the port state if vlan filtering
is disabled and mst enabled and you can avoid checking it altogether if filter && mst
are enabled then always use the vlan mst state. Similar changes would have to happen
for the egress path. Since we are talking about multiple tests the new MST logic can
be hidden behind a static key for both br_handle_frame() and later stages.

This set needs to read a new cache line to fetch mst ptr for all packets in the vlan fast-path,
that is definitely undesirable. Please either cache that state in the vlan and update it when
something changes, or think of some way which avoids that cache line in fast-path.
Alternative would be to make that cache line dependent on the new option, so it's needed
only when mst feature is enabled.

There are other options, but they way more invasive.. I'll think about it more.

Cheers,
 Nik
