Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C661B60BC0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 050CD607CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ooZLq7sC1+gvKa+ByW5ocyYtYqELg6JGdZXKkHGlG10=;
 b=FOqOQwAe1U/P/Hjau8DIcy0mlJikU16lqvhT7CE6yM/4PjW75TMvkWw/M5y2EvDLNe
 hqxJZNjlaamV903SWrDyFYo1+4HatPbg1zADpCVLwft1OHWtXoIrl3URln022KwzXgIJ
 XtGvxzLoNyj8mr6hruhYTTbAtKNYPQGUxHYS7Wbdvs+VZTP4MQ3KPEMM34zByBcf7gYc
 PhcI3foWpz/B1TgA7xT/4Y7dQ365b8qSu/w9Ku6MmCSOr/gSBZJ6vY2DCtu80Oh8f7un
 taZq/9/FfsCW37s5e1lUMV0p1C0SqkB9GWnq5LL23NhcG5lXJlHZTUY16QJwK0UavAGs
 w3Gg==
Message-ID: <39f8b0e3-96a3-9a36-5a99-48088b229f4e@blackwall.org>
Date: Mon, 5 Dec 2022 13:34:55 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221205074251.4049275-1-idosch@nvidia.com>
 <20221205074251.4049275-3-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221205074251.4049275-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 2/8] bridge: mcast: Remove redundant
	checks
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 05/12/2022 09:42, Ido Schimmel wrote:
> These checks are now redundant as they are performed by
> br_mdb_config_init() while parsing the RTM_{NEW,DEL}MDB messages.
> 
> Remove them.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_mdb.c | 63 +++++++--------------------------------------
>  1 file changed, 9 insertions(+), 54 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


