Return-Path: <nikolay@nvidia.com>
References: <20210114075101.6501-1-dong.menglong@zte.com.cn>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <547a00ff-cc4a-05de-b3c5-14266a3b90e5@nvidia.com>
Date: Thu, 14 Jan 2021 19:51:17 +0200
In-Reply-To: <20210114075101.6501-1-dong.menglong@zte.com.cn>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1610646686; bh=9ABF3mk6Qn7hIJTtomit0hYHqXXJiE31q4gqpI3Q3f0=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
 Authentication-Results:Subject:To:CC:References:From:Message-ID:
 Date:User-Agent:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
 MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
 X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
 X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=XDBm0hAE5MX9Bqa3nfMODIECWakC2+WwbFXGdVfnYPRc3COGneNhaNARBrUWfyO40
 bWGo8auZIA8a4dnSRHLTEm43zb/Ws1oEdF4qlqagyzr7tVTP4556XmEKZt9YvAWd8K
 SINZgagkJkbTAhtSgvVMp0Uwd1IE0hh5N0LnwzTTIX+MdJTuLmLP2a5wktUJ5HFZtj
 Pzuc+0DfnaP+0yZozmGbIGEJERfA1tO5qJ3+Hl4RUebWJBJeGfWpCQgn8aQPClQ2pG
 sTtpBXbEMamHOw9fD9wGRt9jK2I/F4VE4T3BdXaTj9KGF4WJnlDjSkrnuFRk363Q55
 +yysLB6LUtEKQ==
Subject: Re: [Bridge] [PATCH net-next] net: bridge: use eth_type_vlan in
 br_dev_queue_push_xmit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: menglong8.dong@gmail.com, kuba@kernel.org
Cc: Menglong Dong <dong.menglong@zte.com.cn>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, roopa@nvidia.com, davem@davemloft.net

On 14/01/2021 09:51, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <dong.menglong@zte.com.cn>
> 
> Replace the check for ETH_P_8021Q and ETH_P_8021AD in
> br_dev_queue_push_xmit with eth_type_vlan.
> 
> Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
> ---
>  net/bridge/br_forward.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index e28ffadd1371..6e9b049ae521 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -39,8 +39,7 @@ int br_dev_queue_push_xmit(struct net *net, struct sock *sk, struct sk_buff *skb
>  	br_drop_fake_rtable(skb);
>  
>  	if (skb->ip_summed == CHECKSUM_PARTIAL &&
> -	    (skb->protocol == htons(ETH_P_8021Q) ||
> -	     skb->protocol == htons(ETH_P_8021AD))) {
> +	    eth_type_vlan(skb->protocol)) {
>  		int depth;
>  
>  		if (!__vlan_get_protocol(skb, skb->protocol, &depth))
> 


Please change all similar checks, there are also:
br_netlink.c - br_validate()
br_vlan.c - br_vlan_set_proto()

Thanks.
