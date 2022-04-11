Return-Path: <dsahern@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649717866;
 bh=a/3DmNUvz8+SO6ZFsddHOOslw+E1jUtBf6lFjrPFsJA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OtFGbLMQr5tthdn03lz+hSR8JVx1ccVMqBNQd2iJxZq93/l+hDtqxuev5YIxHFbcU
 hwor0Tj2r/OGlwwYWz26qvyPprjoUvOcz32b7Dk5JlHsH30tKcBxgSeC+2JI10CVuK
 Hz79TNshZ26pu1sGVCh86vtiIx2DjGR0zubwD7JIXcFlLzP6sDmpQ18hhLLwocCjYk
 VYOc5HAs0zI6VCbcSo3zraRvb1KPGilLEB5Y+R5kHllP4ABBheR8vvlR0LirqSEa+7
 HFjzng7ZtVAsN7ILNCWpgSdl24AFafaHQfvRqpXiqQ5RTop5jT7Iji9JW+CALt0oZ6
 u8s4gm+/EE2aA==
Date: Mon, 11 Apr 2022 16:57:43 -0600
From: David Ahern <dsahern@kernel.org>
Message-ID: <20220411225743.GA8838@u2004-local>
References: <20220411172934.1813604-1-razor@blackwall.org>
 <20220411172934.1813604-2-razor@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411172934.1813604-2-razor@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next v2 1/8] net: rtnetlink: add
	RTM_FLUSHNEIGH
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@idosch.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

On Mon, Apr 11, 2022 at 08:29:27PM +0300, Nikolay Aleksandrov wrote:
> Add a new rtnetlink type used to flush neigh objects. It will be
> initially used to add flush with filtering support for bridge fdbs, but
> it also opens the door to add similar support to others (e.g. vxlan).
> 
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>  include/uapi/linux/rtnetlink.h | 3 +++
>  security/selinux/nlmsgtab.c    | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
> index 83849a37db5b..06001cfd404b 100644
> --- a/include/uapi/linux/rtnetlink.h
> +++ b/include/uapi/linux/rtnetlink.h
> @@ -194,6 +194,9 @@ enum {
>  	RTM_GETTUNNEL,
>  #define RTM_GETTUNNEL	RTM_GETTUNNEL
>  
> +	RTM_FLUSHNEIGH = 124,
> +#define RTM_FLUSHNEIGH	RTM_FLUSHNEIGH
> +

rtm message types are "new, del, get, set" quadruplets; making this a
flush breaks the current consistent style. Can this be done by adding
a FLUSH flag to the RTM_DELNEIGH message?

>  	__RTM_MAX,
>  #define RTM_MAX		(((__RTM_MAX + 3) & ~3) - 1)
>  };
