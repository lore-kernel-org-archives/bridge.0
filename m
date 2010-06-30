From: Sergei Zhirikov <sfzhi@yahoo.com>
Date: Wed, 30 Jun 2010 23:51:55 +0200
Message-ID: <i0ge9s$uou$1@dough.gmane.org>
References: <AANLkTil_htjsbpP4oz318heSGIU-1_Atrcgx9uLoOjpR@mail.gmail.com>	<AANLkTinpKmxk1HmjFOimuJgRXqIM71shpEMg_NVBDLsk@mail.gmail.com>
	<AANLkTinQvzFPWMUvJzORInTnA7uYVqltIjBHMrIcNeiz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <AANLkTinQvzFPWMUvJzORInTnA7uYVqltIjBHMrIcNeiz@mail.gmail.com>
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
To: bridge@osdl.org

On 2010-06-30 22:26, Stef Bon wrote:
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

I think here is the source of your confusion. The function of the bridge is not sharing anything, but rather "joining" several devices (physical or virtual - does not matter) and representing them as a single network interface to the upper layers of the protocol stack. In other words, as soon as, say, eth0 joins a bridge it kind of stops being a network interface, but, of course, remains being a device (physical or virtual). All the devices of the bridge are connected together, not unlike a few wires soldered at a single point, as the result there is only one network interface (one "circuit"), represented by the bridge (called, for example, br0). And that is the only place where it makes sense to assign IP addresses. The rest is internal business of the bridge, where IP addresses have no meaning. (That is not taking into account some "advanced" things one can do with ebtables/iptables).

> Being a bridge between devices and an interface self at the same time
> is confusing.
>
> About creating virtual devices, does anyone know how to create them?
> I've found veth, looks very promising,
> but they seem to come in pairs.
>
> Thanks,
>
> Stef Bon
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge


