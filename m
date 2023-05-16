Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D76460B98
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B6D23615EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1684233128; x=1686825128;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d8XX1tnrPyv3VxvKbHs/8JHiurxuDpWuL5gr09/Ey0k=;
 b=RrCwJVoU1I745RI0LnW3FW5qN9d4s8Vhhltm9l1sd4sOwZY/p1q8y/5I1K5q7y2Jzq
 c/8OCA+HO8xWDfVllymQ21GI3+d9MAxoDZWKWrOYYmjrk8T4H1DDHmOylswO+T6OZ1MN
 kfiD0isdnkaSdFnW5tRqN348l2Vfk2YfmNt3Cd4c34W7OF1gNMj7kMTVU9dsy8WuXXO1
 WRRhsBvP4Oz8WaOoHp3K9lvlrmG3rZZcsgrrA0p4tNVGKjX55dehyE9/zMsPQptmJIeP
 8sjqrdGd8Qct4wePBtQ2nrGI8Vjh5AnaBLxvjz6rUs61qYt1M2PnQyfzUInsFRRjLi9X
 Y8EA==
Message-ID: <ce3835d9-c093-cfcb-3687-3a375236cb8f@blackwall.org>
Date: Tue, 16 May 2023 13:32:05 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230515085046.4457-1-jnixdorf-oss@avm.de>
 <a1d13117-a0c5-d06e-86b7-eacf4811102f@blackwall.org>
 <ZGNEk3F8mcT7nNdB@u-jnixdorf.ads.avm.de>
 <f899f032-b726-7b6d-953d-c7f3f98744ca@blackwall.org>
 <20230516102141.w75yh6pdo53ufjur@skbuf>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230516102141.w75yh6pdo53ufjur@skbuf>
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
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Oleksij Rempel <linux@rempel-privat.de>
Cc: Johannes Nixdorf <jnixdorf-oss@avm.de>, netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On 16/05/2023 13:21, Vladimir Oltean wrote:
> Hi,
> 
> On Tue, May 16, 2023 at 11:56:41AM +0300, Nikolay Aleksandrov wrote:
>> Hmm.. perhaps we can add a flag mask of entries to count. Initially it can be
>> only dynamic entries. We should include more people in this discussion (+CC Ido and Vladimir).
>> Switchdev folks might have more specific requirements and restrictions, so it'd be nice to get
>> their input as well.
> 
> I have some other things to do until I can take a closer look at this
> discussion, but in principle, switchdev drivers will likely want to
> impose their own limit on FDB entries because the hardware itself is
> inherently limited in size, so I'm thinking there should be another way
> for the software bridge to be informed about this limit other than UAPI.

Yep, that's ok but it can be added later. This is pretty much internal.

> Which ports that limit should affect (think bridging between ports of
> different switches with different FDB sizes) I don't know. If we only
> consider switchdev, FDB limits should probably be per hwdom.
> 

Now, that's a whole different issue (per-port limits). I've prototype patches
for that too, but it's a much harder problem to solve and scale in software.
Let's please focus on the single global limit for the moment.

> Also, in terms of static vs dynamic limits, I've seen hardware
> implementations where static FDB entries go to a different FDB table
> compared to dynamic ones (Microchip KSZ DSA switches), implementations
> where static partitioning between static and dynamic FDB entries is
> possible but configurable, and implementations where they all consume
> from the shared space and you'd have to evict a dynamic entry to install
> a static one. So it's hard to really say what's the size. That, plus not
> to mention, many hardware FDBs are not fully associative, and due to
> hash collisions, you may be unable to install an entry in the 4-way
> associative bin where its {MAC,VID} hash says it should go, even though
> the FDB at large is not full.
> 
> It sounds sexy to take switchdev into consideration, but I'm not really
> sure what we want. Something flexible to cater for the above, probably.
> This discussion should probably be merged with:
> https://lore.kernel.org/netdev/20230324144917.32lnpgtw5auuyovy@skbuf/T/#ma600839815582ca61886e83ba533b1dfbe447557
> so I'm CCing Oleksij too, since he probably knows better than me what he
> wants.
> 

Let's take a step back, I wasn't suggesting we start with a full-fledged switchdev
implementation. :) I meant only to see if the minimum global limit implementation
suggested would suffice and would be able to later extend so switchdev can use and
potentially modify (e.g. drivers setting limits etc). We can start with a simple
support for limits and then extend accordingly. The important part here is to
not add any uAPI that can't be changed later which would impact future changes.

> In the thread with DSA trace events, there also was a short talk about
> user space theoretically being able to infer FDB sizes and utilization
> degree based on instrumenting with ftrace, which is something we wouldn't
> like to have to maintain. So I'm adding the DSA maintainers too, since
> there is interest for agreeing on a different API.
> https://lore.kernel.org/netdev/2f150ad4-34f4-4af9-b3ce-c1aff208ec7e@lunn.ch/T/#mfa895245fd012e8f66db784fa568109dba396aa7

