Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616615408;
 bh=jWlbCW3ZvY9ep7+jRAH9k7cY3rs1dnmpwgoeOz00z3w=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=XvWZJy4NHh8YmWYB8PAjHxyx49VVepw96KB0QiUqOhGfsgQCMCMHass0aSITxUnDL
 zqONfHDu2Rh9xt9iydwQhFVQFV2qFsC/RsE5JCuhuJud+kSv43icaaSJ8WV36rNDBB
 u6w5SeXpFQp4y6w/sWCgjN4Amn6DM0dkE9NRG25pygwhWBIbKJ+rQZYP0KjhAUPYlp
 /tcnv+aGplz62JyEtRGuJDU53WmGky+Z5BbgHOcExhGOSdU4BzICJbSEzoAPfTf/zz
 l5OkSCqmE5EvKhJHjeDDzITvjfUFKYqW1jOkeGZ1mFnhR3yb6GfRtc3PWxATBmMJpt
 2iaqc+kkiH6Bw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <161661540817.24400.14095983696664158789.git-patchwork-notify@kernel.org>
Date: Wed, 24 Mar 2021 19:50:08 +0000
References: <20210324150950.253698-1-colin.king@canonical.com>
In-Reply-To: <20210324150950.253698-1-colin.king@canonical.com>
Subject: Re: [Bridge] [PATCH][next] net: bridge: Fix missing return
 assignment from br_vlan_replay_one call
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Colin King <colin.king@canonical.com>
Cc: vladimir.oltean@nxp.com, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Wed, 24 Mar 2021 15:09:50 +0000 you wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The call to br_vlan_replay_one is returning an error return value but
> this is not being assigned to err and the following check on err is
> currently always false because err was initialized to zero. Fix this
> by assigning err.
> 
> [...]

Here is the summary with links:
  - [next] net: bridge: Fix missing return assignment from br_vlan_replay_one call
    https://git.kernel.org/netdev/net-next/c/ad248f7761eb

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


