Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 50DF88409D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8989084089
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1690503621;
 bh=JWpibV1AQXBMpPFvCewoBsCPhbnapxlbGt4HsLNitJo=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=cjsALfXyWA/6raCCl2px6oP9dHVI0H2lgfOOk0OgMkuMP5SgQggtxyRMFs+YHPDfp
 eEZR/KZdnLWiGaq56v2krh/Zj42BbLex/0ual0lDgI3DpqUrp8wSTgM5qWVrHT3yOG
 /eCUgIboNAuzcV8lTNA2NHthDvx5w0CaPWwEKI764J69oc7VJdZDSkCtt0h7XyvGZH
 A2Rq5fIuC/cER0EdPG5kV2jg2g8//gBIjNdYHL7hv7CkKbfMeT/diR+6gUwQ6c6qNs
 OddxVh7qRQnAilLi3WA++CpbLsNBOezNc1461qpd3FwrwftjG25y4ulzPBuRGm/Lfm
 yo0cOqsMs/1Fg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <169050362092.24970.6426041238367256548.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 00:20:20 +0000
References: <20230726143141.11704-1-yuehaibing@huawei.com>
In-Reply-To: <20230726143141.11704-1-yuehaibing@huawei.com>
Subject: Re: [Bridge] [PATCH net-next] bridge: Remove unused declaration
 br_multicast_set_hash_max()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: idosch@nvidia.com, razor@blackwall.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, edumazet@google.com, netdev@vger.kernel.org, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jul 2023 22:31:41 +0800 you wrote:
> Since commit 19e3a9c90c53 ("net: bridge: convert multicast to generic rhashtable")
> this is not used, so can remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/bridge/br_private.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] bridge: Remove unused declaration br_multicast_set_hash_max()
    https://git.kernel.org/netdev/net-next/c/4d66f235c790

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


