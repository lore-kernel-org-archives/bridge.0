Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648057812;
 bh=rZ70td1sUS/GDoOuxgtxbnB3REa3lkh0/GuoF5TNc80=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=A8A7Rf/9WDlEbpiwDY0XgD9WpXagdbvWELls5xCw9GlhtOjaks+wbUu1rjvILhaGX
 BWReAfs4/hKOsPgAW69Z1jx8cWdjwlBGlAt7OYTdq+NYCqttMEeLeG7jLMEf6MTifn
 rv3FoXwFGuICDwujwm7lnr+lQphjAsaBnsbJ+ZhUXZaVOE6Fom41RpNYTuINtRpHRT
 Omm1PO68b5Cfm/J4cy1p8La7UlDF8c1slY3KSmFyl+0tl7/XzU4ISkh3FofS7BCyB5
 3LjtnmQAbhCanE027Uq8/5XAcaEV7Qe5kSPC1fekz9JkPrrFiCWGKFRm9EW5IcdLZW
 vs6eHqROz6bIQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <164805781205.23946.3779643017453826471.git-patchwork-notify@kernel.org>
Date: Wed, 23 Mar 2022 17:50:12 +0000
References: <20220322133001.16181-1-tobias@waldekranz.com>
In-Reply-To: <20220322133001.16181-1-tobias@waldekranz.com>
Subject: Re: [Bridge] [PATCH net-next] net: bridge: mst: Restrict info size
 queries to bridge ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Mar 2022 14:30:01 +0100 you wrote:
> Ensure that no bridge masters are ever considered for MST info
> dumping. MST states are only supported on bridge ports, not bridge
> masters - which br_mst_info_size relies on.
> 
> Fixes: 122c29486e1f ("net: bridge: mst: Support setting and reporting MST port states")
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: bridge: mst: Restrict info size queries to bridge ports
    https://git.kernel.org/netdev/net-next/c/a911ad18a56a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


