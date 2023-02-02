Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1805381379
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 23F2581353
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675318817;
 bh=oD8RzGC4gPQxGDauN4OgiOSf0XpYZ4jYQdyep7tZPDE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=D1kzs7jQ1OT76pRhhKHus5BknR72WHh0aRyWAOnJl/BA7sSzYU/3fKYBpf/hiWlNF
 ds9eBSHhxRiRxF8ZtYjtGhlY0F/v8QbKhJ5ehImA3/1SPqF1fHlDt1UriLZRS4dqbi
 xs/wgo0OTJFAQysPvQBzLLD4O3JWvf0rNi1e3Y4Wc0tjDdrPIOIMdtDhz7fQ/K1CoL
 Ay1804i8+TCuCcaMpooqbKTLlctE1bZhoZzSJujQu2GLiXF1RccvPwbglV9lOXOT2r
 Eipf25c+nYgV8PRoIbn0kovOOs+Y5VAPLfygSknlyu6qddaJM4wiEvX4dgn7XJYc3Y
 KUZrW1oXa3svw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <167531881705.1809.1109150044869661715.git-patchwork-notify@kernel.org>
Date: Thu, 02 Feb 2023 06:20:17 +0000
References: <6993fac557a40a1973dfa0095107c3d03d40bec1.1675171790.git.leon@kernel.org>
In-Reply-To: <6993fac557a40a1973dfa0095107c3d03d40bec1.1675171790.git.leon@kernel.org>
Subject: Re: [Bridge] [PATCH net-next v3] netlink: provide an ability to set
 default extack message
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Leon Romanovsky <leon@kernel.org>
Cc: steffen.klassert@secunet.com, andrew@lunn.ch, f.fainelli@gmail.com, herbert@gondor.apana.org.au, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, edumazet@google.com, olteanv@gmail.com, roopa@nvidia.com, simon.horman@corigine.com, kuba@kernel.org, pabeni@redhat.com, leonro@nvidia.com, davem@davemloft.net

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 31 Jan 2023 15:31:57 +0200 you wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> In netdev common pattern, extack pointer is forwarded to the drivers
> to be filled with error message. However, the caller can easily
> overwrite the filled message.
> 
> Instead of adding multiple "if (!extack->_msg)" checks before any
> NL_SET_ERR_MSG() call, which appears after call to the driver, let's
> add new macro to common code.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] netlink: provide an ability to set default extack message
    https://git.kernel.org/netdev/net-next/c/028fb19c6ba7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


