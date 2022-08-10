Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12771416BA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 99093410DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=r4FpLYfUs7tX4DLeiy0sj/1t8j21OoA6g793iTCGiF8=;
 b=MuyQbiTUTET9fzrBqJrVL6Ql0nSXUtWfMkTeV0mBDzSdpEipm6LSkDAk2TRRbHhcFY
 wVXtGIvSLp1zX+ayyhX9X9Vs+G2gYlKwvu7a0380tbAKcuP1OMT0qzWuHj78nZ6s+5MV
 t7/FErcC+guIKzh+XsumAfNKFOBs5o98HzCcm86P6Pb7sPlqjHuwEAFyORUJ/mWGU2Q4
 tMlLXdYAJp+1RoMLB7y3vb09dzb4EQ8j1WhNkiMxxY35xsjpbBAxJEJn1GI8y/2KAxrJ
 1lmT/LXOZ1+yOgsNG4F02V5uDcBUPxy4GJFG4mXV4sXABfGskmeZY1ccjVG3XET/SiJP
 TJLw==
Message-ID: <49f933c3-7430-a133-9add-ed76c395023b@blackwall.org>
Date: Wed, 10 Aug 2022 17:50:34 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1660100506.git.sevinj.aghayeva@gmail.com>
 <94ec6182-0804-7a0e-dcba-42655ff19884@blackwall.org>
 <CAMWRUK45nbZS3PeSLR1X=Ko6oavrjKj2AWeh2F1wckMPrz_dEg@mail.gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CAMWRUK45nbZS3PeSLR1X=Ko6oavrjKj2AWeh2F1wckMPrz_dEg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH RFC net-next 0/3] net: vlan: fix bridge binding
 behavior and add selftests
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Cc: aroulin@nvidia.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, sbrivio@redhat.com, Eric Dumazet <edumazet@google.com>, roopa@nvidia.com, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On 10/08/2022 17:42, Sevinj Aghayeva wrote:
> 
> 
> On Wed, Aug 10, 2022 at 4:54 AM Nikolay Aleksandrov <razor@blackwall.org <mailto:razor@blackwall.org>> wrote:
> 
>     On 10/08/2022 06:11, Sevinj Aghayeva wrote:
>     > When bridge binding is enabled for a vlan interface, it is expected
>     > that the link state of the vlan interface will track the subset of the
>     > ports that are also members of the corresponding vlan, rather than
>     > that of all ports.
>     >
>     > Currently, this feature works as expected when a vlan interface is
>     > created with bridge binding enabled:
>     >
>     >   ip link add link br name vlan10 type vlan id 10 protocol 802.1q \
>     >         bridge_binding on
>     >
>     > However, the feature does not work when a vlan interface is created
>     > with bridge binding disabled, and then enabled later:
>     >
>     >   ip link add link br name vlan10 type vlan id 10 protocol 802.1q \
>     >         bridge_binding off
>     >   ip link set vlan10 type vlan bridge_binding on
>     >
>     > After these two commands, the link state of the vlan interface
>     > continues to track that of all ports, which is inconsistent and
>     > confusing to users. This series fixes this bug and introduces two
>     > tests for the valid behavior.
>     >
>     > Sevinj Aghayeva (3):
>     >   net: core: export call_netdevice_notifiers_info
>     >   net: 8021q: fix bridge binding behavior for vlan interfaces
>     >   selftests: net: tests for bridge binding behavior
>     >
>     >  include/linux/netdevice.h                     |   2 +
>     >  net/8021q/vlan.h                              |   2 +-
>     >  net/8021q/vlan_dev.c                          |  25 ++-
>     >  net/core/dev.c                                |   7 +-
>     >  tools/testing/selftests/net/Makefile          |   1 +
>     >  .../selftests/net/bridge_vlan_binding_test.sh | 143 ++++++++++++++++++
>     >  6 files changed, 172 insertions(+), 8 deletions(-)
>     >  create mode 100755 tools/testing/selftests/net/bridge_vlan_binding_test.sh
>     >
> 
>     Hi,
>     NETDEV_CHANGE event is already propagated when the vlan changes flags,
> 
> 
> I'm not sure if NETDEV_CHANGE is actually propagated when the vlan changes flags. The two functions in the bridge module that handle NETDEV_CHANGE are br_vlan_port_event  and br_vlan_bridge_event. I've installed probes for both, and when I'm changing flags using "sudo ip link set vlan10 type vlan bridge_binding on", I don't see any of those functions getting called, although I do see vlan_dev_change_flags getting called. I think there may be a bug in core/dev.c:__dev_notify_flags.

are both vlan and bridge interfaces up?
what exactly are you probing for?

I can see the NETDEV_CHANGE event go through when changing the loose binding.




