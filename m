Return-Path: <nikolay@nvidia.com>
References: <20210129115142.188455-1-razor@blackwall.org>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <e0c38c2a-3e72-2ee0-c48d-900e63227528@nvidia.com>
Date: Fri, 29 Jan 2021 13:55:24 +0200
In-Reply-To: <20210129115142.188455-1-razor@blackwall.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1611921333; bh=wuxAtOt9LJPVIPTspQUGnvDsLt+MvgPqr5yMRjXX0nQ=;
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
 b=TRLVy/NGYkyuVICUES8gBX2dLKeV/mtbyxlK0N+VJjvd/vZZcwMCZ9vWu9SB01vHr
 eT6Aq/mE3C5y4Lqr9X9TxmDuVEKb5IYsdtj675x4ynt6TI9WKJwd+Rc1TTy0sWD5qU
 qS5ZNwAjrqKrlER90rJcXQ/JlTgUO6cPzRyP/lSirYq+7Zkjx2118MUEO9aoN7EORp
 S+Rh3x8ck6w7P7fBIzyJNRGS/ZBRNTAMv0/5P/s70j6lu+5/GhFNbvZEGpGl6uSByN
 dCKF+tOSAg9gM/JZ9ZQiTwP0C9TNgmdRmAmaJ6AihWi4J3MJLn+okdq/xMcBJrnCQj
 mwKL5Mn2B+Z3w==
Subject: Re: [Bridge] [PATCH net-next 0/2] net: bridge: drop hosts limit
 sysfs and add a comment
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

On 29/01/2021 13:51, Nikolay Aleksandrov wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> Hi,
> As recently discussed[1] we should stop extending the bridge sysfs
> support for new options and move to using netlink only, so patch 01
> drops the recently added hosts limit sysfs support which is still in
> net-next only and patch 02 adds comments in br_sysfs_br/if.c to warn
> against adding new sysfs options.
> 
> Thanks,
>  Nik
> 
> Nikolay Aleksandrov (2):
>   net: bridge: mcast: drop hosts limit sysfs support
>   net: bridge: add warning comments to avoid extending sysfs
> 
>  net/bridge/br_sysfs_br.c |  4 ++++
>  net/bridge/br_sysfs_if.c | 30 ++++--------------------------
>  2 files changed, 8 insertions(+), 26 deletions(-)
> 

Oops :) the [1] addendum should be:

[1] https://lore.kernel.org/netdev/20210128105201.7c6bed82@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com/T/#mda7265b2e57b52bdab863f286efa85291cf83822

Since this is in the cover letter I don't think v2 is needed.
Please let me know if you'd like me to resend.

Cheers,
 Nik

