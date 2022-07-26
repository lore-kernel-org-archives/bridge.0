Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F29CC41997
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DC2CE418E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1658844012;
 bh=JTC417El+CUs57vvMncV+ly5z5naqXGH++ZVORHJmK0=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=VLmpkhCpQri1xVRvF5yjpaUkOBVrcbLBcPWymxj5H4TKPGnxHufJBsNFtmz+vCwv5
 AYqU/T2tPyPo+O7Y5SKGPYrGww5Wy7gFFnNHgwNwsB0Wg8KgJsXT1fVByZFm0n7Tj2
 1Lxa62EX3CBZvvhR0GUNAXTMTK0jMMLD8ErX3j7IFOTGYbU+PnawHUGN+3MgCP5qnN
 Wk8NI/7/Gh0eNBZsTIsGy8mMEDgKnqO0nsisxwNnN4DuXQaH9Qz20BxAmzEyf1/4pa
 gCcsK7rdI53JZ2+eLoaD8O+bQ7STDvfRrXDBmL/Fsb41e/VUDIt7rl/mrA6LkD51oS
 dA/7H7oyOMT5A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <165884401276.3194.15777870435593251642.git-patchwork-notify@kernel.org>
Date: Tue, 26 Jul 2022 14:00:12 +0000
References: <20220725001236.95062-1-bpoirier@nvidia.com>
In-Reply-To: <20220725001236.95062-1-bpoirier@nvidia.com>
Subject: Re: [Bridge] [PATCH net] bridge: Do not send empty IFLA_AF_SPEC
	attribute
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, henrik.bjoernlund@microchip.com, roopa@nvidia.com, idosch@nvidia.com, horatiu.vultur@microchip.com

Hello:

This patch was applied to netdev/net.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 25 Jul 2022 09:12:36 +0900 you wrote:
> After commit b6c02ef54913 ("bridge: Netlink interface fix."),
> br_fill_ifinfo() started to send an empty IFLA_AF_SPEC attribute when a
> bridge vlan dump is requested but an interface does not have any vlans
> configured.
> 
> iproute2 ignores such an empty attribute since commit b262a9becbcb
> ("bridge: Fix output with empty vlan lists") but older iproute2 versions as
> well as other utilities have their output changed by the cited kernel
> commit, resulting in failed test cases. Regardless, emitting an empty
> attribute is pointless and inefficient.
> 
> [...]

Here is the summary with links:
  - [net] bridge: Do not send empty IFLA_AF_SPEC attribute
    https://git.kernel.org/netdev/net/c/9b134b1694ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


