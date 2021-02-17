Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06lku1VLDwnTxzqqiCIOKPjsSlw8LNx4PZpLXgBnDNA=;
 b=b8VrmMZyN3Ug5QiORMn/5PjAVWorevHWZITfTlWhbtzdxA4F/bwlDn0eOFzX0TwCzLmwdU4Cx+DDyRHQhaeOnZPSHj9T0LT/MZsk7jUIJxymghfKb0CtgZLj9X+jSpH/AFS6rP43amU2rWJQy+J6HSsFrHAUYKG7NVPYCmGKuew=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Wed, 17 Feb 2021 10:24:49 +0000
Message-ID: <20210217102448.oea5dwl2qnhybir3@skbuf>
References: <20210216214205.32385-1-horatiu.vultur@microchip.com>
 <20210216214205.32385-9-horatiu.vultur@microchip.com>
In-Reply-To: <20210216214205.32385-9-horatiu.vultur@microchip.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A48D8AA98F35B34D9F68B6F85E2DB033@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v4 8/8] net: dsa: felix: Add support
	for MRP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>, "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "nikolay@nvidia.com" <nikolay@nvidia.com>, "roopa@nvidia.com" <roopa@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>

On Tue, Feb 16, 2021 at 10:42:05PM +0100, Horatiu Vultur wrote:
> @@ -112,6 +113,7 @@ static struct sk_buff *ocelot_rcv(struct sk_buff *skb=
,
>  	ocelot_xfh_get_qos_class(extraction, &qos_class);
>  	ocelot_xfh_get_tag_type(extraction, &tag_type);
>  	ocelot_xfh_get_vlan_tci(extraction, &vlan_tci);
> +	ocelot_xfh_get_cpuq(extraction, &cpuq);
> =20
>  	skb->dev =3D dsa_master_find_slave(netdev, 0, src_port);
>  	if (!skb->dev)
> @@ -126,6 +128,12 @@ static struct sk_buff *ocelot_rcv(struct sk_buff *sk=
b,
>  	skb->offload_fwd_mark =3D 1;
>  	skb->priority =3D qos_class;
> =20
> +#if IS_ENABLED(CONFIG_BRIDGE_MRP)
> +	if (eth_hdr(skb)->h_proto =3D=3D cpu_to_be16(ETH_P_MRP) &&
> +	    cpuq & BIT(OCELOT_MRP_CPUQ))

Checking the EtherType seems redundant, since those are the only frames
trapped to the MRP CPU queue.

Also, the cpuq variable is potentially unused when CONFIG_BRIDGE_MRP is
unset. I'm concerned that static analysis people may come in and try to
fix it up with even more ifdeffery, which is definitely not what I would
like to go for.

How about just the following, which is not conditionally compiled:
	if (!(cpuq & BIT(OCELOT_MRP_CPUQ)))
		skb->offload_fwd_mark =3D 1;

> +		skb->offload_fwd_mark =3D 0;
> +#endif
> +
>  	/* Ocelot switches copy frames unmodified to the CPU. However, it is
>  	 * possible for the user to request a VLAN modification through
>  	 * VCAP_IS1_ACT_VID_REPLACE_ENA. In this case, what will happen is that
> --=20
> 2.27.0
> =
