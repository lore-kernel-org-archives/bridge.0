Return-Path: <jelledejong@powercraft.nl>
Message-ID: <51A5B41D.4040709@powercraft.nl>
Date: Wed, 29 May 2013 09:54:05 +0200
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
References: <51A53977.1090106@powercraft.nl>
	<1369812543.6697.3.camel@localhost>
In-Reply-To: <1369812543.6697.3.camel@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bond-mode 4 bridge-utils 3.x kernel not fully working
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Wilco Baan Hofman <wilco@baanhofman.nl>
Cc: bridge@lists.linux-foundation.org

Hi Wilco,

On 29/05/13 09:29, Wilco Baan Hofman wrote:
>> Traffic comes out the KVM quests but doesn?t come in. If I disable
>> bonding everything just works again.
>>
>> auto bond0
>>   iface bond0 inet manual
>>   slaves eth0 eth1
>>   bond-mode 4
>>   bond-miimon 100
>>   pre-up /sbin/ifconfig bond0 mtu 9000
> 
>> auto eth0
>>   iface eth0 inet manual
>>   mtu 900
> 
> Does this one really say mtu 900 instead of 9000? 
> Is your eth1 up? 

No, it was mtu 9000 (sorry for the confusion)

> Did you try non-kvm traffic over the bonding interface?
> Is the switch in LACP mode?

Yes the Cisco switch is in LACP mode and I use intel nics.
http://paste.debian.net/6686/

I noticed that incoming IPv6 traffic doesn't work anymore, the br0
interface recieved the IPv6 IP and I can ping it on the local-host but
not from an other server, the IPv6 works again to moment I remove the
bonding.

Remember tcpdump does show traffic coming in and out the br0 device but
not the vnet0 device that is used for the kvm guest.

Kind regards,

Jelle de Jong
