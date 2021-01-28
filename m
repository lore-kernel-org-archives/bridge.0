Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611802210;
 bh=vii+OCZ5Nl2HePoyD10UsBIj2kCrR8hpfV4ficfZ7w8=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=SvPVAwdccF0zoNRlq0q/7mQMXiBM89Xjp71jYn/2Lx+gL1nfZhTeY0v9L5VXqOK/C
 rZIOh4CfJgYiymWwSRMJ5YajsHgGp9R1iJngG4Egn4/wXFV8NWA4emWilxZzxdFiIm
 58kumg8BoJJqjuIKkMN4GhhJgLKSHVB2IctI6ulb3PcLHSE1oqz6qk2udtH8BGVl82
 iyonObTU70Qq0rVqQhg9eZsu+2zTnLiK0MpIQXsQe4jBIDGJVF3sCTq+xjjhNbTbTQ
 gSlduQ/ZwnB6oDqhpCKUnr/vMAuqPiT8XThASXWWEWEishjrZ/zhkalVH+yq5AKFUW
 lZfBq/ZS1yH5Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <161180221086.27895.14934580567433280199.git-patchwork-notify@kernel.org>
Date: Thu, 28 Jan 2021 02:50:10 +0000
References: <20210126093533.441338-1-razor@blackwall.org>
In-Reply-To: <20210126093533.441338-1-razor@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next v2 0/2] net: bridge: multicast:
 per-port EHT hosts limit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Tue, 26 Jan 2021 11:35:31 +0200 you wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> Hi,
> This set adds a simple configurable per-port EHT tracked hosts limit.
> Patch 01 adds a default limit of 512 tracked hosts per-port, since the EHT
> changes are still only in net-next that shouldn't be a problem. Then
> patch 02 adds the ability to configure and retrieve the hosts limit
> and to retrieve the current number of tracked hosts per port.
> Let's be on the safe side and limit the number of tracked hosts by
> default while allowing the user to increase that limit if needed.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: bridge: multicast: add per-port EHT hosts limit
    https://git.kernel.org/netdev/net-next/c/89268b056ed1
  - [net-next,v2,2/2] net: bridge: multicast: make tracked EHT hosts limit configurable
    https://git.kernel.org/netdev/net-next/c/2dba407f994e

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


