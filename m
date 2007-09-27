Message-ID: <46FB99EF.4020806@aitel.hist.no>
Date: Thu, 27 Sep 2007 13:54:23 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
MIME-Version: 1.0
References: <46FA2C17.76E4.0078.0@novell.com>	<20070926083705.6bc65ea5@fujitsu-loaner>	<E1Iae5t-0007Sk-Vu@flower>	<20070926140608.6e6d3d0c@freepuppy.rosehill>	<Pine.LNX.4.64.0709270017120.17414@fbirervta.pbzchgretzou.qr>
	<20070926153330.77aade4d@freepuppy.rosehill>
In-Reply-To: <20070926153330.77aade4d@freepuppy.rosehill>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: why network devices don't do reference counting? (Re:
 [PATCH]
 Module use count must be updated as bridges are created/destroyed)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: Jan Engelhardt <jengelh@computergmbh.de>, Oleg Verych <olecom@flower.upol.cz>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@novell.com>

Stephen Hemminger wrote:
> On Thu, 27 Sep 2007 00:18:55 +0200 (CEST)
> Jan Engelhardt <jengelh@computergmbh.de> wrote:
>
>   
>> On Sep 26 2007 14:06, Stephen Hemminger wrote:
>>     
>>>>> No, network devices don't do reference counting.
>>>>>           
>>>> Could you explain why, please?
>>>>
>>>> After `udevd` on boot loads lots of unused crap, i surrendered, and use
>>>> $(rmmod `lsmod | just first column`). Networing bravely wipes away. OK,
>>>> there are lots of configs: udev, hotplug, modprobe, that somebody might
>>>> like to fix. But it came to the end with me. I just don't care. So,
>>>> please answer :)
>>>>         
>>> For hotplug and other reasons, the network developers decided that being
>>> able to remove a network module at any time was a good thing. It works.
>>>       
>> Except that for ipv6.ko, it's all opposite. After modprobe,
>> it already got a refcount like 8 and you're wondering how
>> to get rid of that.
>>     
>
> ipv6 is not a network driver, it is a protocol. You might be able to remove it if you zap
> all the routes and applications, ...
>   
Wouldn't it be enough to down all the interfaces and close all the sockets?
No need to bring down every app.

Helge Hafting
