Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628626805;
 bh=VdV1s6LdLnj+V2FiURRO+XOlJpDjgTL7v60lLLPRBtE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=oTQiehzL1H2R98IZi14TSEzpO9GkS9DtbNfteH1q0DejubQavTYqyC1oBwn7aYzbD
 BC8uzx6/M+ujn6QDUCiNimTM+kBUzFWa1OS+lnkXnjQChMxHjSf2OBiUe2XVJJdXj7
 S3KT60K0JN4hHKE1+EjtyRkOGLHyKSx06siF9VriaGtDHiYE7p+pH9ztFwuNzINOuv
 48RCfjxp60N6ezYpmgueRf74VvhUC7ffBGd/VezzLcZ70F0MbC/PFmUO8vxGY14Sn0
 7POMKak5eGX033uI5wT0sBA1Ai2Ysk7+Gzx63ya5msXVPNPou43q0FRQqSPh645xGJ
 yFBhsn1vsxMGw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <162862680584.11744.11028894548739295364.git-patchwork-notify@kernel.org>
Date: Tue, 10 Aug 2021 20:20:05 +0000
References: <20210810110010.43859-1-razor@blackwall.org>
In-Reply-To: <20210810110010.43859-1-razor@blackwall.org>
Subject: Re: [Bridge] [PATCH net v2] net: bridge: fix flags interpretation
 for extern learn fdb entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: vladimir.oltean@nxp.com, idosch@nvidia.com, bridge@lists.linux-foundation.org, roopa@nvidia.com, nikolay@nvidia.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Tue, 10 Aug 2021 14:00:10 +0300 you wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> Ignore fdb flags when adding port extern learn entries and always set
> BR_FDB_LOCAL flag when adding bridge extern learn entries. This is
> closest to the behaviour we had before and avoids breaking any use cases
> which were allowed.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: bridge: fix flags interpretation for extern learn fdb entries
    https://git.kernel.org/netdev/net/c/45a687879b31

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


