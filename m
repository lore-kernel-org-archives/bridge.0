MIME-Version: 1.0
Date: Wed, 13 Jan 2010 17:53:10 +0100
Message-ID: <8cad0aa1001130853i38d35b5ft7cd23b749ae891ce@mail.gmail.com>
From: Jean-Michel Hautbois <jhautbois@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Bridge] Re :Re: Re :Re: Re :Re: Bridging LACP (802.3ad) frames
	not working
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: bridge@lists.linux-foundation.org

2010/1/13 Stephen Hemminger <shemminger@vyatta.com>:
> On Wed, 13 Jan 2010 16:47:14 +0000
> jhautbois@gmail.com wrote:
>
>> (snip)
>> > I meant they get processed locally, before that they were dropped.
>>
>> > The best solution is to write an ebtables rule to forward them.
>>
>> Mmh, I can understand that, but I can't see which kind of rule would do
>> that.
>> Something like :
>> ebtables -A FORWARDING -p 0x8809 -j ACCEPT ??
>>
>> But I think this will not do anything, because it is forwarding by default.
>> Or there is something I can't see :-).
>>
>
> You need to put the rule on the local input not forwarding chain.
>

You mean :
ebtables -A INPUT -p 0x8809 -j ACCEPT ?

According to my understanding of this graph :
http://ebtables.sourceforge.net/br_fw_ia/PacketFlow.png
I can't understand why it has to be in the INPUT...

JM
