Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655282414;
 bh=1j1QlHsweRQpSIOaeIQBsKEDbgMrSyrzc3tKZkj01H8=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=roFPwdylpj8k5wOUNUIw6kRjxY4Ja4UmUGFwuQ3K8gRfapYOPYH7XnUKKMauOEml5
 oBq9tnoD7wpwTZT0XnLeK3r42+XqscrPH/ECZDimRC3ovozzAbvQ8Co/NMjLYHzLID
 epDDZvPmrOU59XYPTQ5oRo8fqruYw7hDjcbhmMp6L3uMrZ4KAXrV+1W4Qr9kyTgqzi
 OLLT8tgfzXSbKhAMtmwu+dNl1XAa/DAuxMp8keMVPvxxLHGMb5629mwTeKXP4CyvM8
 7Mn4/IjEo4teKNRKoN9+bpxujQKswNg4m8Oh+aITrnhOwJ6g1bDZv2Xd/Piw2z1cms
 jpXejrhaA/stA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <165528241416.21469.7301652675572375354.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jun 2022 08:40:14 +0000
References: <20220614063223.zvtrdrh7pbkv3b4v@wse-c0155>
In-Reply-To: <20220614063223.zvtrdrh7pbkv3b4v@wse-c0155>
Subject: Re: [Bridge] [PATCH net-next] net: bridge: allow add/remove
 permanent mdb entries on disabled ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Casper Andersson <casper.casan@gmail.com>
Cc: netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, edumazet@google.com, roopa@nvidia.com, troglobit@gmail.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, tobias@waldekranz.com

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Tue, 14 Jun 2022 08:32:23 +0200 you wrote:
> Adding mdb entries on disabled ports allows you to do setup before
> accepting any traffic, avoiding any time where the port is not in the
> multicast group.
> 
> Signed-off-by: Casper Andersson <casper.casan@gmail.com>
> ---
>  net/bridge/br_mdb.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [net-next] net: bridge: allow add/remove permanent mdb entries on disabled ports
    https://git.kernel.org/netdev/net-next/c/2aa4abed3792

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


