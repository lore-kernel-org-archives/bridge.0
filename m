Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BCE5D60BD9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0219B60BCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p+lqCtUO2T8WzhIulXM5wgSeAQF83+0Hc2/jw5pbOGc=;
 b=lwdFTnA19ae+IgrYYz/npsYg4z4drRSms+h2HFXJ65hnj8HMzdJYauBUW5aca1nO9d
 SJNZ8J6dGdurvnrtyJU6u6AypJeexiE674nw0ITpZjMuapYtAvMJlCVaMsDP7bXJ2b+7
 oxN082d4/0bTMmJz3ngMMQxzcsYnYXPnFtmFYW/031sACWF77KK6yVA4pexvnDVHP37N
 Q7QGePxMKEx+WICz6lc4RsZ2LjBio8szNqEDHppgtcFSQ193VvgS2K41nIOCoa5VaURa
 pwLwjb4QHB4asK+nNqrXxNiRogzhLgaXaL30/4MMswEVVR/lhus3XjBJMZL18yl5GTpZ
 EBhQ==
Message-ID: <b83faf19-ec08-c009-572c-4c9868155ed6@blackwall.org>
Date: Mon, 5 Dec 2022 13:35:33 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221205074251.4049275-1-idosch@nvidia.com>
 <20221205074251.4049275-4-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221205074251.4049275-4-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 3/8] bridge: mcast: Use MDB
 configuration structure where possible
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
> The MDB configuration structure (i.e., struct br_mdb_config) now
> includes all the necessary information from the parsed RTM_{NEW,DEL}MDB
> netlink messages, so use it.
> 
> This will later allow us to delete the calls to br_mdb_parse() from
> br_mdb_add() and br_mdb_del().
> 
> No functional changes intended.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_mdb.c | 34 +++++++++++++++-------------------
>  1 file changed, 15 insertions(+), 19 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


