Return-Path: <mirqus@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:mime-version:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type:content-transfer-encoding;
	bh=mwaoAeuaPAky0xX51Js9KtmZx7zIGL8Mo+AlknkCYR0=;
	b=SpLt/sL8y2s1A0QwYBbxfyWJPxubFwDuSOr8vS9OvMUQKUsXxVzuNjPYw0DuDW4Pzh
	jZ2rlG7S56b8KtzUXc4y24bUk3WeuWeTvZruNrDnF56Q6DYUoG5ewrEultJ0ORut8ITk
	fjK2TqBzmcspUxJruwUuAZDAJxidxHIyz+t5PKJ18n+UsYHr6ebzZXAqA34RqlzHHjGR
	zxuzHds4LpN4U1tt76SbhcWR13jtTKOhs50PgzwBJSSRL8ekQSv5yC6t6caaJqrBBCM1
	sbkd8Tc8EXPSA4ylwSTDrUVsnTowissGCLZT3+6ppPLo/FAKIhWC7lHPRjipN/70e5ib
	aU7Q==
MIME-Version: 1.0
In-Reply-To: <1359748930-31475-3-git-send-email-vyasevic@redhat.com>
References: <1359748930-31475-1-git-send-email-vyasevic@redhat.com>
	<1359748930-31475-3-git-send-email-vyasevic@redhat.com>
From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Date: Sat, 2 Feb 2013 02:04:02 +0100
Message-ID: <CAHXqBFLTaPbReQh-vgc_kbBbUtEWOFyE2oq85boWoHFD2+Tm9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH v9 net-next 02/12] bridge: Validate that vlan
 is permitted on ingress
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vlad Yasevich <vyasevic@redhat.com>
Cc: netdev@vger.kernel.org, shemminger@vyatta.com, bridge@lists.linux-foundation.org, davem@davemloft.net

2013/2/1 Vlad Yasevich <vyasevic@redhat.com>:
> When a frame arrives on a port or transmitted by the bridge,
> if we have VLANs configured, validate that a given VLAN is allowed
> to enter the bridge.
[...]
> +static inline struct net_port_vlans *br_get_vlan_info(
> +                                               const struct net_bridge *=
br)
> +{
> +       return rcu_dereference(br->vlan_info);
> +}
> +
> +static inline struct net_port_vlans *nbp_get_vlan_info(
> +                                               const struct net_bridge_p=
ort *p)
> +{
> +       return rcu_dereference(p->vlan_info);
> +}

Those should go to patch #1.

Best Regards,
Micha=C5=82 Miros=C5=82aw
