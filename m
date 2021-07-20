Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626790205;
 bh=QHPi1SgHTJ+jVsXJuZMmsL5Frcd/QclJHG3SP/hUrmI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=f9Ss/cYPiIqd0kwgavL8JGXr/iJ0Hubg74x08cT2HRgshNIQOUzBzbnlsnYnFM4Eo
 X6W1BEE3paPlTBefsC/hmjSEtbye9LfFhKYfFbiDEuTuVVghG7rP9bD3cuFzctmOBt
 16SWDjarBbhdA/X2dGNICH7ZI3iEpJK4lyqHjWpeczFSCk/ItuhoiCo6Hc+am937jf
 BwkcK0twzsrlwsnyXDseSxnFGpoL96ctOc5Yd3ClizcyMs9EbH+n2QGUWc3xvhUuyA
 RxISjH+NACMO7Q5oVng58dDjyGjHjVHb/5z6WkEln9qsjHilMMXPJRrEtB0hZxiSGA
 FjS9znfn7mcZQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <162679020560.11280.5860965048088740851.git-patchwork-notify@kernel.org>
Date: Tue, 20 Jul 2021 14:10:05 +0000
References: <20210719135140.278938-1-vladimir.oltean@nxp.com>
In-Reply-To: <20210719135140.278938-1-vladimir.oltean@nxp.com>
Subject: Re: [Bridge] [PATCH net-next 0/3] Fan out FDB entries pointing
 towards the bridge to all switchdev member ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, dqfext@gmail.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, vivien.didelot@gmail.com, idosch@idosch.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net, tobias@waldekranz.com

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Mon, 19 Jul 2021 16:51:37 +0300 you wrote:
> The "DSA RX filtering" series has added some important support for
> interpreting addresses towards the bridge device as host addresses and
> installing them as FDB entries towards the CPU port, but it does not
> cover all circumstances and needs further work.
> 
> To be precise, the mechanism introduced in that series only works as
> long as the ports are fairly static and no port joins or leaves the
> bridge once the configuration is done. If any port leaves, host FDB
> entries that were installed during runtime (for example the user changes
> the MAC address of the bridge device) will be prematurely deleted,
> resulting in a broken setup.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: switchdev: introduce helper for checking dynamically learned FDB entries
    https://git.kernel.org/netdev/net-next/c/c6451cda100d
  - [net-next,2/3] net: switchdev: introduce a fanout helper for SWITCHDEV_FDB_{ADD,DEL}_TO_DEVICE
    https://git.kernel.org/netdev/net-next/c/8ca07176ab00
  - [net-next,3/3] net: dsa: use switchdev_handle_fdb_{add,del}_to_device
    https://git.kernel.org/netdev/net-next/c/b94dc99c0ddb

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


