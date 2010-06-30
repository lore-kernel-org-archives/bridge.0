Message-ID: <4C2B531E.4010308@ll.mit.edu>
Date: Wed, 30 Jun 2010 10:22:22 -0400
From: Jeff Mitchell <jmitchell@ll.mit.edu>
MIME-Version: 1.0
References: <AANLkTil_htjsbpP4oz318heSGIU-1_Atrcgx9uLoOjpR@mail.gmail.com>
In-Reply-To: <AANLkTil_htjsbpP4oz318heSGIU-1_Atrcgx9uLoOjpR@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] What are actually ethernet devices (and what does a
 bridge	do?).
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

On 06/30/2010 05:37 AM, Stef Bon wrote:
> Now what strikes me first is that in a lot of cases a bridge is
> getting an ip address, which is (I think) not right.
> An bridge connects connects devices, and these devices should get the
> ip address, not the bridge self!

It depends what you're trying to do.

Giving the bridge an IP address can allow you to do some things that 
might otherwise be difficult, by allowing you to do interesting things 
to the underlying interfaces and the bridge itself.

For instance, you could do this to receive packets destined for that IP 
address on any interface in the bridge.

Another use would be to ensure (by setting the ageing to zero) that any 
packet sent from your IP address goes out all of the interfaces. This is 
useful for mirroring/sniffing setups.

--Jeff
