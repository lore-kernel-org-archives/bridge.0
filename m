Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=XgxNuth0Y6EPA2OS6Oho773GNY1Eiz6rBFCbXp6LaNk=;
	b=Qj+NgNBLgVaqIEA9vZ3PL0/ZHf62N2Xq/F5+w7dahu4NvET7ZvwZ/hrZOmPqGVYCzHeP4ugC//DXk3hoOmBCxMNMQx06KwBuNHwnBomXVkVJESgZ+h/KRmFu58Vf8J251sDO8EgGlffWT6VuPjFvRKDpsVwcTDV7SttVOcHARa4=
From: Petr Machata <petrm@mellanox.com>
References: <cover.1527503302.git.petrm@mellanox.com>
	<40d11322cdf295d5f5b03d7acaf997486e68ed2f.1527503302.git.petrm@mellanox.com>
Date: Mon, 28 May 2018 16:39:00 +0300
In-Reply-To: <40d11322cdf295d5f5b03d7acaf997486e68ed2f.1527503302.git.petrm@mellanox.com>
	(Petr Machata's message of "Mon, 28 May 2018 12:49:55 +0200")
Message-ID: <wihk1rngarv.fsf@dev-r-vrt-156.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next v2 1/7] net: bridge: Extract
	boilerplate around switchdev_port_obj_*()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: devel@driverdev.osuosl.org, f.fainelli@gmail.com, andrew@lunn.ch, nikolay@cumulusnetworks.com, gregkh@linuxfoundation.org, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, vivien.didelot@savoirfairelinux.com, davem@davemloft.net

Petr Machata <petrm@mellanox.com> writes:

> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 11520ed..33bd914 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -1178,6 +1178,9 @@ static inline void br_switchdev_frame_unmark(struct sk_buff *skb)
>  }
>  #endif /* CONFIG_NET_SWITCHDEV */
>  
> +int br_switchdev_port_vlan_add(struct net_device *dev, u16 vid, u16 flags);
> +int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid);
> +

Nope, this actually does need to be in the ifdef block. The whole
br_switchdev.c is built conditionally.

I'll send v3.

Petr
