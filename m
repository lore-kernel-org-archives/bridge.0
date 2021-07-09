Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNubTA80KkJEBJTnXMSdPrbQG1opxuYL3shRlQ4bCYo=;
 b=QAF0FVboE9qf2hQYHc1TT+RSSmzomT9D+B+gLMT1G2o56tZ3BXXHvCztHMcKc6Zke52w3UtM9NE2isRBa8SsRb2Q9cTU7DuEndwdZNG0HVk/ob3dtlTeocWOyIqjz5dk6V7vBQkMNp8TjYdZGJzK7McHXP5hMLaRvmDm9YZp438=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Fri, 9 Jul 2021 14:09:40 +0000
Message-ID: <20210709140940.4ak5vvt5hxay3wus@skbuf>
References: <20210703115705.1034112-1-vladimir.oltean@nxp.com>
 <20210703115705.1034112-5-vladimir.oltean@nxp.com>
 <3686cff1-2a80-687e-7c64-cf070a0f5324@ti.com>
In-Reply-To: <3686cff1-2a80-687e-7c64-cf070a0f5324@ti.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <128786DB20964047939743928E4C7CAF@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [RFC PATCH v2 net-next 04/10] net: bridge: switchdev:
 allow the data plane forwarding to be offloaded
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Alexander Duyck <alexander.duyck@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

Hi Grygorii,

On Fri, Jul 09, 2021 at 04:16:13PM +0300, Grygorii Strashko wrote:
> On 03/07/2021 14:56, Vladimir Oltean wrote:
> > From: Tobias Waldekranz <tobias@waldekranz.com>
> >
> > Allow switchdevs to forward frames from the CPU in accordance with the
> > bridge configuration in the same way as is done between bridge
> > ports. This means that the bridge will only send a single skb towards
> > one of the ports under the switchdev's control, and expects the driver
> > to deliver the packet to all eligible ports in its domain.
> >
> > Primarily this improves the performance of multicast flows with
> > multiple subscribers, as it allows the hardware to perform the frame
> > replication.
> >
> > The basic flow between the driver and the bridge is as follows:
> >
> > - The switchdev accepts the offload by returning a non-null pointer
> >    from .ndo_dfwd_add_station when the port is added to the bridge.
> >
> > - The bridge sends offloadable skbs to one of the ports under the
> >    switchdev's control using dev_queue_xmit_accel.
> >
> > - The switchdev notices the offload by checking for a non-NULL
> >    "sb_dev" in the core's call to .ndo_select_queue.
>
> Sry, I could be missing smth.
>
> Is there any possibility to just mark skb itself as "fwd_offload" (or smt=
h), so driver can
> just check it and decide what to do. Following you series:
> - BR itself will send packet only once to one port if fwd offload possibl=
e and supported
> - switchdev driver can check/negotiate BR_FWD_OFFLOAD flag
>
> In our case, TI CPSW can send directed packet (default now), by specifyin=
g port_id if DMA desc
> or keep port_id =3D=3D 0 which will allow HW to process packet internally=
, including MC duplication.
>
> Sry, again, but necessity to add 3 callbacks and manipulate with "virtual=
" queue to achieve
> MC offload (seems like one of the primary goals) from BR itself looks a b=
it over-complicated :(

After cutting my teeth myself with Tobias' patches, I tend to agree with
the idea that the macvlan offload framework is not a great fit for the
software bridge data plane TX offloading. Some reasons:
- the sb_dev pointer is necessary for macvlan because you can have
  multiple macvlan uppers and you need to know which one this packet
  came from. Whereas in the case of a bridge, any given switchdev net
  device can have a single bridge upper. So a single bit per skb,
  possibly even skb->offload_fwd_mark, could be used to encode this bit
  of information: please look up your FDB for this packet and
  forward/replicate it accordingly.
- I am a bit on the fence about the "net: allow ndo_select_queue to go
  beyond dev->num_real_tx_queues" and "net: extract helpers for binding
  a subordinate device to TX queues" patches, they look like the wrong
  approach overall, just to shoehorn our use case into a framework that
  was not meant to cover it.
- most importantly: Ido asked about the possibility for a switchdev to
  accelerate the data plane for a bridge port that is a LAG upper. In the
  current design, where the bridge attempts to call the
  .ndo_dfwd_add_station method of the bond/team driver, this will not
  work. Traditionally, switchdev has migrated away from ndo's towards
  notifiers because of the ability for a switchdev to intercept the
  notifier emitted by the bridge for the bonding interface, and to treat
  it by itself. So, logically speaking, it would make more sense to
  introduce a new switchdev notifier for TX data plane offloading per
  port. Actually, now that I'm thinking even more about this, it would
  be great not only if we could migrate towards notifiers, but if the
  notification could be emitted by the switchdev driver itself, at
  bridge join time. Once upon a time I had an RFC patch that changed all
  switchdev drivers to inform the bridge that they are capable of
  offloading the RX data plane:
  https://patchwork.kernel.org/project/netdevbpf/patch/20210318231829.38929=
20-17-olteanv@gmail.com/
  That patch was necessary because the bridge, when it sees a bridge
  port that is a LAG, and the LAG is on top of a switchdev, will assign
  the port hwdom based on the devlink switch ID of the switchdev. This
  is wrong because it assumes that the switchdev offloads the LAG, but
  in the vast majority of cases this is false, only a handful of
  switchdev drivers have LAG offload right now. So the expectation is
  that the bridge can do software forwarding between such LAG comprised
  of two switchdev interfaces, and a third (standalone) switchdev
  interface, but it doesn't do that, because to the bridge, all ports
  have the same hwdom.
  Now it seems common sense that I pick up this patch again and make the
  switchdev drivers give 2 pieces of information:
  (a) can I offload the RX data path
  (b) can I offload the TX data path

I can try to draft another RFC with these changes.=
