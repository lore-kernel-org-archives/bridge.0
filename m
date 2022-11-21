Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E8D1D80B8D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CCEF080B6E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oVR9zxWFI/yiTfyZ4zmDueQDkqj32nHPs9Uh0PG4vPE=;
 b=KOwk43K2prxMCTWU5zSDoD7OjmzMBpZe59DoyncDt6F+Tc+Qtsvgf+G5R0i17IT+Nj
 3gvfVY0T0UI3OCVP31Cq8Ar0xgsEjJD4bJn5jEFhuvh0dEd7Z0nFgvwKuA6na0brxsD4
 YoLyr+iMi5GVBqKJsZYB1KlyEU41+29Va65MF/LNUJq3dEJA2A0PSFCdO1UnYKiKH8TK
 A1o6q7JMNuSS3kDcOWAHOUt3HLy6qmD3lSiknCa1sZtShQ0PMymnlJxVg1/gfvzGsVIs
 kCydES3mx6bQxzdRK2QcZgTLQLu68suH5cg2TxcFPmrtS7oFhHTx4ZIoeyyF9xHVJA7E
 1yMg==
Message-ID: <a153b239-26f4-9813-beb8-bf74d19808ef@blackwall.org>
Date: Mon, 21 Nov 2022 12:53:22 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221121094649.1556002-1-gregkh@linuxfoundation.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221121094649.1556002-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/5] kobject: make kobject_get_ownership() take
 a constant kobject *
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Cc: linux-nfs@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Eric Dumazet <edumazet@google.com>, Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On 21/11/2022 11:46, Greg Kroah-Hartman wrote:
> The call, kobject_get_ownership(), does not modify the kobject passed
> into it, so make it const.  This propagates down into the kobj_type
> function callbacks so make the kobject passed into them also const,
> ensuring that nothing in the kobject is being changed here.
> 
> This helps make it more obvious what calls and callbacks do, and do not,
> modify structures passed to them.
> 
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> Cc: Anna Schumaker <anna@kernel.org>
> Cc: Roopa Prabhu <roopa@nvidia.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: linux-nfs@vger.kernel.org
> Cc: bridge@lists.linux-foundation.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/base/class.c    | 2 +-
>  drivers/base/core.c     | 8 ++++----
>  fs/nfs/sysfs.c          | 4 ++--
>  include/linux/kobject.h | 8 ++++----
>  lib/kobject.c           | 4 ++--
>  net/bridge/br_if.c      | 2 +-
>  net/core/net-sysfs.c    | 8 ++++----
>  net/sunrpc/sysfs.c      | 8 ++++----
>  8 files changed, 22 insertions(+), 22 deletions(-)
> 

For the bridge:
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


