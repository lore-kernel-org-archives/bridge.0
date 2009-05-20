Message-ID: <4A13E0AD.9090402@epfl.ch>
Date: Wed, 20 May 2009 12:51:25 +0200
From: Alexandre Becholey <alexandre.becholey@epfl.ch>
MIME-Version: 1.0
References: <4A11714A.2000301@epfl.ch>	
	<2e59e6970905181635h3a4da749ue75574633ff75f5e@mail.gmail.com>	
	<4A1296ED.3030801@epfl.ch>
	<2e59e6970905191245y41a7a367offd84b35b652c947@mail.gmail.com>
In-Reply-To: <2e59e6970905191245y41a7a367offd84b35b652c947@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] network bridging between wireless and wired connection
 fails Cont'd
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Cc: "bridge@osdl.org" <bridge@osdl.org>

richardvoigt@gmail.com wrote:
> On Tue, May 19, 2009 at 6:24 AM, Alexandre Becholey
> <alexandre.becholey@epfl.ch> wrote:
>   
>> Hi thanks for your reply.
>>
>> # brctl showmacs br0
>> port no    mac addr        is local?    ageing timer
>>  2    00:14:2d:21:99:2a    no           0.78             (<- PC1's mac)
>>  1    00:1b:38:e8:51:1c    no           5.75             (<- PC2's mac)
>>  1    00:21:e9:e7:ae:88    yes           0.00            (<- wlan0)
>>  2    00:22:41:30:92:18    yes           0.00            (<- eth1)
>>
>> ifconfig shows that br0 has wlan0's mac address. If a use another wireless
>> interface with a "higher" mac address, br0 has eth1's mac address
>>
>> No iptables nor ebtables running.
>>
>> Alexandre
>>     
>
> Does your access point do any sort of filtering (like MAC-based table
> of authorized users)?  Perhaps PC1 is not listed as authorized and so
> the AP won't forward his traffic when it receives it from the wireless
> side (repeated through the Linux bridge).
>
> The linux bridge is a wireless client, not an access point, right?
>   

There are no filtering on the AP. I wasn't clear enough when I explained 
the problem.

I tried with 2 different wireless devices: a broadcom mini-PCI (b43) and 
a ralink USB (rt73usb), they both behave the same:
Let's take the case "PC1 pings PC2". PC1 first send ARP "who-has" (I can 
see them on PC1's eth0 and Bridge's br0, eth0 and wlan0 with wireshark 
or tcpdump). But I think that wlan0 doesn't send them to the AP because 
when I use another wireless interface in monitor mode (sniffing mode) 
with wireshark (I set the channel to the AP's one), I can't see any ARP 
packets.

Now with "PC2 pings PC1". PC2 send ARP "who-has". I see them with my 
wireless interface in monitor mode, I also see them on Bridge's wlan0, 
eth0 and br0 and on PC1's eth0. I see PC1 responding to the ARP 
"who-has" (with ARP "is at") on PC1's eth0, Bridge's br0, eth0 and 
wlan0. But I don't see them with my wireless interface in monitor mode. 
And therefore PC2 doesn't receive them.

It seems like wlan0 doesn't send them, but with ifconfig I can't see any 
drop or error packets. I see with "PC1 pings PC2" the number of packet 
increasing on wlan0 as the ARP "who-has" arrives on it from PC1.

And the Bridge can ping everything.


Now I also have another setup (which is the goal I want to achieve): 
from http://inwww.epfl.ch/~becholey/network.jpg take out the AP, wlan0 
now is in master mode with hostapd and PC2 is connected to the Bridge 
wirelessly. The Bridge configuration doesn't changes except wlan0 in 
master mode with hostapd.

Here, it's a bit more strange...
PC2 can ping everything (it receives the ARP "is-at" from PC1). If there 
was another station connected to the Bridge wirelessly, PC2 would be 
able to ping it.

PC1 can't ping PC2 (same behavior in the setup with wlan0 as a wireless 
client), but if during this ping, with PC2 I ping the Bridge or PC1, 
PC1's ping reaches PC2. As soon as I stop PC2's ping, PC1's ping doesn't 
reach PC2 any more.

Of course PC1 can ping the Bridge. The Bridge can ping PC1 but not PC2 
(same strange behavior when PC1 pings PC2, it works with a ping in the 
other direction).


I hope it's more clear.

PS: I want it to works with the most simple setup, therefore on any 
devices, there are no encryption, filtering,...
