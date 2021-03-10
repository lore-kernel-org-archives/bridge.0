Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615410013;
 bh=6cChmF4xo+CrWaB4TpPNDEZ+Y6NLPBdULri5dNShqtw=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=BBjdrMJ9kFsZQPX97oHs+6xhfuCKuOJQIUczXvUdywmCYJ0HDlibYp7MUI2ZZJAY5
 n4atZbHKbFHcWrsQrjnO9VYd5I1gcg0sQRt3D8RDLtRM8DCp5aaHOSH20zOsDON8mV
 cuQPOx/ngmA1saULqykE+fu3by9NEB8aEFV6yd3uKDMBRRFNi9Lz9bjJVuVcaGIBBr
 rVMRGdsVXaYnbOCaRuHK1qj29ZS3efKyj+5Co7gMXPsrelldmhCwIoyEf97WDXMkbA
 1h+XlQDorf89wZdUp8os6oOkWyLFjscKFvhNv5Z9AETJY57CJuY9otblJJf+LyrzSd
 wo/eosjpipqxA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <161541001297.4631.3343209004781162292.git-patchwork-notify@kernel.org>
Date: Wed, 10 Mar 2021 21:00:12 +0000
References: <20210310054115.GA285785@embeddedor>
In-Reply-To: <20210310054115.GA285785@embeddedor>
Subject: Re: [Bridge] [PATCH RESEND][next] net: bridge: Fix fall-through
	warnings for Clang
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Tue, 9 Mar 2021 23:41:15 -0600 you wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> [...]

Here is the summary with links:
  - [RESEND,next] net: bridge: Fix fall-through warnings for Clang
    https://git.kernel.org/netdev/net-next/c/ecd1c6a51fcc

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


