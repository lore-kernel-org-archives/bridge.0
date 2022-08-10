Return-Path: <sevinj.aghayeva@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8A41C81B0A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 121D68197D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=xcGPSrn81bbqTgT8hKlv4AUoxdEVE3jgIDWDLPnuu7c=;
 b=ai3jWQ7W1o96lCTUtqIYXtGSWAuZdsXAHMw/BE7bc01h2aJv0uBYe5amIRtPis5b1B
 o40rH8wwAwJjFYzmLEkNhpIRLQ5qQtkuI5XU3TN+XOZuE+34GSg5lHwokj2L7f3RZZ1x
 oVro4P/J+Zg5NKb2MV3Lok9ZoFLsjiQm8AZnZpWnlOdnhYc7FX+huepwSCBbHkPRVr0y
 gtlRSCTbCy2/WZxIF3iBzU05icT3xtNM0JqS+NOb4j2d0V15vW5FKwp5LF26zE6MytFB
 MZKPUSeIjCUMTYj3d6zctCxVIx2veioS7WCtF+txEB9pAF6XPUaHUj9W/7Cq7yZVexZg
 egJg==
MIME-Version: 1.0
References: <cover.1660100506.git.sevinj.aghayeva@gmail.com>
 <94ec6182-0804-7a0e-dcba-42655ff19884@blackwall.org>
 <CAMWRUK45nbZS3PeSLR1X=Ko6oavrjKj2AWeh2F1wckMPrz_dEg@mail.gmail.com>
 <49f933c3-7430-a133-9add-ed76c395023b@blackwall.org>
In-Reply-To: <49f933c3-7430-a133-9add-ed76c395023b@blackwall.org>
From: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date: Wed, 10 Aug 2022 11:00:24 -0400
Message-ID: <CAMWRUK4J6Dp7Cff=pN9iw6OwDN8g61dd4S=OVKQ75vBch-PxXQ@mail.gmail.com>
Content-Type: multipart/mixed; boundary="000000000000aedbe905e5e44fe5"
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

--000000000000aedbe905e5e44fe5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 10, 2022 at 10:50 AM Nikolay Aleksandrov
<razor@blackwall.org> wrote:
>
> On 10/08/2022 17:42, Sevinj Aghayeva wrote:
> >
> >
> > On Wed, Aug 10, 2022 at 4:54 AM Nikolay Aleksandrov <razor@blackwall.or=
g <mailto:razor@blackwall.org>> wrote:
> >
> >     On 10/08/2022 06:11, Sevinj Aghayeva wrote:
> >     > When bridge binding is enabled for a vlan interface, it is expect=
ed
> >     > that the link state of the vlan interface will track the subset o=
f the
> >     > ports that are also members of the corresponding vlan, rather tha=
n
> >     > that of all ports.
> >     >
> >     > Currently, this feature works as expected when a vlan interface i=
s
> >     > created with bridge binding enabled:
> >     >
> >     >   ip link add link br name vlan10 type vlan id 10 protocol 802.1q=
 \
> >     >         bridge_binding on
> >     >
> >     > However, the feature does not work when a vlan interface is creat=
ed
> >     > with bridge binding disabled, and then enabled later:
> >     >
> >     >   ip link add link br name vlan10 type vlan id 10 protocol 802.1q=
 \
> >     >         bridge_binding off
> >     >   ip link set vlan10 type vlan bridge_binding on
> >     >
> >     > After these two commands, the link state of the vlan interface
> >     > continues to track that of all ports, which is inconsistent and
> >     > confusing to users. This series fixes this bug and introduces two
> >     > tests for the valid behavior.
> >     >
> >     > Sevinj Aghayeva (3):
> >     >   net: core: export call_netdevice_notifiers_info
> >     >   net: 8021q: fix bridge binding behavior for vlan interfaces
> >     >   selftests: net: tests for bridge binding behavior
> >     >
> >     >  include/linux/netdevice.h                     |   2 +
> >     >  net/8021q/vlan.h                              |   2 +-
> >     >  net/8021q/vlan_dev.c                          |  25 ++-
> >     >  net/core/dev.c                                |   7 +-
> >     >  tools/testing/selftests/net/Makefile          |   1 +
> >     >  .../selftests/net/bridge_vlan_binding_test.sh | 143 ++++++++++++=
++++++
> >     >  6 files changed, 172 insertions(+), 8 deletions(-)
> >     >  create mode 100755 tools/testing/selftests/net/bridge_vlan_bindi=
ng_test.sh
> >     >
> >
> >     Hi,
> >     NETDEV_CHANGE event is already propagated when the vlan changes fla=
gs,
> >
> >
> > I'm not sure if NETDEV_CHANGE is actually propagated when the vlan chan=
ges flags. The two functions in the bridge module that handle NETDEV_CHANGE=
 are br_vlan_port_event  and br_vlan_bridge_event. I've installed probes fo=
r both, and when I'm changing flags using "sudo ip link set vlan10 type vla=
n bridge_binding on", I don't see any of those functions getting called, al=
though I do see vlan_dev_change_flags getting called. I think there may be =
a bug in core/dev.c:__dev_notify_flags.
>
> are both vlan and bridge interfaces up?
> what exactly are you probing for?


I first run the attached pre.sh script that sets up the environment
and creates a vlan interface with bridge binding off. I then start
recording with perf, and here's the list of probes:

$ sudo ./k/linux/tools/perf/perf probe -l
  probe:br_vlan_bridge_event (on br_vlan_bridge_event in bridge with event =
dev)
  probe:br_vlan_port_event (on br_vlan_port_event in bridge with event)
  probe:br_vlan_set_vlan_dev_state (on br_vlan_set_vlan_dev_state in
bridge with br vlan_dev)
  probe:register_vlan_dev (on register_vlan_dev in 8021q with dev)
  probe:vlan_changelink (on vlan_changelink in 8021q with dev)
  probe:vlan_dev_change_flags (on vlan_dev_change_flags in 8021q with dev)
  probe:vlan_dev_fix_features (on vlan_dev_fix_features in 8021q with dev)
  probe:vlan_dev_init  (on vlan_dev_init in 8021q with dev)
  probe:vlan_dev_ioctl (on vlan_dev_ioctl in 8021q with dev)
  probe:vlan_dev_open  (on vlan_dev_open in 8021q with dev)
  probe:vlan_dev_stop  (on vlan_dev_stop in 8021q with dev)
  probe:vlan_dev_uninit (on vlan_dev_uninit in 8021q with dev)
  probe:vlan_newlink   (on vlan_newlink in 8021q with dev)

I then run the following command to turn the bridge binding flag on:

$ sudo ip link set vlan10 type vlan bridge_binding on

Then I stop the recording and print out the events, and I see this. I
don't see br_vlan_port_event or br_vlan_bridge_event getting called.

              ip  5933 [003]  2204.722470:
probe:vlan_changelink: (ffffffffc1042b50) dev=3D"vlan10"
              ip  5933 [003]  2204.722476:
probe:vlan_dev_change_flags: (ffffffffc1042600) dev=3D"vlan10"

Am I doing something wrong?

Thanks



>
>
> I can see the NETDEV_CHANGE event go through when changing the loose bind=
ing.
>
>
>
>


--=20

Sevinj.Aghayeva

--000000000000aedbe905e5e44fe5
Content-Type: application/x-sh; name="pre.sh"
Content-Disposition: attachment; filename="pre.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_l6nqm5n90>
X-Attachment-Id: f_l6nqm5n90

IyEvYmluL2Jhc2gKCiMgVGhpcyBzY3JpcHQgdGVzdHMgdGhhdCB3aGVuIGEgdmxhbiBpbnRlcmZh
Y2UgaXMgY3JlYXRlZCB3aXRoIGJyaWRnZSBiaW5kaW5nCiMgb2ZmLCBhbmQgdGhlbiBicmlkZ2Ug
YmluZGluZyB0dXJuZWQgb24gdXNpbmcgImlwIGxpbmsgc2V0IiBjb21tYW5kLCBicmlkZ2UKIyBi
aW5kaW5nIGlzIGFjdHVhbGx5IHR1cm5lZCBvbiAtLSB0aGlzIGhhc24ndCBiZWVuIHRoZSBjYXNl
IGluIHRoZSBwYXN0LgoKIyBSZW1vdmUgaW50ZXJmYWNlcyB0aGF0IG1heSBoYXZlIGJlZW4gY3Jl
YXRlZCBieSB0aGUgcHJldmlvdXMgcnVuCmlwIGxpbmsgZGVsZXRlIHZldGgxMAppcCBsaW5rIGRl
bGV0ZSB2ZXRoMjAKaXAgbGluayBkZWxldGUgYnJfZGVmYXVsdAoKIyBDcmVhdGUgYSBicmlkZ2Ug
YW5kIGFkZCB0d28gcG9ydHMgdG8gaXQuCmlwIGxpbmsgYWRkIGRldiBicl9kZWZhdWx0IHR5cGUg
YnJpZGdlCmlwIGxpbmsgYWRkIGRldiB2ZXRoMTAgdHlwZSB2ZXRoIHBlZXIgbmFtZSB2ZXRoMTEK
aXAgbGluayBhZGQgZGV2IHZldGgyMCB0eXBlIHZldGggcGVlciBuYW1lIHZldGgyMQppcCBsaW5r
IHNldCBkZXYgdmV0aDEwIG1hc3RlciBicl9kZWZhdWx0CmlwIGxpbmsgc2V0IGRldiB2ZXRoMjAg
bWFzdGVyIGJyX2RlZmF1bHQKCiMgQ3JlYXRlIFZMQU4gMTAuCmJyaWRnZSB2bGFuIGFkZCB2aWQg
MTAgZGV2IGJyX2RlZmF1bHQgc2VsZgoKIyBBZGQgdmV0aDEwIHRvIFZMQU4gMTAuCmJyaWRnZSB2
bGFuIGFkZCB2aWQgMTAgZGV2IHZldGgxMAoKIyBCcmluZyB1cCB0aGUgcG9ydHMgYW5kIHRoZSBi
cmlkZ2UuCmlwIGxpbmsgc2V0IHZldGgxMCB1cAppcCBsaW5rIHNldCB2ZXRoMTEgdXAKaXAgbGlu
ayBzZXQgdmV0aDIwIHVwCmlwIGxpbmsgc2V0IHZldGgyMSB1cAppcCBsaW5rIHNldCBicl9kZWZh
dWx0IHVwCgojIEFkZCBWTEFOIGludGVyZmFjZSB2bGFuMTAgdG8gVkxBTiAxMCB3aXRoIGJyaWRn
ZSBiaW5kaW5nIG9mZi4KaXAgbGluayBhZGQgbGluayBicl9kZWZhdWx0IG5hbWUgdmxhbjEwIHR5
cGUgdmxhbiBpZCAxMCBwcm90b2NvbCA4MDIuMXEgYnJpZGdlX2JpbmRpbmcgb2ZmCgojIEJyaW5n
IHVwICBWTEFOIGludGVyZmFjZS4KaXAgbGluayBzZXQgdmxhbjEwIHVwCgoK
--000000000000aedbe905e5e44fe5--
