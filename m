Return-Path: <patchwork-bot+netdevbpf@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <160686600727.2300.3935564994527670490.git-patchwork-notify@kernel.org>
Date: Tue, 01 Dec 2020 23:40:07 +0000
References: <20201129125407.1391557-1-idosch@idosch.org>
In-Reply-To: <20201129125407.1391557-1-idosch@idosch.org>
Subject: Re: [Bridge] [PATCH net-next 0/9] mlxsw: Add support for 802.1ad
	bridging
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>
Cc: ivecera@redhat.com, petrm@nvidia.com, amcohen@nvidia.com, danieller@nvidia.com, netdev@vger.kernel.org, idosch@nvidia.com, bridge@lists.linux-foundation.org, roopa@nvidia.com, mlxsw@nvidia.com, nikolay@nvidia.com, jiri@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Sun, 29 Nov 2020 14:53:58 +0200 you wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> 802.1ad, also known as QinQ, is an extension to the 802.1q standard,
> which is concerned with passing possibly 802.1q-tagged packets through
> another VLAN-like tunnel. The format of 802.1ad tag is the same as
> 802.1q, except it uses the EtherType of 0x88a8, unlike 802.1q's 0x8100.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] mlxsw: reg: Add Switch Port VLAN Classification Register
    https://git.kernel.org/netdev/net-next/c/7e9a6620d5c3
  - [net-next,2/9] mlxsw: reg: Add et_vlan field to SPVID register
    https://git.kernel.org/netdev/net-next/c/2a5a290d6d94
  - [net-next,3/9] mlxsw: spectrum: Only treat 802.1q packets as tagged packets
    https://git.kernel.org/netdev/net-next/c/a2ef3ae15834
  - [net-next,4/9] mlxsw: Make EtherType configurable when pushing VLAN at ingress
    https://git.kernel.org/netdev/net-next/c/3ae7a65b6424
  - [net-next,5/9] mlxsw: spectrum_switchdev: Create common functions for VLAN-aware bridge
    https://git.kernel.org/netdev/net-next/c/773ce33a4860
  - [net-next,6/9] mlxsw: spectrum_switchdev: Add support of QinQ traffic
    https://git.kernel.org/netdev/net-next/c/80dfeafd6479
  - [net-next,7/9] bridge: switchdev: Notify about VLAN protocol changes
    https://git.kernel.org/netdev/net-next/c/22ec19f3aee3
  - [net-next,8/9] mlxsw: Add QinQ configuration vetoes
    https://git.kernel.org/netdev/net-next/c/09139f67d346
  - [net-next,9/9] selftests: forwarding: Add QinQ veto testing
    https://git.kernel.org/netdev/net-next/c/008cb2ec4354

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


