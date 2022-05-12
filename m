Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSWYUfdKb47f1Ctp8M5EvyOjUh/+POZHDVSpFR8FCpI=;
 b=oFFBe2+Qjjza1eZgP94WQEGMH7IXu44CJMLRPp6XljyoggOAiBftzTMGbQHyPR9a02aDIw61M8Zj+/3EGxYbO2Q2U2/0UXYeE07aGGh/lt4ZRgzgbnl+j5HZxkrHyX/FfV2llwIR9mjJ6kJ226th+kvsE8vVQ/eW2x/TYpfgLGk=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 12 May 2022 17:50:56 +0000
Message-ID: <20220512175055.65ftcpkig3t3ttsq@skbuf>
References: <cover.1652348961.git.eng.alaamohamedsoliman.am@gmail.com>
 <c6069fb695b25dc2f33e8017023ddd47c58caa8d.1652348962.git.eng.alaamohamedsoliman.am@gmail.com>
 <c5ec2677-3047-8a70-9769-d48a79703220@nvidia.com>
 <20220512094743.79f36d81@kernel.org>
 <c6b41db9-78e7-e752-3945-29c70a3d8cb4@nvidia.com>
In-Reply-To: <c6b41db9-78e7-e752-3945-29c70a3d8cb4@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1FBBF271EF790D4EA63BD40553277A08@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v7 2/2] net: vxlan: Add extack support
 to vxlan_fdb_delete
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
Cc: "shshaikh@marvell.com" <shshaikh@marvell.com>, "jdenham@redhat.com" <jdenham@redhat.com>, "GR-Linux-NIC-Dev@marvell.com" <GR-Linux-NIC-Dev@marvell.com>, "manishc@marvell.com" <manishc@marvell.com>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "outreachy@lists.linux.dev" <outreachy@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "razor@blackwall.org" <razor@blackwall.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "sbrivio@redhat.com" <sbrivio@redhat.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>, "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>

On Thu, May 12, 2022 at 10:17:13AM -0700, Roopa Prabhu wrote:
>=20
> On 5/12/22 09:47, Jakub Kicinski wrote:
> > On Thu, 12 May 2022 09:22:17 -0700 Roopa Prabhu wrote:
> > > On 5/12/22 02:55, Alaa Mohamed wrote:
> > > > This patch adds extack msg support to vxlan_fdb_delete and vxlan_fd=
b_parse.
> > > > extack is used to propagate meaningful error msgs to the user of vx=
lan
> > > > fdb netlink api
> > > >=20
> > > > Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> > Also the patches don't apply to net-next, again.
>=20
> that's probably because the patches were already applied. Ido just told m=
e
> abt it also
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commi=
t/?id=3D5dd6da25255a9d64622c693b99d7668da939a980
>=20
> I have requested Alaa send an incremental fix (offline).
>=20
> thanks
>

Alaa, when you send the incremental fixup patch requested by Roopa,
could you please also:

- properly align the extack argument of the ocelot_port_fdb_del()
  function
- properly align the extack argument of the vxlan_fdb_delete() function
- properly align the "DST, VNI, ifindex and port are mutually exclusive wit=
h NH_ID"
  string to the open parenthesis of the NL_SET_ERR_MSG macro in vxlan_fdb_p=
arse().
- make actual use of the extack in ice_fdb_add() and ice_fdb_del(), and
  remove the __always_unused from ice_fdb_add().

Thank you.=
