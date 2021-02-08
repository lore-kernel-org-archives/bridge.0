Return-Path: <nikolay@nvidia.com>
References: <20210207232141.2142678-1-olteanv@gmail.com>
 <20210207232141.2142678-3-olteanv@gmail.com>
 <95dede91-56aa-1852-8fbf-71d446fa7ede@nvidia.com>
 <20210208114511.xtzma5byrdnr5s7r@skbuf>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <a22fee65-9cb5-bdd5-fd40-cdd57dc072f3@nvidia.com>
Date: Mon, 8 Feb 2021 14:17:04 +0200
In-Reply-To: <20210208114511.xtzma5byrdnr5s7r@skbuf>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1612786648; bh=w4RVkI/iNokwmnEOhVMllUSsNW4Mj3EHC1/ddDrha9w=;
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
 b=a1323N8eXC5BFt04xRqsY0wFjsSB/GSz/ZlxgT2JgCdT4xUb01/y/z/ySCaJptdsa
 vo7dPiX8tlzULxmMqsH/PUvlE+yh6CIObDqHS/M5VMXvkvPcT3Ktkg3qZ3r3XYIUhO
 Jd/Q1k/9hZ5oF8Pi9FegJZ/9J2ufBcrDlL4a2NCZiFYlGeZYWx8W3zncMSX/JC2iEa
 zn6RICXRf3syJ95M0feHekq+VpUe86mz5qHotGKPO8meeekP0DQXSe3vSzHmidNQNZ
 /EwLbLeqfgqJIOGva2M3GDbHjFXD8ROlSMW9hnPYV24fOM2iQE4jSlpGJM8jY/MZRI
 AiDh+8BLVyuIw==
Subject: Re: [Bridge] [PATCH net-next 2/9] net: bridge: offload initial and
 final port flags through switchdev
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com, "David S. Miller" <davem@davemloft.net>

On 08/02/2021 13:45, Vladimir Oltean wrote:
> On Mon, Feb 08, 2021 at 01:37:03PM +0200, Nikolay Aleksandrov wrote:
>> Hi Vladimir,
>> I think this patch potentially breaks some use cases. There are a few problems, I'll
>> start with the more serious one: before the ports would have a set of flags that were
>> always set when joining, now due to how nbp_flags_change() handles flag setting some might
>> not be set which would immediately change behaviour w.r.t software fwding. I'll use your
>> example of BR_BCAST_FLOOD: a lot of drivers will return an error for it and any broadcast
>> towards these ports will be dropped, we have mixed environments with software ports that
>> sometimes have traffic (e.g. decapped ARP requests) software forwarded which will stop working.
> 
> Yes, you're right. The only solution I can think of is to add a "bool ignore_errors"
> to nbp_flags_change, set to true from new_nbp and del_nbp, and to false from the
> netlink code.
> 

Indeed, I can't think of any better solution right now, but that would make it more or less
equal to the current situation where the flags are just set. You can read/restore them on add/del
of bridge port, but I guess that's what you'd like to avoid. :)
I don't mind adding the add/del_nbp() notifications, but both of them seem redundant with
the port add/del notifications which you can handle in the driver.

>> The other lesser issue is with the style below, I mean these three calls for each flag are
>> just ugly and look weird as you've also noted, since these APIs are internal can we do better?
> 
> Doing better would mean allowing nbp_flags_change() to have a bit mask with
> potentially more brport flags set, and to call br_switchdev_set_port_flag in
> a for_each_set_bit() loop?
> 

Sure, that sounds better for now. I think you've described the ideal case in your
commit message.
