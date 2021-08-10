Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLb2dFaA/i+r10mugho/BSKWmbLC5ufz+fTQ5w2O9C4=;
 b=IP02/TwcEpgNSF/OS+TW0++1iVOBwv1YFQWgyxbIDb6isnvSWxD5sLqc3WRPD0k66tH2Py1XXr453a4xivXWcBZMQbPtdVlqVYDxKrKz5ldV5seM3ppFhtIYGVsnBnKTJSL8OtY7Vjd8BA6kxyHvFd16F1sB6DvGfoDWKupoPOo=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 10 Aug 2021 13:50:09 +0000
Message-ID: <20210810135009.tn435h75r24qslgh@skbuf>
References: <20210810072139.1597621-1-razor@blackwall.org>
 <20210810110010.43859-1-razor@blackwall.org>
In-Reply-To: <20210810110010.43859-1-razor@blackwall.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <35E3BAAE9FBE9B4494ED82EFA5EE2C96@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net v2] net: bridge: fix flags interpretation
 for extern learn fdb entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, "roopa@nvidia.com" <roopa@nvidia.com>

On Tue, Aug 10, 2021 at 02:00:10PM +0300, Nikolay Aleksandrov wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
>=20
> Ignore fdb flags when adding port extern learn entries and always set
> BR_FDB_LOCAL flag when adding bridge extern learn entries. This is
> closest to the behaviour we had before and avoids breaking any use cases
> which were allowed.
>=20
> This patch fixes iproute2 calls which assume NUD_PERMANENT and were
> allowed before, example:
> $ bridge fdb add 00:11:22:33:44:55 dev swp1 extern_learn
>=20
> Extern learn entries are allowed to roam, but do not expire, so static
> or dynamic flags make no sense for them.
>=20
> Also add a comment for future reference.
>=20
> Fixes: eb100e0e24a2 ("net: bridge: allow to add externally learned entrie=
s from user-space")
> Fixes: 0541a6293298 ("net: bridge: validate the NUD_PERMANENT bit when ad=
ding an extern_learn FDB entry")
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Tested-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>=
