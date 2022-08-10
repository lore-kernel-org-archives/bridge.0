Return-Path: <sevinj.aghayeva@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 37DFE4148A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CEC2B410DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=vyAa9/lSJHOKkyJlHJTvIPQn51upSW+mtKHWf2N+2CM=;
 b=d9XfBPRuiR7Yl2Yrp0abjirhXp/wMnDKYKvxjBPdUET2S+fUf2sSsxKUVOrn9oOHoc
 ohOiWAAfQ72+B8uXLGosK1MImKLzfraF/YUnekLjAPsPcDlbhgnosnkgagc9jNAK6xU5
 JyxLOfQHOVL9sNlfenfAdWbO4aJoKP4YiOdem75xMQLWbBP/1FATuiIKVVtIwelQbV4/
 08xFjo/vkWnwsHNv5wGirmCFVh3nQybdT59sXcPr/Nbc0q2/VOaaznMvZzhu2XBXjDp0
 CwplX5vk4ZBrusRvg3rFA3MyjBOkkxGIbhwuXok7y0wFaH3Sz3hTREu3Q0RinZkj3zhJ
 mY2g==
MIME-Version: 1.0
References: <cover.1660100506.git.sevinj.aghayeva@gmail.com>
 <94ec6182-0804-7a0e-dcba-42655ff19884@blackwall.org>
 <CAMWRUK45nbZS3PeSLR1X=Ko6oavrjKj2AWeh2F1wckMPrz_dEg@mail.gmail.com>
 <49f933c3-7430-a133-9add-ed76c395023b@blackwall.org>
 <CAMWRUK4J6Dp7Cff=pN9iw6OwDN8g61dd4S=OVKQ75vBch-PxXQ@mail.gmail.com>
 <74b69521-0d40-5e2f-4d1b-76e9697d7471@blackwall.org>
In-Reply-To: <74b69521-0d40-5e2f-4d1b-76e9697d7471@blackwall.org>
From: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date: Wed, 10 Aug 2022 11:21:58 -0400
Message-ID: <CAMWRUK4WvrkBDViq0s5Rdc8bziJf7=js4ta6B0kAcAcfV4rLiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: aroulin@nvidia.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, sbrivio@redhat.com, Eric Dumazet <edumazet@google.com>, roopa@nvidia.com, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Wed, Aug 10, 2022 at 11:10 AM Nikolay Aleksandrov
<razor@blackwall.org> wrote:
>
> On 10/08/2022 18:00, Sevinj Aghayeva wrote:
> > On Wed, Aug 10, 2022 at 10:50 AM Nikolay Aleksandrov
> > <razor@blackwall.org> wrote:
> >>
> >> On 10/08/2022 17:42, Sevinj Aghayeva wrote:
> >>>
> >>>
> >>> On Wed, Aug 10, 2022 at 4:54 AM Nikolay Aleksandrov <razor@blackwall.=
org <mailto:razor@blackwall.org>> wrote:
> >>>
> >>>     On 10/08/2022 06:11, Sevinj Aghayeva wrote:
> >>>     > When bridge binding is enabled for a vlan interface, it is expe=
cted
> >>>     > that the link state of the vlan interface will track the subset=
 of the
> >>>     > ports that are also members of the corresponding vlan, rather t=
han
> >>>     > that of all ports.
> >>>     >
> >>>     > Currently, this feature works as expected when a vlan interface=
 is
> >>>     > created with bridge binding enabled:
> >>>     >
> >>>     >   ip link add link br name vlan10 type vlan id 10 protocol 802.=
1q \
> >>>     >         bridge_binding on
> >>>     >
> >>>     > However, the feature does not work when a vlan interface is cre=
ated
> >>>     > with bridge binding disabled, and then enabled later:
> >>>     >
> >>>     >   ip link add link br name vlan10 type vlan id 10 protocol 802.=
1q \
> >>>     >         bridge_binding off
> >>>     >   ip link set vlan10 type vlan bridge_binding on
> >>>     >
> >>>     > After these two commands, the link state of the vlan interface
> >>>     > continues to track that of all ports, which is inconsistent and
> >>>     > confusing to users. This series fixes this bug and introduces t=
wo
> >>>     > tests for the valid behavior.
> >>>     >
> >>>     > Sevinj Aghayeva (3):
> >>>     >   net: core: export call_netdevice_notifiers_info
> >>>     >   net: 8021q: fix bridge binding behavior for vlan interfaces
> >>>     >   selftests: net: tests for bridge binding behavior
> >>>     >
> >>>     >  include/linux/netdevice.h                     |   2 +
> >>>     >  net/8021q/vlan.h                              |   2 +-
> >>>     >  net/8021q/vlan_dev.c                          |  25 ++-
> >>>     >  net/core/dev.c                                |   7 +-
> >>>     >  tools/testing/selftests/net/Makefile          |   1 +
> >>>     >  .../selftests/net/bridge_vlan_binding_test.sh | 143 ++++++++++=
++++++++
> >>>     >  6 files changed, 172 insertions(+), 8 deletions(-)
> >>>     >  create mode 100755 tools/testing/selftests/net/bridge_vlan_bin=
ding_test.sh
> >>>     >
> >>>
> >>>     Hi,
> >>>     NETDEV_CHANGE event is already propagated when the vlan changes f=
lags,
> >>>
> >>>
> >>> I'm not sure if NETDEV_CHANGE is actually propagated when the vlan ch=
anges flags. The two functions in the bridge module that handle NETDEV_CHAN=
GE are br_vlan_port_event  and br_vlan_bridge_event. I've installed probes =
for both, and when I'm changing flags using "sudo ip link set vlan10 type v=
lan bridge_binding on", I don't see any of those functions getting called, =
although I do see vlan_dev_change_flags getting called. I think there may b=
e a bug in core/dev.c:__dev_notify_flags.
> >>
> >> are both vlan and bridge interfaces up?
> >> what exactly are you probing for?
> >
> >
> > I first run the attached pre.sh script that sets up the environment
> > and creates a vlan interface with bridge binding off. I then start
> > recording with perf, and here's the list of probes:
> >
> > $ sudo ./k/linux/tools/perf/perf probe -l
> >   probe:br_vlan_bridge_event (on br_vlan_bridge_event in bridge with ev=
ent dev)
> >   probe:br_vlan_port_event (on br_vlan_port_event in bridge with event)
> >   probe:br_vlan_set_vlan_dev_state (on br_vlan_set_vlan_dev_state in
> > bridge with br vlan_dev)
> >   probe:register_vlan_dev (on register_vlan_dev in 8021q with dev)
> >   probe:vlan_changelink (on vlan_changelink in 8021q with dev)
> >   probe:vlan_dev_change_flags (on vlan_dev_change_flags in 8021q with d=
ev)
> >   probe:vlan_dev_fix_features (on vlan_dev_fix_features in 8021q with d=
ev)
> >   probe:vlan_dev_init  (on vlan_dev_init in 8021q with dev)
> >   probe:vlan_dev_ioctl (on vlan_dev_ioctl in 8021q with dev)
> >   probe:vlan_dev_open  (on vlan_dev_open in 8021q with dev)
> >   probe:vlan_dev_stop  (on vlan_dev_stop in 8021q with dev)
> >   probe:vlan_dev_uninit (on vlan_dev_uninit in 8021q with dev)
> >   probe:vlan_newlink   (on vlan_newlink in 8021q with dev)
> >
> > I then run the following command to turn the bridge binding flag on:
> >
> > $ sudo ip link set vlan10 type vlan bridge_binding on
> >
> > Then I stop the recording and print out the events, and I see this. I
> > don't see br_vlan_port_event or br_vlan_bridge_event getting called.
> >
> >               ip  5933 [003]  2204.722470:
> > probe:vlan_changelink: (ffffffffc1042b50) dev=3D"vlan10"
> >               ip  5933 [003]  2204.722476:
> > probe:vlan_dev_change_flags: (ffffffffc1042600) dev=3D"vlan10"
> >
> > Am I doing something wrong?
> >
> > Thanks
> >
> >
>
> You can't expect to see br_vlan_bridge_event() called because the notific=
ation
> target device is vlan10 and not the bridge. See br_device_event():
> ...
>         if (netif_is_bridge_master(dev)) {
>                 err =3D br_vlan_bridge_event(dev, event, ptr);
>                 if (err)
>                         return notifier_from_errno(err);
> ...
>
>
> Try probing for br_device_event(), you'll see it gets called every time y=
ou change the flag.
>
You're right, I did see br_device_event() getting called. Thanks!

--=20

Sevinj.Aghayeva
