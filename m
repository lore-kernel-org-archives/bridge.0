Return-Path: <vladimir.oltean@nxp.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9D4F741737
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ABC724170E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IldUzgigZGpLqvOtuZQF8FxGmnj4lSM0S4waVzxMh3E=;
 b=W0JTb3T23ACG0KONrYo9g2b2zLcsvhdJQBbTH2isfNFefGQ5+I1OLsKMnSQJEsFXZJtLZ2tWHH0HzPhMf7YXQ10kfL9jVhC1VI/mvNNCL4i9ilsbCW0hb20+sz1KGRtsfdE+61Yw5xj3bLke4UAXF0lLXcwO9Qv9fBvHQR3j+gs=
Date: Tue, 16 May 2023 13:44:28 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Message-ID: <20230516104428.i5ou4ogx7gt2x6gq@skbuf>
References: <20230515085046.4457-1-jnixdorf-oss@avm.de>
 <a1d13117-a0c5-d06e-86b7-eacf4811102f@blackwall.org>
 <ZGNEk3F8mcT7nNdB@u-jnixdorf.ads.avm.de>
 <f899f032-b726-7b6d-953d-c7f3f98744ca@blackwall.org>
 <20230516102141.w75yh6pdo53ufjur@skbuf>
 <ce3835d9-c093-cfcb-3687-3a375236cb8f@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce3835d9-c093-cfcb-3687-3a375236cb8f@blackwall.org>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 1/2] bridge: Add a limit on FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Johannes Nixdorf <jnixdorf-oss@avm.de>, netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Oleksij Rempel <linux@rempel-privat.de>, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Tue, May 16, 2023 at 01:32:05PM +0300, Nikolay Aleksandrov wrote:
> Let's take a step back, I wasn't suggesting we start with a full-fledged switchdev
> implementation. :) I meant only to see if the minimum global limit implementation
> suggested would suffice and would be able to later extend so switchdev can use and
> potentially modify (e.g. drivers setting limits etc). We can start with a simple
> support for limits and then extend accordingly. The important part here is to
> not add any uAPI that can't be changed later which would impact future changes.

I guess adding a global per-bridge learning limit now makes sense and
would not unreasonably hinder switchdev later on. The focus is on
"learning limit" and not a limit to user-created entries as Johannes has
currently done in v1. I don't necessarily see an urgent need for
IFLA_BR_FDB_CUR_ENTRIES, given the fact that user space can dump the FDB
and count what it needs, filtering for FDB types accordingly.
