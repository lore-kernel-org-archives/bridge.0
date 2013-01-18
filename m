Return-Path: <mirqus@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:mime-version:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type:content-transfer-encoding;
	bh=m19p11Kn3kRZZ8vevoRrdj2Vl2O2FfhnbYeRy6uVIbY=;
	b=yUI1XSNPD0yoLxK9JrG8TQLzL8QePaX2fcBcHYCvnSBsZOVWg187KQPyCTEmNJe3c2
	tXZo0tB/5SWi3slTp36tAop7GpLTx4TiZNVjtSPZdk55G5/xcSE1Zw082OeZCjaufQD2
	dAozJqFIheD28Y1BtKqiDuBgypnK71OZu9jciwdsgEDS/1VYiEY7/kxHIS/7YVE9hJX5
	24AltSxbYj7HhtNWwaEAUjkyo0M7AMbKFFL+PnGX1lnSXobMSaxBsDagQVA0IZJbp6B2
	V1dBFa3bJF3aJquTfRZxtK/8cNMOT9O7gc2n7V9JCdqS5sWNYsJgdnoP2Hv1Ur0Su7kT
	DwHQ==
MIME-Version: 1.0
In-Reply-To: <1358360289-23249-3-git-send-email-vyasevic@redhat.com>
References: <1358360289-23249-1-git-send-email-vyasevic@redhat.com>
	<1358360289-23249-3-git-send-email-vyasevic@redhat.com>
From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Date: Fri, 18 Jan 2013 02:57:14 +0100
Message-ID: <CAHXqBFKg6Vp5=dprDYKON2LmshhX+nSPF7KRHiQmOS68PrQq-A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next V6 02/14] bridge: Add vlan filtering
	infrastructure
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vlad Yasevich <vyasevic@redhat.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, shmulik.ladkani@gmail.com, shemminger@vyatta.com, davem@davemloft.net

2013/1/16 Vlad Yasevich <vyasevic@redhat.com>:
[...]
> --- /dev/null
> +++ b/net/bridge/br_vlan.c
[...]
> +struct net_port_vlan *nbp_vlan_find(const struct net_port_vlans *v, u16 =
vid)
> +{
> +       struct net_port_vlan *pve;
> +
> +       /* Must be done either in rcu critical section or with RTNL held =
*/
> +       WARN_ON_ONCE(!rcu_read_lock_held() && !rtnl_is_locked());
> +
> +       list_for_each_entry_rcu(pve, &v->vlan_list, list) {
> +               if (pve->vid =3D=3D vid)
> +                       return pve;
> +       }
> +
> +       return NULL;
> +}

This looks expensive - it's O(n) with n =3D number of configured VLANs on a=
 port.
And this is called for every packet. The bridge already has a hash of VLAN
structures found by br_vlan_find(). You could add a second bitmap there
(eg. ingres_ports[]) and check port's bit instead of walking the list.
You would use a bit more memory (64 bytes minus the removed list-head)
per configured VLAN but save some cycles in hot path.

Best Regards,
Micha=B3 Miros=B3aw
