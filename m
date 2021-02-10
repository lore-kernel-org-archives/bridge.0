Return-Path: <nikolay@nvidia.com>
References: <20210210091445.741269-1-olteanv@gmail.com>
 <a8e9284b-f0a6-0343-175d-8c323371ef8d@nvidia.com>
 <20210210104549.ga3lgjafn5x3htwj@skbuf>
 <a58e9615-036c-0431-4ea6-004af4988b27@nvidia.com>
 <20210210110125.rw6fvjtsqmmuglcg@skbuf>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <90b255e6-efd2-b234-7bfc-4285331e56b1@nvidia.com>
Date: Wed, 10 Feb 2021 13:05:57 +0200
In-Reply-To: <20210210110125.rw6fvjtsqmmuglcg@skbuf>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1612955389; bh=BQXcCNzGldQwHEpCtK/k/A0o3moxDA80QAxpatQPKoQ=;
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
 b=qOqMTgckoOI1RB3HL3mcU/JRejbL0fXkuQp70+xyop3KuiesQ4DKGBYpUDdaY/hpL
 jO3aLkSyRlXo1g5u1njuBb/D/6ff/BHMH5Fziu9BlOwjk2rl9dKkNKW9lygXc4tw/w
 15SREkyR0W1lrtaXC3Wbv7uSgPENjDmrPGVOF9flZZ/7rTlc9D3i2AIXVM+cJi1uR4
 3SIcsNU7lCaufV5agEO1Fm4jDj0ciG44RHaVu/n8BG02loIKh2cEhoctQT7XViK3DT
 8m+DfBBytf4sk8uKdih7kEa2iYLAu4cKu7hzIuTwZ5h3H1iebH2WLTX51A1UmlUMTd
 +fRw6Unn21B8A==
Subject: Re: [Bridge] [PATCH v3 net-next 00/11] Cleanup in brport flags
 switchdev offload for DSA
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

On 10/02/2021 13:01, Vladimir Oltean wrote:
> On Wed, Feb 10, 2021 at 12:52:33PM +0200, Nikolay Aleksandrov wrote:
>> On 10/02/2021 12:45, Vladimir Oltean wrote:
>>> Hi Nikolay,
>>>
>>> On Wed, Feb 10, 2021 at 12:31:43PM +0200, Nikolay Aleksandrov wrote:
>>>> Hi Vladimir,
>>>> Let's take a step back for a moment and discuss the bridge unlock/lock sequences
>>>> that come with this set. I'd really like to avoid those as they're a recipe
>>>> for future problems. The only good way to achieve that currently is to keep
>>>> the PRE_FLAGS call and do that in unsleepable context but move the FLAGS call
>>>> after the flags have been changed (if they have changed obviously). That would
>>>> make the code read much easier since we'll have all our lock/unlock sequences
>>>> in the same code blocks and won't play games to get sleepable context.
>>>> Please let's think and work in that direction, rather than having:
>>>> +	spin_lock_bh(&p->br->lock);
>>>> +	if (err) {
>>>> +		netdev_err(p->dev, "%s\n", extack._msg);
>>>> +		return err;
>>>>  	}
>>>> +
>>>>
>>>> which immediately looks like a bug even though after some code checking we can
>>>> verify it's ok. WDYT?
>>>>
>>>> I plan to get rid of most of the br->lock since it's been abused for a very long
>>>> time because it's essentially STP lock, but people have started using it for other
>>>> things and I plan to fix that when I get more time.
>>>
>>> This won't make the sysfs codepath any nicer, will it?
>>>
>>
>> Currently we'll have to live with a hack that checks if the flags have changed. I agree
>> it won't be pretty, but we won't have to unlock and lock again in the middle of the 
>> called function and we'll have all our locking in the same place, easier to verify and
>> later easier to remove. Once I get rid of most of the br->lock usage we can revisit
>> the drop of PRE_FLAGS if it's a problem. The alternative is to change the flags, then
>> send the switchdev notification outside of the lock and revert the flags if it doesn't
>> go through which doesn't sound much better.
>> I'm open to any other suggestions, but definitely would like to avoid playing locking games.
>> Even if it means casing out flag setting from all other store_ functions for sysfs.
> 
> By casing out flag settings you mean something like this?
> 
> 
> #define BRPORT_ATTR(_name, _mode, _show, _store)		\
> const struct brport_attribute brport_attr_##_name = { 	        \
> 	.attr = {.name = __stringify(_name), 			\
> 		 .mode = _mode },				\
> 	.show	= _show,					\
> 	.store_unlocked	= _store,				\
> };
> 
> #define BRPORT_ATTR_FLAG(_name, _mask)				\
> static ssize_t show_##_name(struct net_bridge_port *p, char *buf) \
> {								\
> 	return sprintf(buf, "%d\n", !!(p->flags & _mask));	\
> }								\
> static int store_##_name(struct net_bridge_port *p, unsigned long v) \
> {								\
> 	return store_flag(p, v, _mask);				\
> }								\
> static BRPORT_ATTR(_name, 0644,					\
> 		   show_##_name, store_##_name)
> 
> static ssize_t brport_store(struct kobject *kobj,
> 			    struct attribute *attr,
> 			    const char *buf, size_t count)
> {
> 	...
> 
> 	} else if (brport_attr->store_unlocked) {
> 		val = simple_strtoul(buf, &endp, 0);
> 		if (endp == buf)
> 			goto out_unlock;
> 		ret = brport_attr->store_unlocked(p, val);
> 	}
> 

Yes, this can work but will need a bit more changes because of br_port_flags_change().
Then the netlink side can be modeled in a similar way.



