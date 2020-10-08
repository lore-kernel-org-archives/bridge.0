Return-Path: <patchwork-bot+netdevbpf@kernel.org>
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602187205;
 bh=1WhE5EzPegLl39at06cilTCOFsyWTja12hZlDpWb/d4=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=Ev69BPsUnGFThD4QuhjsMdaITkLXmaCxF1IF1nEtbtZ5WyP0MB4/DF23UujrfOZEb
 k2v9b6PnFSqsV+R6ZwBZswxvbCsO+YnCkhirg4GIo93a9y3C6Z7/rovZElPtaLdXEh
 fNDquAxg25EMer+Ql6/V8t3O+arZ7XN/drZBZbEE=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <160218720516.8125.842220080436586129.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2020 20:00:05 +0000
References: <20201007120700.2152699-1-henrik.bjoernlund@microchip.com>
In-Reply-To: <20201007120700.2152699-1-henrik.bjoernlund@microchip.com>
Subject: Re: [Bridge] [PATCH net] bridge: Netlink interface fix.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, horatiu.vultur@microchip.com, davem@davemloft.net

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Wed, 7 Oct 2020 12:07:00 +0000 you wrote:
> This commit is correcting NETLINK br_fill_ifinfo() to be able to
> handle 'filter_mask' with multiple flags asserted.
> 
> Fixes: 36a8e8e265420 ("bridge: Extend br_fill_ifinfo to return MPR status")
> 
> Signed-off-by: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
> Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> Suggested-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> Tested-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> [...]

Here is the summary with links:
  - [net] bridge: Netlink interface fix.
    https://git.kernel.org/netdev/net/c/b6c02ef54913

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


