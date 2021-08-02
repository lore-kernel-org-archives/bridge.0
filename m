Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSUuVj92+VuObyRpQZSJYxDeRmhjpmInepr9vn4uIiA=;
 b=XsGWne0A+WsjyCM21MbXkvE/wY65sy+x9fFd0qAMmMzbJWngB98Wjc9YxImCVDLkCGUv9igOkuCUp8S3FNhFsGFW2xwK1IRKBwFxKALPXizk2SMzxbjBVbkEJTb5Ts35BRxUuIJg8atPpIdhMOMlXmjW8UwYehLEINK6U72jtt4=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 2 Aug 2021 10:52:33 +0000
Message-ID: <20210802105233.64r23kucu4mjnjsu@skbuf>
References: <20210801231730.7493-1-vladimir.oltean@nxp.com>
 <ff6d11a2-2931-714a-7301-f624160a2d48@nvidia.com>
 <20210802092053.qyfkuhhqzxjyqf24@skbuf>
 <451c4538-eb77-2865-af74-777e51cd5c31@nvidia.com>
In-Reply-To: <451c4538-eb77-2865-af74-777e51cd5c31@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8A74A5EF58A80546AFC031C8812AB8F4@eurprd04.prod.outlook.com>
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

On Mon, Aug 02, 2021 at 12:42:17PM +0300, Nikolay Aleksandrov wrote:
> >>> Before, the two commands listed above both crashed the kernel in this
> >>> check from br_switchdev_fdb_notify:
> >>>
> >>
> >> Not before 52e4bec15546 though, the check used to be:
> >> struct net_device *dev =3D dst ? dst->dev : br->dev;
> >
> > "Before", as in "before this patch, on net-next/linux-next".
> >
>
> We still need that check, more below.
>
> >> which wouldn't crash. So the fixes tag below is incorrect, you could
> >> add a weird extern learn entry, but it wouldn't crash the kernel.
> >
> > :)
> >
> > Is our only criterion whether a patch is buggy or not that it causes a
> > NULL pointer dereference inside the kernel?
> >
> > I thought I'd mention the interaction with the net-next work for the
> > sake of being thorough, and because this is how the syzcaller caught it
> > by coincidence, but "kernel does not treat an FDB entry with the
> > 'permanent' flag as permanent" is enough of a reason to submit this as =
a
>
> Not exactly right, you may add it as permanent but it doesn't get "perman=
ent" flag set.

And that is the bug I am addressing here, no?

> The actual bug is that it points to the bridge device, e.g. null dst with=
out the flag.
>
> > bug fix for the commit that I pointed to. Granted, I don't have any use
> > case with extern_learn, so probably your user space programs simply
> > don't add permanent FDB entries, but as this is the kernel UAPI, it
> > should nevertheless do whatever the user space is allowed to say. For a
> > permanent FDB entry, that behavior is to stop forwarding for that MAC
> > DA, and that behavior obviously was not taking place even before any
> > change in br_switchdev_fdb_notify(), or even with CONFIG_NET_SWITCHDEV=
=3Dn.
> >
>
> Actually I believe there is still a bug in 52e4bec15546 even with this fi=
x.
> The flag can change after the dst has been read in br_switchdev_fdb_notif=
y()
> so in theory you could still do a null pointer dereference. fdb_notify()
> can be called from a few places without locking. The code shouldn't deref=
erence
> the dst based on the flag.

Are you thinking of a specific code path that triggers a race between
(a) a writer side doing WRITE_ONCE(fdb->dst, NULL) and then
    set_bit(BR_FDB_LOCAL, &fdb->flags), exactly in this order, and
(b) a reader side catching that fdb exactly in between the above 2
    statements, through fdb_notify or otherwise (br_fdb_replay)?

Because I don't see any.

Plus, I am a bit nervous about protecting against theoretical/unproven
races in a way that masks real bugs, as we would be doing if I add an
extra check in br_fdb_replay_one and br_switchdev_fdb_notify against the
case where an entry has fdb->dst =3D=3D NULL but not BR_FDB_LOCAL.

>
> I'm okay with this change due to the null dst without permanent flag fix,=
 but
> it doesn't fully fix the null pointer dereference.

So is there any change that I should make to this patch?=
