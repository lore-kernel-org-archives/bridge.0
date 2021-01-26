Return-Path: <nikolay@nvidia.com>
References: <20210126092132.407355-1-razor@blackwall.org>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <f0f19c6c-f5bf-0d07-fb49-60167e281bd1@nvidia.com>
Date: Tue, 26 Jan 2021 11:23:38 +0200
In-Reply-To: <20210126092132.407355-1-razor@blackwall.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1611653041; bh=/jUBdUOkbwd/WN8tHGLMNUyg6S3FbagX4rD7ZwwdgPE=;
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
 b=sPijnaqxpDxn3megZiIySBj7LO/ZD3a6EfaBcbhwBe6hJbtjVYzNNd72v8HqeRbcX
 IP6XozumK5dHXLUuu5pFvr0pTyLzCXL8PIwvtJYjKti/Ujm5asLH42sudQkRxCTKc5
 w1x/G+6TmEOvlBVZP3oY1YHCTpXqvjhQxbLXqyS5rFFR5Rt0Ef2iLsXeHmkeIa7Z65
 AqiYUBGbTRsHBfoyTYYwX6FbUttpi9WqqZGAQc/YlAPQA51X6f4rvTEOGMxOBJe68M
 Vjnvr9jntjFM2UTVtBKZWMXwJyZhmpGAQp2NcvqsWzpDYbI7sIFJnpdPs/4Elb6HCW
 dynQVguU1U9fA==
Subject: Re: [Bridge] [PATCH net-next 0/2] net: bridge: multicast: per-port
 EHT hosts limit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: kuba@kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

On 26/01/2021 11:21, Nikolay Aleksandrov wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> Hi,
> This set adds a simple configurable per-port EHT tracked hosts limit.
> Patch 01 adds a default limit of 512 tracked hosts per-port, since the EHT
> changes are still only in net-next that shouldn't be a problem. Then
> patch 02 adds the ability to configure and retrieve the hosts limit
> and to retrieve the current number of tracked hosts per port.
> 
> Thanks,
>  Nik
> 
> Nikolay Aleksandrov (2):
>   net: bridge: multicast: add per-port EHT hosts limit
>   net: bridge: multicast: make tracked EHT hosts limit configurable
> 
>  include/uapi/linux/if_link.h      |  2 ++
>  net/bridge/br_multicast.c         | 16 ++++++++++++++++
>  net/bridge/br_multicast_eht.c     |  7 +++++++
>  net/bridge/br_netlink.c           | 19 ++++++++++++++++++-
>  net/bridge/br_private.h           |  2 ++
>  net/bridge/br_private_mcast_eht.h | 28 ++++++++++++++++++++++++++++
>  net/bridge/br_sysfs_if.c          | 26 ++++++++++++++++++++++++++
>  net/core/rtnetlink.c              |  2 +-
>  8 files changed, 100 insertions(+), 2 deletions(-)
> 

Self-NAK
Aaargh.. sent older version, sorry about the noise. I'll send the proper one as
v2 in a bit.


