Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=33Gwu+0LuqHpJ3OW3A9sev3yjtwBkaEVKVwM7l1+PLY=;
	b=FZI5EiQcU5ujE+C7rIHiSE4yeCBz+g71bJJtPV0OIjCiszeiLJC28nXsSQMDFRMjsY
	Im+LBNyE3wGfysqccrQMrPwIknVPnpaf8OueVkNRd8HgTJVQQGJVYbXfzK6co86irv0Z
	ZheigHcvQYR+t64aAFyMQJxaH/5C3AOChYkVw=
References: <20180429075613.10832-1-idosch@mellanox.com>
	<20180429075613.10832-7-idosch@mellanox.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <9916a3a6-0efd-3d03-7eda-159906f406a4@cumulusnetworks.com>
Date: Sun, 29 Apr 2018 11:20:03 +0300
MIME-Version: 1.0
In-Reply-To: <20180429075613.10832-7-idosch@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 6/6] mlxsw: spectrum_span: Allow
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

On 29/04/18 10:56, Ido Schimmel wrote:
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
>   .../net/ethernet/mellanox/mlxsw/spectrum_span.c    | 95 ++++++++++++++++++++--
>   .../net/ethernet/mellanox/mlxsw/spectrum_span.h    |  1 +
>   2 files changed, 90 insertions(+), 6 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

