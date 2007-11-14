Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [Bridge] Rx Buffer sizes on e1000
Date: Thu, 15 Nov 2007 08:47:48 +1100
Message-ID: <96CF49BD8B56384395D698BA99007FA32D55@exchange.pacwire.local>
From: "Leigh Sharpe" <lsharpe@pacificwireless.com.au>
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andy Gospodarek <andy@greyhouse.net>, bridge@lists.linux-foundation.org

>$ cat /proc/interrupts


leigh@qosbox:~$ cat /proc/interrupts
           CPU0
  0:   15011517    IO-APIC-edge  timer
  4:          6    IO-APIC-edge  serial
  6:          2    IO-APIC-edge  floppy
  7:          0    IO-APIC-edge  parport0
  8:          1    IO-APIC-edge  rtc
  9:          1   IO-APIC-level  acpi
 14:        108    IO-APIC-edge  ide0
 15:     501765    IO-APIC-edge  ide1
169:    8964401   IO-APIC-level  uhci_hcd:usb1, eth3, eth8, eth13,
eth14, eth21,
 eth24
177:    9074694   IO-APIC-level  uhci_hcd:usb2, eth4, eth9, eth10,
eth15, eth18,
 eth25
185:         38   IO-APIC-level  uhci_hcd:usb3
193:   10256409   IO-APIC-level  ehci_hcd:usb4, eth2, eth7, eth12,
eth17, eth20,
 eth23
201:      44119   IO-APIC-level  eth0
217:    9734965   IO-APIC-level  eth5, eth6, eth11, eth16, eth19, eth22
225:          0   IO-APIC-level  Intel 82801DB-ICH4
NMI:          0
LOC:   15012117
ERR:          0
MIS:          0 

-----Original Message-----
From: bridge-bounces@lists.linux-foundation.org
[mailto:bridge-bounces@lists.linux-foundation.org] On Behalf Of Andy
Gospodarek
Sent: Thursday, 15 November 2007 3:10 AM
To: bridge@lists.linux-foundation.org
Subject: Re: [Bridge] Rx Buffer sizes on e1000

On Nov 14, 2007 12:26 AM, Leigh Sharpe <lsharpe@pacificwireless.com.au>
wrote:
>
> Looking at this a little further, the stats on the ethernet card (from
> ifconfig) tell me that it has transmitted as many bytes as it has
> received, which indicates that the bridge itself is not dropping the
> packets. I'm back to the idea that the card sn't delivering them to
the
> bridge somehow. Hence my first guess about buffer sizes.

The e1000 module does have options for Tx/RxDescriptors (buffers), but
I'm not sure that's going to help you too much.

> As far as MSI goes, I have it enabled in the kernel (looks like it's
> default for 2.6.18?), but I see nothing in the logs referring to MSI.
Is
> there any way of checking whether it's enabled and working? Or is it
> only a PCI-X thing?
>


$ cat /proc/interrupts
_______________________________________________
Bridge mailing list
Bridge@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/bridge

