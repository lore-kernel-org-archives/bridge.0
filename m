Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ag166LO41mmIdH93hcAzJxPUu6DQ+iUSSg9O8F3Mz+8=;
 b=bOiADHgew3Ea4mYbibX0J/zHUQu24msSSDM1WwGDDvtHFiRtPwzVvTlAznwc5T8Usd
 /0NaheD+OFNIMT07YicGgnBkfBcqlnixQYJ8SUcl2sFpDaZ98qChoqfsIpUnD8dW3fSt
 FXg1lZcDeIK4fBamc7bQ3xx+ZdnAasH906KQM=
References: <20191212010711.1664000-1-vivien.didelot@gmail.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <15115a6a-b95f-8de0-12ac-c3c98301ae25@cumulusnetworks.com>
Date: Thu, 12 Dec 2019 08:55:30 +0200
MIME-Version: 1.0
In-Reply-To: <20191212010711.1664000-1-vivien.didelot@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3] net: bridge: add STP xstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vivien Didelot <vivien.didelot@gmail.com>, "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, David Ahern <dsahern@gmail.com>

On 12/12/2019 03:07, Vivien Didelot wrote:
> This adds rx_bpdu, tx_bpdu, rx_tcn, tx_tcn, transition_blk,
> transition_fwd xstats counters to the bridge ports copied over via
> netlink, providing useful information for STP.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@gmail.com>
> ---
>  include/uapi/linux/if_bridge.h | 10 ++++++++++
>  net/bridge/br_netlink.c        | 13 +++++++++++++
>  net/bridge/br_private.h        |  2 ++
>  net/bridge/br_stp.c            | 15 +++++++++++++++
>  net/bridge/br_stp_bpdu.c       |  4 ++++
>  5 files changed, 44 insertions(+)
> 

Looks good to me, thanks!

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>


