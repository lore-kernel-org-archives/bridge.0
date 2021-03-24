Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616614808;
 bh=KLYENuOcXI14xb4rj4Fs42f+fX8Y8nzzaYL3MtEcvmE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=H65ORv819BZRboWNPrL9tqsKb7Uip7DzXHRDOPOK+zFOiZWt4GZxJMeiEb10cbiYq
 lTDs9KhUE8w3e9xBy7dlizlmCyJIQptiXRsazQeuaW+Om89Sy388MgJrjTJv7OTieo
 ZPuZBvgT+xvxEPkSlJmAO1vN8XqeYVXDz9/uSz/iz7pyr4QiFIAgebGDP4kL6RS9ia
 n2+WoDzSzOf1mUGS1O5PCce4OzyWLSyBMsozRBCpvkY7zxu7rGRm70kpgbi3pQ0bEp
 wLQCUlBCrkR7kTNXv0fQsrU39V/EE0MPjG1wuo7CRp07D+75i5gOUbQpegepnUdsnw
 U+bmpP9ub07dg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <161661480890.20893.12247357786552976282.git-patchwork-notify@kernel.org>
Date: Wed, 24 Mar 2021 19:40:08 +0000
References: <20210323083347.1474883-1-horatiu.vultur@microchip.com>
In-Reply-To: <20210323083347.1474883-1-horatiu.vultur@microchip.com>
Subject: Re: [Bridge] [PATCH net-next 0/2] bridge: mrp: Disable roles before
	deleting
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: alexandre.belloni@bootlin.com, vladimir.oltean@nxp.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, claudiu.manoil@nxp.com, netdev@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Tue, 23 Mar 2021 09:33:45 +0100 you wrote:
> The first patch in this series make sures that the driver is notified
> that the role is disabled before the MRP instance is deleted. The
> second patch uses this so it can simplify the driver.
> 
> Horatiu Vultur (2):
>   bridge: mrp: Disable roles before deleting the MRP instance
>   net: ocelot: Simplify MRP deletion
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] bridge: mrp: Disable roles before deleting the MRP instance
    https://git.kernel.org/netdev/net-next/c/b3cb91b97c04
  - [net-next,2/2] net: ocelot: Simplify MRP deletion
    https://git.kernel.org/netdev/net-next/c/5b7c0c32c904

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


