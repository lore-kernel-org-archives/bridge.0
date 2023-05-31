Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA93760DE5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E4CBE608D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685516422;
 bh=r0KIbdwpgXgFSmC8bPmq5xQixhE9aSHSAEULanS/PDE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=kyAZ1zyIiYmuPW/lQqknodkW7y/oPHbTrBfiwM7IK1T2kKGmvv+cKFXZx/9XMBhqt
 K1X77qXe23da284Mf69kKyBdIl5XLyTu1sajaQL8QYt3fRMOkZ6Ozw/1o79bDu8MuM
 eNr1mrglJ0nFBO6TDwwdl2mbJu+ctftf1L+9G8pN7rI3ZA1NG36lQpr1zEz0ZiVXhb
 z7m64PcKzLW47hJP2k75sdETnhOBJ5DEF3WP4DZJLuY2Gy8VYTpuK5xFBFQ3TEfmPo
 iGmM3vDH232aDHN4wPJozD78n9oRjmCozbgf1D28RLkcPtwPR/ri6JvZszvGfKCAEe
 VPE2+sM8IhRiA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <168551642191.20025.10645289366060748687.git-patchwork-notify@kernel.org>
Date: Wed, 31 May 2023 07:00:21 +0000
References: <20230529114835.372140-1-idosch@nvidia.com>
In-Reply-To: <20230529114835.372140-1-idosch@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next v2 0/8] Add layer 2 miss indication
	and filtering
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, razor@blackwall.org, jiri@resnulli.us, leon@kernel.org, roopa@nvidia.com, netdev@vger.kernel.org, xiyou.wangcong@gmail.com, bridge@lists.linux-foundation.org, claudiu.manoil@nxp.com, UNGLinuxDriver@microchip.com, edumazet@google.com, jhs@mojatatu.com, vladimir.oltean@nxp.com, simon.horman@corigine.com, kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, davem@davemloft.net

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 May 2023 14:48:27 +0300 you wrote:
> tl;dr
> =====
> 
> This patchset adds a single bit to the tc skb extension to indicate that
> a packet encountered a layer 2 miss in the bridge and extends flower to
> match on this metadata. This is required for non-DF (Designated
> Forwarder) filtering in EVPN multi-homing which prevents decapsulated
> BUM packets from being forwarded multiple times to the same multi-homed
> host.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/8] skbuff: bridge: Add layer 2 miss indication
    https://git.kernel.org/netdev/net-next/c/7b4858df3bf7
  - [net-next,v2,2/8] flow_dissector: Dissect layer 2 miss from tc skb extension
    https://git.kernel.org/netdev/net-next/c/d5ccfd90df7f
  - [net-next,v2,3/8] net/sched: flower: Allow matching on layer 2 miss
    https://git.kernel.org/netdev/net-next/c/1a432018c0cd
  - [net-next,v2,4/8] flow_offload: Reject matching on layer 2 miss
    https://git.kernel.org/netdev/net-next/c/f4356947f029
  - [net-next,v2,5/8] mlxsw: spectrum_flower: Split iif parsing to a separate function
    https://git.kernel.org/netdev/net-next/c/d04e26509678
  - [net-next,v2,6/8] mlxsw: spectrum_flower: Do not force matching on iif
    https://git.kernel.org/netdev/net-next/c/0b9cd74b8d1e
  - [net-next,v2,7/8] mlxsw: spectrum_flower: Add ability to match on layer 2 miss
    https://git.kernel.org/netdev/net-next/c/caa4c58ab5d9
  - [net-next,v2,8/8] selftests: forwarding: Add layer 2 miss test cases
    https://git.kernel.org/netdev/net-next/c/8c33266ae26a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


