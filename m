Return-Path: <eric.dumazet@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=8IjMW6kyewB7HLmt/uQqvKqK5mbucpa6D6MSyk1fHdQ=;
 b=gKE4UomKBFwRpUshG0snXgWNC/rxvjVyQ8jVCfO9j82EJZwmb/UcMTRrrQbgXq0hrF
 rTfFlCyhgANb2v7sdxl4Jin7ut5WN1WO44htt/gQJIupRLBZO+PTL6+bHiVoMePRGHBR
 EX228Bum6EoQAPa+1wnEjBJou/GyrQ5EDD/eROUQYiw/DryE685vocVXA3xysDiXy5kT
 fZrXKsqOc+QtW22/Ua86OONpG/tzAIjreZFDL2At7gvmadwou/RD1D1P8eexwGOOW3De
 cktCBuVV8ceC2SnmqXZFU8xKAnIq2ojSpgN2/qoRaBa0pIaf+f9d5x9eEUk9BTmrOqBy
 wVcg==
Message-ID: <425e92d0-4321-8f9d-fc75-bba29f172550@gmail.com>
Date: Wed, 5 Jan 2022 10:14:37 -0800
MIME-Version: 1.0
Content-Language: en-US
References: <20211227172116.320768-1-nikolay@nvidia.com>
 <20211227172116.320768-2-nikolay@nvidia.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <20211227172116.320768-2-nikolay@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net 1/2] net: bridge: mcast: add and enforce
 query interval minimum
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>, netdev@vger.kernel.org
Cc: herbert@gondor.apana.org.au, eric.dumazet@gmail.com, bridge@lists.linux-foundation.org, stable@vger.kernel.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net


On 12/27/21 09:21, Nikolay Aleksandrov wrote:
> As reported[1] if query interval is set too low and we have multiple
> bridges or even a single bridge with multiple querier vlans configured
> we can crash the machine. Add a 1 second minimum which must be enforced
> by overwriting the value if set lower (i.e. without returning an error) to
> avoid breaking user-space. If that happens a log message is emitted to let
> the administrator know that the interval has been set to the minimum.
> The issue has been present since these intervals could be user-controlled.
>
> [1] https://lore.kernel.org/netdev/e8b9ce41-57b9-b6e2-a46a-ff9c791cf0ba@gmail.com/
>
> Fixes: d902eee43f19 ("bridge: Add multicast count/interval sysfs entries")
> Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
> Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> ---


Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !


