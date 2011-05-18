Message-ID: <4DD3F168.1060308@candelatech.com>
Date: Wed, 18 May 2011 09:18:48 -0700
From: Ben Greear <greearb@candelatech.com>
MIME-Version: 1.0
References: <20110518081718.0b1fc390@nehalam>	<4DD3E38C.30609@candelatech.com>
	<20110518083948.261ded68@nehalam>
In-Reply-To: <20110518083948.261ded68@nehalam>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: add notification over netlink
 when STP changes state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org, David Miller <davem@davemloft.net>

On 05/18/2011 08:39 AM, Stephen Hemminger wrote:
> On Wed, 18 May 2011 08:19:40 -0700
> Ben Greear<greearb@candelatech.com>  wrote:
>
>> On 05/18/2011 08:17 AM, Stephen Hemminger wrote:
>>> The first netlink code in the bridge module was to notify
>>> user space implementations of Spanning Tree Protocol about
>>> new ports. It did not handle the case of kernel mode STP
>>> changing states which could be useful for monitoring.
>>>
>>> This patch causes RTM_NEWLINK message to occur on kernel
>>> transitions. It does not send message if request was from user
>>> space STP, since that would cause reflection and break existing
>>> API.
>>
>> So one app monitoring the system won't get updates if another
>> app makes changes?
>>
>> Ben
>
> For now, yes. Just don't want to break any existing users
> which is more important.

You can get RTM_NEWLINK messages for various reasons..it would
seem a non-buggy program should have no problem dealing with one
more source.

It seems like this code is going to be inconvenient
for anyone wanting to monitor bridges using netlink, and
even if you fix it in the future, there is going to be
backwards compatible hacks that are likely to be quite
ugly!

Thanks,
Ben

>


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

