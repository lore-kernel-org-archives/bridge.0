Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6169060F15
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 88EA460E81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1684234069; x=1686826069;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Js3YuPgss9QnQgb0ghb/7P0ksUMIVrx2im8eZEBPrko=;
 b=L+dTajnQeDtHHrVal8YzvGE5uYvGo+QGMEUc2KcrDnIEKFbEUgJEEqW29k+GjRVr2d
 35X1YcGFtg5YpAYrzHzORZjhnAS8QgOqQHnlhf4vQDXHVgF61gqErpVXt+aR7fy9Vk2/
 PZAI1w6yyrzaP+YvYAKRCaS0wi8I4qmkgHNZm1cHNDSIhvT6DHNy7LFa0wEDUPr1wABV
 XlrAwTt8BBhkC7rTlJW27pgqt3Kai1rKOQaa5EaJnEwS4go/o7cf7yta2SlAN3iRtuzD
 CFCz4MJ+VsHvH1JljS/Ou5RYgYZDkNoTDStEjglITU6PxrjApNwbg+tl84pcoOPRDsss
 bDMQ==
Message-ID: <c05b5623-c096-162f-3a2d-db19ca760098@blackwall.org>
Date: Tue, 16 May 2023 13:47:47 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230515085046.4457-1-jnixdorf-oss@avm.de>
 <a1d13117-a0c5-d06e-86b7-eacf4811102f@blackwall.org>
 <ZGNEk3F8mcT7nNdB@u-jnixdorf.ads.avm.de>
 <f899f032-b726-7b6d-953d-c7f3f98744ca@blackwall.org>
 <20230516102141.w75yh6pdo53ufjur@skbuf>
 <ce3835d9-c093-cfcb-3687-3a375236cb8f@blackwall.org>
 <20230516104428.i5ou4ogx7gt2x6gq@skbuf>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230516104428.i5ou4ogx7gt2x6gq@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/2] bridge: Add a limit on FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Johannes Nixdorf <jnixdorf-oss@avm.de>, netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Oleksij Rempel <linux@rempel-privat.de>, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On 16/05/2023 13:44, Vladimir Oltean wrote:
> On Tue, May 16, 2023 at 01:32:05PM +0300, Nikolay Aleksandrov wrote:
>> Let's take a step back, I wasn't suggesting we start with a full-fledged switchdev
>> implementation. :) I meant only to see if the minimum global limit implementation
>> suggested would suffice and would be able to later extend so switchdev can use and
>> potentially modify (e.g. drivers setting limits etc). We can start with a simple
>> support for limits and then extend accordingly. The important part here is to
>> not add any uAPI that can't be changed later which would impact future changes.
> 
> I guess adding a global per-bridge learning limit now makes sense and
> would not unreasonably hinder switchdev later on. The focus is on
> "learning limit" and not a limit to user-created entries as Johannes has
> currently done in v1. I don't necessarily see an urgent need for
> IFLA_BR_FDB_CUR_ENTRIES, given the fact that user space can dump the FDB
> and count what it needs, filtering for FDB types accordingly.

Having the current count is just a helper, if you have a high limit dumping the table
and counting might take awhile. Thanks for the feedback, then we'll polish and move
on with the set for a global limit.
