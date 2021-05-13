Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1rDoHWnKgvnPbBeA9WaG73j2PcaUGzAnfs4PmTE+1Y=;
 b=N0EIRQiLM7QTDKqyIK9zeKAc61K3hmvYSRUfStMQm+LiUDKS8bxou3wgp5os82gWP55RjkR2qF5yEwqGzVPbQvhQZxVAQjj44RYvwZWvr2vOfep4Bdpxwa0zBkWFYkAiBHxcphjlKEXQZO6+fsnmR0TlGA9F37fTS5CL5hyHYY21F8IuwangHddVuIF++Thc0V5+H7/UIPjnS1QdNGG5mSI7iF5On/m+xHqlS9OxXTDcHEMBW28Tgi5oqPggFV9zDgKLD5S50+4MOfML/OCxgxhGduuXHE4ZV2ku/TMpgPTejivCIca8l0bnG66pX8OVIb/zLy+cFWmwC8Bi7uK9/g==
References: <20210512231941.19211-1-linus.luessing@c0d3.blue>
 <20210512231941.19211-5-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <b58cbdb7-a95c-752b-78bc-9ab86d79f8f4@nvidia.com>
Date: Thu, 13 May 2021 14:30:49 +0300
In-Reply-To: <20210512231941.19211-5-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: Re: [Bridge] [net-next v3 04/11] net: bridge: mcast: prepare query
 reception for mcast router split
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
> their IPv4 and IPv6 variants and as the br_multicast_mark_router() will
> be split for that remove the select querier wrapper and instead add
> ip4 and ip6 variants for br_multicast_query_received().
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_multicast.c | 53 ++++++++++++++++++++-------------------
>  1 file changed, 27 insertions(+), 26 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

