Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621981811;
 bh=OP+2crvbUdflDGJs+DZrs5Hsm5swebZhY7rgc9PlKBE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=uM2XgOdHN/pg7sxi8fpJGFYmT7i4nOO8OI0B+IOeEo/J3jta35kTJNQ+aYnQKhP33
 +bXK0zKDrUnUBQOf7ITanU3cLPn1VWEnzHCqeIg+hYjrqNQmTI9gH2bqtcb2GL55Nt
 NAZe58AvHWKBGjxvS6TMpBGAt8IrtZb5TCwCI2gfnQLO+ARQ9HkLTTqI+mBN3XsZ66
 Ls270nYNwvJypzlrjKxy9hzQcDUs+afHRw6X3iSlW6XzmRxv1pqsc5Z6BxjRmDb2zy
 Wb5xUWflAsmVWZQfqNJmJaNUYnBRo/q5+153pwcWghxH85vLxvVmL/CeZu/miDfMWY
 jyqwiJnbL0KzQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <162198181119.18500.5211226351903654537.git-patchwork-notify@kernel.org>
Date: Tue, 25 May 2021 22:30:11 +0000
References: <YKx3ptXPNbd3Bdiq@fedora>
In-Reply-To: <YKx3ptXPNbd3Bdiq@fedora>
Subject: Re: [Bridge] [PATCH] net: bridge: remove redundant assignment
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nigel Christian <nigel.l.christian@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Mon, 24 May 2021 23:05:58 -0500 you wrote:
> The variable br is assigned a value that is not being read after
> exiting case IFLA_STATS_LINK_XSTATS_SLAVE. The assignment is
> redundant and can be removed.
> 
> Addresses-Coverity ("Unused value")
> Signed-off-by: Nigel Christian <nigel.l.christian@gmail.com>
> 
> [...]

Here is the summary with links:
  - net: bridge: remove redundant assignment
    https://git.kernel.org/netdev/net-next/c/ccc882f0d838

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


