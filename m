Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626112203;
 bh=m1u+wsv4BJOX3LivCYyJp0GfsFgFqYK+vfWFUwQLN38=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=b+uicz15iiBfEcOLpE4brAL1ii21QEunJ698xJX21eGLJP/q4iRHLmc1vsTEm5TuK
 f/JSlbXiCLwTE2Jm7rOnUbqpzfZie5El9np9MsQkGIgJrWteDWOwE7caZfKFXYyMCX
 SnyPwPoIdG1JWRCvRE4c8LTA193tN9o+eAvl8ZtcZ7s7FHWK08dnBJmFeOTGifvZ8A
 rSkFQWewoy1RU50hmdYg9O+P6NSjG83l9yNYZEGxCDR5VfWrnpZti1kczHa29dO0ba
 T687BCvCPT6AR2DTk06xaFmLzStmWySiPj+tU43pJHJHAANbwnWDiYNkbjLxfaRfu9
 P+Wd/PY5v6NXA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <162611220380.1672.9078277385481579129.git-patchwork-notify@kernel.org>
Date: Mon, 12 Jul 2021 17:50:03 +0000
References: <20210711095629.2986949-1-razor@blackwall.org>
In-Reply-To: <20210711095629.2986949-1-razor@blackwall.org>
Subject: Re: [Bridge] [PATCH net 0/2] net: bridge: multicast: fix automatic
 router port marking races
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, nikolay@nvidia.com, stable@vger.kernel.org, roopa@nvidia.com

Hello:

This series was applied to netdev/net.git (refs/heads/master):

On Sun, 11 Jul 2021 12:56:27 +0300 you wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> Hi,
> While working on per-vlan multicast snooping I found two race conditions
> when multicast snooping is enabled. They're identical and happen when
> the router port list is modified without the multicast lock. One requires
> a PIM hello message to be received on a port and the other an MRD
> advertisement. To fix them we just need to take the multicast_lock when
> adding the ports to the router port list (marking them as router ports).
> Tested on an affected setup by generating the required packets while
> modifying the port list in parallel.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: bridge: multicast: fix PIM hello router port marking race
    https://git.kernel.org/netdev/net/c/04bef83a3358
  - [net,2/2] net: bridge: multicast: fix MRD advertisement router port marking race
    https://git.kernel.org/netdev/net/c/000b7287b675

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


