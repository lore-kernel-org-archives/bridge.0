Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=p0h1I2tU40MVEe/iq0GPb6BvRGF0+jimshHBcD8Y96o=;
 b=UYxL1aPIIPS7dZJFvNFh6Gi7rWcPCnq0LT08QW+F6/HZXq6mbwF8gr9DEQ2z8ZgO7r
 dZ31Oe2JgNLZIf9KX+4S0UvQ7V8y9v2n7/jYvHfNHjm2k15HIuaVceJG3qkJg1EqLtPB
 LkJ96zui76hJkuznZNalH0tvK4QFSp9k7YTqifqDGJAnCze1bamfgvt+N2oHMM8ldjPu
 Ibf1rMbmngk1Gbhy79F6gTXVORnLsE2VieIu639CP+HpZeC19nu8SkRsMO9cIKc/fXhr
 HaXgNOl1e9UXZKneUfj9dHbbQG9e7QOTVv8j6soU7b+hOIsDZOXsCYmgAqip8RCJmcy3
 ZAGg==
Date: Wed, 24 Mar 2021 18:02:29 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210324160229.cyzepir5fnfnfeox@skbuf>
References: <20210324150950.253698-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324150950.253698-1-colin.king@canonical.com>
Subject: Re: [Bridge] [PATCH][next] net: bridge: Fix missing return
 assignment from br_vlan_replay_one call
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Colin King <colin.king@canonical.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>

On Wed, Mar 24, 2021 at 03:09:50PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The call to br_vlan_replay_one is returning an error return value but
> this is not being assigned to err and the following check on err is
> currently always false because err was initialized to zero. Fix this
> by assigning err.
> 
> Addresses-Coverity: ("'Constant' variable guards dead code")
> Fixes: 22f67cdfae6a ("net: bridge: add helper to replay VLANs installed on port")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
