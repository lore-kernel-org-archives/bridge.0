From: TheSin <thesin@southofheaven.org>
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Date: Tue, 29 Sep 2009 10:00:47 -0600
Message-Id: <00309E24-4415-4D4C-BD37-AD79B227865D@southofheaven.org>
Mime-Version: 1.0 (Apple Message framework v1076)
Subject: [Bridge] Not sure what's wrong.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Okay I'm running debian sqeeze (testing) which bridge-utils 1.4-5 and  
kernel 2.6.30 amd64 variant

This is running on a new Dell Poweredge R610 with dual dual bnx2 nics

01:00.0 Ethernet controller: Broadcom Corporation NetXtreme II BCM5709  
Gigabit Ethernet (rev 20)
01:00.1 Ethernet controller: Broadcom Corporation NetXtreme II BCM5709  
Gigabit Ethernet (rev 20)
02:00.0 Ethernet controller: Broadcom Corporation NetXtreme II BCM5709  
Gigabit Ethernet (rev 20)
02:00.1 Ethernet controller: Broadcom Corporation NetXtreme II BCM5709  
Gigabit Ethernet (rev 20)

I have a bridge I'm trying to create for kvm.  eth0 is my local access  
so it's just a now nic with dhcp connected to my lan, which works no  
problem.  Then I created a bridge called prot0 and set it to manual,  
and added eth1 (also set to manual) to it.  When I start my kvm guest  
it creates a tap interface called vnet0 also without an ip and adds it  
to the bridge.  My guest OS then has eth0 which has an ip on static.

So at this point this is what things look like on the host box.

brctl show
bridge name	bridge id		STP enabled	interfaces
prot0		8000.0022195e3239	no		eth1
							vnet0

brctl showmacs prot0
port no	mac addr		is local?	ageing timer
   1	00:22:19:5e:32:39	yes		   0.00
   2	ba:ea:0d:0f:8b:aa	yes		   0.00

on the guest I start a ping to anything, google.com for this example.   
And I set tcpdump -i prot0 or vnet0 and I see the arp request for the  
dns servers but no reply.  Which looks like this.

09:54:43.444533 ARP, Request who-has dns1.domain.tld tell  
rdns.guestdomain.tld, length 28
09:54:44.440585 ARP, Request who-has dns1.domain.tld tell  
rdns.guestdomain.tld, length 28
09:54:45.440587 ARP, Request who-has dns1.domain.tld tell  
rdns.guestdomain.tld, length 28

But if I do a tcpdump -i eth1 I see nothing at all.

here is my /etc/network/interfaces

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto eth0
iface eth0 inet dhcp

auto prot0
iface prot0 inet manual
	bridge_ports eth1
	bridge_stp off
	bridge_maxwait 5

And my lsmod

Module                  Size  Used by
ip6table_filter         3904  0
ip6_tables             18928  1 ip6table_filter
iptable_filter          3776  0
ip_tables              17392  1 iptable_filter
x_tables               22440  2 ip6_tables,ip_tables
tun                    13984  2
kvm_intel              47368  4
kvm                   158904  1 kvm_intel
bridge                 48256  0
stp                     2868  1 bridge
ext2                   62816  1
loop                   15980  0
snd_pcsp               10588  2
snd_pcm                78504  1 snd_pcsp
snd_timer              21824  1 snd_pcm
snd                    63912  7 snd_pcsp,snd_pcm,snd_timer
soundcore               7984  1 snd
snd_page_alloc         10000  1 snd_pcm
joydev                 10992  0
psmouse                42172  0
serio_raw               5844  0
dcdbas                  8560  0
evdev                  10448  13
button                  6512  0
processor              40160  8
ext3                  122864  1
jbd                    48168  1 ext3
mbcache                 8804  2 ext2,ext3
dm_mod                 59384  6
sg                     24024  0
usbhid                 37328  0
hid                    41376  1 usbhid
sr_mod                 15908  0
cdrom                  34344  1 sr_mod
ide_pci_generic         4964  0
ide_core              105120  1 ide_pci_generic
ses                     6528  0
ata_generic             5924  0
sd_mod                 33720  3
uhci_hcd               22208  0
crc_t10dif              2096  1 sd_mod
enclosure               9120  1 ses
ata_piix               25124  0
megaraid_sas           34396  2
libata                175500  2 ata_generic,ata_piix
scsi_mod              158784  6 sg,sr_mod,ses,sd_mod,megaraid_sas,libata
ehci_hcd               33820  0
bnx2                   62712  0
thermal                15936  0
fan                     5240  0
thermal_sys            16448  3 processor,thermal,fan

/proc/sys/net/bridge# for i in *; do echo -n $i; echo -n ": ";cat $i;  
done
bridge-nf-call-arptables: 0
bridge-nf-call-ip6tables: 0
bridge-nf-call-iptables: 0
bridge-nf-filter-pppoe-tagged: 0
bridge-nf-filter-vlan-tagged: 0

I just don't understand how it can be getting to prot0 (my bridge) but  
no be seen on eth1 which is a bridge member.
Any help or anything I can try would be most helpful, Thanks in advance.
---
TS
http://southofheaven.org/
Chaos is the beginning and end, try dealing with the rest.

