Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619557810;
 bh=d82NCV/TH6w3zyVp8P1oiizsMEP4o+OYdZ9mR7Wfo5I=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=mCbeWSwBNUsnYosJdQ2ylI1FWCJsDPpTG8g8xkt/HbfRF8hNTgM5RplLsPpaHYrAd
 8/qFHBkF1UYvU88j3KMnGWUN0MtV5jHkvAQpOrRa0XB5ddO8CmQ+rn8zNOgid1cSEG
 ikCVoWqFC/zCE21K4FbsvLnKjKPLgyXIDIZeAJi9QongI+YXNzVW3V58KWpPEYyu/W
 oSU2G3nsK3uRJvr/qdQBBWcTj+u94JhMVmaxFgOiXRSbeH1D2GYwdUsccRovPEEcL4
 11+ohBu/6yvBNVOFMOQaiq/48VTCmUJrBCleiPInAKn7WjHzDS+Gai8bKjyRs0LEbn
 Tl7tYTHhqRuPw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <161955781000.15707.777989471738202707.git-patchwork-notify@kernel.org>
Date: Tue, 27 Apr 2021 21:10:10 +0000
References: <20210425152736.8421-1-linus.luessing@c0d3.blue>
In-Reply-To: <20210425152736.8421-1-linus.luessing@c0d3.blue>
Subject: Re: [Bridge] [PATCH net] net: bridge: mcast: fix broken length +
 header check for MRDv6 Adv.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?utf-8?q?Linus_L=C3=BCssing_=3Clinus=2Eluessing=40c0d3=2Eblue=3E?=@ci.codeaurora.org
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Sun, 25 Apr 2021 17:27:35 +0200 you wrote:
> The IPv6 Multicast Router Advertisements parsing has the following two
> issues:
> 
> For one thing, ICMPv6 MRD Advertisements are smaller than ICMPv6 MLD
> messages (ICMPv6 MRD Adv.: 8 bytes vs. ICMPv6 MLDv1/2: >= 24 bytes,
> assuming MLDv2 Reports with at least one multicast address entry).
> When ipv6_mc_check_mld_msg() tries to parse an Multicast Router
> Advertisement its MLD length check will fail - and it will wrongly
> return -EINVAL, even if we have a valid MRD Advertisement. With the
> returned -EINVAL the bridge code will assume a broken packet and will
> wrongly discard it, potentially leading to multicast packet loss towards
> multicast routers.
> 
> [...]

Here is the summary with links:
  - [net] net: bridge: mcast: fix broken length + header check for MRDv6 Adv.
    https://git.kernel.org/netdev/net-next/c/99014088156c

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


