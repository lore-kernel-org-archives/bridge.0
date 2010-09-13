Message-ID: <4C8E6D82.6020509@superduper.net>
Date: Mon, 13 Sep 2010 11:29:22 -0700
From: Simon Barber <simon@superduper.net>
MIME-Version: 1.0
References: <AANLkTi=Qi36akPjHb4UJTXhDPW0tCrS7MC4CyAXSDBO4@mail.gmail.com>
	<20100913075419.4d70f1c8@nehalam>
In-Reply-To: <20100913075419.4d70f1c8@nehalam>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] help needed regarding configuration for bridging
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

I think you're looking for more vlan capability than the current Linux 
bridging code has. I posted a patch a few years back to add vlan aware 
bridging to the kernel - it would be great if someone updated it to the 
current kernel. Here's a reference:

https://lists.linux-foundation.org/pipermail/bridge/2006-September/005046.html

Simon


On 09/13/2010 07:54 AM, Stephen Hemminger wrote:
> On Mon, 13 Sep 2010 15:11:21 +0530
> debasis das<fordebasis@gmail.com>  wrote:
>
>> Hi all,
>>          I have a Linux box with 3 interfaces eth0,eth1 and eth2.
>>          Could anyone please let me know whether the following configuration
>> would be valid :
>>
>> *#brctl addbr br1
>> #brctl addif br1 eth1
>> #ifconfig br1 up
>> # brctl show
>> bridge name     bridge id               STP enabled     interfaces
>> br1             8000.001000000007       no              eth1
>>
>>
>> # brctl addbr br0
>> # brctl addif br0 eth0
>> # ifconfig br0 up
>> # vconfig add br0 5
>> # brctl addif br1 br0.5
>
> A bridge can not be added to a bridge.
>
