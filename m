Message-ID: <412B607E.6030109@joshua.raleigh.nc.us>
Date: Tue, 24 Aug 2004 11:36:30 -0400
From: Josh Wyatt <jdwyatt@joshua.raleigh.nc.us>
MIME-Version: 1.0
Subject: Re: [Bridge] Encrypting Bridge?
References: <1196.80.133.183.165.1093361732.squirrel@80.133.183.165>
In-Reply-To: <1196.80.133.183.165.1093361732.squirrel@80.133.183.165>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Rene Bartsch <ML@Bartschnet.de>
Cc: bridge@lists.osdl.org

Rene Bartsch wrote:
> On Di, 24.08.2004, 01:45, Francois Ambrosini sagte:
> 
>>On Mon, 23 Aug 2004 10:31:26 -0700
>>Stephen Hemminger <shemminger@osdl.org> wrote:
>>
>>[snip]
>>
>>>The encrypting bridge isn't a bad idea, just not sure it is worth
> 
> maintaining
> 
>>>yet another VPN solution.
>>>
>>
>>Greetings,
>>
>>IMHO, and in addition to what Rene Bartsch said, providing an encrypted
> 
> tunnel at layer 2 can be really useful when it comes to bandwidth and/or
> latency matters.
> 

There is already a tool to do layer-2 bridging with encryption.  Check out vtun:

http://vtun.sourceforge.net/

I use it a great deal to do layer-2 bridging.  It works with the kernel tun/tap 
driver and works very well.  It can use TCP or UDP as the transport, offers 
compression, etc.  Key management is up to you, however.

Thanks,
Josh

