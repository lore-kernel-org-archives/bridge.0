Return-Path: <horms@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5657D40541
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8611B400D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692184611;
 bh=wfhySSnPK75SKJ9vyK9+QFR5+bImMQwF+/PIQmTua/o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NI7KTXynb5crT3rAJwh9tudjya++J9+kamFqQjnVdxIWmv+inAgkrelMfl8d+Vg4U
 KU5PNDU4WAmY24PvegTFeIysG1P5Av4P/WgCg+FOu384kbsN7M4w7FEH2MTNu9k4DO
 P1RVMmI7lwqMXeZYwcGw7+bSh2fpVfy2K8Y8OvDraxNASkMGn+UYoYnMsoXflMwdKA
 O1HUknXRSyp8upNJfiT0CJ542nONDCsz8oFucll8yfF68QFhw8+W5Pzvjtul7sHzWw
 gFHQAk8LKUKLYmtQGFq6/SUKjAziJfDhEgw2xuj6HFg1SAX6WSvfjpQ2uh4oEduXqE
 PrGbtWqgXM2Kw==
Date: Wed, 16 Aug 2023 13:16:46 +0200
From: Simon Horman <horms@kernel.org>
Message-ID: <ZNywHiWhaL6pRZsd@vergenet.net>
References: <20230816093443.1460204-1-gongruiqi@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816093443.1460204-1-gongruiqi@huaweicloud.com>
Subject: Re: [Bridge] [PATCH net-next v2] netfilter: ebtables: replace
 zero-length array members
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc: coreteam@netfilter.org, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, gongruiqi1@huawei.com, Jozsef Kadlecsik <kadlec@netfilter.org>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>

On Wed, Aug 16, 2023 at 05:34:43PM +0800, GONG, Ruiqi wrote:
> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
> 
> As suggested by Kees[1], replace the old-style 0-element array members
> of multiple structs in ebtables.h with modern C99 flexible array.
> 
> [1]: https://lore.kernel.org/all/5E8E0F9C-EE3F-4B0D-B827-DC47397E2A4A@kernel.org/
> 
> Link: https://github.com/KSPP/linux/issues/21
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
> 
> v2: designate to net-next; cc more netdev maintainers

It's slightly unclear to me if this should be targeting
net-next or nf-next. But regardless, it doesn't seem
to apply cleanly to the main branch of either tree.

Please consider resolving that and posting again,
being sure to allow 24h before postings.

Link: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

-- 
pw-bot: changes-requested
