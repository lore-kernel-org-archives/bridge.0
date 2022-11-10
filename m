Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1845960AC4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 63FA960AC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668051018;
 bh=K+8a66hs8qAIAe/6tZ9tl3yQ2XhnG4uFdwh/r7DvqNo=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=WeFd2Yjzi/5eYvTaMuyEua8jd+tCzL3wCoXpYUX5fqOt94XV88kpPN23+ioUW8YVx
 182+rWgk4qI6owhTCf1QqMxRaLzmqpTPUbIpOYd3dV2mxc1gAEPHrj8l8Y+y9AD0c5
 kqivFBKyIPoNt2BSRQmIC6aOvBegYgd1H1VabPrJXYoweQ6B9CHBYTJ6CJozg0dohj
 t2vUJnL8lN8CsXeOpHy2CfRjulwyGm75sFyrZKNGqyWthPWbEXt7Xvx1U14Xuc2dA7
 utL8fhVBoczAxxZqHfiKbaDSxVpSoAMuRaOYxpPOmee4nvNW3HdWWGCFzL6WHunGtf
 dtJnMR7SKKLCQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <166805101862.26797.801225756307788281.git-patchwork-notify@kernel.org>
Date: Thu, 10 Nov 2022 03:30:18 +0000
References: <cover.1667902754.git.petrm@nvidia.com>
In-Reply-To: <cover.1667902754.git.petrm@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next 00/15] mlxsw: Add 802.1X and MAB
	offload support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@nvidia.com>
Cc: ivecera@redhat.com, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, razor@blackwall.org, jiri@nvidia.com, idosch@nvidia.com, netdev@kapio-technology.com, edumazet@google.com, mlxsw@nvidia.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Hello:

This series was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 8 Nov 2022 11:47:06 +0100 you wrote:
> Ido Schimmel <idosch@nvidia.com> writes:
> 
> This patchset adds 802.1X [1] and MAB [2] offload support in mlxsw.
> 
> Patches #1-#3 add the required switchdev interfaces.
> 
> Patches #4-#5 add the required packet traps for 802.1X.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] bridge: switchdev: Let device drivers determine FDB offload indication
    https://git.kernel.org/netdev/net-next/c/9baedc3c8780
  - [net-next,02/15] bridge: switchdev: Allow device drivers to install locked FDB entries
    https://git.kernel.org/netdev/net-next/c/27fabd02abf3
  - [net-next,03/15] bridge: switchdev: Reflect MAB bridge port flag to device drivers
    https://git.kernel.org/netdev/net-next/c/9c0ca02bace4
  - [net-next,04/15] devlink: Add packet traps for 802.1X operation
    https://git.kernel.org/netdev/net-next/c/2640a82bbc08
  - [net-next,05/15] mlxsw: spectrum_trap: Register 802.1X packet traps with devlink
    https://git.kernel.org/netdev/net-next/c/d85be0f5fd7c
  - [net-next,06/15] mlxsw: reg: Add Switch Port FDB Security Register
    https://git.kernel.org/netdev/net-next/c/0b31fb9ba2b5
  - [net-next,07/15] mlxsw: spectrum: Add an API to configure security checks
    https://git.kernel.org/netdev/net-next/c/dc0d1a8b7f84
  - [net-next,08/15] mlxsw: spectrum_switchdev: Prepare for locked FDB notifications
    https://git.kernel.org/netdev/net-next/c/b72cb660b26b
  - [net-next,09/15] mlxsw: spectrum_switchdev: Add support for locked FDB notifications
    https://git.kernel.org/netdev/net-next/c/5a660e43f8b9
  - [net-next,10/15] mlxsw: spectrum_switchdev: Use extack in bridge port flag validation
    https://git.kernel.org/netdev/net-next/c/136b8dfbd784
  - [net-next,11/15] mlxsw: spectrum_switchdev: Add locked bridge port support
    https://git.kernel.org/netdev/net-next/c/25ed80884ce1
  - [net-next,12/15] selftests: devlink_lib: Split out helper
    https://git.kernel.org/netdev/net-next/c/da23a713d1de
  - [net-next,13/15] selftests: mlxsw: Add a test for EAPOL trap
    https://git.kernel.org/netdev/net-next/c/25a26f0c2015
  - [net-next,14/15] selftests: mlxsw: Add a test for locked port trap
    https://git.kernel.org/netdev/net-next/c/fb398432db2f
  - [net-next,15/15] selftests: mlxsw: Add a test for invalid locked bridge port configurations
    https://git.kernel.org/netdev/net-next/c/cdbde7edf0e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


