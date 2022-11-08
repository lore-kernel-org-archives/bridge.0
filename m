Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 78931404BF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C4436401A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=P0Vrqb0dV10ZcDKDMyGy8PmlBFfLVXxuYtbQVL//Jq0=;
 b=5m4zQpr7pvvBisJk52ZcXiS7iceaQyBjJq4K1ZygUmcjudl74qEXu+WlE0WagbOVgh
 le1LtiT0xTvcc1YUvxmUcvxYS4K4ocQLV01A+WtNUoqfHQE+Zno+h2XCQDT4ybc8AVl7
 qtbvjGo2ZzO52aS+yaNu2vEKXTX+RWN7FYxC/kXa4FjNXfrlL+/F22Lixve/lqMiohRf
 Ok5ZL8E7gpozkChiriUTC1adI38mXus30k3ykmyEM35hjnYoc6adziJdWS7S2ziqA9VM
 WzS2te2ucIkO1aOcMzhT3MHC09x6XoPlrdBK0wPoFHpMqAUDAKK44ySyGuskRg+Nosjs
 rETw==
Date: Tue, 08 Nov 2022 14:02:05 -0400
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <2db3f3f1eff65e42c92a8e3a5626d64f46e68edc.1667902754.git.petrm@nvidia.com>
References: <cover.1667902754.git.petrm@nvidia.com>
 <2db3f3f1eff65e42c92a8e3a5626d64f46e68edc.1667902754.git.petrm@nvidia.com>
Message-ID: <E8F3691A-66B2-49F6-93AB-3C175CC559F1@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next 03/15] bridge: switchdev: Reflect MAB
	bridge port flag to device drivers
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

On 8 November 2022 06:47:09 GMT-04:00, Petr Machata <petrm@nvidia=2Ecom> wr=
ote:
>From: Ido Schimmel <idosch@nvidia=2Ecom>
>
>Reflect the 'BR_PORT_MAB' flag to device drivers so that:
>
>* Drivers that support MAB could act upon the flag being toggled=2E
>* Drivers that do not support MAB will prevent MAB from being enabled=2E
>
>Signed-off-by: Ido Schimmel <idosch@nvidia=2Ecom>
>Reviewed-by: Petr Machata <petrm@nvidia=2Ecom>
>Signed-off-by: Petr Machata <petrm@nvidia=2Ecom>
>---
>
>Notes:
>    v1:
>    * New patch=2E
>
> net/bridge/br_switchdev=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>

Acked-by: Nikolay Aleksandrov <razor@blackwall=2Eorg>

>diff --git a/net/bridge/br_switchdev=2Ec b/net/bridge/br_switchdev=2Ec
>index 8a0abe35137d=2E=2E7eb6fd5bb917 100644
>--- a/net/bridge/br_switchdev=2Ec
>+++ b/net/bridge/br_switchdev=2Ec
>@@ -71,7 +71,7 @@ bool nbp_switchdev_allowed_egress(const struct net_brid=
ge_port *p,
> }
>=20
> /* Flags that can be offloaded to hardware */
>-#define BR_PORT_FLAGS_HW_OFFLOAD (BR_LEARNING | BR_FLOOD | \
>+#define BR_PORT_FLAGS_HW_OFFLOAD (BR_LEARNING | BR_FLOOD | BR_PORT_MAB |=
 \
> 				  BR_MCAST_FLOOD | BR_BCAST_FLOOD | BR_PORT_LOCKED | \
> 				  BR_HAIRPIN_MODE | BR_ISOLATED | BR_MULTICAST_TO_UNICAST)
>=20

