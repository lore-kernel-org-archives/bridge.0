Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632912008;
 bh=E0TH8z77BBmELqaI2fYubgpmiK2lzgi9yaK0FARYJiM=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=EEc1j2eDdwlSF9KZ8oLELKzNZeIcXQ7eoPtoBIx1SiY3fEg1ZZHGaLicqLMeMoZ9M
 gUZbPgh987XcQRr7HKgfqDobOVmrAkdCsYrAGg8EjoyQq2hDlR0W+nrB4tX9ldeJJo
 tTvzk9wMhBY6miobUgsGJhfZxn04kL7EJw+dcBehb28eWtLbmO8yuFrZW1VDIoNw6a
 AwzUJGEzdwodvTaWubuUACaZkR52mFn6qYc8pSaDCZ0kcp3hTjgrZEwWqhLEXEANCH
 wYvbAxdr7sgCas9YUg5DvMelfR2m8Gfvb6ZmBO0Sl9OVKR7qDBXF+R3o92ywCyETE2
 VFNMv5lDzKyYw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <163291200877.26498.13462885838977349261.git-patchwork-notify@kernel.org>
Date: Wed, 29 Sep 2021 10:40:08 +0000
References: <20210928201239.GA267176@embeddedor>
In-Reply-To: <20210928201239.GA267176@embeddedor>
Subject: Re: [Bridge] [PATCH][net-next] net: bridge: Use array_size() helper
 in copy_to_user()
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

On Tue, 28 Sep 2021 15:12:39 -0500 you wrote:
> Use array_size() helper instead of the open-coded version in
> copy_to_user(). These sorts of multiplication factors need
> to be wrapped in array_size().
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: bridge: Use array_size() helper in copy_to_user()
    https://git.kernel.org/netdev/net-next/c/865bfb2affa8

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


