Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC988605F6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0732860593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DYM+UIuymwma5G6DYkw7/MsYdvWysx8+7uyf+N85amo=;
 b=uMUfs0YhOECmMRpcaDtjHP0b5MCQYz0N2jamvkr0m5+tMEmHdCAOTRPIdrqV+X0ad/
 kMYd0PKNMjmhPJoVj0+xI76eArlkMFfFR/HiwfOJxEc78IMQ9TXJuNqf/WHy2QNiJtPp
 jVOywPlD45qkPWzxa5aK+qvXB8/OfhqQeJXOz0gFq0jAcbzsMQMHldLz5yrQWAakxv2o
 GxoPM1SusHpUKNHgtI6ufT8l2vlEhk3mwuHR/+A7NOOf7hhaWu5YavN7cQxphZs5a+66
 BRWrrL3wX2Q/aTgVqo90FN5DLFIS/t68kTx3sTTrV4gTP0AgZ/cpuH2xYnLDDzKyczPB
 Sw4A==
Message-ID: <8cbaccf9-2ca3-b15e-dd1e-85e344a89561@blackwall.org>
Date: Fri, 9 Dec 2022 09:53:55 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221208152839.1016350-1-idosch@nvidia.com>
 <20221208152839.1016350-12-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221208152839.1016350-12-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 11/14] bridge: mcast: Allow user space
 to specify MDB entry routing protocol
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 08/12/2022 17:28, Ido Schimmel wrote:
> Add the 'MDBE_ATTR_RTPORT' attribute to allow user space to specify the
> routing protocol of the MDB port group entry. Enforce a minimum value of
> 'RTPROT_STATIC' to prevent user space from using protocol values that
> should only be set by the kernel (e.g., 'RTPROT_KERNEL'). Maintain
> backward compatibility by defaulting to 'RTPROT_STATIC'.
> 
> The protocol is already visible to user space in RTM_NEWMDB responses
> and notifications via the 'MDBA_MDB_EATTR_RTPROT' attribute.
> 
> The routing protocol allows a routing daemon to distinguish between
> entries configured by it and those configured by the administrator. Once
> MDB flush is supported, the protocol can be used as a criterion
> according to which the flush is performed.
> 
> Examples:
> 
>  # bridge mdb add dev br0 port dummy10 grp 239.1.1.1 permanent proto kernel
>  Error: integer out of range.
> 
>  # bridge mdb add dev br0 port dummy10 grp 239.1.1.1 permanent proto static
> 
>  # bridge mdb add dev br0 port dummy10 grp 239.1.1.1 src 192.0.2.1 permanent proto zebra
> 
>  # bridge mdb add dev br0 port dummy10 grp 239.1.1.2 permanent source_list 198.51.100.1,198.51.100.2 filter_mode include proto 250
> 
>  # bridge -d mdb show
>  dev br0 port dummy10 grp 239.1.1.2 src 198.51.100.2 permanent filter_mode include proto 250
>  dev br0 port dummy10 grp 239.1.1.2 src 198.51.100.1 permanent filter_mode include proto 250
>  dev br0 port dummy10 grp 239.1.1.2 permanent filter_mode include source_list 198.51.100.2/0.00,198.51.100.1/0.00 proto 250
>  dev br0 port dummy10 grp 239.1.1.1 src 192.0.2.1 permanent filter_mode include proto zebra
>  dev br0 port dummy10 grp 239.1.1.1 permanent filter_mode exclude proto static
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     v1:
>     * Reject protocol for host entries.
> 
>  include/uapi/linux/if_bridge.h |  1 +
>  net/bridge/br_mdb.c            | 15 +++++++++++++--
>  net/bridge/br_private.h        |  1 +
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


