Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1E8E2408BF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B059D4089F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668232818;
 bh=GEKv9FokRcaiEDaEwMPRK38n9n8GnCFECbCRomwVT8s=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=j/Rl8ccG+tqAwXBswhdjyai6PncKdGnIWY0fb7KbKZhUWKbKWTyg3Nf9NGnHbAv46
 sNilgF6oWwyWO5Lx7KzsU55bEAEImKZTA3jx8ig26k+Lo4iPjtDcfvJe1BFrWMfKce
 0jWFgYe98hztOM8wEym5Ae0oWGdEode+XPY9ykTLNlVB1dJSyxBAlLlV8hJBdjj2dF
 AQtdxfN3OaCwPi1sQrOQlKep3f+9ooAOrd60iZyOAuJ7GeN7GNFd/6rDDJFw3vUtN0
 kT2s+ExNPdPmjDPM2dsWYrAuuJ9RWFLxXWZt1WIJuVtB56AF/VuV30g3YOTsIg+Bhp
 C1MHd1YQLCnJw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <166823281813.10181.5447638832386414958.git-patchwork-notify@kernel.org>
Date: Sat, 12 Nov 2022 06:00:18 +0000
References: <20221110085422.521059-1-idosch@nvidia.com>
In-Reply-To: <20221110085422.521059-1-idosch@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next] bridge: Add missing parentheses
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: petrm@nvidia.com, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, edumazet@google.com, mlxsw@nvidia.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Nov 2022 10:54:22 +0200 you wrote:
> No changes in generated code.
> 
> Reported-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_input.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] bridge: Add missing parentheses
    https://git.kernel.org/netdev/net-next/c/3e35f26d3397

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


