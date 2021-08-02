Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=225VjnI4g/cwcuGDafQ92hHuuafGlFeEaP4Z9jFRABk=;
 b=jZJFDe09VLZ6R4Hu4wRELDsjwzkQBNSHScE2rxWMR4gOJtaFoaUK+7FePFiSx8ZUObd4/1Nf6f4f83RwpLuYRdqH3vN4nea1TX4Edg1Qc4S40GUlJh5DAZ9EYpm1DxRFyZgk4jwtS0D3THqHSkZ96hM9vYTvLHjbDFttsPrAplY=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 2 Aug 2021 11:20:01 +0000
Message-ID: <20210802112001.rxfajfttl35bnh5s@skbuf>
References: <20210801231730.7493-1-vladimir.oltean@nxp.com>
 <ff6d11a2-2931-714a-7301-f624160a2d48@nvidia.com>
 <20210802092053.qyfkuhhqzxjyqf24@skbuf>
 <451c4538-eb77-2865-af74-777e51cd5c31@nvidia.com>
 <20210802105233.64r23kucu4mjnjsu@skbuf>
 <4d85eacb-152e-8e4e-bb18-ad2814d249c1@nvidia.com>
In-Reply-To: <4d85eacb-152e-8e4e-bb18-ad2814d249c1@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <73DBDAD1B048D546BFAC0CFC0F9CA141@eurprd04.prod.outlook.com>
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

On Mon, Aug 02, 2021 at 02:02:36PM +0300, Nikolay Aleksandrov wrote:
> >> Actually I believe there is still a bug in 52e4bec15546 even with this=
 fix.
> >> The flag can change after the dst has been read in br_switchdev_fdb_no=
tify()
> >> so in theory you could still do a null pointer dereference. fdb_notify=
()
> >> can be called from a few places without locking. The code shouldn't de=
reference
> >> the dst based on the flag.
> >
> > Are you thinking of a specific code path that triggers a race between
> > (a) a writer side doing WRITE_ONCE(fdb->dst, NULL) and then
> >     set_bit(BR_FDB_LOCAL, &fdb->flags), exactly in this order, and
>
> Visible order is not guaranteed, there are no barriers neither at writer =
nor reader
> sides, especially when used without locking. So we cannot make any assump=
tions
> about the order visibility of these writes.
>
> > (b) a reader side catching that fdb exactly in between the above 2
> >     statements, through fdb_notify or otherwise (br_fdb_replay)?
> >
> > Because I don't see any.
> >
> > Plus, I am a bit nervous about protecting against theoretical/unproven
> > races in a way that masks real bugs, as we would be doing if I add an
> > extra check in br_fdb_replay_one and br_switchdev_fdb_notify against th=
e
> > case where an entry has fdb->dst =3D=3D NULL but not BR_FDB_LOCAL.
> >
>
> The bits are _not_ visible atomically with the setting of ->dst. It is ob=
vious
> you must not dereference anything based on them, they are only indication=
s when used
> outside of locked regions and code must be able to deal with inconsistenc=
ies as that
> is implied by the way they're used. It is a clear and obvious bug derefer=
encing based
> on a bit that can change in parallel without any memory ordering guarante=
es.

Ok, I will send a separate patch for that.

> You are not "masking" anything, but fixing what is currently buggy use of=
 fdb bits.

I am "masking" in the sense that the bug I am fixing here was not
obvious to me until it triggered a NPD. That would stop happening with
the patch I'm about to send, but maybe there are still bridge UAPI
functions that do not validate the 'permanent' flag from FDB entries.

> As I already said - this doesn't fix the null deref bug completely, in fa=
ct it fixes a different
> inconsistency, before at worst you'd get blackholed traffic for such entr=
ies now
> you get a null pointer dereference.=
