Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=821CA3IEsc2LKjYWxGMByAa504fgsyB8kCPnI6BBCg4=;
 b=a/PBizmNf01GU1MUpJy7IBAvw8uuN8+b6OtTB+JvXBE8YrUv141wytRE3HaJMAWx/mJoxti5293GTdfsUJv1zKv+8sKtlM7mZ0UEmv7eVxiQigzrO2m+qyw347E7P8uX5Y9jj0Hp8weOjdbUmZQfi/OvehswGAlTOqZ+xePHDMCajrhN7WipUEF7NH8M6FbsRojmm9oi8wVMrTfBrf3IX5fg1Jr8DPe0wnfHLQVlVotXH2lL+qNzu+v2E4l/N+mBYwijK3WrR5f2i3yQ72YYUWwxFAGS/ffmFI+AOctnoqxqZ+DyMLMxtcTMG8c+/SmHNkftiK7AWqjGEFUasub/8Q==
References: <20210512231941.19211-1-linus.luessing@c0d3.blue>
 <20210512231941.19211-11-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <c2f37f1c-61d1-726f-a122-844616531763@nvidia.com>
Date: Thu, 13 May 2021 14:38:45 +0300
In-Reply-To: <20210512231941.19211-11-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: Re: [Bridge] [net-next v3 10/11] net: bridge: mcast: add ip4+ip6
 mcast router timers to mdb netlink
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>

On 13/05/2021 02:19, Linus Lüssing wrote:
> Now that we have split the multicast router state into two, one for IPv4
> and one for IPv6, also add individual timers to the mdb netlink router
> port dump. Leaving the old timer attribute for backwards compatibility.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  include/uapi/linux/if_bridge.h | 2 ++
>  net/bridge/br_mdb.c            | 8 +++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

