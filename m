Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615928342;
 bh=kemmhiNXGjgM3Xez8OspoEtsDyPaLxVqLgsB1W7iaYw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=SlRhSovfQZ7GhqhOSREw5bDT+EfPb3UQVIPexq2SwpdkbuWHKs0xDq0idL1zR4fN2
 ES7yOeXaVJ5WERa3vTSRA/6j+iD0rBhWj8rXJIIqLU6r1Z5oqzUBZ8g5nRmqk3a7uZ
 zW5lQ9RGy6OEEQAdRBJ8slKIHqnn1UJFuqebk+hsODDWzlip9fIHgXIPMgXr8VIysK
 ZKf6CEXEwpVPp5RG1xZ3h2aWNI5RyrMVkuOb2ucY0DY/i6+pZcrk3gK7xt5+Mw3hbX
 TMOzNO1DMgbgnU9U60kidurfftDaW/FICTv6jZEQMWNF1pqd8yd/0h94gqiJrhpwQE
 c/qRaWgIziW7w==
Date: Tue, 16 Mar 2021 13:59:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20210316135901.4e4239fc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210315171342.232809-1-razor@blackwall.org>
References: <20210315171342.232809-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 0/2] net: bridge: mcast: simplify
 allow/block EHT code
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

On Mon, 15 Mar 2021 19:13:40 +0200 Nikolay Aleksandrov wrote:
> There are no functional changes.

That appears to indeed be the case:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
