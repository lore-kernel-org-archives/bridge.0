Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=EXGE03+aYGnzj6ntsHv9+tiQJAe4sslVqlGEQV9Ul/o=;
	b=OqgZcaKISeMAwdw32JDGyc0brd7lTqS7KB3hUmL4QQh8rgK+epphLe7VMvDAmdTCZ/
	u7EWJMptogRgeykC3KUosc3I5/KPPBfvmNv3ekgGeqJus0q6/fpDiuejDKC6KWyAQh3Z
	ICE2uzl3At9B9ZcvApDY1DSqpsZ6+ER8pauGE=
References: <20180427151111.22099-1-idosch@mellanox.com>
	<20180427151111.22099-7-idosch@mellanox.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <f9f1377e-88a1-5601-f57b-e2fafb1b220b@cumulusnetworks.com>
Date: Fri, 27 Apr 2018 18:39:09 +0300
MIME-Version: 1.0
In-Reply-To: <20180427151111.22099-7-idosch@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 6/6] mlxsw: spectrum_span: Allow
 bridge for gretap mirror
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@mellanox.com, jiri@mellanox.com, mlxsw@mellanox.com, davem@davemloft.net

On 27/04/18 18:11, Ido Schimmel wrote:
> From: Petr Machata <petrm@mellanox.com>
> 
> When handling mirroring to a gretap or ip6gretap netdevice in mlxsw, the
> underlay address (i.e. the remote address of the tunnel) may be routed
> to a bridge.
> 
> In that case, look up the resolved neighbor Ethernet address in that
> bridge's FDB. Then configure the offload to direct the mirrored traffic
> to that port, possibly with tagging.
> 
> Signed-off-by: Petr Machata <petrm@mellanox.com>
> Signed-off-by: Ido Schimmel <idosch@mellanox.com>
> ---
>  .../net/ethernet/mellanox/mlxsw/spectrum_span.c    | 95 ++++++++++++++++++++--
>  .../net/ethernet/mellanox/mlxsw/spectrum_span.h    |  1 +
>  2 files changed, 90 insertions(+), 6 deletions(-)
>

Looks good, thanks!

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
