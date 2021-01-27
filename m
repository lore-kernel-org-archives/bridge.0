Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611708010;
 bh=jjFGgTzCmRCv7pShpF5J8MlAqaYhEy4lCIb8vLuNKa4=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=Kd8UQW5dM5G4XMT2ytIXC2jySY8GIlogq57BAp7B8dxXI9q+WGYE4NOIzDc3Mxwlw
 AsJAIjVri6sYK+4lXqy5SSDlGbE2XyW+lHuF9/2Epm5gXHOiP2BnswBEzEXy/H5XrP
 M8o7TzB7smhB79ImmGwmwO6jURI6dlmS/qP9Fd8yCYGGhBDoPBUSzmZVfBTH3VAjLc
 g8xRl/cGd0hapBmYKkYvrBcM+RpPWq29ZA3p1O/c1U4LNGUKHMt+u9N9xY3v/UmVwt
 2qEK80iBZNixBfhpogkkUg85H8KlpNia6WQdorbNLiE9CrAI8kxlOLIoyt0QakDWu3
 9sfsKeT/Vm9bQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <161170801027.21618.16390055451192059692.git-patchwork-notify@kernel.org>
Date: Wed, 27 Jan 2021 00:40:10 +0000
References: <20210125082040.13022-1-razor@blackwall.org>
In-Reply-To: <20210125082040.13022-1-razor@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next] net: bridge: multicast: fix
 br_multicast_eht_set_entry_lookup indentation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: lkp@intel.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Mon, 25 Jan 2021 10:20:40 +0200 you wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> Fix the messed up indentation in br_multicast_eht_set_entry_lookup().
> 
> Fixes: baa74d39ca39 ("net: bridge: multicast: add EHT source set handling functions")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: bridge: multicast: fix br_multicast_eht_set_entry_lookup indentation
    https://git.kernel.org/netdev/net-next/c/3e841bacf72f

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


