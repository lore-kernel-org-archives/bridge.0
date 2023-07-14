Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F3522606AA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 01059600CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1689320421;
 bh=zViWJNTHWrbHBwfi3RX0ddnfAUS+Uix1W7WMqjrfPZI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=Zxkkrfx91nWV0zJDFJPtFB66J8uVx4ne1J8fFt7JkP5LUoRY0seLieteKaWvvvUIm
 e6ZoC7HGsAB4dauV/Vyh0nBdBN+v9UHvz1tr2q80KqKRlvzEIq5VAOnE7j0Brg2PP3
 sKzouVKV/wxOFbY7M0juMLrUm9CFcOAFlaLZGML5ZZAtRys4c2hevR7FhJRXQKIJp5
 2fMfoLPyn1t3p9xK5vssUloheu568tyFCT7mSoSlOzuk3hKJ/uQXvzz1mCoLAjoeL0
 S6AiN9YmS1xBtmZ95/1X2lZcxgs/CIy0BpCi4hysHMOrzEV8ZzysZp2+atbAuJBscv
 E5ojiqmw+5KTA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <168932042084.7517.1979590687068900394.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jul 2023 07:40:20 +0000
References: <20230712154449.6093-1-kuniyu@amazon.com>
In-Reply-To: <20230712154449.6093-1-kuniyu@amazon.com>
Subject: Re: [Bridge] [PATCH v2 net] bridge: Add extack warning when
	enabling STP in netns.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, kuni1840@gmail.com, hcoin@quietfountain.com, idosch@idosch.org, edumazet@google.com, ebiederm@xmission.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 12 Jul 2023 08:44:49 -0700 you wrote:
> When we create an L2 loop on a bridge in netns, we will see packets storm
> even if STP is enabled.
> 
>   # unshare -n
>   # ip link add br0 type bridge
>   # ip link add veth0 type veth peer name veth1
>   # ip link set veth0 master br0 up
>   # ip link set veth1 master br0 up
>   # ip link set br0 type bridge stp_state 1
>   # ip link set br0 up
>   # sleep 30
>   # ip -s link show br0
>   2: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
>       link/ether b6:61:98:1c:1c:b5 brd ff:ff:ff:ff:ff:ff
>       RX: bytes  packets  errors  dropped missed  mcast
>       956553768  12861249 0       0       0       12861249  <-. Keep
>       TX: bytes  packets  errors  dropped carrier collsns     |  increasing
>       1027834    11951    0       0       0       0         <-'   rapidly
> 
> [...]

Here is the summary with links:
  - [v2,net] bridge: Add extack warning when enabling STP in netns.
    https://git.kernel.org/netdev/net/c/56a16035bb6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


