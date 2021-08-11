Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628724006;
 bh=YpmWvW0Qk3w8BFLnyW33YKDX1CeI/iRDbDtSbLHoiJo=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=iwMOsUREf/GPaPrpmyjVx/rP7LulAsoVxRRVmPqtUppDAQQ4ss89ij7wkuHShfxij
 AbpidJMLut4r+BHyVYfwVzU4mbm7IjSSzhjp4+pittUMsgYcKGi7qJ+12M4K5K6rMi
 4oCqinwRty/GV8HUtOS938+oKzgqhKfVM6o1sd3nar3eTVEW5Wgc3d46DhJi0NFVFP
 CyidOn5JvWuqjxBivM9iskN44GzHufIheZHthVSxFG5Mk6wPTdypiLRt4Mo4nb/sc1
 qXAaIjBQMG/H6DHn+DcMt94bBu8PA8EW/wBQPBz6QjlSzvsXBTG+gtdDb/degmA2Ld
 6Qi4JYXTAsFIw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <162872400616.25017.15203791570168450663.git-patchwork-notify@kernel.org>
Date: Wed, 11 Aug 2021 23:20:06 +0000
References: <20210810092139.11700-1-razor@blackwall.org>
In-Reply-To: <20210810092139.11700-1-razor@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next] net: bridge: vlan: fix global vlan
 option range dumping
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

This patch was applied to netdev/net-next.git (refs/heads/master):

On Tue, 10 Aug 2021 12:21:39 +0300 you wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> When global vlan options are equal sequentially we compress them in a
> range to save space and reduce processing time. In order to have the
> proper range end id we need to update range_end if the options are equal
> otherwise we get ranges with the same end vlan id as the start.
> 
> [...]

Here is the summary with links:
  - [net-next] net: bridge: vlan: fix global vlan option range dumping
    https://git.kernel.org/netdev/net-next/c/6c4110d9f499

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


