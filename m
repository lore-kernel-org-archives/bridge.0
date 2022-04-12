Return-Path: <patchwork-bot+netdevbpf@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649752212;
 bh=m+1PpGjcwzHYLO+3cx1OqvO/hhTh8rff68hcJcnjGQA=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=bFSn3y8tt33D6MUcoPmxOFx49qQePeyXNBYioOxS3rObIZuOnq3c5WAwcuTkjL7vY
 JtFd2DOOqld136OWdCzBvJCeZ20Fe2pKgAHSTNjlmE/9p/xNq6X5N2HdWdGh4xuMkq
 flJasIEY3MLhZoPkv3R89EQ/aN+JIZPTJCM0YNH45K4rdwfAtXcr3jSux1ZTHEUbHj
 m8wKITzMS/2dLZRaXhUBIbPOwGrcZRRNSnHcgZRf49aIrW95j+nfzpp8+BU691dxiw
 iyhGsNLLGbMoe7Mu0QySYrA+MiH8BF4P8izivP30NfI2QOdAY7zg+thCFehpt3CSyn
 uS/ljFgukr4Xw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <164975221257.23162.6047417037650246223.git-patchwork-notify@kernel.org>
Date: Tue, 12 Apr 2022 08:30:12 +0000
References: <20220411084054.298807-1-troglobit@gmail.com>
In-Reply-To: <20220411084054.298807-1-troglobit@gmail.com>
Subject: Re: [Bridge] [PATCH v2 net-next 0/2] net: bridge: add support for
 host l2 mdb entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joachim Wiberg <troglobit@gmail.com>
Cc: netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Hello:

This series was applied to netdev/net-next.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 11 Apr 2022 10:40:52 +0200 you wrote:
> Fix to an obvious omissions for layer-2 host mdb entries, this v2 adds
> the missing selftest and some minor style fixes.
> 
> Note: this patch revealed some worrying problems in how the bridge
>       forwards unknown BUM traffic and also how unknown multicast is
>       forwarded when a IP multicast router is known, which a another
>       (RFC) patch series intend to address.  That series will build
>       on this selftest, hence the name of the test.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/2] net: bridge: add support for host l2 mdb entries
    https://git.kernel.org/netdev/net-next/c/e65693b0179e
  - [v2,net-next,2/2] selftests: forwarding: new test, verify host mdb entries
    https://git.kernel.org/netdev/net-next/c/50fe062c806e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


