Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14B2F4175B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 28490410DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=QvWgi4bapgJrNQFkQQ/ZI8kSbG7GnXbksaof+b0rmLc=;
 b=kDqaOrUd0p917w2v+d7X2KGqQbhozVosVzex2g0KecOPP4HWnCyfpVycR36/m83PkC
 r/hVZZMqfEpfB7mKxkEPtcyPiqS1KgwmZdOduWmZgbmbXoFP0xMdRxrP2+IRLOL+gj+G
 a/bob2EBbCfku/BjYYbmzh4nD1gUsYEhfM6st88Co6+JheB1J5myX7YsP+kxmieOtbH0
 uXjeJ34pA12v4Ap3fRnc/M+VHnE8FQTkIIw+3vQwguJFVxBiSvfTZpJFZ3r48T8VlXhr
 UxMW5Kw+ZDGmbp9LSMUOBGDLTLxf/D6w/gHE1XFb728KVwkDCNQ2f5LasZ+e5dPa9vZi
 acow==
Message-ID: <74b69521-0d40-5e2f-4d1b-76e9697d7471@blackwall.org>
Date: Wed, 10 Aug 2022 18:10:40 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1660100506.git.sevinj.aghayeva@gmail.com>
 <94ec6182-0804-7a0e-dcba-42655ff19884@blackwall.org>
 <CAMWRUK45nbZS3PeSLR1X=Ko6oavrjKj2AWeh2F1wckMPrz_dEg@mail.gmail.com>
 <49f933c3-7430-a133-9add-ed76c395023b@blackwall.org>
 <CAMWRUK4J6Dp7Cff=pN9iw6OwDN8g61dd4S=OVKQ75vBch-PxXQ@mail.gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CAMWRUK4J6Dp7Cff=pN9iw6OwDN8g61dd4S=OVKQ75vBch-PxXQ@mail.gmail.com>
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

On 10/08/2022 18:00, Sevinj Aghayeva wrote:
> On Wed, Aug 10, 2022 at 10:50 AM Nikolay Aleksandrov
> <razor@blackwall.org> wrote:
>>
>> On 10/08/2022 17:42, Sevinj Aghayeva wrote:
>>>
>>>
>>> On Wed, Aug 10, 2022 at 4:54 AM Nikolay Aleksandrov <razor@blackwall.org <mailto:razor@blackwall.org>> wrote:
>>>
>>>     On 10/08/2022 06:11, Sevinj Aghayeva wrote:
>>>     > When bridge binding is enabled for a vlan interface, it is expected
>>>     > that the link state of the vlan interface will track the subset of the
>>>     > ports that are also members of the corresponding vlan, rather than
>>>     > that of all ports.
>>>     >
>>>     > Currently, this feature works as expected when a vlan interface is
>>>     > created with bridge binding enabled:
>>>     >
>>>     >   ip link add link br name vlan10 type vlan id 10 protocol 802.1q \
>>>     >         bridge_binding on
>>>     >
>>>     > However, the feature does not work when a vlan interface is created
>>>     > with bridge binding disabled, and then enabled later:
>>>     >
>>>     >   ip link add link br name vlan10 type vlan id 10 protocol 802.1q \
>>>     >         bridge_binding off
>>>     >   ip link set vlan10 type vlan bridge_binding on
>>>     >
>>>     > After these two commands, the link state of the vlan interface
>>>     > continues to track that of all ports, which is inconsistent and
>>>     > confusing to users. This series fixes this bug and introduces two
>>>     > tests for the valid behavior.
>>>     >
>>>     > Sevinj Aghayeva (3):
>>>     >   net: core: export call_netdevice_notifiers_info
>>>     >   net: 8021q: fix bridge binding behavior for vlan interfaces
>>>     >   selftests: net: tests for bridge binding behavior
>>>     >
>>>     >  include/linux/netdevice.h                     |   2 +
>>>     >  net/8021q/vlan.h                              |   2 +-
>>>     >  net/8021q/vlan_dev.c                          |  25 ++-
>>>     >  net/core/dev.c                                |   7 +-
>>>     >  tools/testing/selftests/net/Makefile          |   1 +
>>>     >  .../selftests/net/bridge_vlan_binding_test.sh | 143 ++++++++++++++++++
>>>     >  6 files changed, 172 insertions(+), 8 deletions(-)
>>>     >  create mode 100755 tools/testing/selftests/net/bridge_vlan_binding_test.sh
>>>     >
>>>
>>>     Hi,
>>>     NETDEV_CHANGE event is already propagated when the vlan changes flags,
>>>
>>>
>>> I'm not sure if NETDEV_CHANGE is actually propagated when the vlan changes flags. The two functions in the bridge module that handle NETDEV_CHANGE are br_vlan_port_event  and br_vlan_bridge_event. I've installed probes for both, and when I'm changing flags using "sudo ip link set vlan10 type vlan bridge_binding on", I don't see any of those functions getting called, although I do see vlan_dev_change_flags getting called. I think there may be a bug in core/dev.c:__dev_notify_flags.
>>
>> are both vlan and bridge interfaces up?
>> what exactly are you probing for?
> 
> 
> I first run the attached pre.sh script that sets up the environment
> and creates a vlan interface with bridge binding off. I then start
> recording with perf, and here's the list of probes:
> 
> $ sudo ./k/linux/tools/perf/perf probe -l
>   probe:br_vlan_bridge_event (on br_vlan_bridge_event in bridge with event dev)
>   probe:br_vlan_port_event (on br_vlan_port_event in bridge with event)
>   probe:br_vlan_set_vlan_dev_state (on br_vlan_set_vlan_dev_state in
> bridge with br vlan_dev)
>   probe:register_vlan_dev (on register_vlan_dev in 8021q with dev)
>   probe:vlan_changelink (on vlan_changelink in 8021q with dev)
>   probe:vlan_dev_change_flags (on vlan_dev_change_flags in 8021q with dev)
>   probe:vlan_dev_fix_features (on vlan_dev_fix_features in 8021q with dev)
>   probe:vlan_dev_init  (on vlan_dev_init in 8021q with dev)
>   probe:vlan_dev_ioctl (on vlan_dev_ioctl in 8021q with dev)
>   probe:vlan_dev_open  (on vlan_dev_open in 8021q with dev)
>   probe:vlan_dev_stop  (on vlan_dev_stop in 8021q with dev)
>   probe:vlan_dev_uninit (on vlan_dev_uninit in 8021q with dev)
>   probe:vlan_newlink   (on vlan_newlink in 8021q with dev)
> 
> I then run the following command to turn the bridge binding flag on:
> 
> $ sudo ip link set vlan10 type vlan bridge_binding on
> 
> Then I stop the recording and print out the events, and I see this. I
> don't see br_vlan_port_event or br_vlan_bridge_event getting called.
> 
>               ip  5933 [003]  2204.722470:
> probe:vlan_changelink: (ffffffffc1042b50) dev="vlan10"
>               ip  5933 [003]  2204.722476:
> probe:vlan_dev_change_flags: (ffffffffc1042600) dev="vlan10"
> 
> Am I doing something wrong?
> 
> Thanks
> 
> 

You can't expect to see br_vlan_bridge_event() called because the notification
target device is vlan10 and not the bridge. See br_device_event():
...
        if (netif_is_bridge_master(dev)) {
                err = br_vlan_bridge_event(dev, event, ptr);
                if (err)
                        return notifier_from_errno(err);
...


Try probing for br_device_event(), you'll see it gets called every time you change the flag.

