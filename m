Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635511808;
 bh=8A7jVNKhe8n8XuPnA2FudeVKdnsBoqU4jLdS3VqA9qY=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=MO+MMIoX1Xef2V56xXg0iplJ3Lsbgv5Khn1yzzgmbbBikRlUPsT3VMA5HcM8hwzcD
 06up2y94ZXTxsTopa2oqAaxpMcfWjm866Ol/C5S12+CukDJkB+VPUBn1E/pErAV0Y9
 prOD6k2UO6GaMAwZul1TA5k/w10U+S+WrZ9HF6ioZS/QXKhg0pBCLVHnk9cf1eBUM7
 SMec7DoQB03j7QfLGbZhmvp1aHxxZ3hN69c4P0LDNymyDeaywSdX2STrJVqYV1+RXf
 X3xI3mya+Y3luPNdpeznFT+4burC3/lBcEQzNVUEw2EMb1Z72TB6eJIEazeUkhwU53
 RNsV/ntpNdehA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <163551180842.32606.14897066407826010805.git-patchwork-notify@kernel.org>
Date: Fri, 29 Oct 2021 12:50:08 +0000
References: <20211028155835.2134753-1-ivecera@redhat.com>
In-Reply-To: <20211028155835.2134753-1-ivecera@redhat.com>
Subject: Re: [Bridge] [PATCH net v2] net: bridge: fix uninitialized
 variables when BRIDGE_CFM is disabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, horatiu.vultur@microchip.com, henrik.bjoernlund@microchip.com, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Thu, 28 Oct 2021 17:58:35 +0200 you wrote:
> Function br_get_link_af_size_filtered() calls br_cfm_{,peer}_mep_count()
> that return a count. When BRIDGE_CFM is not enabled these functions
> simply return -EOPNOTSUPP but do not modify count parameter and
> calling function then works with uninitialized variables.
> Modify these inline functions to return zero in count parameter.
> 
> Fixes: b6d0425b816e ("bridge: cfm: Netlink Notifications.")
> Cc: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: bridge: fix uninitialized variables when BRIDGE_CFM is disabled
    https://git.kernel.org/netdev/net/c/829e050eea69

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


