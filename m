Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version:organization
 :content-transfer-encoding;
 bh=7QqLZbURjfzrJmew4Nev3nfIU835eXeMgxWsq8ycOmk=;
 b=8NOmVFFzzhW84LcTC8FUSG7v+xkhO1kmFLtdiXP71jkAj/ZqJjSumEtDVTX43BmOxN
 Qiuxy7Y8e7uThI96MQmYQeVxylr28Onc0ULrJcMg1srI1t5FiYEcO1nCo4j+zRsNPkzw
 xu13xWXrf1lVSJ3xNCq+19EyabVMb+kUBZNP1NlKaoU7pnNeYcctoAlEyskwjV0KT25Z
 M9/QdiICoj4Lr9oMUyeDyiocsSX9/fb16XcVLsghcCKiktSp0wlNVr4pPTtNJJwiLy5f
 BzsGA4sV3wXnIous6TulReojV7EU78ynNCLM/NMHpDHY68p6M39hRQGOZqnaEwfT7BY7
 zG2Q==
From: Tobias Waldekranz <tobias@waldekranz.com>
Date: Wed, 16 Feb 2022 14:29:25 +0100
Message-Id: <20220216132934.1775649-1-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [RFC net-next 0/9] net: bridge: vlan: Multiple Spanning
	Trees
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

The bridge has had per-VLAN STP support for a while now, since:

https://lore.kernel.org/netdev/20200124114022.10883-1-nikolay@cumulusnetworks.com/

The current implementation has some problems:

- The mapping from VLAN to STP state is fixed as 1:1, i.e. each VLAN
  is managed independently. This is awkward from an MSTP (802.1Q-2018,
  Clause 13.5) point of view, where the model is that multiple VLANs
  are grouped into MST instances.

  Because of the way that the standard is written, presumably, this is
  also reflected in hardware implementations. It is not uncommon for a
  switch to support the full 4k range of VIDs, but that the pool of
  MST instances is much smaller. Some examples:

  Marvell LinkStreet (mv88e6xxx): 4k VLANs, but only 64 MSTIs
  Marvell Prestera: 4k VLANs, but only 128 MSTIs
  Microchip SparX-5i: 4k VLANs, but only 128 MSTIs

- By default, the feature is enabled, and there is no way to disable
  it. This makes it hard to add offloading in a backwards compatible
  way, since any underlying switchdevs have no way to refuse the
  function if the hardware does not support it

- The port-global STP state has precedence over per-VLAN states. In
  MSTP, as far as I understand it, all VLANs will use the common
  spanning tree (CST) by default - through traffic engineering you can
  then optimize your network to group subsets of VLANs to use
  different trees (MSTI). To my understanding, the way this is
  typically managed in silicon is roughly:

  Incoming packet:
  .----.----.--------------.----.-------------
  | DA | SA | 802.1Q VID=X | ET | Payload ...
  '----'----'--------------'----'-------------
                        |
                        '->|\     .----------------------------.
                           | +--> | VID | Members | ... | MSTI |
                   PVID -->|/     |-----|---------|-----|------|
                                  |   1 | 0001001 | ... |    0 |
                                  |   2 | 0001010 | ... |   10 |
                                  |   3 | 0001100 | ... |   10 |
                                  '----------------------------'
                                                             |
                               .-----------------------------'
                               |  .------------------------.
                               '->| MSTI | Fwding | Lrning |
                                  |------|--------|--------|
                                  |    0 | 111110 | 111110 |
                                  |   10 | 110111 | 110111 |
                                  '------------------------'

  What this is trying to show is that the STP state (whether MSTP is
  used, or ye olde STP) is always accessed via the VLAN table. If STP
  is running, all MSTI pointers in that table will reference the same
  index in the STP stable - if MSTP is running, some VLANs may point
  to other trees (like in this example).

  The fact that in the Linux bridge, the global state (think: index 0
  in most hardware implementations) is supposed to override the
  per-VLAN state, is very awkward to offload. In effect, this means
  that when the global state changes to blocking, drivers will have to
  iterate over all MSTIs in use, and alter them all to match. This
  also means that you have to cache whether the hardware state is
  currently tracking the global state or the per-VLAN state. In the
  first case, you also have to cache the per-VLAN state so that you
  can restore it if the global state transitions back to forwarding.

This series adds support for an arbitrary M:N mapping of VIDs to
MSTIs, proposing one solution to the first issue. An example of an
offload implementation for mv88e6xxx is also provided. Offloading is
done on a best-effort basis, i.e. notifications of the relevant events
are generated, but there is no way for the user to see whether the
per-VLAN state has been offloaded or not. There is also no handling of
the relationship between the port-global state the the per-VLAN ditto.

If I was king of net/bridge/*, I would make the following additional
changes:

- By default, when a VLAN is created, assign it to MSTID 0, which
  would mean that no per-VLAN state is used and that packets belonging
  to this VLAN should be filtered according to the port-global state.

  This way, when a VLAN is configured to use a separate tree (setting
  a non-zero MSTID), an underlying switchdev could oppose it if it is
  not supported.

  Obviously, this adds an extra step for existing users of per-VLAN
  STP states and would thus not be backwards compatible. Maybe this
  means that that is impossible to do, maybe not.

- Swap the precedence of the port-global and the per-VLAN state,
  i.e. the port-global state only applies to packets belonging to
  VLANs that does not make use of a per-VLAN state (MSTID != 0).

  This would make the offloading much more natural, as you avoid all
  of the caching stuff described above.

  Again, this changes the behavior of the kernel so it is not
  backwards compatible. I suspect that this is less of an issue
  though, since my guess is that very few people rely on the old
  behavior.

Thoughts?

Tobias Waldekranz (9):
  net: bridge: vlan: Introduce multiple spanning trees (MST)
  net: bridge: vlan: Allow multiple VLANs to be mapped to a single MST
  net: bridge: vlan: Notify switchdev drivers of VLAN MST migrations
  net: bridge: vlan: Notify switchdev drivers of MST state changes
  net: dsa: Pass VLAN MST migration notifications to driver
  net: dsa: Pass MST state changes to driver
  net: dsa: mv88e6xxx: Disentangle STU from VTU
  net: dsa: mv88e6xxx: Export STU as devlink region
  net: dsa: mv88e6xxx: MST Offloading

 drivers/net/dsa/mv88e6xxx/chip.c        | 223 +++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h        |  38 +++
 drivers/net/dsa/mv88e6xxx/devlink.c     |  94 +++++++
 drivers/net/dsa/mv88e6xxx/global1.h     |  10 +
 drivers/net/dsa/mv88e6xxx/global1_vtu.c | 311 ++++++++++++++----------
 include/linux/if_bridge.h               |   6 +
 include/net/dsa.h                       |   5 +
 include/net/switchdev.h                 |  17 ++
 include/uapi/linux/if_bridge.h          |   1 +
 net/bridge/br_private.h                 |  44 +++-
 net/bridge/br_vlan.c                    | 249 ++++++++++++++++++-
 net/bridge/br_vlan_options.c            |  48 +++-
 net/dsa/dsa_priv.h                      |   3 +
 net/dsa/port.c                          |  40 +++
 net/dsa/slave.c                         |  12 +
 15 files changed, 941 insertions(+), 160 deletions(-)

-- 
2.25.1

