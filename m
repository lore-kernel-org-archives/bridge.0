Message-ID: <4B81DA09.8070204@xs4all.nl>
Date: Mon, 22 Feb 2010 02:12:41 +0100
From: Zoilo Gomez <zoilo@xs4all.nl>
MIME-Version: 1.0
References: <4B81C096.9090106@xs4all.nl>
	<2e59e6971002211647r10f229b2l25b5dd68e397dfff@mail.gmail.com>
In-Reply-To: <2e59e6971002211647r10f229b2l25b5dd68e397dfff@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] using bridges to connect vlans and untagged data
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Cc: bridge@lists.linux-foundation.org

Thank you Richard.

Anyway, I just found the solution while re-reading the FAQ 
http://ebtables.sourceforge.net/misc/brnf-faq.html (see section 3: How 
do I let vlan-tagged traffic go through a vlan bridge port and the other 
traffic through a non-vlan bridge port?).

And lo-and-behold - after adding the ebtables rule ....

ebtables -t broute -A BROUTING -j DROP -i eth1 -p 802_1Q --vlan-id 23

.... now everything works like a charm!

I can now ping through br1 as well (br0 was never a problem) - 
vlan23-traffic arriving on eth1 does not get bridged, but instead the 
vlan23-tag is stripped and the packet then arrives magically on my 
vlan23-interface.

Only after reading this part for the 3rd time just now, I suddenly 
understood the meaning, added the brouter rule, and done.

Thank you all for your support,

Z.


richardvoigt@gmail.com wrote:
> On Sun, Feb 21, 2010 at 5:24 PM, Zoilo Gomez <zoilo@xs4all.nl> wrote:
>   
>> I have the following interfaces:
>> => vlan22 and vlan2 on eth0
>> => vlan23 and untagged traffic on eth1
>>
>> The essence is that:
>> => vlan22@eth0 and vlan23@eth1 need to be bridged, and
>> => vlan2@eth0 and the untagged traffic on eth1 need to be bridged.
>>
>> Software:
>> => Gentoo 10.1
>> => linux 2.6.32.7 vanilla
>> => vconfig 1.9
>> => bridge-utils 1.4
>>
>> ===== My implementation:
>>
>> vconfig add eth0 2
>> vconfig add eth0 22
>>
>> vconfig add eth1 23
>>
>> brctl addbr br0
>> brctl addif br0 vlan2
>> brctl addif br0 eth1
>>
>> brctl addbr br1
>> brctl addif br1 vlan22
>> brctl addif br1 vlan23
>>
>> ebtables -P FORWARD DROP
>>
>> ebtables -A FORWARD -j ACCEPT -p ! 802_1Q -i eth1 -o vlan2
>> ebtables -A FORWARD -j ACCEPT -p ! 802_1Q -i vlan2 -o eth1
>>
>> ebtables -A FORWARD -j ACCEPT -i vlan23 -o vlan22
>> ebtables -A FORWARD -j ACCEPT -i vlan22 -o vlan23
>>
>> Unfortunately, the vlan23 interface stops receiving data as soon as eth1
>> is connected to br0. It seems that the bridge sucks all data from eth1,
>> effectively disabling vlan23; why is this?
>>
>> How can I get access to the untagged data on eth1, while simultaneously
>> using vlan23@eth1 ?
>>
>> Or should I use a different approach?
>>     
>
> This is an issue with linux vlan support, there is no interface for
> untagged traffic.  eth1 represents all traffic through that nic
> whether tagged or not.
>
> You should ask this question again on the vlan mailing list, maybe
> there's a new configuration option I don't know about or maybe they
> can offer a workaround.
>
>   
>> Z.
>>
>> _______________________________________________
>> Bridge mailing list
>> Bridge@lists.linux-foundation.org
>> https://lists.linux-foundation.org/mailman/listinfo/bridge
>>
>>     
>
>   

