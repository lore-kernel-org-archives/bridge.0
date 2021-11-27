Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637974211;
 bh=v8BOn7EPv3xrqT4+YqYoa4aVCb5AluDB5tNqp1286cE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=X0qeK9kERWhhQzgiD/PBi3Vp/QahRo2qmWaX2Kzkw1q0p6DKR52RLCkK1TuZgEQ91
 iA0YYKA2b6l/bDDwj8KklPw6gNWcLi37rvXrRfpLyZZNZQEaYcVmeVWg/RQgokCRkx
 5xXBNoCpnOoljA2np78oqp+AEZZVfJ6sgk15SKWhym/yDCVCh1tIat0DKBYFmGiLDj
 xIKLiuioEtv1WGfioRwASgjbRoBLtMR3l4mSF0O+1tgcLs9VWCRY6Wn0kZb658WXXP
 oqgsMFaMCKrU7pRgp8IwzI70Xy8YQlyZ2iG40sGU9q5ZJvP957rowAMce8VuOn+ZsK
 7TJdZdZ9Itg1g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <163797421104.20298.2423972399369533865.git-patchwork-notify@kernel.org>
Date: Sat, 27 Nov 2021 00:50:11 +0000
References: <4e35f415226765e79c2a11d2c96fbf3061c486e2.1637782773.git.lucien.xin@gmail.com>
In-Reply-To: <4e35f415226765e79c2a11d2c96fbf3061c486e2.1637782773.git.lucien.xin@gmail.com>
Subject: Re: [Bridge] [PATCH net-next] bridge: use __set_bit in
	__br_vlan_set_default_pvid
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, christophe.jaillet@wanadoo.fr, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Nov 2021 14:39:33 -0500 you wrote:
> The same optimization as the one in commit cc0be1ad686f ("net:
> bridge: Slightly optimize 'find_portno()'") is needed for the
> 'changed' bitmap in __br_vlan_set_default_pvid().
> 
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  net/bridge/br_vlan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] bridge: use __set_bit in __br_vlan_set_default_pvid
    https://git.kernel.org/netdev/net-next/c/442b03c32ca1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


