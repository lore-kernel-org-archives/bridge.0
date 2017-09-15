Return-Path: <vincent@bernat.im>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bernat.im; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=postfix; bh=cO00Z4JV3D5eI6UtRE72Z+5T6XI=; b=ZWF
	vVWwHbJNQx6dBjfQPPyF4BJrPMJ32D32wGu46Yle9+ccwXnbs10Yw6nXLeUJeA5x
	/IO6rglAPS2yHgefAPFppVDQYahJ3dhaVMyGXE2TsFyvHjPFVwPGr/3TPIonylSr
	0OJHHGeZtffov7cVpSlXFrJwMRFf0cPqnU6XRZnc=
From: Vincent Bernat <vincent@bernat.im>
References: <20170915193808.22338-1-vincent@bernat.im>
In-Reply-To: <20170915193808.22338-1-vincent@bernat.im> (Vincent Bernat's
	message of "Fri, 15 Sep 2017 21:38:08 +0200")
Message-ID: <m3zi9vbrfp.fsf@luffy.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next v1] bridge: also trigger RTM_NEWLINK
	when interface is released from bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Fri, 15 Sep 2017 21:17:10 -0000
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>

 =E2=9D=A6 15 septembre 2017 21:38 +0200, Vincent Bernat <vincent@bernat.im=
>=C2=A0:

> Currently, when an interface is released from a bridge, we get a
> RTM_DELLINK event through netlink:
>
> Deleted 2: dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 =
state UNKNOWN
>     link/ether 6e:23:c2:54:3a:b3

It should be noted this only happens when using the ioctl API. When
using the netlink API, rtnetlink.c will send a RTM_NEWLINK because of
the modification.
--=20
When in doubt, tell the truth.
		-- Mark Twain
