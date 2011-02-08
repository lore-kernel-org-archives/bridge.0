Message-ID: <4D519E97.40706@ll.mit.edu>
Date: Tue, 8 Feb 2011 14:50:47 -0500
From: Jeff Mitchell <jmitchell@ll.mit.edu>
MIME-Version: 1.0
References: <4D519986.7070000@ll.mit.edu> <4D519DC8.9070908@candelatech.com>
In-Reply-To: <4D519DC8.9070908@candelatech.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge suddenly only passes traffic if in promiscuous
 mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ben Greear <greearb@candelatech.com>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

On 02/08/2011 02:47 PM, Ben Greear wrote:
> On 02/08/2011 11:29 AM, Jeff Mitchell wrote:
>> Hello,
>>
>> I have a bridge to various interfaces. There is an IP address on the
>> bridge, and hosts on the interfaces connected to the bridge use the
>> bridge's IP address as a gateway. STP is off and the forwarding delay is
>> set to 0.
>>
>> This has been working fine, however, today I needed to change around
>> some IPv6 addresses on the connected hosts. I made the IPv6 changes and
>> rebooted those boxes, only to find that suddenly no traffic -- IPv4 *or*
>> IPv6 -- was passing through the bridge.
>>
>> When I pulled up tshark to see what was going on, traffic suddenly
>> started flowing again. And even as I type this, as long as tshark is
>> running on that interface (no matter what the capture filter is),
>> traffic is flowing. The moment I stop tshark from running, traffic
>> stops. IOW, the bridge is only passing traffic while in promiscuous mode.
>>
>> I didn't change the IP address on the bridge itself. As far as I can
>> tell I didn't do anything odd whatsoever. But I have no idea what's
>> causing this and I'd really like to not reboot the box if at all possible.
>>
>> Does anyone have any idea what might be causing this and/or how to
>> troubleshoot this?
>
> What kernel version?
>
> And, you are sniffing the physical interface, or the bridge?
>
> Maybe send us output of brctl show, and ifconfig -a?
>
> Promisc bit is sometimes hard to detect properly, so if you can, please
> post /sys/class/net/[iface-name]/flags
> If bit 0x100 is set, the NIC is actually promisc, regardless of what
> ifconfig -a shows.

I found other funky behavior (sendmsg denied when trying to ping via 
IPv6) and users had trouble accessing services on the box, so I already 
initiated a reboot of the box -- I need those services up. :-|

If it happens again I'll be sure to get you that info.

However, here's what I *can* provide:
2.6.36 kernel, and sniffing the bridge. (There's actually no physical 
interface on the bridge -- this is on purpose, to prevent any problems 
on the bridge from affecting the one physical interface on the box, and 
thus my ability to get in and fix things.)

--Jeff
