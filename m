Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647562814;
 bh=VhMA0U/HDQoA1cmOY4Bw3fD0npt5Q4VMst5fHYiRhmA=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=P6Go+x8KVLt2xjAZm2WceBHay10DQUhwETNW0CAa436/pxozvw3gfdDDZLfBCeZjM
 +iim+PYuyZVmXu3qGxseThgyfqcAWTDgH+SXULnOChAIZCYDpM0PUqby68bZWrttit
 8IJ4xAVtwDxfSlZKUU5TPJfZ9Go3KAnIpAPs6uEbGFDQI9G/tiYIGjVd2F2JF7yp1D
 84Eo4tyw4xeURBuNUU6v+qQ2iVY4qRomm3WfjQV/qVfHpGnOGydA1a6FzMfuRDNQQL
 AJ+h3r9m1RKBZnO7xQGOlWhkD8t7SPy32MxvxWeX87Rg78FdTqWZp7v+euptDvT5LI
 BZ60cpxZaNNFg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <164756281405.28197.1278570234241451207.git-patchwork-notify@kernel.org>
Date: Fri, 18 Mar 2022 00:20:14 +0000
References: <20220316150857.2442916-1-tobias@waldekranz.com>
In-Reply-To: <20220316150857.2442916-1-tobias@waldekranz.com>
Subject: Re: [Bridge] [PATCH v5 net-next 00/15] net: bridge: Multiple
	Spanning Trees
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: ivecera@redhat.com, andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, petrm@nvidia.com, razor@blackwall.org, bridge@lists.linux-foundation.org, linux@armlinux.org.uk, vivien.didelot@gmail.com, idosch@nvidia.com, netdev@vger.kernel.org, me@cooperlees.com, roopa@nvidia.com, kuba@kernel.org, matt@codeconstruct.com.au, olteanv@gmail.com, davem@davemloft.net, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Mar 2022 16:08:42 +0100 you wrote:
> The bridge has had per-VLAN STP support for a while now, since:
> 
> https://lore.kernel.org/netdev/20200124114022.10883-1-nikolay@cumulusnetworks.com/
> 
> The current implementation has some problems:
> 
> - The mapping from VLAN to STP state is fixed as 1:1, i.e. each VLAN
>   is managed independently. This is awkward from an MSTP (802.1Q-2018,
>   Clause 13.5) point of view, where the model is that multiple VLANs
>   are grouped into MST instances.
> 
> [...]

Here is the summary with links:
  - [v5,net-next,01/15] net: bridge: mst: Multiple Spanning Tree (MST) mode
    https://git.kernel.org/netdev/net-next/c/ec7328b59176
  - [v5,net-next,02/15] net: bridge: mst: Allow changing a VLAN's MSTI
    https://git.kernel.org/netdev/net-next/c/8c678d60562f
  - [v5,net-next,03/15] net: bridge: mst: Support setting and reporting MST port states
    https://git.kernel.org/netdev/net-next/c/122c29486e1f
  - [v5,net-next,04/15] net: bridge: mst: Notify switchdev drivers of MST mode changes
    https://git.kernel.org/netdev/net-next/c/87c167bb94ee
  - [v5,net-next,05/15] net: bridge: mst: Notify switchdev drivers of VLAN MSTI migrations
    https://git.kernel.org/netdev/net-next/c/6284c723d9b9
  - [v5,net-next,06/15] net: bridge: mst: Notify switchdev drivers of MST state changes
    https://git.kernel.org/netdev/net-next/c/7ae9147f4312
  - [v5,net-next,07/15] net: bridge: mst: Add helper to map an MSTI to a VID set
    https://git.kernel.org/netdev/net-next/c/cceac97afa09
  - [v5,net-next,08/15] net: bridge: mst: Add helper to check if MST is enabled
    https://git.kernel.org/netdev/net-next/c/48d57b2e5f43
  - [v5,net-next,09/15] net: bridge: mst: Add helper to query a port's MST state
    https://git.kernel.org/netdev/net-next/c/f54fd0e16306
  - [v5,net-next,10/15] net: dsa: Validate hardware support for MST
    https://git.kernel.org/netdev/net-next/c/332afc4c8c0d
  - [v5,net-next,11/15] net: dsa: Pass VLAN MSTI migration notifications to driver
    https://git.kernel.org/netdev/net-next/c/8e6598a7b0fa
  - [v5,net-next,12/15] net: dsa: Handle MST state changes
    https://git.kernel.org/netdev/net-next/c/7414af30b7d8
  - [v5,net-next,13/15] net: dsa: mv88e6xxx: Disentangle STU from VTU
    https://git.kernel.org/netdev/net-next/c/49c98c1dc7d9
  - [v5,net-next,14/15] net: dsa: mv88e6xxx: Export STU as devlink region
    https://git.kernel.org/netdev/net-next/c/7dc96039b967
  - [v5,net-next,15/15] net: dsa: mv88e6xxx: MST Offloading
    https://git.kernel.org/netdev/net-next/c/acaf4d2e36b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


