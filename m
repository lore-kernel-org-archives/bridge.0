Message-ID: <40D20843.2020109@siennax.com>
Date: Thu, 17 Jun 2004 23:08:19 +0200
From: Mark Ruijter <bridge@siennax.com>
MIME-Version: 1.0
Subject: Re: [Bridge] Bridge code enhancement (link state detection) and bug
	fix. (patches included).
References: <40D1E993.3060801@siennax.com>
	<20040617132849.0b64c799@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040617132849.0b64c799@dell_ss3.pdx.osdl.net>
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
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org


> Rather than add another state, it should just go to DISABLED state.

I did think about doing just that. But the problem then is that the 
bridge needs to be reenabled by hand when the link comes back.

You can't automatically enable a disabled interface when the link goes 
down/up. It would also not be clear why a port is disabled. Link problem 
or human intervention?

So that's the reason why I made up the nolink state.
> 
>>I did encounter a second problem when writing the link monitoring code.
>>When you add a vlan interface like eth0.10 then it's not possible to
>>obtain link state information from this interface.
> 
> That is a VLAN problem, fix it there.  Sorry.

Hmmm.... I'll investigate the amount of work that needs to be done for this.

> 
> 
> 
>>The fix I wrote is that brctl now allows you to specify the interface
>>that contains the link state.
>>
>>Example : brctl addif NUM1 eth0.10 eth0
> 
> 
> I prefer to eschew needless complexity.

It might be complex but this is also true for a swiss army knife. :-)
If the vlan interfaces are the only ones that don't allow link state 
monitoring then I do agree that it would be best to fix the vlan 
interface status.

If the are more types of interfaces that don't support state checking 
then the current solution might be better. It is highly flexible....
> 
> That doesn't mean I won't consider adding it, but let me look at the problem
> a little more before accepting your solution as is.

Thanks for considering it. It probably needs some work. I hope that you 
do agree that some form of link state monitoring is useful.

Regards,

Mark.
