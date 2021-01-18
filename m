Return-Path: <nikolay@nvidia.com>
References: <20210117080950.122761-1-dong.menglong@zte.com.cn>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <ffce5e21-fdd2-cb2b-6957-7454aea9c665@nvidia.com>
Date: Mon, 18 Jan 2021 13:55:11 +0200
In-Reply-To: <20210117080950.122761-1-dong.menglong@zte.com.cn>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1610970922; bh=yEdfpYVHfIWXubdM9Fe9ow4PHbVKBEVGfcE3jCihZDM=;
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
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=MDNJiiza0lLSo6/NMP1UAQB5Zr4OwhRDpTasWnCYpTc5gUHRVbpOnxCZV5xQbAGk4
 ohFvm3ix8t3o+FLBe0Ia1yqW6UJfKsWZw06YBao1hx+ZfbVriI98lYTcYFK8JWgzZu
 FvuQtdyibWMqK7+xYGjmw9FbtRb9qJ41aFCnAOXklH8K87Uk0Dun7hrOYKLiGHyt8u
 1O2kczoYMR+nLXgi0hRDOvA2lULFJzfVB0bOu7R60EMm52fOHLrbfd2yNsVlrcCkiv
 4MpiIAsnQYeTa7XQUC7I5V8vVteqt2QB9S6jgR1ATaCTKE+BQ6zzKlj+9wZ9knV6R1
 ES72LilMQe9hw==
Subject: Re: [Bridge] [PATCH v4 net-next] net: bridge: check vlan with
 eth_type_vlan() method
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

On 17/01/2021 10:09, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <dong.menglong@zte.com.cn>
> 
> Replace some checks for ETH_P_8021Q and ETH_P_8021AD with
> eth_type_vlan().
> 
> Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
> ---
> v4:
> - remove unnecessary brackets.
> 
> v3:
> - fix compile warning in br_vlan_set_proto() by casting 'val' to
>   be16.
> 
> v2:
> - use eth_type_vlan() in br_validate() and __br_vlan_set_proto()
>   too.
> ---
>  net/bridge/br_forward.c |  3 +--
>  net/bridge/br_netlink.c | 12 +++---------
>  net/bridge/br_vlan.c    |  2 +-
>  3 files changed, 5 insertions(+), 12 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

