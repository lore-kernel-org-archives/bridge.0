Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F0C74098D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0DED44097D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Y2EdN1b7RhysOT15RURE5ha+GdNMYogbP0VztCt1Rok=;
 b=XTGZDwzwD7eX7RMU3MkCmQaarNWCP1ZYYsSHu7vW45fUcT6YElvg/pJhJMcK4zhkke
 qQwFyH0ov5WVMiH9ZXUWDumfqZ8qDlx5aFLNULcbNb9O6Yf5/Ek2PXRSf7VOYPSvaPMN
 gZiAevFtKr2P8WU6YvJtC6JvdaLvNeqIq58Y0rOXcSCtQA2p8GDsK2NvRbDVBCIGJRrI
 5MrbcO1HAKRDZ35tDTViDqXeLspHGPf7836l96EwN+aGcheAPrzNwRlOGKU2jKl5jS5U
 5qHWkieGFVY8zYaxR6ld7b9MNDmL7kXy+R0eboXoNsdfvzlB6p/pjqOiD6JZohwAfAhQ
 9EzQ==
Date: Tue, 01 Nov 2022 21:04:24 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221101185753.2120691-1-idosch@nvidia.com>
References: <20221101185753.2120691-1-idosch@nvidia.com>
Message-ID: <FB8BCFAD-D132-4B8A-BE01-859327F22D19@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net] bridge: Fix flushing of dynamic FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 1 November 2022 20:57:53 EET, Ido Schimmel <idosch@nvidia=2Ecom> wrote:
>The following commands should result in all the dynamic FDB entries
>being flushed, but instead all the non-local (non-permanent) entries are
>flushed:
>
> # bridge fdb add 00:aa:bb:cc:dd:ee dev dummy1 master static
> # bridge fdb add 00:11:22:33:44:55 dev dummy1 master dynamic
> # ip link set dev br0 type bridge fdb_flush
> # bridge fdb show brport dummy1
> 00:00:00:00:00:01 master br0 permanent
> 33:33:00:00:00:01 self permanent
> 01:00:5e:00:00:01 self permanent
>
>This is because br_fdb_flush() works with FDB flags and not the
>corresponding enumerator values=2E Fix by passing the FDB flag instead=2E
>
>After the fix:
>
> # bridge fdb add 00:aa:bb:cc:dd:ee dev dummy1 master static
> # bridge fdb add 00:11:22:33:44:55 dev dummy1 master dynamic
> # ip link set dev br0 type bridge fdb_flush
> # bridge fdb show brport dummy1
> 00:aa:bb:cc:dd:ee master br0 static
> 00:00:00:00:00:01 master br0 permanent
> 33:33:00:00:00:01 self permanent
> 01:00:5e:00:00:01 self permanent
>
>Fixes: 1f78ee14eeac ("net: bridge: fdb: add support for fine-grained flus=
hing")
>Signed-off-by: Ido Schimmel <idosch@nvidia=2Ecom>
>---
> net/bridge/br_netlink=2Ec  | 2 +-
> net/bridge/br_sysfs_br=2Ec | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/net/bridge/br_netlink=2Ec b/net/bridge/br_netlink=2Ec
>index 5aeb3646e74c=2E=2Ed087fd4c784a 100644
>--- a/net/bridge/br_netlink=2Ec
>+++ b/net/bridge/br_netlink=2Ec
>@@ -1332,7 +1332,7 @@ static int br_changelink(struct net_device *brdev, =
struct nlattr *tb[],
>=20
> 	if (data[IFLA_BR_FDB_FLUSH]) {
> 		struct net_bridge_fdb_flush_desc desc =3D {
>-			=2Eflags_mask =3D BR_FDB_STATIC
>+			=2Eflags_mask =3D BIT(BR_FDB_STATIC)
> 		};
>=20
> 		br_fdb_flush(br, &desc);
>diff --git a/net/bridge/br_sysfs_br=2Ec b/net/bridge/br_sysfs_br=2Ec
>index 612e367fff20=2E=2Eea733542244c 100644
>--- a/net/bridge/br_sysfs_br=2Ec
>+++ b/net/bridge/br_sysfs_br=2Ec
>@@ -345,7 +345,7 @@ static int set_flush(struct net_bridge *br, unsigned =
long val,
> 		     struct netlink_ext_ack *extack)
> {
> 	struct net_bridge_fdb_flush_desc desc =3D {
>-		=2Eflags_mask =3D BR_FDB_STATIC
>+		=2Eflags_mask =3D BIT(BR_FDB_STATIC)
> 	};
>=20
> 	br_fdb_flush(br, &desc);

Oops=2E :)
Acked-by: Nikolay Aleksandrov <razor@blackwall=2Eorg>

