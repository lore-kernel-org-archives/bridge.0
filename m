Return-Path: <roopa@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=6/YUk+s06hAVlFScFvuqBWrCMc7SbUqY5yZ8thAohgc=;
	b=YEeAa1MO/ZT/XDp6v5ZilE/cHNC23cJUFVL42exnPJkE17cDls7LUzePvMmvcojzKr
	PYJ5hl1WwwA6Izfc3TqctfJtebTD1PmD/XnePRCAkYj2Qhh/l2FLHCh/E3dFFqBR09bT
	mxHs/b4qleIWhCdQg+CPgcq2gX+RNczY/v5Js=
MIME-Version: 1.0
References: <0a015a21-c1ae-e275-e675-431f08bece86@cumulusnetworks.com>
	<20190802105736.26767-1-nikolay@cumulusnetworks.com>
In-Reply-To: <20190802105736.26767-1-nikolay@cumulusnetworks.com>
From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Fri, 2 Aug 2019 07:29:46 -0700
Message-ID: <CAJieiUiPFYDoi=AuFURNEuxNmkcVq5jcEVyDq5Ei1=i5tZ4nSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH net v4] net: bridge: move default pvid
	init/deinit to NETDEV_REGISTER/UNREGISTER
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>, michael-dev <michael-dev@fami-braun.de>

On Fri, Aug 2, 2019 at 3:57 AM Nikolay Aleksandrov
<nikolay@cumulusnetworks.com> wrote:
>
> Most of the bridge device's vlan init bugs come from the fact that its
> default pvid is created at the wrong time, way too early in ndo_init()
> before the device is even assigned an ifindex. It introduces a bug when the
> bridge's dev_addr is added as fdb during the initial default pvid creation
> the notification has ifindex/NDA_MASTER both equal to 0 (see example below)
> which really makes no sense for user-space[0] and is wrong.
> Usually user-space software would ignore such entries, but they are
> actually valid and will eventually have all necessary attributes.
> It makes much more sense to send a notification *after* the device has
> registered and has a proper ifindex allocated rather than before when
> there's a chance that the registration might still fail or to receive
> it with ifindex/NDA_MASTER == 0. Note that we can remove the fdb flush
> from br_vlan_flush() since that case can no longer happen. At
> NETDEV_REGISTER br->default_pvid is always == 1 as it's initialized by
> br_vlan_init() before that and at NETDEV_UNREGISTER it can be anything
> depending why it was called (if called due to NETDEV_REGISTER error
> it'll still be == 1, otherwise it could be any value changed during the
> device life time).
>
> For the demonstration below a small change to iproute2 for printing all fdb
> notifications is added, because it contained a workaround not to show
> entries with ifindex == 0.
> Command executed while monitoring: $ ip l add br0 type bridge
> Before (both ifindex and master == 0):
> $ bridge monitor fdb
> 36:7e:8a:b3:56:ba dev * vlan 1 master * permanent
>
> After (proper br0 ifindex):
> $ bridge monitor fdb
> e6:2a:ae:7a:b7:48 dev br0 vlan 1 master br0 permanent
>
> v4: move only the default pvid init/deinit to NETDEV_REGISTER/UNREGISTER
> v3: send the correct v2 patch with all changes (stub should return 0)
> v2: on error in br_vlan_init set br->vlgrp to NULL and return 0 in
>     the br_vlan_bridge_event stub when bridge vlans are disabled
>
> [0] https://bugzilla.kernel.org/show_bug.cgi?id=204389
>
> Reported-by: michael-dev <michael-dev@fami-braun.de>
> Fixes: 5be5a2df40f0 ("bridge: Add filtering support for default_pvid")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Acked-by: Roopa Prabhu <roopa@cumulusnetworks.com>
