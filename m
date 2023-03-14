Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 18F1381E2F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5576B81E0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112; t=1678796681;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UwbHt6idtZCCtjCrFRLotwokcc91x7BzRsfspk4D+Bs=;
 b=OViau/4tkuET8wV7RbEr1O4VwMsMJLlFKZQ6nZzuv2/WxY6VPlvYsIRw8TL8MIFtAM
 EdpPM471ZMa5w0fI8st+88q5NBg150pKY2en4UOtsWRhdNSJsUVfJlPRw6AgVK3kBdL6
 J26H+2HS5DrgKNi+oTeHyC8A1mJXqXJ998yuAjaHMktb1FuPY4jfNSv6iJafA/wVXZTO
 js7NbZJiCYIwtolYKKNARhMRGHFSrLxR8bPQ+YRwpYCbGEhV8AhjYerLQL1qEZXeRobO
 mpRe+zMyfxeKTNYRo2o9PFgoaCaYQn4C0CS98qL+SBA7hq0CdD5afnmdBtIlYFrCEnVf
 K+MQ==
Message-ID: <b4f379a4-b883-d903-148b-a6270aedce20@blackwall.org>
Date: Tue, 14 Mar 2023 14:24:40 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230313145349.3557231-1-idosch@nvidia.com>
 <20230313145349.3557231-9-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230313145349.3557231-9-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 08/11] vxlan: mdb: Add an internal
 flag to indicate MDB usage
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 13/03/2023 16:53, Ido Schimmel wrote:
> Add an internal flag to indicate whether MDB entries are configured or
> not. Set the flag after installing the first MDB entry and clear it
> before deleting the last one.
> 
> The flag will be consulted by the data path which will only perform an
> MDB lookup if the flag is set, thereby keeping the MDB overhead to a
> minimum when the MDB is not used.
> 
> Another option would have been to use a static key, but it is global and
> not per-device, unlike the current approach.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  drivers/net/vxlan/vxlan_mdb.c | 7 +++++++
>  include/net/vxlan.h           | 1 +
>  2 files changed, 8 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


