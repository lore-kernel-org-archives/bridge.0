Return-Path: <vladimir.oltean@nxp.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3C886410B2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DA1ED409E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JJJB+CDMZx6MOhV2+WKtF8/AgZJPNv12+bo4pB3o6c=;
 b=WD6jIwEMe1Nm1acW4VJG/1GE9MrWAz1/4jlXZOTnxODX068g4hpfXYCpjglaFVk4UP0h49m0VaeU+wHW1hMC7ZXZh6fOdt9/SBXoWXH/oR7vXILvWIRxNTdPVm0mPEymFCeHe7ted6ADsivXV5M3az5ky4ZRxnguPk3RelHVfhI=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 27 Oct 2022 23:49:08 +0000
Message-ID: <20221027234906.pm744rd2srwbq7be@skbuf>
References: <20221025100024.1287157-1-idosch@nvidia.com>
In-Reply-To: <20221025100024.1287157-1-idosch@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2BE7D0F76A2012409F411FC43941D83B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [RFC PATCH net-next 00/16] bridge: Add MAC
 Authentication Bypass (MAB) support with offload
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: "petrm@nvidia.com" <petrm@nvidia.com>, "ivecera@redhat.com" <ivecera@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "razor@blackwall.org" <razor@blackwall.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "roopa@nvidia.com" <roopa@nvidia.com>, "netdev@kapio-technology.com" <netdev@kapio-technology.com>, "edumazet@google.com" <edumazet@google.com>, "mlxsw@nvidia.com" <mlxsw@nvidia.com>, "jiri@nvidia.com" <jiri@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>

On Tue, Oct 25, 2022 at 01:00:08PM +0300, Ido Schimmel wrote:
> Merge plan
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> We need to agree on a merge plan that allows us to start submitting
> patches for inclusion and finally conclude this work. In my experience,
> it is best to work in small batches. I therefore propose the following
> plan:
>=20
> * Add MAB support in the bridge driver. This corresponds to patches
>   #1-#2.

Yes, exactly, let's keep the software implementation its own patch set,
together with its selftest.

> * Switchdev extensions for MAB offload together with mlxsw
>   support. This corresponds to patches #3-#16. I can reduce the number
>   of patches by splitting out the selftests to a separate submission.

I don't think that further splitting of mlxsw will be necessary, the
threshold is 15 patches, and the current 16-2 =3D 14.

IMO patches 3-4 should go with mlxsw being the first user.

> * mv88e6xxx support. I believe the blackhole stuff is an optimization,
>   so I suggest getting initial MAB offload support without that. Support
>   for blackhole entries together with offload can be added in a separate
>   submission.
>=20
> * Switchdev extensions for dynamic FDB entries together with mv88e6xxx
>   support. I can follow up with mlxsw support afterwards.

The last 2 can also happen in parallel, if somebody else comes to it.

Looks great, thanks for doing this!=
