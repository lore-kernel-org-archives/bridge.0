Return-Path: <vladimir.oltean@nxp.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1D8C540A55
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 60D7C409A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2eATHDWfBwliiKsDwyEf6GdLM9NZxOFrZgpWe1cZDo=;
 b=HqWpCL7x4GGoKPioHC2l5lJueLj0EESgmvqsNWhF7hlkzK36JLRU1spNaYpHh4T2KbCShPfebFQqkEOo9Qiie18iwVnKnkfckzB6Fmw1rGw57DbPpU5hjyZhK6KseKHqCRw4fdt9/gaSuYSfzQLq/3zIQfGjrD9Tg/wZmix5j28=
Date: Tue, 16 May 2023 13:55:09 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Message-ID: <20230516105509.xaalfs77vrlr663u@skbuf>
References: <20230515085046.4457-1-jnixdorf-oss@avm.de>
 <a1d13117-a0c5-d06e-86b7-eacf4811102f@blackwall.org>
 <ZGNEk3F8mcT7nNdB@u-jnixdorf.ads.avm.de>
 <f899f032-b726-7b6d-953d-c7f3f98744ca@blackwall.org>
 <20230516102141.w75yh6pdo53ufjur@skbuf>
 <ce3835d9-c093-cfcb-3687-3a375236cb8f@blackwall.org>
 <20230516104428.i5ou4ogx7gt2x6gq@skbuf>
 <c05b5623-c096-162f-3a2d-db19ca760098@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c05b5623-c096-162f-3a2d-db19ca760098@blackwall.org>
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

On Tue, May 16, 2023 at 01:47:47PM +0300, Nikolay Aleksandrov wrote:
> Having the current count is just a helper, if you have a high limit dumping the table
> and counting might take awhile. Thanks for the feedback, then we'll polish and move
> on with the set for a global limit.

Ok, but to be useful, the current count will have to be directly
comparable to the limit, I guess. So the current count will also be for
dynamically learned entries? Or is the plan to enforce the global limit
for any kind of FDB entries?
