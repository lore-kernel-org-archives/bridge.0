Return-Path: <makita.toshiaki@lab.ntt.co.jp>
References: <CA+k9h3PudMEAC7geZ7PPvR4m-6_9X4bFnWcvrBkb4sst0q3v8Q@mail.gmail.com>
	<20171215075512.6138a258@xeon-e3>
	<CA+k9h3OQen=ySLH_JyrqTNyHKOkgK+eFtB8JKKLpokiZN+OuPg@mail.gmail.com>
	<20171215174709.4cea5b98@xeon-e3>
	<CA+k9h3PrJK4u+wzQZWBxQxL-EN8gFx0wVCX6GZ_MkvU91VGieA@mail.gmail.com>
	<CA+k9h3PN8xmXe0kSWOYsP=Rj6vK00ExPYPnPRF6hiKvECLimAQ@mail.gmail.com>
	<20171216093520.74b7fafd@xeon-e3>
	<CA+k9h3PEQ+MBq4A2a=k-Dgs=e5vGatc6oKQZd3V7iRysipHjMg@mail.gmail.com>
	<CA+k9h3N5+DMFj3jB8s8LinxpzicDwy_jbe42+M7e4ohgt02YxQ@mail.gmail.com>
	<5283ecbb-4292-9420-7f0e-0d8922b8ad35@lab.ntt.co.jp>
	<CA+k9h3Nxvm0x9LtwYhQNpYvq+XqNVvNPk98Ce7C9Ed0N7zW0wg@mail.gmail.com>
	<CA+k9h3PVr9V3wPSW7uNq-j=0htZRKWdgoaaVnDcGD_Kmn2MMBA@mail.gmail.com>
From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Message-ID: <fb9b6265-a42c-1d44-45cb-415abd6c5cdc@lab.ntt.co.jp>
Date: Wed, 20 Dec 2017 14:04:27 +0900
MIME-Version: 1.0
In-Reply-To: <CA+k9h3PVr9V3wPSW7uNq-j=0htZRKWdgoaaVnDcGD_Kmn2MMBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] linux bridge does not forward arp reply back packets
 in a vmware vm
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Adrian Pascalau <adrian27oradea@gmail.com>
Cc: bridge@lists.linux-foundation.org

On 2017/12/20 4:18, Adrian Pascalau wrote:
> On Mon, Dec 18, 2017 at 10:05 AM, Adrian Pascalau
> <adrian27oradea@gmail.com> wrote:
>> On Mon, Dec 18, 2017 at 4:54 AM, Toshiaki Makita
>> <makita.toshiaki@lab.ntt.co.jp> wrote:
>>> It looks like the broadcast arp request is coming back from gw or
>>> vmware. Would you check it?
>>
>> So if I look into the flow below, once more:
>>
>> default gw --- physical switch ---  vmware --- [ ens160 bridge tap ] --- eth0
>>
>> The arp request goes out on the eth0 interface, and enters the bridge
>> on the tap interface. The bridge assigns the eth0 mac address to the
>> tap interface, and sends the arp request out on the ens160 interface.
>> Now some deice on the left side of the bridge (either de vmware,
>> physical switch or the default gw), broadcasts that arp requests back,
>> therefore the same arp request enters back the bridge on the ens160
>> interface, and the bridge assigns the source mac address of the arp
>> request (which is still the eth0 mac address) to the ens160 port in
>> the forwarding table, which causes the behavior I have noticed...
>>
>> This explains why I see multiple times the arp request when using
>> tcpdump. By why there are three? Maybe two devices broadcasts back the
>> arp request?
>>
>> # tcpdump -n -i ens160 arp
>> tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
>> listening on ens160, link-type EN10MB (Ethernet), capture size 262144 bytes
>> 01:38:29.008219 ARP, Request who-has 10.20.21.1 tell 10.20.21.233, length 28
>> 01:38:29.008619 ARP, Request who-has 10.20.21.1 tell 10.20.21.233, length 46
>> 01:38:29.008732 ARP, Request who-has 10.20.21.1 tell 10.20.21.233, length 46
>> 01:38:29.009000 ARP, Reply 10.20.21.1 is-at 00:17:08:c4:52:80, length 46
>>
>> What is strange in the above tcpdump is that the first arp request is
>> 28 bytes in length (I suppose this is the one that enters the bridge
>> on the tap interface), and the 2 others is 46 bytes in length (I
>> suppose these are the ones that enters the bridge on the ens160
>> interface). If I open the capture in wireshark, I see some padding
>> added in the last two arp requests, which does not appear in the first
>> arp request:
>>
>> Ethernet II, Src: fa:16:3e:9a:04:95 (fa:16:3e:9a:04:95), Dst:
>> Broadcast (ff:ff:ff:ff:ff:ff)
>>     Destination: Broadcast (ff:ff:ff:ff:ff:ff)
>>     Source: fa:16:3e:9a:04:95 (fa:16:3e:9a:04:95)
>>     Type: ARP (0x0806)
>>     Padding: 000000000000000000000000000000000000
>>
>> Any thoughts how I can find out who duplicates the two additional arps?
> 
> Is there a way to trace the packet as it passes through the bridge?
> Something like a debug mode?

FWIW you can use "bridge monitor" command to monitor fdb update.
tcpdump has --direction option so you can only capture either of "out"
packets or "in" packets.

-- 
Toshiaki Makita

