Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6B005401ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6E2894010F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i4DbpifCqabRgCyCKd8UEM5w26sLROwDi22v6917074=;
 b=TEyhofPv/3fZEM5gSXQq3zJGsQqeL5iVEnb9IUXSl9sHFoeUNzf1trCcve0zg+JoAR
 Z0QHqwd8fPynZgr6nZAWUpJFJ3IoYrs6WG+JvCBNRZxExuXtoakkyP8FMvX0meJhkWQo
 7OSibO+xWr+pYYAv5hszN01KrH5uDAcq7UN9XlrWwHdDcTfLuUJExukgRVHOF/iE7R0G
 KTY88XS91OvXMY2ZD41fjSCHNkgEHQLlrIvKRSxMcuH9MN1aN9gULcasEj2yNaJ18C6Z
 XGMKEqylkFKgoU0KBYgvTeLl/PTZP1jqDusucxa7KS2zGHJK+tJpafQty9ou4gTStI/z
 YSFw==
Message-ID: <9b66580a-f158-43d0-36e1-511e6fe63da7@blackwall.org>
Date: Sun, 29 Jan 2023 20:44:43 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <c1a88f471a8aa6d780dde690e76b73ba15618b6d.1675010984.git.leon@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <c1a88f471a8aa6d780dde690e76b73ba15618b6d.1675010984.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2] netlink: provide an ability to set
 default extack message
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Leon Romanovsky <leon@kernel.org>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>

On 29/01/2023 18:51, Leon Romanovsky wrote:
> In netdev common pattern, extack pointer is forwarded to the drivers
> to be filled with error message. However, the caller can easily
> overwrite the filled message.
> 
> Instead of adding multiple "if (!extack->_msg)" checks before any
> NL_SET_ERR_MSG() call, which appears after call to the driver, let's
> add new macro to common code.
> 
> [1] https://lore.kernel.org/all/Y9Irgrgf3uxOjwUm@unreal
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Changelog:
> v2:
>  * Removed () brackets around msg to fix compilation error.
> v1: https://lore.kernel.org/all/d4843760219f20367c27472f084bd8aa729cf321.1674995155.git.leon@kernel.org
>  * Added special *_WEAK() macro instead of embedding same check in
>    NL_SET_ERR_MSG_MOD/NL_SET_ERR_MSG_FMT.
>  * Reuse same macro for XFRM code which triggered this patch.
> v0: https://lore.kernel.org/all/2919eb55e2e9b92265a3ba600afc8137a901ae5f.1674760340.git.leon@kernel.org
> ---
>  include/linux/netlink.h   | 10 ++++++++++
>  net/bridge/br_switchdev.c | 10 ++++------
>  net/dsa/master.c          |  4 +---
>  net/dsa/slave.c           |  4 +---
>  net/xfrm/xfrm_device.c    |  5 ++++-
>  5 files changed, 20 insertions(+), 13 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


