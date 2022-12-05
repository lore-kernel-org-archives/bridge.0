Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2C4D14052E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B164D4052C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3ck7nJMtJWfMXqJ5W4UKDMRT+n97feLu0BpQVT11JQQ=;
 b=lS/ObLnzVsgptiLXORTVWvMO3nrBM2AT6OkFfPPqf87rWVrtfvzCrbYETxTtU4bMQr
 sqObjWGqLJhO+5cq1gZllTYH3VpQRrhhPHQOQHpK22bXgoRDbpxLYuql91FRBeGZFcF4
 xqufuc3Q1cfFQIjwo3KcGlS92PTPq+NoxPJvgzEyjro7l4Z27qXNLZC/AsuumUE5aQNb
 V/rWtepKDqMCNLYgBqrpneI8YVBbWbs+4msacon5ZKGipn5pIHYKZgAZDGV9NVtGW8f5
 WidDsDvctGq05hQaxrmM+6IF6NJ9xhI8G74FyUXeiuaykl8PNjTLlJbo3v3zl4U+aOZW
 bsiA==
Message-ID: <2d043351-0be2-67ea-5da2-1f29777c9fb7@blackwall.org>
Date: Mon, 5 Dec 2022 13:40:05 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221205074251.4049275-1-idosch@nvidia.com>
 <20221205074251.4049275-5-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221205074251.4049275-5-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 4/8] bridge: mcast: Propagate MDB
 configuration structure further
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
> As an intermediate step towards only using the new MDB configuration
> structure, pass it further in the control path instead of passing
> individual attributes.
> 
> No functional changes intended.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_mdb.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

