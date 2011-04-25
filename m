MIME-Version: 1.0
Sender: aenertia@aenertia.net
In-Reply-To: <4DB5BE51.6050108@gmail.com>
References: <4DB540CA.8030903@gmail.com>
	<BANLkTimgVfBmKyE8YcO4_TuQvCf_Y-vfNQ@mail.gmail.com>
	<4DB5BE51.6050108@gmail.com>
From: Joel Wiramu Pauling <joel@aenertia.net>
Date: Tue, 26 Apr 2011 08:43:17 +1200
Message-ID: <BANLkTi=corFGAgbPi1hTmxaWpyrYxYA9Ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] mind-boggling questions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Ireneusz_Szcze=C5=9Bniak?= <irek.szczesniak@gmail.com>
Cc: bridge@lists.linux-foundation.org

It is normal for switch vendors to assign mac addresses to a bridge -
only cheap consumer bridges don't have them, normally this is assigned
by a stanza during config.

I think many of these problems come from the fact that bridge devices
in linux are really more like a SAP construct. It would be more useful
IMHO to introduce a new class of "bridge" device which acted like a
SAP (service access port)

Consider:


Customer A - CVLAN 100
Customer B - CVLAN 200

Service A - SVLAN 1000
Service B - SVLAN 2000

Incoming interface received QinQ (stacked) 1000:[100-200] as both
subscribers are on service 1000.

To get both of these customers to be in the same segment you first
need to create a bridge, create a vlan 1000, then each CVLAN per
customer off this new interface, and finally add it to the bridge.

Tunable  like per bridge member interface broadcast enable/disable etc
would be nice as well.

A SAP construct would allow alot more flexibility and I think clear up
some of the uses that bridge devices are currently used for.



2011/4/26 Ireneusz Szcze=C5=9Bniak <irek.szczesniak@gmail.com>:
> Thanks, Sasikanth, for your response. =C2=A0Yes, I didn't realize that we
> need a MAC address for STP. =C2=A0Not only we need a MAC for a bridge, bu=
t
> there can be MAC addresses for ports too, and why I just don't know.
> I need to do some reading on STP, because I know very little about it.
>
> On 25.04.2011 13:02, Sasikanth V wrote:
>> 2011/4/25 Ireneusz Szcze=C5=9Bniak <irek.szczesniak@gmail.com
>> <mailto:irek.szczesniak@gmail.com>>
>>
>> =C2=A0 =C2=A0 Hi,
>>
>> =C2=A0 =C2=A0 I have a few questions on the Linux bridge, and I would ap=
preciate it
>> =C2=A0 =C2=A0 if someone could answer them.
>>
>> =C2=A0 =C2=A0 1. Why does a bridge have a MAC address? =C2=A0A bridge do=
esn't need a MAC
>> =C2=A0 =C2=A0 address. I understand that a Linux box might offer more th=
an a regular
>> =C2=A0 =C2=A0 switch, and for that you need a MAC address. But the servi=
ces should
>>
>> =C2=A0 =C2=A0 =C2=A0Yes, Linux bridge needs mac address. Because linux w=
orks based on
>> the 802.1D bridge
>> =C2=A0 =C2=A0 =C2=A0which has MAC relay entity, =C2=A0Spanning tree prot=
ocol entity. The
>> bridge required mac-address to communicate
>> =C2=A0 =C2=A0 =C2=A0with other bridges. For example to form a loop-free =
network
>> spanning-tree protocol in the bridges will communicate with
>> =C2=A0 =C2=A0 =C2=A0the bridges using BPDU, the bpdus carry the bridge a=
ddress to
>> identify from which bridge we have received the BPDU.
>> =C2=A0 =C2=A0 =C2=A0If your bridge just acts as forwarding =C2=A0agent, =
then mac address is
>> not requried.
>>
>> =C2=A0 =C2=A0 be provided by a new tap interface added to the bridge. I =
believe that
>> =C2=A0 =C2=A0 the bridge should not even be shown by ifconfig.
>>
>>
>> =C2=A0 =C2=A0 =C2=A0I am not familiar with tap interface, So ignoring it=
.
>> =C2=A0 =C2=A0 =C2=A0I agree with you that bridge should not be shown in =
ifconfig.
>> Bridge must come up =C2=A0when anyone of the bridge ports are up.
>> =C2=A0 =C2=A0 =C2=A0But in current implementation we have to issue ifcon=
fig <bridge>
>> up =C2=A0to make the bridge up. As far as i see it is not required.
>> =C2=A0 =C2=A0 =C2=A0Hope someone can give more clarification and its pur=
pose
>>
>>
>> =C2=A0 =C2=A0 2. Why does a bridge take the lowest MAC address of the in=
terfaces
>> =C2=A0 =C2=A0 connected to it?
>>
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 From 802.1D
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 7.12.5 Unique identification of a bridge
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 A unique 48-bit Universally Administered MAC=
 Address, termed the
>> Bridge Address, shall be assigned to
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 each Bridge. The Bridge Address may be the i=
ndividual MAC
>> Address of a Bridge Port, in which case, use
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 of the address of the lowest numbered Bridge=
 Port (Port 1) is
>> recommended.
>>
>>
>> =C2=A0 =C2=A0 3. When I send broadcast frames to a bridge interface (eth=
erwake -b -i
>> =C2=A0 =C2=A0 br0 00:00:00:00:00:00), the frames are received by the int=
erfaces of
>> =C2=A0 =C2=A0 the bridge. =C2=A0But when I send the frames to one of the=
 interfaces, they
>> =C2=A0 =C2=A0 are not broadcasted to other interfaces. =C2=A0I though th=
at the bridge
>> =C2=A0 =C2=A0 interface (br0) behaves the same as an interface added to =
the bridge,
>> =C2=A0 =C2=A0 but I was mistaken. =C2=A0What are the differences?
>>
>> =C2=A0 =C2=A0 =C2=A0no idea
>>
>>
>> =C2=A0 =C2=A0 Thanks,
>> =C2=A0 =C2=A0 Irek
>>
>> =C2=A0 =C2=A0 --
>> =C2=A0 =C2=A0 Ireneusz (Irek) Szczesniak
>> =C2=A0 =C2=A0 http://www.irkos.org
>> =C2=A0 =C2=A0 _______________________________________________
>> =C2=A0 =C2=A0 Bridge mailing list
>> =C2=A0 =C2=A0 Bridge@lists.linux-foundation.org
>> =C2=A0 =C2=A0 <mailto:Bridge@lists.linux-foundation.org>
>> =C2=A0 =C2=A0 https://lists.linux-foundation.org/mailman/listinfo/bridge
>>
>
>
> --
> Ireneusz (Irek) Szczesniak
> http://www.irkos.org
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
