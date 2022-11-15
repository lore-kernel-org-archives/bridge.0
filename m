Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0B74660C14
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 212D060BAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668517215;
 bh=VF4Q0WzM2CiusNuMpims9Ot44VyD7qu0aefy2AZtTrc=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=IOc4juoSaRS0kNtR75y9p6+leOkIdF5fXg8yWFZC0vOqlbdNhHQqKHWBGDC4mQopX
 w4mJcad/3OWFJw2qy7Pv63eZbXvnJZwDGbUEySZ/2gSEOMYeTwXpoN5i3TeEi60GSL
 U9kfF4QBSvmVkPuFT7dPZyJBnqmjzIqRveADH2+z5NhzzxzCPnE82Vydb1/+Ydm0dU
 2gGb37WxNfhMCvIxnWJ7UAEszIdJ/JfW3MqXTpnypMy9N+mTP0bGNUWYUTt7v7leUg
 NpD9SMnEGcZimDthraXkrQ6mGhOt5Xp/yxs6lKiLpCUpf+vRFIrrf/Hs7RD3GIwOSM
 f49eHOE2Mjpew==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <166851721541.14988.2851505012033520291.git-patchwork-notify@kernel.org>
Date: Tue, 15 Nov 2022 13:00:15 +0000
References: <20221114084509.860831-1-idosch@nvidia.com>
In-Reply-To: <20221114084509.860831-1-idosch@nvidia.com>
Subject: Re: [Bridge] [PATCH net] bridge: switchdev: Fix memory leaks when
 changing VLAN protocol
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: petrm@nvidia.com, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, roopa@nvidia.com, edumazet@google.com, mlxsw@nvidia.com, vladbu@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Hello:

This patch was applied to netdev/net.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 14 Nov 2022 10:45:09 +0200 you wrote:
> The bridge driver can offload VLANs to the underlying hardware either
> via switchdev or the 8021q driver. When the former is used, the VLAN is
> marked in the bridge driver with the 'BR_VLFLAG_ADDED_BY_SWITCHDEV'
> private flag.
> 
> To avoid the memory leaks mentioned in the cited commit, the bridge
> driver will try to delete a VLAN via the 8021q driver if the VLAN is not
> marked with the previously mentioned flag.
> 
> [...]

Here is the summary with links:
  - [net] bridge: switchdev: Fix memory leaks when changing VLAN protocol
    https://git.kernel.org/netdev/net/c/9d45921ee4cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


