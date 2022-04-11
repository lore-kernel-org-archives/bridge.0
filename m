Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AA8FICreZLhELcYhsUL5ZOOyD5bG02UICUV0jKEuSFI=;
 b=fUA5RDc0oC6R81Pz244AS1J9EQvo1OMdAja6HuIjkNe3kHacJgyQn6G4/FF7HWXvzQo2Dkw4Y8xMfl4bnEtoe7Izot81Y7uDuWzosz8Sgn9i1W6N/ttKtZivR3MoLpWNu7tiXRfipkUnz1YlxRkE5yzg6uB374eRJOqLoXxZnAU=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 11 Apr 2022 17:26:36 +0000
Message-ID: <20220411172635.6pgeq56p7oixaz43@skbuf>
References: <20220411133837.318876-1-troglobit@gmail.com>
 <20220411133837.318876-7-troglobit@gmail.com>
In-Reply-To: <20220411133837.318876-7-troglobit@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4BF5A9EE8F17824A8FB5252A81A87104@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH RFC net-next 06/13] selftests: forwarding:
 multiple instances in tcpdump helper
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joachim Wiberg <troglobit@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On Mon, Apr 11, 2022 at 03:38:30PM +0200, Joachim Wiberg wrote:
> Extend tcpdump_start() & C:o to handle multiple instances.  Useful when
> observing bridge operation, e.g., unicast learning/flooding, and any
> case of multicast distribution (to these ports but not that one ...).
>=20
> This means the interface argument is now a mandatory argument to all
> tcpdump_*() functions, hence the changes to the ocelot flower test.
>=20
> Signed-off-by: Joachim Wiberg <troglobit@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>=
