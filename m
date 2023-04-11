Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E51B81E1E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A17C281E1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112; t=1681200238; x=1683792238;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k3Azqi0PzzANZ2Rni8AADHxyvhPXgRP3KYAVzLP4PpE=;
 b=UVDFhFMczoGb5yiDNS1TI66Sb20eqDUD+eJbsyOVBoYGQeTQV4wdBK+bMKV/onsr/8
 B+mAWm96B8bw4aZ5GP6ZT0KUBR8u1zeSHLGelX3CwrW8yPTz3ZPAO9kfGzAP31k2syfD
 wsPSLc2nYR3deHV0XBZMGVLOFvcz5uZRZhxR/P+98GBO3UzSK/4PsQD+vKkAUFxi3Eve
 pjB/nVFEQO0UN+1G6awcdyAMOz3d1RZpU9Lo0LRclae9nXgF7Ratg/l0z0kDL/v1nJSX
 U1Icua1Dhjnjrswa1x5KIok6g5L32KSZLUljk65OT4ZH9Ww4pMkMsRaptMXhkqM40HyR
 Irqw==
Message-ID: <87e5f12f-ec66-817a-9937-2db0e067d171@blackwall.org>
Date: Tue, 11 Apr 2023 11:03:54 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <202304061930349843930@zte.com.cn>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <202304061930349843930@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net/bridge: add drop reasons for
 bridge forwarding
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: yang.yang29@zte.com.cn, davem@davemloft.net
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, edumazet@google.com, zhang.yunkai@zte.com.cn, jiang.xuexin@zte.com.cn, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com

On 06/04/2023 14:30, yang.yang29@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> This creates six drop reasons as follows, which will help users know the
> specific reason why bridge drops the packets when forwarding.
> 
> 1) SKB_DROP_REASON_BRIDGE_FWD_NO_BACKUP_PORT: failed to get a backup
>    port link when the destination port is down.
> 
> 2) SKB_DROP_REASON_BRIDGE_FWD_SAME_PORT: destination port is the same
>    with originating port when forwarding by a bridge.
> 
> 3) SKB_DROP_REASON_BRIDGE_NON_FORWARDING_STATE: the bridge's state is
>    not forwarding.
> 
> 4) SKB_DROP_REASON_BRIDGE_NOT_ALLOWED_EGRESS: the packet is not allowed
>    to go out through the port due to vlan filtering.
> 
> 5) SKB_DROP_REASON_BRIDGE_SWDEV_NOT_ALLOWED_EGRESS: the packet is not
>    allowed to go out through the port which is offloaded by a hardware
>    switchdev, checked by nbp_switchdev_allowed_egress().
> 
> 6) SKB_DROP_REASON_BRIDGE_BOTH_PORT_ISOLATED: both source port and dest
>    port are in BR_ISOLATED state when bridge forwarding.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang19@zte.com.cn>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> ---
>  include/net/dropreason.h | 33 ++++++++++++++++++++++++++++++++
>  net/bridge/br_forward.c  | 49 +++++++++++++++++++++++++++++++++++++-----------
>  2 files changed, 71 insertions(+), 11 deletions(-)
> 

In addition to Jakub's comments, next time please CC bridge maintainers.
I just noticed this patch now.

Thanks,
 Nik


