Return-Path: <nikolay@nvidia.com>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <44b2e50d345f1319071a53fb191ac0a0cf3fcf37.1605896060.git.gustavoars@kernel.org>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <143dd4a9-b0b7-36a6-ee33-0b5cb024c1e6@nvidia.com>
Date: Tue, 2 Feb 2021 16:16:07 +0200
In-Reply-To: <44b2e50d345f1319071a53fb191ac0a0cf3fcf37.1605896060.git.gustavoars@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1612275382; bh=JsL7qfg+zKynB5Z7OSyECdPUdFbLmsetrFPFxTBwbOU=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
 Authentication-Results:Subject:To:CC:References:From:Message-ID:
 Date:User-Agent:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
 MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
 X-Microsoft-Antispam-PRVS:X-Header:X-MS-Oob-TLC-OOBClassifiers:
 X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=osREM9QiAR6Zy07bBDJYEdibzkxFUz/TZIhJNFQCyygvZ77yeuSnbMgu/APf14/W6
 8ZEVEDU9/bn6YriIVWf/ZeC7kYX9uf/ScDWf7bB9Zk9mkmHuM0AtS/O94sMYYzmeTk
 Rh1Zwrx15O7Qgd2eUHFtjbOcLT+J75nk0UrTkh2xhdMWuw18wVnKavzE1FD/sWgTM3
 V/sqB//G67azEHgJreq8ur9S88emD7VscZXO26CmXU2zmT2J//gYOEmFo+IwFBakiX
 HcPYF4M5TLOGAD5mYJj5d+zVdIMqYGKL3YrfEl/SsuyohL1bhGqRtUsNvgUTW3dXHw
 AxpCkKGmX53/Q==
Subject: Re: [Bridge] [PATCH 106/141] net: bridge: Fix fall-through warnings
	for Clang
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

On 20/11/2020 20:37, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  net/bridge/br_input.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 59a318b9f646..8db219d979c5 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -148,6 +148,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>  		break;
>  	case BR_PKT_UNICAST:
>  		dst = br_fdb_find_rcu(br, eth_hdr(skb)->h_dest, vid);
> +		break;
>  	default:
>  		break;
>  	}
> 

Somehow this hasn't hit my inbox, good thing I just got the reply and saw the
patch. Anyway, thanks!

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

