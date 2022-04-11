Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1649666475; x=
 1649752875; bh=Zpd0dbMP4Qqg9X4hnW+fvYt79OSKTVRKGbShdxRmpz8=; b=W
 EXBJUdrtt46g9rFPLJc2LK70WpYvV2dQ4uaEyx88GQ1MfNWOM1maljBdMlwyjpiN
 l2MER2ZQ+PcDhKd2W6pFcFPqW+65l5Gud7haY7TIhkoHHYFnSkTwhBPzV1LxQAcV
 ZIwrBD7w6qFW6PZ3VhEQXfUNDT9KVJbtLmqSb7OrV+o9mdm8n6YaZWDG21y4MXK/
 cQePpTYVyUjHDucETekE7dm9NKWQXcgvNTo74uTe8XbENk8MLOEWAE88u4A1FzQk
 YGRlOBN0YSj9SJbVd4MNU9+crMvpzfi1PcUQQGWTY/dhrtIAAP6PM0FOpUQ3j+Tj
 MOat/POqg+BCEWPbF8t7g==
Date: Mon, 11 Apr 2022 11:41:12 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YlPpqKFeAs5oCHGD@shredder>
References: <20220409105857.803667-1-razor@blackwall.org>
 <20220409105857.803667-4-razor@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409105857.803667-4-razor@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next 3/6] net: bridge: fdb: add new nl
 attribute-based flush call
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com

On Sat, Apr 09, 2022 at 01:58:54PM +0300, Nikolay Aleksandrov wrote:
> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
> index 221a4256808f..2f3799cf14b2 100644
> --- a/include/uapi/linux/if_bridge.h
> +++ b/include/uapi/linux/if_bridge.h
> @@ -807,7 +807,15 @@ enum {
>  /* embedded in IFLA_BRIDGE_FLUSH */
>  enum {
>  	BRIDGE_FLUSH_UNSPEC,
> +	BRIDGE_FLUSH_FDB,
>  	__BRIDGE_FLUSH_MAX
>  };
>  #define BRIDGE_FLUSH_MAX (__BRIDGE_FLUSH_MAX - 1)
> +
> +/* embedded in BRIDGE_FLUSH_FDB */
> +enum {
> +	FDB_FLUSH_UNSPEC,

BTW, is there a reason this is not called FLUSH_FDB_UNSPEC given it's
embedded in BRIDGE_FLUSH_FDB, which is embedded in IFLA_BRIDGE_FLUSH ?

Regardless, in the cover letter you have '[ BRIDGE_FDB_FLUSH ]', which
is actually BRIDGE_FLUSH_FDB. I only noticed it because the code didn't
match what I had in my notebook, which I copied from the cover letter :)

> +	__FDB_FLUSH_MAX
> +};
> +#define FDB_FLUSH_MAX (__FDB_FLUSH_MAX - 1)
>  #endif /* _UAPI_LINUX_IF_BRIDGE_H */
