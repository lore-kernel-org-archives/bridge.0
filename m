Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNwtyyTsqJMA6wQJqf2EhbzDNo9/il/W7vMrwloXBNo=;
 b=FobI3sqmZnhbqmKNJCLdJjRcUOkDqtdASa5Q4qTfAwAffpLG4eTgbrJ6ltcYnfoPamT4zI/KEPJyCAIiPaTjS0B4QjKjiz3a/BRanlBnwnpAdKsPFnwQTedpwVamaOFtLq/MnG9lC4mDnzBbbIMXfM+03Bv0JP3/yXE3h4qwgEg=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 9 Aug 2021 12:32:39 +0000
Message-ID: <20210809123238.pi26xjxraaczemne@skbuf>
References: <20210801231730.7493-1-vladimir.oltean@nxp.com>
 <YREcqAdU+6IpT0+w@shredder>
In-Reply-To: <YREcqAdU+6IpT0+w@shredder>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D3D05FF3A807554085480A6B8D572C04@eurprd04.prod.outlook.com>
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

On Mon, Aug 09, 2021 at 03:16:40PM +0300, Ido Schimmel wrote:
> On Mon, Aug 02, 2021 at 02:17:30AM +0300, Vladimir Oltean wrote:
> > diff --git a/net/bridge/br.c b/net/bridge/br.c
> > index ef743f94254d..bbab9984f24e 100644
> > --- a/net/bridge/br.c
> > +++ b/net/bridge/br.c
> > @@ -166,7 +166,8 @@ static int br_switchdev_event(struct notifier_block=
 *unused,
> >  	case SWITCHDEV_FDB_ADD_TO_BRIDGE:
> >  		fdb_info =3D ptr;
> >  		err =3D br_fdb_external_learn_add(br, p, fdb_info->addr,
> > -						fdb_info->vid, false);
> > +						fdb_info->vid,
> > +						fdb_info->is_local, false);
>=20
> When 'is_local' was added in commit 2c4eca3ef716 ("net: bridge:
> switchdev: include local flag in FDB notifications") it was not
> initialized in all the call sites that emit
> 'SWITCHDEV_FDB_ADD_TO_BRIDGE' notification, so it can contain garbage.

Thanks for the report, I'll send a patch which adds a:

	memset(&info, 0, sizeof(info));

to all SWITCHDEV_FDB_*_TO_BRIDGE call sites.=
