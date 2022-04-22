Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650665667;
 bh=OBcxSR9xi8xcrAi/LuWUvS+xg1jLOhXBymc5euRWtvg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Vxp3cZDongmz0cuL/Uq7z3oAQEThdZyXloJYSjDrME+6Sc2UXKCBMT5RWtp9sZdEr
 ZA3VB5Xx6se4O0cDs4APAktjZ8Iv29pnuNCxF3Yx7eyE5zaMc4xWqFUEgTQN3fkJKJ
 rmR+aMwcDhFyY06JiVfwlv5mtEziLkJx++OnYV3pySFXCMA5/yP1R3MnrjbsC0s9cw
 fcYNvq0pySITAQMLZwj2Sv5oQ3LFHwk6OT8Kduspy+wCXCmejYTSgXqrqgt5b0cTRh
 6cpYzTJuMTAGA82EuswOhRY9SwNryS8qgmfs66Au7Fx7fVWhlbjcQJQL+XLp7CCxjJ
 G4qaidBDIpgIQ==
Date: Fri, 22 Apr 2022 15:14:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20220422151425.7a3f90d4@kernel.org>
In-Reply-To: <c945ebff-02fe-f2d5-656f-6bdfc46416f1@blackwall.org>
References: <20220421101247.121896-1-clement.leger@bootlin.com>
 <c945ebff-02fe-f2d5-656f-6bdfc46416f1@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next] net: bridge: switchdev: check
 br_vlan_group() return value
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, "David S. Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On Thu, 21 Apr 2022 13:17:51 +0300 Nikolay Aleksandrov wrote:
> On 21/04/2022 13:12, Cl=C3=A9ment L=C3=A9ger wrote:
> > br_vlan_group() can return NULL and thus return value must be checked
> > to avoid dereferencing a NULL pointer.
> >=20
> > Fixes: 6284c723d9b9 ("net: bridge: mst: Notify switchdev drivers of VLA=
N MSTI migrations")
> > Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> > ---
> >  net/bridge/br_switchdev.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> > index 81400e0b26ac..8f3d76c751dd 100644
> > --- a/net/bridge/br_switchdev.c
> > +++ b/net/bridge/br_switchdev.c
> > @@ -354,6 +354,8 @@ static int br_switchdev_vlan_attr_replay(struct net=
_device *br_dev,
> >  	attr.orig_dev =3D br_dev;
> > =20
> >  	vg =3D br_vlan_group(br);
> > +	if (!vg)
> > +		return 0;
> > =20
> >  	list_for_each_entry(v, &vg->vlan_list, vlist) {
> >  		if (v->msti) { =20
>=20
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

Thanks! Applying to net tho, the patch in question is already=20
in Linus's tree.
