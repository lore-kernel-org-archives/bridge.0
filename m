Message-ID: <41E2DD26.2070301@redhat.com>
Date: Mon, 10 Jan 2005 14:53:10 -0500
From: Neil Horman <nhorman@redhat.com>
MIME-Version: 1.0
References: <20050110140638.GH7529@thunderchild.debian.net>
	<41E299D4.2010605@redhat.com>
	<20050110154506.GJ7529@thunderchild.debian.net>
	<41E2A7A7.3060109@redhat.com>
	<20050110161855.GK7529@thunderchild.debian.net>
	<41E2BE29.8090800@redhat.com>
	<20050110191133.GM7529@thunderchild.debian.net>
	<41E2DA6E.8090703@redhat.com>
	<20050110194914.GN7529@thunderchild.debian.net>
In-Reply-To: <20050110194914.GN7529@thunderchild.debian.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: tg3 bridge problems
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Gergely Madarasz <gorgo@broadband.hu>
Cc: linux-net@vger.kernel.org, bridge@lists.osdl.org

Gergely Madarasz wrote:
> On Mon, Jan 10, 2005 at 02:41:34PM -0500, Neil Horman wrote:
> 
>>Gergely Madarasz wrote:
>>
>>>On Mon, Jan 10, 2005 at 12:40:57PM -0500, Neil Horman wrote:
>>>
>>>
>>>>Gergely Madarasz wrote:
>>>>
>>>>
>>>>>On Mon, Jan 10, 2005 at 11:04:55AM -0500, Neil Horman wrote:
>>>>>
>>>>>
>>>>>
>>>>>>Strange.  My concern was that the tg3 interface has its hardware reset 
>>>>>>whenever its set to be up, and part of that is a resetting of its 
>>>>>>receive mode.  If for some reason IFF_PROMISC was cleared after you set 
>>>>>>it using brctl, the interface might be taken out of promisc mode.  Do 
>>>>>>you have any iptables rules running that might drop bpdus?
>>>>>
>>>>>
>>>>>No iptables rules az all. Btw iptables wouldn't prevent tcpdump from
>>>>>seeing the packets, would it?
>>>>>Could it be that the driver perhaps has a problem setting promisc mode
>>>>>when resetting the hardware?
>>>>>
>>>>
>>>>Not really sure about this.  One experiment is worth a thousand guesses 
>>>>I suppose.......  I'll try and let you know. :)
>>>
>>>
>>>I did some other checks, like adding an explicit ifconfig eth0 promisc,
>>>then looking at tcpdump output - I didn't see any stray packets like I
>>>usually do, just ethernet broadcasts and unicasts to my mac, this also
>>>points to a problem that the ethernet interface is actually not in
>>>promisc, while the driver thinks it is.
>>>
>>>And it is probably not a driver-only issue. I've got older machines with
>>>tg3 running fine with bridge (with an older tg3 driver), and eth1 on the
>>>same machine also runs fine. On another machine I tested today, an IBM
>>>x326, the same thing happens - eth0 broken, eth1 fine. Would access to one
>>>of these machines help? :)
>>>
>>>Greg
>>
>>I've got a tg3 card here.  I'll try re-create it as soon as I have time. 
> 
> 
> Sounds great, but I expect it will not occur with a random tg3 card,
> explained above... 
> 
Mmmmm....post your lspci -vvv entry for your broken tg3 card?

> 
>>    Just out of curiosity, are you running tcpdump against the physical 
>>interface or the bridged interface?  I do recall some issues involving 
>>using PF_PACKET on virtual interfaces, that might cause you to not see 
>>some packets that the physical interface really does receive.
> 
> 
> The physical interface of course. I wouldn't have a chance seeing the
> bpdu's on the bridge interface because they're handled by the bridge
> driver and not passed on :)
> 
> Greg
Just making sure.....When you're car doesn't start, make sure you have 
gas in it before you replace the engine.... :)
Neil

-- 
/***************************************************
  *Neil Horman
  *Software Engineer
  *Red Hat, Inc.
  *nhorman@redhat.com
  *gpg keyid: 1024D / 0x92A74FA1
  *http://pgp.mit.edu
  ***************************************************/
