Return-Path: <sevinj.aghayeva@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE2C9832DC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E0980831F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lx39+48xs+QrEXdefGJWcbwB1k+hspd/NoATXGR9qyI=;
 b=fQs7W0idr3E+3WnRUded1LPamtZKuryRCbirEjzF53u4oNcwPnOdogFKZgwQ7qg6NG
 08QY1rjL0vxaz8VFy8CE02TvEcivR5iGGhpmWfSbsMaMbn0tHA0r/I0vRBPD7xbtpOeD
 m5vnXXrVFqdh2PhurvMneZKfdWKmpWQOzyj1WyHsKTW0sD2J418llMShs9bed0+AAKDY
 +UvBwo8knJjVWV37oijcua2rUkNyn2oH1yPaQ71142PJFx1gxdi6isXJ39btgaZNmalb
 ukdU/sqkwznO5Z6rYrXmFFYFqQgMxPxXI4ROSU7T1bogsUAWtIzQeEAJk5pciUyWs9po
 P2gg==
MIME-Version: 1.0
References: <cover.1659195179.git.sevinj.aghayeva@gmail.com>
 <f7ede054-f0b3-558a-091f-04b4f7139564@blackwall.org>
 <CAMWRUK5j4UAwjw4UGN=SVbbDbut0zWg5e03wupAXCPwT8K8zzQ@mail.gmail.com>
In-Reply-To: <CAMWRUK5j4UAwjw4UGN=SVbbDbut0zWg5e03wupAXCPwT8K8zzQ@mail.gmail.com>
From: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date: Sat, 30 Jul 2022 12:48:08 -0400
Message-ID: <CAMWRUK5TZ5iZWZJO7Bbn-b43ZbT7mRzUDr4LdseLCne8qvG6pw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH net-next 0/3] net: vlan: fix bridge binding
 behavior and add selftests
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: aroulin@nvidia.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, sbrivio@redhat.com, Eric Dumazet <edumazet@google.com>, roopa@nvidia.com, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

(Resending this because the first email was rejected due to being in HTML.)


On Sat, Jul 30, 2022 at 12:46 PM Sevinj Aghayeva
<sevinj.aghayeva@gmail.com> wrote:
>
>
>
> On Sat, Jul 30, 2022 at 12:22 PM Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>
>> On 7/30/22 19:03, Sevinj Aghayeva wrote:
>> > When bridge binding is enabled for a vlan interface, it is expected
>> > that the link state of the vlan interface will track the subset of the
>> > ports that are also members of the corresponding vlan, rather than
>> > that of all ports.
>> >
>> > Currently, this feature works as expected when a vlan interface is
>> > created with bridge binding enabled:
>> >
>> >    ip link add link br name vlan10 type vlan id 10 protocol 802.1q \
>> >          bridge_binding on
>> >
>> > However, the feature does not work when a vlan interface is created
>> > with bridge binding disabled, and then enabled later:
>> >
>> >    ip link add link br name vlan10 type vlan id 10 protocol 802.1q \
>> >          bridge_binding off
>> >    ip link set vlan10 type vlan bridge_binding on
>> >
>> > After these two commands, the link state of the vlan interface
>> > continues to track that of all ports, which is inconsistent and
>> > confusing to users. This series fixes this bug and introduces two
>> > tests for the valid behavior.
>> >
>> > Sevinj Aghayeva (3):
>> >    net: bridge: export br_vlan_upper_change
>> >    net: 8021q: fix bridge binding behavior for vlan interfaces
>> >    selftests: net: tests for bridge binding behavior
>> >
>> >   include/linux/if_bridge.h                     |   9 ++
>> >   net/8021q/vlan.h                              |   2 +-
>> >   net/8021q/vlan_dev.c                          |  21 ++-
>> >   net/bridge/br_vlan.c                          |   7 +-
>> >   tools/testing/selftests/net/Makefile          |   1 +
>> >   .../selftests/net/bridge_vlan_binding_test.sh | 143 ++++++++++++++++++
>> >   6 files changed, 176 insertions(+), 7 deletions(-)
>> >   create mode 100755 tools/testing/selftests/net/bridge_vlan_binding_test.sh
>> >
>>
>> Hmm.. I don't like this and don't think this bridge function should be
>> exported at all.
>>
>> Calling bridge state changing functions from 8021q module is not the
>> proper way to solve this. The problem is that the bridge doesn't know
>> that the state has changed, so you can process NETDEV_CHANGE events and
>> check for the bridge vlan which got its state changed and react based on
>> it. I haven't checked in detail, but I think it should be doable. So all
>> the logic is kept inside the bridge.
>
>
> Hi Nik,
>
> Can please elaborate on where I should process NETDEV_CHANGE events? I'm doing this as part of outreachy project and this is my first kernel task, so I don't know the bridging code that well.
>
> Thanks!
>
>>
>>
>> Cheers,
>>   Nik
>
>
>
> --
>
> Sevinj.Aghayeva



-- 

Sevinj.Aghayeva
