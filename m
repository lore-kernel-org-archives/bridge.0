Return-Path: <simon.horman@corigine.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 268E483A80
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5CAB083A7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1At6ayDDP/04qN+Uus/x8mxoTo98nP1tWBSkoOhmp4=;
 b=j6wgjcPRdCU65stXh66CHEyzp6UKpccLA4uCZb1HVNStLk30EQkbXRraGQ8rF8kgrfo+TBGUJymvl0mabAaVcgOBJuG1cIxcKfkHkO9NuewXKGldOaoEQ6OFB576J5uQQbDZtwICLABXRY1TS+BX3HduFqbSAWdLmulRApDEGFU=
Date: Thu, 27 Jul 2023 13:29:22 +0200
From: Simon Horman <simon.horman@corigine.com>
Message-ID: <ZMJVEjMQ0o/0GOKU@corigine.com>
References: <20230726143141.11704-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726143141.11704-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next] bridge: Remove unused declaration
 br_multicast_set_hash_max()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: YueHaibing <yuehaibing@huawei.com>
Cc: idosch@nvidia.com, razor@blackwall.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, edumazet@google.com, netdev@vger.kernel.org, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On Wed, Jul 26, 2023 at 10:31:41PM +0800, YueHaibing wrote:
> Since commit 19e3a9c90c53 ("net: bridge: convert multicast to generic rhashtable")
> this is not used, so can remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

