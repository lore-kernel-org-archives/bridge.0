Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 50F4042718
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7784042722
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1681977018;
 bh=Zex/PHqNKlzuqAb5IKI38cfJjF9+sZcpSyiYt2IgbdE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=O6PaxSi2uEIQi8YDcQHElp+rn3lkbiN/7ej31a2vyTF/ZgCSzg98dqgK4f8btz+8z
 id81Q/PYJ8nRHy96/kU9sCi0WJqwtGhYISQG8dqFXwMjKNq0DJ7jR4HyrsRqnoaBL3
 ceDfwjPuEPUHQ5VLMThnRnWQrJWvqbkCRsw9Z47NdS7BaG+i9CQVIDjvdVBHeLJx9C
 swN/8z/x1GH3TnizoSHIMMPob+veFvEO48/TtO4mpgsdhhA4hkdYwyNW2RRynQhUiZ
 mC4pNNy9rbKxewJICmXaHQriI0Sp5WBbRg3BgNSz6nUX0+vNKIIWH/bxpokmNLNZMY
 ZDXT/eZfMqb0g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <168197701861.16164.10630611699563272591.git-patchwork-notify@kernel.org>
Date: Thu, 20 Apr 2023 07:50:18 +0000
References: <20230418155902.898627-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230418155902.898627-1-vladimir.oltean@nxp.com>
Subject: Re: [Bridge] [PATCH v2 net] net: bridge: switchdev: don't notify
 FDB entries with "master dynamic"
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: ivecera@redhat.com, bridge@lists.linux-foundation.org, jiri@resnulli.us, netdev@vger.kernel.org, razor@blackwall.org, netdev@kapio-technology.com, roopa@nvidia.com, jesse.brandeburg@intel.com, edumazet@google.com, idosch@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 18 Apr 2023 18:59:02 +0300 you wrote:
> There is a structural problem in switchdev, where the flag bits in
> struct switchdev_notifier_fdb_info (added_by_user, is_local etc) only
> represent a simplified / denatured view of what's in struct
> net_bridge_fdb_entry :: flags (BR_FDB_ADDED_BY_USER, BR_FDB_LOCAL etc).
> Each time we want to pass more information about struct
> net_bridge_fdb_entry :: flags to struct switchdev_notifier_fdb_info
> (here, BR_FDB_STATIC), we find that FDB entries were already notified to
> switchdev with no regard to this flag, and thus, switchdev drivers had
> no indication whether the notified entries were static or not.
> 
> [...]

Here is the summary with links:
  - [v2,net] net: bridge: switchdev: don't notify FDB entries with "master dynamic"
    https://git.kernel.org/netdev/net/c/927cdea5d209

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


