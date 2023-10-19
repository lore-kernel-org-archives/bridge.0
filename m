Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3966C42094
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3EAAC41D70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697730022;
 bh=RXleMGUABnXctBgs2bSXk7hwLIx2O6aidlEwNJw1R+8=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=ohVx8xPMSLc2bJXDB8tRTPnIZXsFXaen/7bBgD4Cb/I9idU7Whp0Tdl7dCXsuukt5
 bPXq9P7cRyGyPP+OIp57xhvozjhA4nBv0fHTbapsx82MvEY/cQoTs/KvZYH5u/YYS5
 pIaidIolo2KuoNgQuM8hl34nDAi3Ii11qlpm/FBbQyQZTClZCCgf1eqL4LKUCH9M5e
 GHhT336wd9IutVscEpOe8zNMyX3GP1AkK2q+equEUw0PSZvaa8ykEPVpw4XXp4KYeZ
 VK+MPz3TxNVVxL8kcCW7tH5sn9m2rtRn54zQfslJaNYEEIFPBD03dikMglZuOA71WI
 eb2dqfBYiTmpQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <169773002236.10915.7572793107235329470.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 15:40:22 +0000
References: <20231018-fdb_limit-v5-1-7ca3b3eb7c1f@avm.de>
In-Reply-To: <20231018-fdb_limit-v5-1-7ca3b3eb7c1f@avm.de>
Subject: Re: [Bridge] [PATCH iproute2-next v5] iplink: bridge: Add support
 for bridge FDB learning limits
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>
Cc: petrm@nvidia.com, dsahern@gmail.com, idosch@nvidia.com, razor@blackwall.org, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, roopa@nvidia.com

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 18 Oct 2023 09:04:43 +0200 you wrote:
> Support setting the FDB limit through ip link. The arguments is:
>  - fdb_max_learned: A 32-bit unsigned integer specifying the maximum
>                     number of learned FDB entries, with 0 disabling
>                     the limit.
> 
> Also support reading back the current number of learned FDB entries in
> the bridge by this count. The returned value's name is:
>  - fdb_n_learned: A 32-bit unsigned integer specifying the current number
>                   of learned FDB entries.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v5] iplink: bridge: Add support for bridge FDB learning limits
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=48cb4320487a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


