Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=3gwgxIcOqE5uF/OjhyD26h/VZb8bHqeUQbavo2adA/s=;
	b=Iwr3wRPx+jtZ69CODcTkuypCpH8jic5LqxvshpI8sTH+F+x3SYjjbXDEQ8VztfDUh3
	e99Z1sreUdITvzfvgpMo9YsDvoxlTytGaBvDHuefJvC2vaBH/BtzwwoQ0RNSd9+c19fK
	3kL1IR3uA8VVDjxqGvZUoYV4jpFB9bo6xYBFESvcqCu+QobV5vaVtx5LcSYbS1dR9I/w
	QBP2AwemsAT6Vp/y6/4mHQPHkUISyHxZ2fARw2sC9GxgOayMXPj9Js6JDBaeCKSqGBX7
	Cpniuvxti4+L2uZDSUSJ1CIa7gK0nFabK8+8vhr2iv2/rHzLcJVcSDWN6ORnw75J+HU+
	ulgA==
Date: Thu, 19 Jan 2017 11:05:20 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20170119110520.24dfd34d@xeon-e3>
In-Reply-To: <20170119024510.3284-1-linus.luessing@c0d3.blue>
References: <20170119024510.3284-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next v4] bridge: multicast to unicast
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Felix Fietkau <nbd@nbd.name>

On Thu, 19 Jan 2017 03:45:10 +0100
Linus L=C3=BCssing <linus.luessing@c0d3.blue> wrote:

> From: Felix Fietkau <nbd@nbd.name>
>=20
> Implements an optional, per bridge port flag and feature to deliver
> multicast packets to any host on the according port via unicast
> individually. This is done by copying the packet per host and
> changing the multicast destination MAC to a unicast one accordingly.
>=20
> multicast-to-unicast works on top of the multicast snooping feature of
> the bridge. Which means unicast copies are only delivered to hosts which
> are interested in it and signalized this via IGMP/MLD reports
> previously.
>=20
> This feature is intended for interface types which have a more reliable
> and/or efficient way to deliver unicast packets than broadcast ones
> (e.g. wifi).
>=20
> However, it should only be enabled on interfaces where no IGMPv2/MLDv1
> report suppression takes place. This feature is disabled by default.
>=20
> The initial patch and idea is from Felix Fietkau.
>=20
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> [linus.luessing@c0d3.blue: various bug + style fixes, commit message]
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
>=20

In general this looks good.

One issue I see is how existing entries are handled when the bridge port fl=
ags
are changed dynamically. It might be better to always record the necessary =
data
in the bridge_port_group and not have a per-entry flag bit. In your current
patch the API changes the response to future IGMP but does not take instant
effect. Code would be simpler if there was less logic to handle per-entry f=
lags.

Also, you might want to add sysfs interface for the attribute as well.
