Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640608809;
 bh=/NK8+LkGhicZgiX/HgeQA3rLcix8TFZ17hv+wILvgKY=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=qgKLSjNkeM5+8xOVP2S/ZUzAVttCObwil0/5LZziLctPXqN9PLO0V9AG5Xk1aFK6+
 t/5TqdhGhfUug1/0UG6EopDJzCyx74R53L2+1aInBimtexChVkOogl7IMMWzYY8hCd
 WcY7RohF0HAVLWMcpynBkr1kiVvEuiubQqG/NmewJjeHZwNUC/jtZ2xvTJEgA+YEER
 iXDO7dCjJtE/3CABa0m6Tg7n4MU8Nf3ziDofJSm51pQLlqi/vQ6QuugXe0uTHiT/NH
 CLGWtNF/avPtQT6fs0ns3H7ocy3DwRSnjanXPmLGE4VFFbFi3vNfkrSEl9mPzlLkar
 R1zuBTTYFiLQA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <164060880950.2123.6082560093716021616.git-patchwork-notify@kernel.org>
Date: Mon, 27 Dec 2021 12:40:09 +0000
References: <20211224114640.29679-1-repk@triplefau.lt>
In-Reply-To: <20211224114640.29679-1-repk@triplefau.lt>
Subject: Re: [Bridge] [PATCH net-next] net: bridge: Get SIOCGIFBR/SIOCSIFBR
 ioctl working in compat mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Remi Pommarel <repk@triplefau.lt>
Cc: arnd@arndb.de, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Fri, 24 Dec 2021 12:46:40 +0100 you wrote:
> In compat mode SIOC{G,S}IFBR ioctls were only supporting
> BRCTL_GET_VERSION returning an artificially version to spur userland
> tool to use SIOCDEVPRIVATE instead. But some userland tools ignore that
> and use SIOC{G,S}IFBR unconditionally as seen with busybox's brctl.
> 
> Example of non working 32-bit brctl with CONFIG_COMPAT=y:
> $ brctl show
> brctl: SIOCGIFBR: Invalid argument
> 
> [...]

Here is the summary with links:
  - [net-next] net: bridge: Get SIOCGIFBR/SIOCSIFBR ioctl working in compat mode
    https://git.kernel.org/netdev/net-next/c/fd3a45900055

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


