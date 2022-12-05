Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4B7AC4052E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 89E4F40522
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=knyyPlNbBxcU+qJ0FVDjA2Jr+aOD9AGR8p2XI9iZKlA=;
 b=sP0PT5QlxzUm2mdQs2yeqeVnGD/bCIXNEYE7DgEWFvImqA2UtrKcxkxcsz+kjVAlNB
 xmDrQiUN30zBjZ3KcAbEiOEJym5cF/GxeFBV2d1sS5/dNIn7VyZ7yXDkNyV24XHHu9wE
 l1F1+yspsGkw743BRWBxMuLl1lnfwBtAhGFtw9CdhlP5N6oiNvN6SjvsrwZNTl9Ea1yP
 Ae+uWNI9EMRlDqwtqtMKDwrCqx7m0/xK22qjcCVc4uU/R2fPYBzxHugsO+VJh1LMnB6c
 5ToSgPUCQ82FQmuqb76W/GDzY5oVOBLlhGd/Ml07Ik8V89QwgTPfWrNa6EAuv0bGmRUl
 RUkg==
Message-ID: <729a8f5b-1a4e-1838-93e0-27ac814bb015@blackwall.org>
Date: Mon, 5 Dec 2022 13:41:41 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221205074251.4049275-1-idosch@nvidia.com>
 <20221205074251.4049275-6-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221205074251.4049275-6-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 5/8] bridge: mcast: Use MDB group key
 from configuration structure
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
> The MDB group key (i.e., {source, destination, protocol, VID}) is
> currently determined under the multicast lock from the netlink
> attributes. Instead, use the group key from the MDB configuration
> structure that was prepared before acquiring the lock.
> 
> No functional changes intended.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_mdb.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


