Return-Path: <vladimir.oltean@nxp.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B3FEB41763
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6235E4170B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohJGSY14DRrbFq2x0nTI34lERLeMvdwFerb37tNaFeU=;
 b=neAB8OZpYbTdDXHHd2Feq66Xl1wp5ktH3VLsWHjOR1GUIzXVxTvFFw//R9oiNd+JzW5g59OAxrr0sK+KUow+UA/3LcflX2KZ8JEgp7UBvaM8Whf3CLhiYYJq52ovHgIQZJbssxl2wk75tcnyRImSb2g7Bxv0GAMs8Ur50O/6b2k=
Date: Tue, 16 May 2023 13:21:41 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Message-ID: <20230516102141.w75yh6pdo53ufjur@skbuf>
References: <20230515085046.4457-1-jnixdorf-oss@avm.de>
 <a1d13117-a0c5-d06e-86b7-eacf4811102f@blackwall.org>
 <ZGNEk3F8mcT7nNdB@u-jnixdorf.ads.avm.de>
 <f899f032-b726-7b6d-953d-c7f3f98744ca@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f899f032-b726-7b6d-953d-c7f3f98744ca@blackwall.org>
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
To: Nikolay Aleksandrov <razor@blackwall.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Oleksij Rempel <linux@rempel-privat.de>
Cc: Johannes Nixdorf <jnixdorf-oss@avm.de>, netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

Hi,

On Tue, May 16, 2023 at 11:56:41AM +0300, Nikolay Aleksandrov wrote:
> Hmm.. perhaps we can add a flag mask of entries to count. Initially it can be
> only dynamic entries. We should include more people in this discussion (+CC Ido and Vladimir).
> Switchdev folks might have more specific requirements and restrictions, so it'd be nice to get
> their input as well.

I have some other things to do until I can take a closer look at this
discussion, but in principle, switchdev drivers will likely want to
impose their own limit on FDB entries because the hardware itself is
inherently limited in size, so I'm thinking there should be another way
for the software bridge to be informed about this limit other than UAPI.
Which ports that limit should affect (think bridging between ports of
different switches with different FDB sizes) I don't know. If we only
consider switchdev, FDB limits should probably be per hwdom.

Also, in terms of static vs dynamic limits, I've seen hardware
implementations where static FDB entries go to a different FDB table
compared to dynamic ones (Microchip KSZ DSA switches), implementations
where static partitioning between static and dynamic FDB entries is
possible but configurable, and implementations where they all consume
from the shared space and you'd have to evict a dynamic entry to install
a static one. So it's hard to really say what's the size. That, plus not
to mention, many hardware FDBs are not fully associative, and due to
hash collisions, you may be unable to install an entry in the 4-way
associative bin where its {MAC,VID} hash says it should go, even though
the FDB at large is not full.

It sounds sexy to take switchdev into consideration, but I'm not really
sure what we want. Something flexible to cater for the above, probably.
This discussion should probably be merged with:
https://lore.kernel.org/netdev/20230324144917.32lnpgtw5auuyovy@skbuf/T/#ma600839815582ca61886e83ba533b1dfbe447557
so I'm CCing Oleksij too, since he probably knows better than me what he
wants.

In the thread with DSA trace events, there also was a short talk about
user space theoretically being able to infer FDB sizes and utilization
degree based on instrumenting with ftrace, which is something we wouldn't
like to have to maintain. So I'm adding the DSA maintainers too, since
there is interest for agreeing on a different API.
https://lore.kernel.org/netdev/2f150ad4-34f4-4af9-b3ce-c1aff208ec7e@lunn.ch/T/#mfa895245fd012e8f66db784fa568109dba396aa7
