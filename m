Return-Path: <dsahern@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4hsK/0s8PL+6nEueLAF8iMvcACpG5LyaCfMthRe24CU=;
 b=ouip0pnwFVPH0Z08TmBjHyZZPW45gYU0h9zI4PfRLa+kARjS4p0/k3MlzyCwmXOEqU
 K+u9j/F5sbhzmcFQyoVPJ9hMWE0VA2VuRzY+mSPvCG/OGF8OIgg+zWVTh30jbnu3PnJG
 lWsLTtBNRswFNcdsrSo6Sz+JezKh9pK5LUKYw6S4bJpECI12WjbX/AJn0uSZnWHjDatd
 oxdtHBhKyYBHNihRadxtgVJq9WMJrj376Nx2WauIKRxMnheRnMwx7ZFe/B6vbTZCmscD
 vpe+TnEF13riSESO3r577s0NKYsH1C5K68biieREi398h4gOxR1YL8ZmVxLFq0vc1psY
 pY8g==
References: <20191212010711.1664000-1-vivien.didelot@gmail.com>
 <20191212010711.1664000-2-vivien.didelot@gmail.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <2166597e-b5d2-ee1e-3dc3-bfacdf3cc8b8@gmail.com>
Date: Tue, 17 Dec 2019 09:35:09 -0700
MIME-Version: 1.0
In-Reply-To: <20191212010711.1664000-2-vivien.didelot@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH iproute2 v4] iplink: add support for STP xstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vivien Didelot <vivien.didelot@gmail.com>, "David S. Miller" <davem@davemloft.net>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, David Ahern <dsahern@gmail.com>

On 12/11/19 6:07 PM, Vivien Didelot wrote:
> Add support for the BRIDGE_XSTATS_STP xstats, as follow:
> 
>     # ip link xstats type bridge_slave dev lan4 stp
>     lan4
>                         STP BPDU:  RX: 0 TX: 61
>                         STP TCN:   RX: 0 TX: 0
>                         STP Transitions: Blocked: 2 Forwarding: 1
> 
> Or below as JSON:
> 
>     # ip -j -p link xstats type bridge_slave dev lan0 stp
>     [ {
>             "ifname": "lan0",
>             "stp": {
>                 "rx_bpdu": 0,
>                 "tx_bpdu": 500,
>                 "rx_tcn": 0,
>                 "tx_tcn": 0,
>                 "transition_blk": 0,
>                 "transition_fwd": 0
>             }
>         } ]
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@gmail.com>
> ---
>  include/uapi/linux/if_bridge.h | 10 ++++++++++
>  ip/iplink_bridge.c             | 26 ++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
> 

applied to iproute2-next. Thanks


