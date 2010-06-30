Message-ID: <4C2BAAEE.3040906@ll.mit.edu>
Date: Wed, 30 Jun 2010 16:37:02 -0400
From: Jeff Mitchell <jmitchell@ll.mit.edu>
MIME-Version: 1.0
References: <AANLkTil_htjsbpP4oz318heSGIU-1_Atrcgx9uLoOjpR@mail.gmail.com>	<AANLkTinpKmxk1HmjFOimuJgRXqIM71shpEMg_NVBDLsk@mail.gmail.com>
	<AANLkTinQvzFPWMUvJzORInTnA7uYVqltIjBHMrIcNeiz@mail.gmail.com>
In-Reply-To: <AANLkTinQvzFPWMUvJzORInTnA7uYVqltIjBHMrIcNeiz@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] What are actually ethernet devices (and what does a
 bridge do?).
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

On 06/30/2010 04:26 PM, Stef Bon wrote:
> 2010/6/30 richardvoigt@gmail.com<richardvoigt@gmail.com>:
>> The host processor which does the bridging, can also act as a node
>> sending and receiving traffic to the bridged network.  What you see as
>> the "IP address of the bridge" is actually the configuration of the
>> interface representing this connection to the host processor.
>>
>> Packets generated on the bridge host use this IP address as the source
>> address, packets sent to this IP address are processed locally on the
>> bridge host and not forwarded.
>
> Ok, but then you're talking about a router for example, but I see a
> lot of setups for machines hosting
> other virtual machines, where the bridge gets also an ip address,
> which does not make sense to me.
>
> The function of a bridge is to share the physical device with more
> ethernet devices (virtual because they are not connected to a real
> device), and that's it.
>
> Being a bridge between devices and an interface self at the same time
> is confusing.
>
> About creating virtual devices, does anyone know how to create them?
> I've found veth, looks very promising,
> but they seem to come in pairs.

Look at the documentation for your chosen virtual machine solution -- it 
should tell you how (or have built-in capabilities) to create the 
necessary networking devices.

--Jeff
