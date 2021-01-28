Return-Path: <nikolay@nvidia.com>
References: <20210126093533.441338-1-razor@blackwall.org>
 <20210127174226.4d29f454@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <046fad19-2f44-21d2-82b9-feb1fd62b068@nvidia.com>
Date: Thu, 28 Jan 2021 11:12:26 +0200
In-Reply-To: <20210127174226.4d29f454@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1611825163; bh=6434+fx3NeTTQzriDT1tL1g4EM7i187MlZg28mNBPeE=;
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
 b=YnZStjHaf+6bzVPdmJA4QAEgq+srZgxy98AjqLhZU4UtWyYpBSj/mvo1UNkzeCFR0
 68FcXw+3rTHfwkoMTjdbDrbFYtPyN4g+/HDJa+4t8vcTn/FK/I4SfuF5aIbgnCutIR
 KSfQIHHcQ9fMlYcnzVbyNsqsbfOuSP5u5rDdxWr37ktzlUCsFNt0r8zCJurAsgwznG
 NtAPhUiflMbciWQMm6jY5F2zalC1Nc6EW7k3N/NgIEZC0zgXvxZ47jI/8zXv74+fSz
 aqDIaLRYxYn1KbtPDf1ayfq1vk5cYvo+gra/dRpWZ7gC0Z8m/5Z30RhQJqtY882Ccn
 XU2uge+M1FDsQ==
Subject: Re: [Bridge] [PATCH net-next v2 0/2] net: bridge: multicast:
 per-port EHT hosts limit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

On 28/01/2021 03:42, Jakub Kicinski wrote:
> On Tue, 26 Jan 2021 11:35:31 +0200 Nikolay Aleksandrov wrote:
>> From: Nikolay Aleksandrov <nikolay@nvidia.com>
>>
>> Hi,
>> This set adds a simple configurable per-port EHT tracked hosts limit.
>> Patch 01 adds a default limit of 512 tracked hosts per-port, since the EHT
>> changes are still only in net-next that shouldn't be a problem. Then
>> patch 02 adds the ability to configure and retrieve the hosts limit
>> and to retrieve the current number of tracked hosts per port.
>> Let's be on the safe side and limit the number of tracked hosts by
>> default while allowing the user to increase that limit if needed.
> 
> Applied, thanks!
> 
> I'm curious that you add those per-port sysfs files, is this a matter
> of policy for the bridge? Seems a bit like a waste of memory at this
> point.
> 

Indeed, that's how historically new port and bridge options are added.
They're all exposed via sysfs. I wonder if we should just draw the line
and continue with netlink-only attributes. Perhaps we should add a comment
about it for anyone adding new ones.

Since this is in net-next I can send a follow up to drop the sysfs part
and another to add that comment.

WDYT?

Cheers,
 Nik

