Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7B8A2418BB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DCFDC410C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112; t=1678794674;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RDVVUR+sXeSTSSTr5N1GxIRd1v5VKh3gMAujp5AXOCw=;
 b=tytzsvmhA7PbupttINkYDa2kvVAiTmURa5SS/dWCfHmzmYutlP5ay9czU9bk6VD3FD
 RfUL7nNjFhVqAu8WIvVQpwT3UZpUPZu6b0hm3G7C1dPGoL8aaY38WRLzaf75Aie8k2Ux
 DJx26v8VzoBe3EOWU1Y2M7zT2Q+E2H2nw+QRARGGPKbQzl+Ez/QoVkle7ajCtgETIzMI
 mPET47b+z1hPmQSrVc95VGksAnQi9hlXHbCdqC37Ye3+isbaqtbpv+f2DFD0Vd2bE1oc
 2CvQgIb8O8ayJyVe5oWvP45vxJkTpTxB12sAQm4/1J/lFlHZbBjQn0CyZSTBLWZ5+l61
 tErg==
Message-ID: <dc4b2eb0-2478-7e26-4292-b8856494fae2@blackwall.org>
Date: Tue, 14 Mar 2023 13:51:12 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230313145349.3557231-1-idosch@nvidia.com>
 <20230313145349.3557231-4-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230313145349.3557231-4-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 03/11] rtnetlink: bridge: mcast: Move
 MDB handlers out of bridge driver
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 13/03/2023 16:53, Ido Schimmel wrote:
> Currently, the bridge driver registers handlers for MDB netlink
> messages, making it impossible for other drivers to implement MDB
> support.
> 
> As a preparation for VXLAN MDB support, move the MDB handlers out of the
> bridge driver to the core rtnetlink code. The rtnetlink code will call
> into individual drivers by invoking their previously added MDB net
> device operations.
> 
> Note that while the diffstat is large, the change is mechanical. It
> moves code out of the bridge driver to rtnetlink code. Also note that a
> similar change was made in 2012 with commit 77162022ab26 ("net: add
> generic PF_BRIDGE:RTM_ FDB hooks") that moved FDB handlers out of the
> bridge driver to the core rtnetlink code.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     v1:
>     * Use NL_ASSERT_DUMP_CTX_FITS().
>     * memset the entire context when moving to the next device.
>     * Reset sequence counters when moving to the next device.
>     * Use NL_SET_ERR_MSG_ATTR() in rtnl_validate_mdb_entry().
> 
>  net/bridge/br_device.c  |   6 +-
>  net/bridge/br_mdb.c     | 301 ++--------------------------------------
>  net/bridge/br_netlink.c |   3 -
>  net/bridge/br_private.h |  35 ++---
>  net/core/rtnetlink.c    | 217 +++++++++++++++++++++++++++++
>  5 files changed, 244 insertions(+), 318 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

