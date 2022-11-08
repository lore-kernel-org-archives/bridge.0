Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2ED1B40297
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 752AC40116
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wDrq2KVoUCxkhxO6WpTTyZbqFCb6qloqTFLoADCq7ok=;
 b=hZMmHshSNADKZamj2Bl4ylyYFEWjU0kz6N9zuO1+U0zleujiKgoM4TX0bM6OZUqaEm
 pQSgJbEgzt5ZYsl9FcgDapOpJe7HScO3RHf6B2R6hICdI7zpCNaNDqKbCJ1CyH76TRk/
 4ztAez3Nio3lp9AX6bo+xtsZX8SZPPP8P0oz//bM1WfdQ94tgxZEwVJ67QdA7mXnV7bO
 c1Q2v3yUADNOyalJSL1ZKqXE42AQR0n8A85gW1qgi04Jj+YO5F2o10JDLw4qtwm90P7c
 PM1A596+wCzDo28uMju9vCNyIFX8PlcHqsgzzC5WiP0KduUyOVhANmWdN1JF5yEVyg3Y
 StDA==
Date: Tue, 08 Nov 2022 14:01:17 -0400
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <b266dcf6d647684a10984d12f98549f93fd378ab.1667902754.git.petrm@nvidia.com>
References: <cover.1667902754.git.petrm@nvidia.com>
 <b266dcf6d647684a10984d12f98549f93fd378ab.1667902754.git.petrm@nvidia.com>
Message-ID: <31C46FC0-3ABB-4FD1-B44B-D467C81C6340@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next 01/15] bridge: switchdev: Let device
	drivers determine FDB offload indication
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, mlxsw@nvidia.com, Jiri Pirko <jiri@nvidia.com>, "Hans J . Schultz" <netdev@kapio-technology.com>

On 8 November 2022 06:47:07 GMT-04:00, Petr Machata <petrm@nvidia=2Ecom> wr=
ote:
>From: Ido Schimmel <idosch@nvidia=2Ecom>
>
>Currently, FDB entries that are notified to the bridge via
>'SWITCHDEV_FDB_ADD_TO_BRIDGE' are always marked as offloaded=2E With MAB
>enabled, this will no longer be universally true=2E Device drivers will
>report locked FDB entries to the bridge to let it know that the
>corresponding hosts required authorization, but it does not mean that
>these entries are necessarily programmed in the underlying hardware=2E
>
>Solve this by determining the offload indication based of the
>'offloaded' bit in the FDB notification=2E
>
>Signed-off-by: Ido Schimmel <idosch@nvidia=2Ecom>
>Reviewed-by: Petr Machata <petrm@nvidia=2Ecom>
>Signed-off-by: Petr Machata <petrm@nvidia=2Ecom>
>---
> net/bridge/br=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>

Acked-by: Nikolay Aleksandrov <razor@blackwall=2Eorg>

>diff --git a/net/bridge/br=2Ec b/net/bridge/br=2Ec
>index 96e91d69a9a8=2E=2E145999b8c355 100644
>--- a/net/bridge/br=2Ec
>+++ b/net/bridge/br=2Ec
>@@ -172,7 +172,7 @@ static int br_switchdev_event(struct notifier_block *=
unused,
> 			break;
> 		}
> 		br_fdb_offloaded_set(br, p, fdb_info->addr,
>-				     fdb_info->vid, true);
>+				     fdb_info->vid, fdb_info->offloaded);
> 		break;
> 	case SWITCHDEV_FDB_DEL_TO_BRIDGE:
> 		fdb_info =3D ptr;

