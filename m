Return-Path: <roopa@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5122383139
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B29AB83133
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YgmbH5KE5e9qKEnqQ30NYf3rYr8hEa0TLzm7/pBtKo=;
 b=pvTmxd79caN2M3SXXrbHsZmyR1SEvg56OWspn3m4arEPeTTqmXJbfofrjVC9g97tN6eDCW4woEAiHzhs7p1m1403stvGNpMevlBQSWzxY3FI+yb2lJY2pVvXboPyJ+e3uRFPuYdwgLRDLILmcDJ61PVtEz3YjM/wF0FnMxO7p4GMfu8y55ZUylkuiIevHjMbDljN5td2i0iNl9YIM/RLJ+LNpsLtB+BGgNIgJAq+TCpvK53RK2JU+K4DwZ/Tve3/YWJI0rInkC87TSXg23EeVTa0McWi/UbG+4qk/mtGsvXU7yq8aeJiemrFgK5bfp8cmAFwOB6lfyI8w8ka3rZMMQ==
Message-ID: <8e0a0ceb-5816-60a6-6219-7306e75ce006@nvidia.com>
Date: Sat, 30 Jul 2022 18:54:52 -0700
Content-Language: en-US
References: <cover.1659195179.git.sevinj.aghayeva@gmail.com>
 <f7ede054-f0b3-558a-091f-04b4f7139564@blackwall.org>
 <CAMWRUK5j4UAwjw4UGN=SVbbDbut0zWg5e03wupAXCPwT8K8zzQ@mail.gmail.com>
 <CAMWRUK5TZ5iZWZJO7Bbn-b43ZbT7mRzUDr4LdseLCne8qvG6pw@mail.gmail.com>
From: Roopa Prabhu <roopa@nvidia.com>
In-Reply-To: <CAMWRUK5TZ5iZWZJO7Bbn-b43ZbT7mRzUDr4LdseLCne8qvG6pw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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
To: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: aroulin@nvidia.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, sbrivio@redhat.com, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>


On 7/30/22 09:48, Sevinj Aghayeva wrote:
> (Resending this because the first email was rejected due to being in HTML.)
>
>
> On Sat, Jul 30, 2022 at 12:46 PM Sevinj Aghayeva
> <sevinj.aghayeva@gmail.com> wrote:
>>
>>
>> On Sat, Jul 30, 2022 at 12:22 PM Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>> On 7/30/22 19:03, Sevinj Aghayeva wrote:
>>>> When bridge binding is enabled for a vlan interface, it is expected
>>>> that the link state of the vlan interface will track the subset of the
>>>> ports that are also members of the corresponding vlan, rather than
>>>> that of all ports.
>>>>
>>>> Currently, this feature works as expected when a vlan interface is
>>>> created with bridge binding enabled:
>>>>
>>>>     ip link add link br name vlan10 type vlan id 10 protocol 802.1q \
>>>>           bridge_binding on
>>>>
>>>> However, the feature does not work when a vlan interface is created
>>>> with bridge binding disabled, and then enabled later:
>>>>
>>>>     ip link add link br name vlan10 type vlan id 10 protocol 802.1q \
>>>>           bridge_binding off
>>>>     ip link set vlan10 type vlan bridge_binding on
>>>>
>>>> After these two commands, the link state of the vlan interface
>>>> continues to track that of all ports, which is inconsistent and
>>>> confusing to users. This series fixes this bug and introduces two
>>>> tests for the valid behavior.
>>>>
>>>> Sevinj Aghayeva (3):
>>>>     net: bridge: export br_vlan_upper_change
>>>>     net: 8021q: fix bridge binding behavior for vlan interfaces
>>>>     selftests: net: tests for bridge binding behavior
>>>>
>>>>    include/linux/if_bridge.h                     |   9 ++
>>>>    net/8021q/vlan.h                              |   2 +-
>>>>    net/8021q/vlan_dev.c                          |  21 ++-
>>>>    net/bridge/br_vlan.c                          |   7 +-
>>>>    tools/testing/selftests/net/Makefile          |   1 +
>>>>    .../selftests/net/bridge_vlan_binding_test.sh | 143 ++++++++++++++++++
>>>>    6 files changed, 176 insertions(+), 7 deletions(-)
>>>>    create mode 100755 tools/testing/selftests/net/bridge_vlan_binding_test.sh
>>>>
>>> Hmm.. I don't like this and don't think this bridge function should be
>>> exported at all.
>>>
>>> Calling bridge state changing functions from 8021q module is not the
>>> proper way to solve this. The problem is that the bridge doesn't know
>>> that the state has changed, so you can process NETDEV_CHANGE events and
>>> check for the bridge vlan which got its state changed and react based on
>>> it. I haven't checked in detail, but I think it should be doable. So all
>>> the logic is kept inside the bridge.
>>
>> Hi Nik,
>>
>> Can please elaborate on where I should process NETDEV_CHANGE events? I'm doing this as part of outreachy project and this is my first kernel task, so I don't know the bridging code that well.
>>
>> Thanks!

good point Nikolay.

Sevinj, see br_vlan_bridge_event and __vlan_device_event  for how both 
drivers react to netdev change events.

I have not looked at it in detail yet, but lets explore and discuss if 
we can make use of events to achieve same results.

