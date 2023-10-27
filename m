Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BD18070655
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4BA1F70651
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698402024;
 bh=T+3V1QPNWQUYBlU7Bsq22khHxGFNFrur7XQd590rXoM=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=RVk3/sIiGmoj19UD63rK9A/Liipt6WZ7nQRvTYjjUPMlNONrHvLbOeh1ww0EvhqME
 fR44vLwFwb1b0dzcnCVvpJdL64T7tXkDSxghrsxb6GjdCqv483/9DBtHFQI84qLB4i
 itWWLS6LTni1sMBtNBoVxyEG9HKCZO0KCLzg3y0UE+WdtWJnXxaELw6aS77hRxCum6
 zul82YK/Nslnz5DFHsiHOeQIHjhbWw8fA+Ol/zJY+ANLboWavKBHSqg7ytbsgz3bqU
 EypIcRM2yU7DwTUtbg4W24Lxt2IQd2Wk1UZzwP3uqRDq7DLUfKoL5av1I+4WEVtcIa
 uqPummy4+KTNA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <169840202448.15376.8674341343569691359.git-patchwork-notify@kernel.org>
Date: Fri, 27 Oct 2023 10:20:24 +0000
References: <20231027100549.1695865-1-razor@blackwall.org>
In-Reply-To: <20231027100549.1695865-1-razor@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next] net: bridge: fill in
	MODULE_DESCRIPTION()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, roopa@nvidia.com, kuba@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 27 Oct 2023 13:05:49 +0300 you wrote:
> Fill in bridge's module description.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>  net/bridge/br.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net-next] net: bridge: fill in MODULE_DESCRIPTION()
    https://git.kernel.org/netdev/net-next/c/6808918343a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


