Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExT1E/vovGjsb2BsWR4V2OkMt2T0WQ4+w3CH5VGk3RQ=;
 b=ExCPbwoFrf1q1AqHxsOIf1hue3NJlJRjXkHOk4UucqGFtDieZQcJQeqNQlZsCGoOghMbLm7FqIan8iLZMqLcu353MDVrQk135LvR8TY0zFuYvWLdN81eOg6t6ZUytzKfWJDXzWZ8YxsCoMNfqkJb79wWfZImmpmNun62VQUj2bA=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Sun, 25 Oct 2020 06:59:58 +0000
Message-ID: <20201025065957.5736elloorffcdif@skbuf>
References: <20201017184139.2331792-1-vladimir.oltean@nxp.com>
 <98ac64d9b048278d2296f5b0ff3320c70ea13c72.camel@nvidia.com>
In-Reply-To: <98ac64d9b048278d2296f5b0ff3320c70ea13c72.camel@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E16C77FF765849479CDE86712DB1ACC8@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [RFC PATCH] net: bridge: multicast: add support for L2
	entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, "idosch@idosch.org" <idosch@idosch.org>, "jiri@mellanox.com" <jiri@mellanox.com>, Roopa Prabhu <roopa@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>

On Wed, Oct 21, 2020 at 09:17:07AM +0000, Nikolay Aleksandrov wrote:
> > diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bri=
dge.h
> > index 4c687686aa8f..a25f6f9aa8c3 100644
> > --- a/include/uapi/linux/if_bridge.h
> > +++ b/include/uapi/linux/if_bridge.h
> > @@ -520,12 +520,14 @@ struct br_mdb_entry {
> >  #define MDB_FLAGS_FAST_LEAVE	(1 << 1)
> >  #define MDB_FLAGS_STAR_EXCL	(1 << 2)
> >  #define MDB_FLAGS_BLOCKED	(1 << 3)
> > +#define MDB_FLAGS_L2		(1 << 5)
>=20
> I think this should be 4.
>=20

Shouldn't this be in sync with MDB_PG_FLAGS_L2 though? We also have
MDB_PG_FLAGS_BLOCKED which is BIT(4).=
