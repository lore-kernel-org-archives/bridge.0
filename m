Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DB60A83E47
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C41C783E1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=HK82LSxIMPc36pF31OFj9tkttn9EAAbGZ7Ls5L+6umc=;
 b=gNGJcUbZZ65YkBC2hD+Vb1sGsl6fdD/kKhe/eV3iUZnQVC5QubgMwVcmK38rnLso+r
 /d27g2Lp6lCH+1bgtmH+dWcGNJqKXLMxnE6Ee2eRx8zEwG991/N6UuL3fsXHwF85fv6a
 sanAV2Gxmx5Jiib75buiGJD7HC0T4ZUrNRQfTL7msoK/2bW+os+DfSLLoKwaJTZ8Xoio
 0lINQ1y0RV7LdkoG2bf91yikIlNUNlJ+ag61oe1ofG9iHXaFrpObPwgJ1U/hNSYP5xIb
 Jla8rEwZOu/2RipliAJyRbbeFoOH0McXzYbFC+MkVF6xqpw/pWf91MWrcf8s7yCLigRw
 4RxA==
Message-ID: <46deef15-a67b-91ad-bc47-1b1306d1d654@blackwall.org>
Date: Thu, 18 Aug 2022 15:00:22 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1660100506.git.sevinj.aghayeva@gmail.com>
 <94ec6182-0804-7a0e-dcba-42655ff19884@blackwall.org>
 <CAMWRUK4Mo2KHfa-6Z4Ka+ZLx8TtmzSvq9CLmMmEwE5S7Yp7-Kw@mail.gmail.com>
 <34228958-081d-52b5-f363-d2df6ecf251d@blackwall.org>
 <CAMWRUK43+NG63J2YCiKijREjUg5zjii=_2knN6ZCL6PHMP3q8w@mail.gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CAMWRUK43+NG63J2YCiKijREjUg5zjii=_2knN6ZCL6PHMP3q8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 18/08/2022 14:50, Sevinj Aghayeva wrote:
> On Sun, Aug 14, 2022 at 3:38 AM Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>
>> On 12/08/2022 18:30, Sevinj Aghayeva wrote:
>>> On Wed, Aug 10, 2022 at 4:54 AM Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>>>
>>>> On 10/08/2022 06:11, Sevinj Aghayeva wrote:
>>>>> When bridge binding is enabled for a vlan interface, it is expected
>>>>> that the link state of the vlan interface will track the subset of the
>>>>> ports that are also members of the corresponding vlan, rather than
>>>>> that of all ports.
>>>>>
>>>>> Currently, this feature works as expected when a vlan interface is
>>>>> created with bridge binding enabled:
>>>>>
>>>>>   ip link add link br name vlan10 type vlan id 10 protocol 802.1q \
>>>>>         bridge_binding on
>>>>>
>>>>> However, the feature does not work when a vlan interface is created
>>>>> with bridge binding disabled, and then enabled later:
>>>>>
>>>>>   ip link add link br name vlan10 type vlan id 10 protocol 802.1q \
>>>>>         bridge_binding off
>>>>>   ip link set vlan10 type vlan bridge_binding on
>>>>>
>>>>> After these two commands, the link state of the vlan interface
>>>>> continues to track that of all ports, which is inconsistent and
>>>>> confusing to users. This series fixes this bug and introduces two
>>>>> tests for the valid behavior.
>>>>>
>>>>> Sevinj Aghayeva (3):
>>>>>   net: core: export call_netdevice_notifiers_info
>>>>>   net: 8021q: fix bridge binding behavior for vlan interfaces
>>>>>   selftests: net: tests for bridge binding behavior
>>>>>
>>>>>  include/linux/netdevice.h                     |   2 +
>>>>>  net/8021q/vlan.h                              |   2 +-
>>>>>  net/8021q/vlan_dev.c                          |  25 ++-
>>>>>  net/core/dev.c                                |   7 +-
>>>>>  tools/testing/selftests/net/Makefile          |   1 +
>>>>>  .../selftests/net/bridge_vlan_binding_test.sh | 143 ++++++++++++++++++
>>>>>  6 files changed, 172 insertions(+), 8 deletions(-)
>>>>>  create mode 100755 tools/testing/selftests/net/bridge_vlan_binding_test.sh
>>>>>
>>>>
>>>> Hi,
>>>> NETDEV_CHANGE event is already propagated when the vlan changes flags,
>>>> NETDEV_CHANGEUPPER is used when the devices' relationship changes not their flags.
>>>> The only problem you have to figure out is that the flag has changed. The fix itself
>>>> must be done within the bridge, not 8021q. You can figure it out based on current bridge
>>>> loose binding state and the vlan's changed state, again in the bridge's NETDEV_CHANGE
>>>> handler. Unfortunately the proper fix is much more involved and will need new
>>>> infra, you'll have to track the loose binding vlans in the bridge. To do that you should
>>>> add logic that reflects the current vlans' loose binding state *only* for vlans that also
>>>> exist in the bridge, the rest which are upper should be carrier off if they have the loose
>>>> binding flag set.
>>>>
>>>> Alternatively you can add a new NETDEV_ notifier (using something similar to struct netdev_notifier_pre_changeaddr_info)
>>>> and add link type-specific space (e.g. union of link type-specific structs) in the struct which will contain
>>>> what changed for 8021q and will be properly interpreted by the bridge. The downside is that we'll generate
>>>> 2 notifications when changing the loose binding flag, but on the bright side won't have to track anything
>>>> in the bridge, just handle the new notifier type. This might be the easiest path, the fix is still in
>>>> the bridge though, the 8021q module just needs to fill in the new struct and emit the notification on
>>>> any loose binding changes, the bridge must decide if it should process it (i.e. based on upper/lower
>>>> relationship). Such notifier can be also re-used by other link types to propagate link-type specific
>>>> changes.
>>
>> Hi,
>>
>>>
>>> Hi Nik,
>>>
>>> Can you please clarify the following?
>>>
>>> 1) should the new NETDEV_ notifier be about the vlan device and not
>>> the bridge? That is, should I handle it in br_device_event?
>>
>> Yes, it should be about the vlan device (i.e. the target device that changes its state).
> 
> Hi Nik,
> 
> I implemented this and tried to handle NETDEV_CHANGE_DETAILS in
> br_device_event, but there's a check there that performs early return
> if the device is not a bridge port:
> 
> https://github.com/torvalds/linux/blob/master/net/bridge/br.c#L55-L57
> 
> Should I add a new function before that check, e.g.
> br_vlan_device_event, and handle vlan device events there, similar to
> br_vlan_bridge_event? Or do you have a better idea?
> 
> Thanks
> 

Hi,
Handling all vlan device-related changes in br_vlan_device_event() sounds good to me.
Please add it to br_vlan.c.

Thanks,
 Nik


