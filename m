Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcYlSFKFIgpm8tcAstvWlJ5bLgqUHukHY6Vh4zxSntM=;
 b=LDiwurYDNvT1uBMVk+m8OU3Crao2sfd10bs1dvKwBVW53bNy3dduaVq9Fyy7GM/6vhfEHcB95Hu5PBhOJ4JhZamDE/EcW+WYzWxTpvjqQWbZLPtATG23DstTqxaqSaOkEcljs0KmVMVl2lqigVehf+Y85ePzoR1rZIwcdr49np0=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 10 Aug 2021 10:09:29 +0000
Message-ID: <20210810100928.uk7dfstrnts2may4@skbuf>
References: <20210801231730.7493-1-vladimir.oltean@nxp.com>
 <YREcqAdU+6IpT0+w@shredder> <20210809160521.audhnv7o2tugwtmp@skbuf>
 <YRIgynudgTsOpe5q@shredder>
In-Reply-To: <YRIgynudgTsOpe5q@shredder>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CE3ADE0C5E28374FA60AE0C4B933989B@eurprd04.prod.outlook.com>
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
To: Ido Schimmel <idosch@idosch.org>
Cc: "syzbot+9ba1174359adba5a5b7c@syzkaller.appspotmail.com" <syzbot+9ba1174359adba5a5b7c@syzkaller.appspotmail.com>, Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, "nikolay@nvidia.com" <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Tue, Aug 10, 2021 at 09:46:34AM +0300, Ido Schimmel wrote:
> On Mon, Aug 09, 2021 at 04:05:22PM +0000, Vladimir Oltean wrote:
> > On Mon, Aug 09, 2021 at 03:16:40PM +0300, Ido Schimmel wrote:
> > > I have at least once selftest where I forgot the 'static' keyword:
> > >
> > > bridge fdb add de:ad:be:ef:13:37 dev $swp1 master extern_learn vlan 1
> > >
> > > This patch breaks the test when run against both the kernel and hardw=
are
> > > data paths. I don't mind patching these tests, but we might get more
> > > reports in the future.
> >=20
> > Is it the 'static' keyword that you forgot, or 'dynamic'? The
> > tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh selftest
> > looks to me like it's testing the behavior of an FDB entry which should
> > roam, and which without the extern_learn flag would be ageable.
>=20
> static - no aging, no roaming
> dynamic - aging, roaming
> extern_learn - no aging, roaming
>=20
> So these combinations do not make any sense and the kernel will ignore
> static/dynamic when extern_learn is specified. It's needed to work
> around iproute2 behavior of "assume permanent"

Since NTF_EXT_LEARNED is part of ndm->ndm_flags and NUD_REACHABLE/NUD_NOARP
are part of ndm->ndm_state, it is not at all clear to me that 'extern_learn=
'
belongs to the same class of bridge neighbor attributes as 'static'/'dynami=
c',
and that it is invalid to have the full degree of freedom. If it isn't,
shouldn't the kernel validate that, instead of just ignoring the ndm->ndm_s=
tate?
If it's too late to validate, shouldn't we at least document somewhere
that the ndm_state is ignored in the presence of ndm_flags & NTF_EXT_LEARNE=
D?
It is user API after all, easter eggs like this aren't very enjoyable.=
