In-Reply-To: <20060816110931.731d166d@localhost.localdomain>
References: <2fe13191741861f3e39da4d79f9b7c42@shee.org>
	<20060816110931.731d166d@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <915e6d409ef485c793728c2b00cdc9db@shee.org>
Content-Transfer-Encoding: 7bit
From: Moire <sec@shee.org>
Date: Fri, 18 Aug 2006 18:03:03 +0200
Subject: Re: [Bridge] Dead loop on virtual device - how to interpret it ?
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: "<bridge@osdl.org> <bridge@osdl.org>" <bridge@osdl.org>

Am 16.08.2006 um 20:09 schrieb Stephen Hemminger:

> On Wed, 16 Aug 2006 14:05:26 +0200
> Moire <sec@shee.org> wrote:
>>
>> i am not so familiar with the deep art of
>> network internals more with the basics one.
>> Therefore i have a problem to interpret this
>> error message:
>>
>> Dead loop on virtual device br0, fix it urgently!
>>
>> In the corresponding kernel code i found this quote:
>>
>> /* It may be transient configuration error,
>>     when hard_start_xmit() recurses. We detect
>>     it by checking xmit owner and drop the
>>     packet when deadloop is detected.
>> */
>>
>> but i still have no idea what could be wrong.

Hello,

> What are the devices you are putting in the bridge?

they exist three devices:

eth0 - Intranet
eth1  (br0) - Internet
eth2  (br0) - DMZ (public IP range)

> What kernel version?

Kernel             2.4.31
bridge-utils     1.0.4

> What are the commands being used to put the devices into
> the bridge.

My init script:

INTERFACES="eth1 eth2"
BRIDGE="br0"

do_start() {
       echo "Starting Bridge $BRIDGE"

       for interface in $INTERFACES; do
         /sbin/ip addr flush dev $interface 2>/dev/null
         /sbin/ip link set $interface up
       done

         /sbin/ip link set dev $BRIDGE down 2>/dev/null
         /sbin/brctl delbr $BRIDGE 2>/dev/null 2>/dev/null
         /sbin/brctl addbr $BRIDGE
         /sbin/brctl stp $BRIDGE off

       for interface in $INTERFACES; do
         /sbin/brctl addif $BRIDGE $interface
       done
}

> It looks like a bridge ended up including itself some how.

The system is in a production environment since two month. In that
time this message (Dead loop on virtual device br0, fix it urgently!)
appeared 5 times.  I can not reproduce this alert. Therefore i have no 
idea
what could trigger this.

One think, maybe related: I am observing packets coming from eth0
with the destination DMZ. Sometimes they are routed to the wrong
bridge port  (br0:eth1 instead br0:eth2) and consequently drop by my
iptables rules.

brctl shows

bridge name	STP enabled	interfaces
br0			no                       eth1
                                                         eth2


brctl showmacs br0 (macs are Xed)

port no	mac addr		is local?	ageing timer
    1	00:xxxxxxxxxxxx	yes		   0.00
    2	00:xxxxxxxxxxxx	no		    45.22     <<<< DMZ/Webserver
    2	00:xxxxxxxxxxxx	yes		   0.00
    1	00:xxxxxxxxxxxx	no		   0.19


Regards

C. Moire


>> My setup is an bridge (two interfaces) and local
>> interface. The bridge connects the dmz with the internet.
>>
>> How can i reproduce this error message - to find the cause.
>>
>> What does it mean (for a not so advanced admin;).

