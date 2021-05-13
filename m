Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btjUqxIAIG7LxnFeFiiL/nhBDr1FVrk5voR74V0uMsI=;
 b=QsrDBiMHZYA8yw5e1zOFm1kYtKeYMslEUPk+bVDGxj4653j2D4vsRTmGrV3y5xJUVUcMrkwyAygrq0DMBto3gag+Bma2/4KbkK5pmQn4WfVe1MioRS7CY/tdm8A57Ro9mC7RZl+wB2JQJ7RqnC4sBRwCR2Sg3LAiS1QZ9JBcibmo8pmw6vRR1SGQPBXS++qclAMAx8m8owL+IIzydje70THJobRrm0Q17xH6MOAgHI0eYfDE3jHrqQxZ0aHWKNknDlez+aImcijVhPw9LKpgpjDIiToacs98off2/MKb8t/BUy/W1Xzs4hb1WzE1fjCtm3j/+ZRqe4dnzBXQdHq/Rg==
References: <20210512231941.19211-1-linus.luessing@c0d3.blue>
 <20210512231941.19211-4-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <b1819215-ed94-2777-911c-ba20400f42fa@nvidia.com>
Date: Thu, 13 May 2021 14:30:18 +0300
In-Reply-To: <20210512231941.19211-4-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: Re: [Bridge] [net-next v3 03/11] net: bridge: mcast: prepare mdb
 netlink for mcast router split
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
> In preparation for the upcoming split of multicast router state into
> their IPv4 and IPv6 variants and to avoid IPv6 #ifdef clutter later add
> some inline functions for the protocol specific parts in the mdb router
> netlink code. Also the we need iterate over the port instead of router
> list to be able put one router port entry with both the IPv4 and IPv6
> multicast router info later.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_mdb.c | 39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

