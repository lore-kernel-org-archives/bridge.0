Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645072809;
 bh=SQie68LtRJwl6pfaDF+fS7AfThug4tVyYsyf5TnnDHk=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=Hu1z+s5TJUTiOBBG6qj4KsIbqwHJn8CImpT8ZxGQs8I0X8ABWw3xjZoGW0mCb6E3R
 dEk3IHHjfuo58mRzDBHomA20lqgcAt8PgYKo+8SpqAznvnQomU00wFLCv4QDk7JK1q
 xjzCk3cEnvOaEv5Ysry4HwGDKJ+uv3kzEohmUEXtnuIT2Nnja2hauxSHgDozI185bI
 ZQEdm53zAzi5QtyS7sa3PTzjf7ggi324TdjgCS7JeiGrErZkH2+uU+MTS+zrc2ALHh
 WMP7OoYXeAVDorjxFcvawulYf/XCYodFkvuWXBuwab+1ivRTdq0ZRxTYttnGxLvjXn
 VfE3XH4mox8Kg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <164507280928.19778.1810833319273321601.git-patchwork-notify@kernel.org>
Date: Thu, 17 Feb 2022 04:40:09 +0000
References: <20220215165303.31908-1-oleksandr.mazur@plvision.eu>
In-Reply-To: <20220215165303.31908-1-oleksandr.mazur@plvision.eu>
Subject: Re: [Bridge] [PATCH net v2] net: bridge: multicast: notify
 switchdev driver whenever MC processing gets disabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Oleksandr Mazur <oleksandr.mazur@plvision.eu>
Cc: ivecera@redhat.com, taras.chornyi@plvision.eu, yotamg@mellanox.com, vladimir.oltean@nxp.com, razor@blackwall.org, bridge@lists.linux-foundation.org, volodymyr.mytnyk@plvision.eu, linux-kernel@vger.kernel.org, jiri@mellanox.com, netdev@vger.kernel.org, nogahf@mellanox.com, roopa@nvidia.com, kuba@kernel.org, nikolay@nvidia.com, davem@davemloft.net, mickeyr@marvell.com

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Feb 2022 18:53:03 +0200 you wrote:
> Whenever bridge driver hits the max capacity of MDBs, it disables
> the MC processing (by setting corresponding bridge option), but never
> notifies switchdev about such change (the notifiers are called only upon
> explicit setting of this option, through the registered netlink interface).
> 
> This could lead to situation when Software MDB processing gets disabled,
> but this event never gets offloaded to the underlying Hardware.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: bridge: multicast: notify switchdev driver whenever MC processing gets disabled
    https://git.kernel.org/netdev/net/c/c832962ac972

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


