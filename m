Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E99114023F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 49CB94014B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=je/hcoSOt+coZaybXz7eb8R7zv6LEFeKDF9n70ZMzAc=;
 b=ysYDYD5RtN+wIYSi1bI5J111qdXzPFrAlv/bvN5yu0u4v+Tp7pVZVf0rIVPV6a+E/a
 yeTu3/8SIWMxOXG1MAms01hgZADrUoGEPy0MQzC5IKkfT1P0iCLOHul8aAUfxlwVT4AP
 HHyQBC5kg1010G1exzh2LJ3eOMui03e2/P2i61X5KCjqJEDzZcj1A4TtllwKBM+4pTr3
 qTyPCJgltrX7kNjxJ4X5FPwC2iHIKv5oI1NgSHVC7pm9NUaW3t1p8N1SfahlApEXlK8g
 v2oNkxxa+QUxD+JO2m1tSDNORSe9g1JSb0UBke9CSw47YcawfLmnu3drQUhuecq4l0M/
 yI+g==
Message-ID: <68714375-7d33-a9de-e59d-48a4250831d0@blackwall.org>
Date: Fri, 9 Dec 2022 09:31:16 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221208152839.1016350-1-idosch@nvidia.com>
 <20221208152839.1016350-7-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221208152839.1016350-7-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 06/14] bridge: mcast: Expose
 __br_multicast_del_group_src()
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

On 08/12/2022 17:28, Ido Schimmel wrote:
> Expose __br_multicast_del_group_src() which is symmetric to
> br_multicast_new_group_src() and does not remove the installed {S, G}
> forwarding entry, unlike br_multicast_del_group_src().
> 
> The function will be used in the error path when user space was able to
> add a new source entry, but failed to install a corresponding forwarding
> entry.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     v1:
>     * New patch.
> 
>  net/bridge/br_multicast.c | 11 ++++++++---
>  net/bridge/br_private.h   |  1 +
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


