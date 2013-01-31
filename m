Return-Path: <mirqus@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:mime-version:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type:content-transfer-encoding;
	bh=savfkZlPHfsKUtzRV7sqev1PSYCitydGRHiDqVHXxvs=;
	b=Ojw715f7Dl5Dde2YaMWhJK7TRz+ed13rhrhU9ybQcVaLf+zGJO+a7jDipf1cQVmxQn
	wGpPxqkrpLEtpq4lOJOiy0uUFe3NXkh9OrYOL382AArSN1TnnP9fdg5ma//n6U+1eUAC
	VUFGsDKz7/EjBd840NI/jq0X/v/g1V6cWXXprluymfK9br3cQtuLavxLcJ8zfMkUp8Yz
	YSXkC+DNyt/Xqb+NJqmaYHjb0O+nvHQfPqrq8huGhmDKchBSK2XEEKEkIJR0x0ajqwVH
	1Qokk0ioKeODZI52Jw+cwYWthLqu6TorvG9AsjuqHEkMbOZflWxUsUQCY8a+0A72HJAm
	42fw==
MIME-Version: 1.0
In-Reply-To: <1359601979-14942-4-git-send-email-vyasevic@redhat.com>
References: <1359601979-14942-1-git-send-email-vyasevic@redhat.com>
	<1359601979-14942-4-git-send-email-vyasevic@redhat.com>
From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Date: Thu, 31 Jan 2013 21:03:16 +0100
Message-ID: <CAHXqBFLQofoWPN9nfAKc6xumjzO3hu7ue3r=bHYerypAuRW0qw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH v7 net-next 03/12] bridge: Verify that a vlan
 is allowed to egress on give port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vlad Yasevich <vyasevic@redhat.com>
Cc: netdev@vger.kernel.org, shemminger@vyatta.com, bridge@lists.linux-foundation.org, davem@davemloft.net, shmulik.ladkani@gmail.com

2013/1/31 Vlad Yasevich <vyasevic@redhat.com>:
> When bridge forwards a frame, make sure that a frame is allowed
> to egress on that port.

For egress checks it might be better to have per-vlan bitmaps of ports
instead. For unicast this doesn't really change anything, but for
broadcast and multicast all ports are checked so reading all bits from
one location is going to be cheaper.

[...]
> -static inline struct net_port_vlans *br_get_vlan_info(struct net_bridge =
*br)
> +static inline struct net_port_vlans *br_get_vlan_info(
> +                                               const struct net_bridge *=
br)
>  {
>         return rcu_dereference(br->vlan_info);
>  }
>
> -static inline struct net_port_vlans *nbp_get_vlan_info(struct net_bridge=
_port *p)
> +static inline struct net_port_vlans *nbp_get_vlan_info(
> +                                               const struct net_bridge_p=
ort *p)
>  {
>         return rcu_dereference(p->vlan_info);
>  }

Shouldn't this be in patch 1?

Best Regards,
Micha=B3 Miros=B3aw
