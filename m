Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EGF/Z4K5qmejHv0aEFL7njXnRA6bcE+UEVa1yoLJls=;
 b=C24vOmK6XGpONuBvWEtD8r2yqOaUT59wSY6VXzi7K/GmPFJS2RgTMu6KoR/K635Q/KUQOVLEoYmlMeYa8KdHIr/5/NdIWw5+P6rIiiS/uijFEj0IPgYdHqJIlIWmqVkNsaOKVpgDE20ZrIDqvVTKHBAtPQY6gCeHgTS34H3+yX4=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 2 Aug 2021 09:20:53 +0000
Message-ID: <20210802092053.qyfkuhhqzxjyqf24@skbuf>
References: <20210801231730.7493-1-vladimir.oltean@nxp.com>
 <ff6d11a2-2931-714a-7301-f624160a2d48@nvidia.com>
In-Reply-To: <ff6d11a2-2931-714a-7301-f624160a2d48@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A0C97A562CC2C14ABFDC193E1BCC5402@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net] net: bridge: validate the NUD_PERMANENT
 bit when adding an extern_learn FDB entry
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: "syzbot+9ba1174359adba5a5b7c@syzkaller.appspotmail.com" <syzbot+9ba1174359adba5a5b7c@syzkaller.appspotmail.com>, Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Ido Schimmel <idosch@idosch.org>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Mon, Aug 02, 2021 at 10:42:41AM +0300, Nikolay Aleksandrov wrote:
> On 02/08/2021 02:17, Vladimir Oltean wrote:
> > Currently it is possible to add broken extern_learn FDB entries to the
> > bridge in two ways:
> >
> > 1. Entries pointing towards the bridge device that are not local/perman=
ent:
> >
> > ip link add br0 type bridge
> > bridge fdb add 00:01:02:03:04:05 dev br0 self extern_learn static
> >
> > 2. Entries pointing towards the bridge device or towards a port that
> > are marked as local/permanent, however the bridge does not process the
> > 'permanent' bit in any way, therefore they are recorded as though they
> > aren't permanent:
> >
> > ip link add br0 type bridge
> > bridge fdb add 00:01:02:03:04:05 dev br0 self extern_learn permanent
> >
> > Since commit 52e4bec15546 ("net: bridge: switchdev: treat local FDBs th=
e
> > same as entries towards the bridge"), these incorrect FDB entries can
> > even trigger NULL pointer dereferences inside the kernel.
> >
> > This is because that commit made the assumption that all FDB entries
> > that are not local/permanent have a valid destination port. For context=
,
> > local / permanent FDB entries either have fdb->dst =3D=3D NULL, and the=
se
> > point towards the bridge device and are therefore local and not to be
> > used for forwarding, or have fdb->dst =3D=3D a net_bridge_port structur=
e
> > (but are to be treated in the same way, i.e. not for forwarding).
> >
> > That assumption _is_ correct as long as things are working correctly in
> > the bridge driver, i.e. we cannot logically have fdb->dst =3D=3D NULL u=
nder
> > any circumstance for FDB entries that are not local. However, the
> > extern_learn code path where FDB entries are managed by a user space
> > controller show that it is possible for the bridge kernel driver to
> > misinterpret the NUD flags of an entry transmitted by user space, and
> > end up having fdb->dst =3D=3D NULL while not being a local entry. This =
is
> > invalid and should be rejected.
> >
> > Before, the two commands listed above both crashed the kernel in this
> > check from br_switchdev_fdb_notify:
> >
>
> Not before 52e4bec15546 though, the check used to be:
> struct net_device *dev =3D dst ? dst->dev : br->dev;

"Before", as in "before this patch, on net-next/linux-next".

> which wouldn't crash. So the fixes tag below is incorrect, you could
> add a weird extern learn entry, but it wouldn't crash the kernel.

:)

Is our only criterion whether a patch is buggy or not that it causes a
NULL pointer dereference inside the kernel?

I thought I'd mention the interaction with the net-next work for the
sake of being thorough, and because this is how the syzcaller caught it
by coincidence, but "kernel does not treat an FDB entry with the
'permanent' flag as permanent" is enough of a reason to submit this as a
bug fix for the commit that I pointed to. Granted, I don't have any use
case with extern_learn, so probably your user space programs simply
don't add permanent FDB entries, but as this is the kernel UAPI, it
should nevertheless do whatever the user space is allowed to say. For a
permanent FDB entry, that behavior is to stop forwarding for that MAC
DA, and that behavior obviously was not taking place even before any
change in br_switchdev_fdb_notify(), or even with CONFIG_NET_SWITCHDEV=3Dn.=
