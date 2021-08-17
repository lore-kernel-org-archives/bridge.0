Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629193211;
 bh=V9Bku/K/4t7oyt1jzwKixNxdquZRMQx4YUQra0E8/ME=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=DW+nWchzNdunC6g/e4SZfCDN7+hkb70xSwIMrAAy1OE4kk5A9g+vQWkWVoZgWJ0yo
 7edNw+3MUixJm+Wi/LjH4a0U32nEbmtaugrQvvGAZ7E+cej2vKYcKkTcRzYgHneUyB
 uVagpa0/J2h9wOyb5xBHrb1oxXeWBAz2ibfWYqQo9xqB7p1yhwcT+Mp5tezu3x5R7e
 XGsWoIwNp18jws/blTHaVAaNzezRA3/Dsbl0Vg8DMgBDyevWseu2sCVAW320QccZwK
 D+5el5S3VF4fKTm9GUFqjvIleGpCH0Ym8geLTHvo1P6FsIIFGLS0wpdHG2HELxl0ku
 HOhkWmWCbl2aA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <162919321138.26227.14459978814742770113.git-patchwork-notify@kernel.org>
Date: Tue, 17 Aug 2021 09:40:11 +0000
References: <20210816145707.671901-1-razor@blackwall.org>
In-Reply-To: <20210816145707.671901-1-razor@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next 0/4] net: bridge: vlan: fixes for vlan
	mcast contexts
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, nikolay@nvidia.com, roopa@nvidia.com

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Mon, 16 Aug 2021 17:57:03 +0300 you wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> Hi,
> These are four fixes for vlan multicast contexts. The first patch enables
> mcast ctx snooping when adding already existing master vlans to be
> consistent with the rest of the code. The second patch accounts for the
> mcast ctx router ports when allocating skb for notification. The third
> one fixes two suspicious rcu usages due to wrong vlan group helper, and
> the fourth updates host vlan mcast state along with port mcast state.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net: bridge: vlan: enable mcast snooping for existing master vlans
    https://git.kernel.org/netdev/net-next/c/b92dace38f8f
  - [net-next,2/4] net: bridge: vlan: account for router port lists when notifying
    https://git.kernel.org/netdev/net-next/c/05d6f38ec0a5
  - [net-next,3/4] net: bridge: mcast: use the correct vlan group helper
    https://git.kernel.org/netdev/net-next/c/3f0d14efe2fa
  - [net-next,4/4] net: bridge: mcast: toggle also host vlan state in br_multicast_toggle_vlan
    https://git.kernel.org/netdev/net-next/c/affce9a774ca

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


