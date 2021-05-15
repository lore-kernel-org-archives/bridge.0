Return-Path: <groeck7@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=Di0tqQRWLN116HzASz5hiSUHMEBmVNCl6fxRwEe3CFk=;
 b=f+jMnZN0cLBSqvApg/1qJq/cF1cVYc3CpgJKG8GQBoLex92Jp2NG9PuGnfZnIkifdp
 EHbAvdtIakodfGPxpErihof3l0WHWeGkVcvoxt9oUEofkDzNDJIIAhvGwBR0zZEIhRoY
 9Dr/qC8+m395QhSuoilv4Ljyb0VdVCQwff4Ifa58Iv7N2xFs5ceoHs4tfB0669zWBV5p
 bD6/ADBx1QvRYMTRQ17utQzZHxgzEtBcOboz1A6JhjdjkoQW47OE5vmH+OgxMzvsTMFo
 ZiNk15+bVeIXtjXTx1qboJNN0Qw8F6mZMMA6GibYC7LNIqgmlPbUHX6qf3hK7gvBRv3c
 /OzA==
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 15 May 2021 09:44:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20210515164457.GA1387203@roeck-us.net>
References: <20210513132053.23445-1-linus.luessing@c0d3.blue>
 <20210513132053.23445-6-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210513132053.23445-6-linus.luessing@c0d3.blue>
Subject: Re: [Bridge] [net-next v4 05/11] net: bridge: mcast: prepare
 is-router function for mcast router split
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>

On Thu, May 13, 2021 at 03:20:47PM +0200, Linus L=FCssing wrote:
> In preparation for the upcoming split of multicast router state into
> their IPv4 and IPv6 variants make br_multicast_is_router() protocol
> family aware.
>=20
> Note that for now br_ip6_multicast_is_router() uses the currently still
> common ip4_mc_router_timer for now. It will be renamed to
> ip6_mc_router_timer later when the split is performed.
>=20
> While at it also renames the "1" and "2" constants in
> br_multicast_is_router() to the MDB_RTR_TYPE_TEMP_QUERY and
> MDB_RTR_TYPE_PERM enums.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>

Just in case this hasn't been reported yet. In next-20210514:

$ git grep br_multicast_is_router
net/bridge/br_input.c:                      br_multicast_is_router(br, skb)=
) {
net/bridge/br_multicast.c:      is_router =3D br_multicast_is_router(br, NU=
LL);
net/bridge/br_private.h:br_multicast_is_router(struct net_bridge *br, struc=
t sk_buff *skb)
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^
net/bridge/br_private.h:static inline bool br_multicast_is_router(struct ne=
t_bridge *br)
                                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^

Guenter
