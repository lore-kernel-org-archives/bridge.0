Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=0njhmFMB7YGM1lxXw8lv8Du+QtFIF36U2sCeO/sbrqc=;
 b=4cOto6GTLyrG1vHzK/XU21unLBboPvpGxq/9dOU9VzTvXqGmm7w/90Jaql6sz6XvpV
 KJhq3pSsDkQWkpQLpKwh0oz80v4yPqTpPj+IHBsTmYt/KsKOF2OHKyi2in/lFldM/e6A
 L+rLaJSSQZC2UypDSzRDo4l7ZRxXvD7ZxAGqf1Tzc7RmsiXOvJ+lR942gefInlGGgGr3
 KrilYlhlQYDxpkuFsswaJbsS0pXH1Htz4B9ASN32Xyhqlv89x1ISg6U+jjYmw39E6M6R
 1LYpioTnmWuCqGsXm6qyq8fd0VWYs9J8dSYUCah2sNarP3mhc7qQkFAMZSvzaHGr3diS
 oRqw==
Message-ID: <66dc205f-9f57-61c1-35d9-8712e8d9fe3a@blackwall.org>
Date: Thu, 24 Feb 2022 13:26:22 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220223172407.175865-1-troglobit@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220223172407.175865-1-troglobit@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/1 net-next] net: bridge: add support for host
 l2 mdb entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joachim Wiberg <troglobit@gmail.com>, Roopa Prabhu <roopa@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>

On 23/02/2022 19:24, Joachim Wiberg wrote:
> This patch expands on the earlier work on layer-2 mdb entries by adding
> support for host entries.  Due to the fact that host joined entries do
> not have any flag field, we infer the permanent flag when reporting the
> entries to userspace, which otherwise would be listed as 'temp'.
> 
> Before patch:
> 
>     ~# bridge mdb add dev br0 port br0 grp 01:00:00:c0:ff:ee permanent
>     Error: bridge: Flags are not allowed for host groups.
>     ~# bridge mdb add dev br0 port br0 grp 01:00:00:c0:ff:ee
>     Error: bridge: Only permanent L2 entries allowed.
> 
> After patch:
> 
>     ~# bridge mdb add dev br0 port br0 grp 01:00:00:c0:ff:ee permanent
>     ~# bridge mdb show
>     dev br0 port br0 grp 01:00:00:c0:ff:ee permanent vid 1
> 
> Signed-off-by: Joachim Wiberg <troglobit@gmail.com>
> ---
>  net/bridge/br_mdb.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

It would be nice to add a selftest for L2 entries. You can send it as a follow-up.
The patch looks good to me.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

