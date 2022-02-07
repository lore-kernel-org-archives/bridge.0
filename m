Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c3UO1TTRZqzSjjDQY9Mwanici3NZ8tfp3AuhU7oMYuA=;
 b=QPHaqlTiE16WocBPSKB+Lh+Ski0qtk/u+htUzq292AHwqkwfgCqNFPoyzWnzp35sr1
 n78XPElUsjVk+gUGFqDap1fb/7cK7w3cKnLfv/E1GfzCkSjYiGDbS4+eZ00YZIqec36r
 55RYOC2HtBq5z7nfTlvxbqnm0+1d/78bCDNOvtUD+Jznz0Pv/3oQaLKY4fJGfaDokHcs
 m3OPmlwR+CTgXREhrBYj5yishPrXwWxcJrEjBiv+ALyN8E2AYBv2GcZorbFEj/MBHjdb
 i4HFCxGCYrfT39BP2j5Ag0bTWXBwepHMjSv7tZCU5oF3rdb1QaapZIZPlDDy/uKn9Kx/
 hOgQ==
Date: Mon, 7 Feb 2022 09:30:48 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20220207093048.24bb6249@hermes.local>
In-Reply-To: <20220207100742.15087-2-schultz.hans+netdev@gmail.com>
References: <20220207100742.15087-1-schultz.hans+netdev@gmail.com>
 <20220207100742.15087-2-schultz.hans+netdev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/4] net: bridge: Add support for
 bridge port in locked mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Hans Schultz <schultz.hans+netdev@gmail.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, davem@davemloft.net

On Mon,  7 Feb 2022 11:07:39 +0100
Hans Schultz <schultz.hans@gmail.com> wrote:

> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -532,6 +532,7 @@ enum {
>  	IFLA_BRPORT_GROUP_FWD_MASK,
>  	IFLA_BRPORT_NEIGH_SUPPRESS,
>  	IFLA_BRPORT_ISOLATED,
> +	IFLA_BRPORT_LOCKED,
>  	IFLA_BRPORT_BACKUP_PORT,
>  	IFLA_BRPORT_MRP_RING_OPEN,

Adding new element in middle of enum causes them to be renumbered.
That breaks the kernel ABI. Please add only at end.
