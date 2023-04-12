Return-Path: <vladimir.oltean@nxp.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B132F41DB2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 78784400C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmTQCkNjgjvKNMAok8QbskQl2zPgwu/kwkIaeW4J8xE=;
 b=jeLDIukDI96l8gmpBQE41kYFt68AySq+l+gSYTxVhKylbPJdqfe4rCH0IA5+zRUI9REm2MsL9b9LWY9k5KKwhwAzd3NkE4mgj7Yv/mLtnfAawNcjwA45mb3MpOGWR9RE8RFyDI3OIoG99ZzcVMlvV0JQv8FqlvCzfKpJ2EpzCGw=
Date: Wed, 12 Apr 2023 17:27:33 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Message-ID: <20230412142733.6jhxt7kjf3nwqzsy@skbuf>
References: <20230410204951.1359485-1-vladimir.oltean@nxp.com>
 <ZDa856x2rhzNrrXa@shredder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDa856x2rhzNrrXa@shredder>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net] net: bridge: switchdev: don't notify FDB
 entries with "master dynamic"
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Ivan Vecera <ivecera@redhat.com>, bridge@lists.linux-foundation.org, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, Arkadi Sharshevsky <arkadis@mellanox.com>, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>, Eric Dumazet <edumazet@google.com>, "Hans J. Schultz" <netdev@kapio-technology.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Wed, Apr 12, 2023 at 05:15:03PM +0300, Ido Schimmel wrote:
> > Looking at tools/testing/selftests/net/forwarding/, there is no valid
> > use of the "bridge fdb add ... master dynamic" command there, so I am
> > fairly confident that no one used to rely on this behavior.
> 
> Yes, but there are tests that use "extern_learn". If you post a v2 that
> takes "BR_FDB_ADDED_BY_EXT_LEARN" into account, then I can ask Petr to
> run it through our regression and report back (not sure we will make it
> to this week's PR though).
> 
> Thanks

How are extern_learn FDB entries processed by spectrum's
SWITCHDEV_FDB_ADD_TO_DEVICE handler?
