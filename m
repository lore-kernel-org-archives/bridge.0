Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640283010;
 bh=oyh+QBfNI/GMX9Lq6AawFnQWCAFkjjqO6uAUCAtczVA=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=vL58s+QGCC49AR9aFgbj996Q8JloiwBecYYNRV+G3ws3FU7kOjPe4SVrVLAGLv0PW
 n2YjXmNCpdXwaEyWFzTcMhhpc/r4FWNAczmmkyLj1x1qOg5VEuHgoHFmP6ztXDn7aK
 nQuhCDfIFD8hgXQ8i9s25METHzsd8nEbwX2Mgh3dim9sMM+UU3ZqKATBnM2kxNYn+G
 cq0Gmh0JnqemQwP4q03xdaxXc1WYnDrXjszIKFbHmnorSzNpUywM/YCEHaGfpl3J9M
 RgkPSNpu820hUQXpHutCPw2Tf9BFfPnpOPzBRqd6SCcCQIgx9QGUA9XiV10mZdNAx1
 IB8GsmybKTqHQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <164028301044.27483.17708005720486132473.git-patchwork-notify@kernel.org>
Date: Thu, 23 Dec 2021 18:10:10 +0000
References: <20211222191320.17662-1-repk@triplefau.lt>
In-Reply-To: <20211222191320.17662-1-repk@triplefau.lt>
Subject: Re: [Bridge] [PATCH net] net: bridge: fix ioctl old_deviceless
	bridge argument
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Remi Pommarel <repk@triplefau.lt>
Cc: arnd@arndb.de, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Dec 2021 20:13:20 +0100 you wrote:
> Commit 561d8352818f ("bridge: use ndo_siocdevprivate") changed the
> source and destination arguments of copy_{to,from}_user in bridge's
> old_deviceless() from args[1] to uarg breaking SIOC{G,S}IFBR ioctls.
> 
> Commit cbd7ad29a507 ("net: bridge: fix ioctl old_deviceless bridge
> argument") fixed only BRCTL_{ADD,DEL}_BRIDGES commands leaving
> BRCTL_GET_BRIDGES one untouched.
> 
> [...]

Here is the summary with links:
  - [net] net: bridge: fix ioctl old_deviceless bridge argument
    https://git.kernel.org/netdev/net/c/d95a56207c07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


