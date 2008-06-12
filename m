Message-ID: <4850FA96.1050205@trash.net>
Date: Thu, 12 Jun 2008 12:29:42 +0200
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
References: <E88155B5BD67CE4D87A3F1F70950B96A2FF8A8@berta.maurer-it.com>	<20080611085859.721e3917@extreme>
	<E88155B5BD67CE4D87A3F1F70950B96A2FF8AA@berta.maurer-it.com>
In-Reply-To: <E88155B5BD67CE4D87A3F1F70950B96A2FF8AA@berta.maurer-it.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge MAC selection
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org

Dietmar Maurer wrote:
>>> There any side effects with the following patch?
>> Not for you. But if it got changed now, it would surprise the 
>> existing users (change in ABI behaviour).  
>>
>> So if you need a particular mac address, you can set it with 
>> other tools (ip or ifconfig).
> 
> You are right, I can set the Hw address with ifconfig - but 
> any 'brctl addif' later resets the address, so that is simply not 
> usable.

Maybe add a persistent option to keep the manually configured
mac? Or simply disable this behaviour if a mac is configured
manually automatically. If someone does this, its probably
fair to assume he doesn't expect the address to change.

