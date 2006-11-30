Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C71416.9220973E"
Date: Wed, 29 Nov 2006 19:29:17 -0500
Message-ID: <587BB495FD172F43931DE54C0AFD218616F9FF@reset6.ad2.felines.org>
From: "Jay Libove" <libove@felines.org>
Subject: [Bridge] recent crashes? Linux kernel 2.6.18-1.2239.fc5 (Linux
	Fedora Core 5)
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------_=_NextPart_001_01C71416.9220973E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Recently, possibly since the most recent one or two kernel upgrades in
Linux Fedora Core 5, my system has been crashing with a kernel panic.
The panic prevents anything useful from being written to any log files,
but on the crash trace left on the screen each time I always see
something which looks like it is in the bridge code.

=20

This system is based on Linux Fedora Core 5, and currently has the
following showing up with "kernel" in the name in the output of "rpm -q
-a":

kernel-2.6.18-1.2200.fc5

kernel-2.6.18-1.2239.fc5

I'm a bit concerned about the fact that more than one single kernel
instance appears in this output! Not sure that I've ever seen that
before... "dmesg -a" shows that it is the .2239 version of the kernel
which is booting.

=20

The system has 576MB of RAM (dmesg -a shows 575MB, I think it shares 1MB
with an on-board video module; this thing never runs in graphics mode
anyway). It has a Celeron 766MHz CPU.=20

=20

I've pasted the output of "dmesg -a" at the bottom of this email, in
case it provides any useful diagnostic information.

=20

I know this is very little information. I'm hoping that what is
happening here is an incompatibility between a recent Fedora Core 5
kernel upgrade and the bridge code, and that others have seen it, and
someone knows a fix / workaround; or that there is some kind of attack
going on which is randomly hitting my system and triggering the panic,
and, again someone has seen it and has a fix / workaround.

=20

Thanks very much!

-Jay

=20

Linux version 2.6.18-1.2239.fc5
(brewbuilder@hs20-bc1-7.build.redhat.com) (gcc version 4.1.1 20060525
(Red Hat 4.1.1-1)) #1 Fri Nov 10 13:04:06 EST 2006

BIOS-provided physical RAM map:

 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)

 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)

 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)

 BIOS-e820: 0000000000100000 - 0000000023ff0000 (usable)

 BIOS-e820: 0000000023ff0000 - 0000000023ff3000 (ACPI NVS)

 BIOS-e820: 0000000023ff3000 - 0000000024000000 (ACPI data)

 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)

0MB HIGHMEM available.

575MB LOWMEM available.

Using x86 segment limits to approximate NX protection

On node 0 totalpages: 147440

  DMA zone: 4096 pages, LIFO batch:0

  Normal zone: 143344 pages, LIFO batch:31

DMI 2.3 present.

IO/L-APIC disabled because your old system seems to be old

overwrite with "apic"

ACPI: RSDP (v000 ABIT                                  ) @ 0x000f6fd0

ACPI: RSDT (v001 ABIT   AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x23ff3000

ACPI: FADT (v001 ABIT   AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x23ff3040

ACPI: DSDT (v001 ABIT   AWRDACPI 0x00001000 MSFT 0x0100000c) @
0x00000000

ACPI: PM-Timer IO Port: 0x4008

Allocating PCI resources starting at 30000000 (gap: 24000000:dbff0000)

Detected 768.433 MHz processor.

Built 1 zonelists.  Total pages: 147440

Kernel command line: ro root=3DLABEL=3D/1

mapped APIC to ffffd000 (01487000)

Enabling fast FPU save and restore... done.

Enabling unmasked SIMD FPU exception support... done.

Initializing CPU#0

CPU 0 irqstacks, hard=3Dc075a000 soft=3Dc0759000

PID hash table entries: 4096 (order: 12, 16384 bytes)

Console: colour VGA+ 80x25

Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)

Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)

Memory: 578960k/589760k available (2040k kernel code, 10240k reserved,
798k data, 220k init, 0k highmem)

Checking if this processor honours the WP bit even in supervisor mode...
Ok.

Calibrating delay using timer specific routine.. 1537.46 BogoMIPS
(lpj=3D768733)

Security Framework v1.0.0 initialized

SELinux:  Initializing.

SELinux:  Starting in permissive mode

selinux_register_security:  Registering secondary module capability

Capability LSM initialized as secondary

Mount-cache hash table entries: 512

CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000
00000000 00000000 00000000

CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
00000000 00000000 00000000

CPU: L1 I cache: 16K, L1 D cache: 16K

CPU: L2 cache: 128K

CPU: After all inits, caps: 0383f1ff 00000000 00000000 00000040 00000000
00000000 00000000

Intel machine check architecture supported.

Intel machine check reporting enabled on CPU#0.

CPU: Intel Celeron (Coppermine) stepping 06

Checking 'hlt' instruction... OK.

ACPI: Core revision 20060707

ACPI: setting ELCR to 0200 (from 0e20)

checking if image is initramfs... it is

Freeing initrd memory: 918k freed

NET: Registered protocol family 16

ACPI: bus type pci registered

PCI: PCI BIOS revision 2.10 entry at 0xfb3b0, last bus=3D2

PCI: Using configuration type 1

Setting up standard PCI resources

ACPI: Interpreter enabled

ACPI: Using PIC for interrupt routing

ACPI: PCI Root Bridge [PCI0] (0000:00)

PCI: Probing PCI hardware (bus 00)

ACPI: Assume root bridge [\_SB_.PCI0] bus is 0

* Found PM-Timer Bug on the chipset. Due to workarounds for a bug,

* this clock source is slow. Consider trying other clock sources

PCI quirk: region 4000-403f claimed by PIIX4 ACPI

PCI quirk: region 5000-500f claimed by PIIX4 SMB

Boot video device is 0000:00:0f.0

ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]

ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)

ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *9

ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)

Linux Plug and Play Support v0.97 (c) Adam Belay

pnp: PnP ACPI init

pnp: PnP ACPI: found 13 devices

usbcore: registered new driver usbfs

usbcore: registered new driver hub

PCI: Using ACPI for IRQ routing

PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a
report

PCI: Bridge: 0000:00:01.0

  IO window: disabled.

  MEM window: disabled.

  PREFETCH window: disabled.

PCI: Bridge: 0000:00:0d.0

  IO window: 9000-9fff

  MEM window: d4000000-d5ffffff

  PREFETCH window: 30000000-300fffff

NET: Registered protocol family 2

IP route cache hash table entries: 32768 (order: 5, 131072 bytes)

TCP established hash table entries: 131072 (order: 9, 2097152 bytes)

TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)

TCP: Hash tables configured (established 131072 bind 65536)

TCP reno registered

apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)

apm: overridden by ACPI.

audit: initializing netlink socket (disabled)

audit(1164826911.852:1): initialized

Total HugeTLB memory allocated, 0

VFS: Disk quotas dquot_6.5.1

Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)

SELinux:  Registering netfilter hooks

Initializing Cryptographic API

ksign: Installing public key data

Loading keyring

- Added public key 481F17AAEB289250

- User ID: Red Hat, Inc. (Kernel Module GPG key)

io scheduler noop registered

io scheduler anticipatory registered

io scheduler deadline registered

io scheduler cfq registered (default)

Limiting direct PCI/PCI transfers.

pci_hotplug: PCI Hot Plug PCI Core version: 0.5

ACPI: Fan [FAN0] (on)

ACPI: CPU0 (power states: C1[C1] C2[C2])

ACPI: Processor [CPU0] (supports 2 throttling states)

isapnp: Scanning for PnP cards...

isapnp: No Plug & Play device found

Real Time Clock Driver v1.12ac

Non-volatile memory driver v1.2

Linux agpgart interface v0.101 (c) Dave Jones

agpgart: Detected an Intel 440BX Chipset.

agpgart: AGP aperture is 64M @ 0xd0000000

Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled

serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A

serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A

00:08: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A

00:09: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A

RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2

ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=3Dxx

PIIX4: IDE controller at PCI slot 0000:00:07.1

PIIX4: chipset revision 1

PIIX4: not 100% native mode: will probe irqs later

    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio

    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio

Probing IDE interface ide0...

hda: SAMSUNG SP1213N, ATA DISK drive

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

Probing IDE interface ide1...

hdc: DVDROM 12X, ATAPI CD/DVD-ROM drive

ide1 at 0x170-0x177,0x376 on irq 15

HPT374: IDE controller at PCI slot 0000:00:0b.0

ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5

PCI: setting IRQ 5 as level-triggered

ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKC] -> GSI 5 (level, low)
-> IRQ 5

HPT374: chipset revision 7

HPT374: 100% native mode on irq 5

HPT37X: using 33MHz PCI clock

    ide2: BM-DMA at 0xb000-0xb007, BIOS settings: hde:pio, hdf:pio

HPT37X: using 33MHz PCI clock

    ide3: BM-DMA at 0xb008-0xb00f, BIOS settings: hdg:pio, hdh:pio

ACPI: PCI Interrupt 0000:00:0b.1[A] -> Link [LNKC] -> GSI 5 (level, low)
-> IRQ 5

HPT37X: using 33MHz PCI clock

    ide4: BM-DMA at 0xc400-0xc407, BIOS settings: hdi:pio, hdj:pio

HPT37X: using 33MHz PCI clock

    ide5: BM-DMA at 0xc408-0xc40f, BIOS settings: hdk:pio, hdl:pio

Probing IDE interface ide2...

Probing IDE interface ide3...

Probing IDE interface ide4...

Probing IDE interface ide5...

Probing IDE interface ide2...

Probing IDE interface ide3...

Probing IDE interface ide4...

Probing IDE interface ide5...

hda: max request size: 512KiB

hda: 234493056 sectors (120060 MB) w/8192KiB Cache, CHS=3D16383/255/63,
UDMA(33)

hda: cache flushes supported

 hda: hda1 hda2 hda3

ide-floppy driver 0.99.newide

usbcore: registered new driver libusual

usbcore: registered new driver hiddev

usbcore: registered new driver usbhid

drivers/usb/input/hid-core.c: v2.6:USB HID core driver

PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12

serio: i8042 AUX port at 0x60,0x64 irq 12

serio: i8042 KBD port at 0x60,0x64 irq 1

mice: PS/2 mouse device common for all mice

md: md driver 0.90.3 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27

md: bitmap version 4.39

TCP bic registered

Initializing IPsec netlink socket

NET: Registered protocol family 1

NET: Registered protocol family 17

Using IPI Shortcut mode

Time: tsc clocksource has been installed.

ACPI: (supports S0 S1 S4 S5)

Time: acpi_pm clocksource has been installed.

Freeing unused kernel memory: 220k freed

Write protecting the kernel read-only data: 377k

input: AT Translated Set 2 keyboard as /class/input/input0

input: ImExPS/2 Generic Explorer Mouse as /class/input/input1

EXT3-fs: INFO: recovery required on readonly filesystem.

EXT3-fs: write access will be enabled during recovery.

kjournald starting.  Commit interval 5 seconds

EXT3-fs: recovery complete.

EXT3-fs: mounted filesystem with ordered data mode.

security:  3 users, 6 roles, 1481 types, 152 bools, 1 sens, 256 cats

security:  58 classes, 43474 rules

SELinux:  Completing initialization.

SELinux:  Setting up existing superblocks.

SELinux: initialized (dev hda2, type ext3), uses xattr

SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs

SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts

SELinux: initialized (dev selinuxfs, type selinuxfs), uses
genfs_contexts

SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs

SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses
genfs_contexts

SELinux: initialized (dev devpts, type devpts), uses transition SIDs

SELinux: initialized (dev eventpollfs, type eventpollfs), uses task SIDs

SELinux: initialized (dev inotifyfs, type inotifyfs), uses
genfs_contexts

SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs

SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts

SELinux: initialized (dev pipefs, type pipefs), uses task SIDs

SELinux: initialized (dev sockfs, type sockfs), uses task SIDs

SELinux: initialized (dev proc, type proc), uses genfs_contexts

SELinux: initialized (dev bdev, type bdev), uses genfs_contexts

SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts

SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts

audit(1164826922.708:2): policy loaded auid=3D4294967295

SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts

hdc: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)

Uniform CD-ROM driver Revision: 3.20

input: PC Speaker as /class/input/input2

piix4_smbus 0000:00:07.3: Found 0000:00:07.3 device

Linux Tulip driver version 1.1.13 (May 11, 2002)

ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11

PCI: setting IRQ 11 as level-triggered

ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [LNKB] -> GSI 11 (level,
low) -> IRQ 11

tulip0:  EEPROM default media type Autosense.

tulip0:  Index #0 - Media 10baseT (#0) described by a 21140 non-MII (0)
block.

tulip0:  Index #1 - Media 100baseTx (#3) described by a 21140 non-MII
(0) block.

tulip0:  Index #2 - Media 10baseT-FDX (#4) described by a 21140 non-MII
(0) block.

tulip0:  Index #3 - Media 100baseTx-FDX (#5) described by a 21140
non-MII (0) block.

eth0: Digital DS21140 Tulip rev 34 at e481a000, 00:00:BC:11:56:D7, IRQ
11.

ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNKC] -> GSI 5 (level, low)
-> IRQ 5

tulip1:  EEPROM default media type Autosense.

tulip1:  Index #0 - Media 10baseT (#0) described by a 21140 non-MII (0)
block.

tulip1:  Index #1 - Media 100baseTx (#3) described by a 21140 non-MII
(0) block.

tulip1:  Index #2 - Media 10baseT-FDX (#4) described by a 21140 non-MII
(0) block.

tulip1:  Index #3 - Media 100baseTx-FDX (#5) described by a 21140
non-MII (0) block.

eth1: Digital DS21140 Tulip rev 34 at e483c000, 00:00:BC:11:56:D6, IRQ
5.

ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10

PCI: setting IRQ 10 as level-triggered

ACPI: PCI Interrupt 0000:02:06.0[A] -> Link [LNKD] -> GSI 10 (level,
low) -> IRQ 10

tulip2:  EEPROM default media type Autosense.

tulip2:  Index #0 - Media 10baseT (#0) described by a 21140 non-MII (0)
block.

tulip2:  Index #1 - Media 100baseTx (#3) described by a 21140 non-MII
(0) block.

tulip2:  Index #2 - Media 10baseT-FDX (#4) described by a 21140 non-MII
(0) block.

tulip2:  Index #3 - Media 100baseTx-FDX (#5) described by a 21140
non-MII (0) block.

eth2: Digital DS21140 Tulip rev 34 at e483e000, 00:00:BC:11:56:D5, IRQ
10.

ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11

ACPI: PCI Interrupt 0000:02:07.0[A] -> Link [LNKA] -> GSI 11 (level,
low) -> IRQ 11

tulip3:  EEPROM default media type Autosense.

tulip3:  Index #0 - Media 10baseT (#0) described by a 21140 non-MII (0)
block.

tulip3:  Index #1 - Media 100baseTx (#3) described by a 21140 non-MII
(0) block.

tulip3:  Index #2 - Media 10baseT-FDX (#4) described by a 21140 non-MII
(0) block.

tulip3:  Index #3 - Media 100baseTx-FDX (#5) described by a 21140
non-MII (0) block.

eth3: Digital DS21140 Tulip rev 34 at e4840000, 00:00:BC:11:56:D4, IRQ
11.

Floppy drive(s): fd0 is 1.44M

USB Universal Host Controller Interface driver v3.0

ACPI: PCI Interrupt 0000:00:07.2[D] -> Link [LNKD] -> GSI 10 (level,
low) -> IRQ 10

uhci_hcd 0000:00:07.2: UHCI Host Controller

uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1

uhci_hcd 0000:00:07.2: irq 10, io base 0x0000c800

usb usb1: configuration #1 chosen from 1 choice

hub 1-0:1.0: USB hub found

hub 1-0:1.0: 2 ports detected

FDC 0 is a post-1991 82077

parport: PnPBIOS parport detected.

parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]

lp0: using parport0 (interrupt-driven).

lp0: console ready

ACPI: Power Button (FF) [PWRF]

ACPI: Power Button (CM) [PWRB]

ibm_acpi: ec object not found

md: Autodetecting RAID arrays.

md: autorun ...

md: ... autorun DONE.

device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised:
dm-devel@redhat.com

EXT3 FS on hda2, internal journal

kjournald starting.  Commit interval 5 seconds

EXT3 FS on hda1, internal journal

EXT3-fs: mounted filesystem with ordered data mode.

SELinux: initialized (dev hda1, type ext3), uses xattr

SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs

Adding 1124540k swap on /dev/hda3.  Priority:-1 extents:1
across:1124540k

SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses
genfs_contexts

audit(1164844962.313:3): avc:  denied  { append } for  pid=3D1557
comm=3D"syslogd" name=3D"messages" dev=3Dhda2 ino=3D163850
scontext=3Dsystem_u:system_r:syslogd_t:s0
tcontext=3Dsystem_u:object_r:root_t:s0 tclass=3Dfile

audit(1164844962.313:4): avc:  denied  { ioctl } for  pid=3D1557
comm=3D"syslogd" name=3D"messages" dev=3Dhda2 ino=3D163850
scontext=3Dsystem_u:system_r:syslogd_t:s0
tcontext=3Dsystem_u:object_r:root_t:s0 tclass=3Dfile

NET: Registered protocol family 10

lo: Disabled Privacy Extensions

ADDRCONF(NETDEV_UP): eth2: link is not ready

IPv6 over IPv4 tunneling driver

SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses
genfs_contexts

SELinux: initialized (dev autofs, type autofs), uses genfs_contexts

ip_tables: (C) 2000-2006 Netfilter Core Team

arp_tables: (C) 2002 David S. Miller

Ebtables v2.0 registered

Netfilter messages via NETLINK v0.30.

ip_conntrack version 2.4 (4607 buckets, 36856 max) - 228 bytes per
conntrack

Bridge firewalling registered

eth3: Promiscuous mode enabled.

device eth3 entered promiscuous mode

audit(1164844969.791:5): dev=3Deth3 prom=3D256 old_prom=3D0 auid=3D42949672=
95

br0: port 1(eth3) entering learning state

audit(1164844970.479:6): avc:  denied  { append } for  pid=3D1557
comm=3D"syslogd" name=3D"messages" dev=3Dhda2 ino=3D163850
scontext=3Dsystem_u:system_r:syslogd_t:s0
tcontext=3Dsystem_u:object_r:root_t:s0 tclass=3Dfile

audit(1164844973.658:7): avc:  denied  { name_bind } for  pid=3D2142
comm=3D"httpd" src=3D563 scontext=3Dsystem_u:system_r:httpd_t:s0
tcontext=3Dsystem_u:object_r:reserved_port_t:s0 tclass=3Dtcp_socket

audit(1164844973.660:8): avc:  denied  { name_bind } for  pid=3D2142
comm=3D"httpd" src=3D143 scontext=3Dsystem_u:system_r:httpd_t:s0
tcontext=3Dsystem_u:object_r:pop_port_t:s0 tclass=3Dtcp_socket

eth3: no IPv6 routers present

eth1: no IPv6 routers present

eth0: no IPv6 routers present

audit(1164844976.694:9): avc:  denied  { write } for  pid=3D2172
comm=3D"smbd" name=3D"krb5.conf" dev=3Dhda2 ino=3D14877755
scontext=3Dsystem_u:system_r:smbd_t:s0 tcontext=3Droot:object_r:etc_t:s0
tclass=3Dfile

tun: Universal TUN/TAP device driver, 1.6

tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>

br0: no IPv6 routers present

audit(1164844980.421:10): avc:  denied  { append } for  pid=3D1557
comm=3D"syslogd" name=3D"messages" dev=3Dhda2 ino=3D163850
scontext=3Dsystem_u:system_r:syslogd_t:s0
tcontext=3Dsystem_u:object_r:root_t:s0 tclass=3Dfile

audit(1164844980.543:11): avc:  denied  { write } for  pid=3D2287
comm=3D"ifconfig" name=3D"openvpn-status1.log" dev=3Dhda2 ino=3D16089668
scontext=3Dsystem_u:system_r:ifconfig_t:s0 tcontext=3Droot:object_r:etc_t:s0
tclass=3Dfile

audit(1164844980.543:12): avc:  denied  { read write } for  pid=3D2287
comm=3D"ifconfig" name=3D"[6565]" dev=3Dsockfs ino=3D6565
scontext=3Dsystem_u:system_r:ifconfig_t:s0
tcontext=3Dsystem_u:system_r:initrc_t:s0 tclass=3Dudp_socket

audit(1164844981.105:13): avc:  denied  { read write } for  pid=3D2333
comm=3D"ifconfig" name=3D"[6688]" dev=3Dsockfs ino=3D6688
scontext=3Dsystem_u:system_r:ifconfig_t:s0
tcontext=3Dsystem_u:system_r:initrc_t:s0 tclass=3Dtcp_socket

br0: topology change detected, propagating

br0: port 1(eth3) entering forwarding state

audit(1164845166.512:14): avc:  denied  { append } for  pid=3D1557
comm=3D"syslogd" name=3D"messages" dev=3Dhda2 ino=3D163850
scontext=3Dsystem_u:system_r:syslogd_t:s0
tcontext=3Dsystem_u:object_r:root_t:s0 tclass=3Dfile

=20

=20

=20


------_=_NextPart_001_01C71416.9220973E
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html DEFANGED_xmlns:o=3D"urn:schemas-microsoft-com:office:office" DEFANGED=
_xmlns:w=3D"urn:schemas-microsoft-com:office:word" DEFANGED_xmlns:st1=3D"ur=
n:schemas-microsoft-com:office:smarttags" DEFANGED_xmlns=3D"http://www.w3.o=
rg/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<DEFANGED_o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:s=
marttags"
 name=3D"City"/>
<DEFANGED_o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:s=
marttags"
 name=3D"PlaceType"/>
<DEFANGED_o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:s=
marttags"
 name=3D"PlaceName"/>
<DEFANGED_o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:s=
marttags"
 name=3D"place"/>
<!--[if !mso]>
<DEFANGED_style=20
st1\:*{behavior:url(#default#ieooui) }
></DEFANGED_style>
<![endif]-->
<DEFANGED_style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
@font-face
	{font-family:"\@MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</DEFANGED_style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">Recently, possibly since the most recent one or two kern=
el
upgrades in Linux Fedora Core 5, my system has been crashing with a kernel
panic. The panic prevents anything useful from being written to any log fil=
es,
but on the crash trace left on the screen each time I always see something
which looks like it is in the bridge code.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">This system is based on Linux Fedora Core 5, and current=
ly
has the following showing up with &#8220;kernel&#8221; in the name in the o=
utput
of &#8220;rpm &#8211;q &#8211;a&#8221;:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">kernel-2.6.18-1.2200.fc5<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">kernel-2.6.18-1.2239.fc5<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">I&#8217;m a bit concerned about the fact that more than =
one
single kernel instance appears in this output! Not sure that I&#8217;ve eve=
r seen
that before&#8230; &#8220;dmesg &#8211;a&#8221; shows that it is the .2239
version of the kernel which is booting.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">The system has 576MB of RAM (dmesg &#8211;a shows 575MB,=
 I
think it shares 1MB with an on-board video module; this thing never runs in
graphics mode anyway). It has a Celeron 766MHz CPU. <o:p></o:p></span></fon=
t></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">I&#8217;ve pasted the output of &#8220;dmesg &#8211;a&#8=
221;
at the bottom of this email, in case it provides any useful diagnostic
information.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">I know this is very little information. I&#8217;m hoping=
 that
what is happening here is an incompatibility between a recent Fedora Core 5
kernel upgrade and the bridge code, and that others have seen it, and someo=
ne
knows a fix / workaround; or that there is some kind of attack going on whi=
ch
is randomly hitting my system and triggering the panic, and, again someone =
has
seen it and has a fix / workaround.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">Thanks very much!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial">-Jay<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Linux version
2.6.18-1.2239.fc5 (brewbuilder@hs20-bc1-7.build.redhat.com) (gcc version 4.=
1.1
20060525 (Red Hat 4.1.1-1)) #1 Fri Nov 10 13:04:06 EST 2006<o:p></o:p></spa=
n></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>BIOS-provided=
 physical RAM
map:<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;BIOS-e8=
20:
0000000000000000 - 000000000009fc00 (usable)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;BIOS-e8=
20: 000000000009fc00
- 00000000000a0000 (reserved)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;BIOS-e8=
20:
00000000000f0000 - 0000000000100000 (reserved)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;BIOS-e8=
20:
0000000000100000 - 0000000023ff0000 (usable)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;BIOS-e8=
20:
0000000023ff0000 - 0000000023ff3000 (ACPI NVS)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;BIOS-e8=
20:
0000000023ff3000 - 0000000024000000 (ACPI data)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;BIOS-e8=
20:
00000000ffff0000 - 0000000100000000 (reserved)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>0MB HIGHMEM a=
vailable.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>575MB LOWMEM =
available.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Using x86 seg=
ment limits to
approximate NX protection<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>On node 0 tot=
alpages: 147440<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp; DMA zo=
ne: 4096 pages,
LIFO batch:0<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp; Normal=
 zone: 143344
pages, LIFO batch:31<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>DMI 2.3 prese=
nt.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>IO/L-APIC dis=
abled because
your old system seems to be old<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>overwrite with
&quot;apic&quot;<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: RSDP (v=
000
ABIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
) @ 0x000f6fd0<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: RSDT (v=
001
ABIT&nbsp;&nbsp; AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x23ff3000<o:p></o:=
p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: FADT (v=
001
ABIT&nbsp;&nbsp; AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x23ff3040<o:p></o:=
p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: DSDT (v=
001
ABIT&nbsp;&nbsp; AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000<o:p></o:=
p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: PM-Time=
r IO Port:
0x4008<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Allocating PC=
I resources
starting at 30000000 (gap: 24000000:dbff0000)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Detected 768.=
433 MHz
processor.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Built 1 zonel=
ists.&nbsp;
Total pages: 147440<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Kernel comman=
d line: ro
root=3DLABEL=3D/1<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>mapped APIC t=
o ffffd000
(01487000)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Enabling fast=
 FPU save and
restore... done.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Enabling unma=
sked SIMD FPU
exception support... done.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Initializing =
CPU#0<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>CPU 0 irqstac=
ks,
hard=3Dc075a000 soft=3Dc0759000<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>PID hash tabl=
e entries: 4096
(order: 12, 16384 bytes)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Console: colo=
ur VGA+ 80x25<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Dentry cache =
hash table
entries: 131072 (order: 7, 524288 bytes)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Inode-cache h=
ash table
entries: 65536 (order: 6, 262144 bytes)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Memory: 57896=
0k/589760k
available (2040k kernel code, 10240k reserved, 798k data, 220k init, 0k
highmem)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Checking if t=
his processor
honours the WP bit even in supervisor mode... Ok.<o:p></o:p></span></font><=
/p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Calibrating d=
elay using
timer specific routine.. 1537.46 BogoMIPS (lpj=3D768733)<o:p></o:p></span><=
/font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Security Fram=
ework v1.0.0
initialized<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux:&nbsp=
; Initializing.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux:&nbsp=
; Starting in
permissive mode<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>selinux_regis=
ter_security:&nbsp;
Registering secondary module capability<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Capability LS=
M initialized
as secondary<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Mount-cache h=
ash table
entries: 512<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>CPU: After ge=
neric identify,
caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000<o:p></=
o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>CPU: After ve=
ndor identify,
caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000<o:p></=
o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>CPU: L1 I cac=
he: 16K, L1 D
cache: 16K<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>CPU: L2 cache=
: 128K<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>CPU: After al=
l inits, caps:
0383f1ff 00000000 00000000 00000040 00000000 00000000 00000000<o:p></o:p></=
span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Intel machine=
 check
architecture supported.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Intel machine=
 check
reporting enabled on CPU#0.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>CPU: Intel Ce=
leron (<DEFANGED_st1:place
w:st=3D"on">Coppermine</DEFANGED_st1:place>) stepping 06<o:p></o:p></span><=
/font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Checking 'hlt'
instruction... OK.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: Core re=
vision 20060707<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: setting=
 ELCR to 0200
(from 0e20)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>checking if i=
mage is
initramfs... it is<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Freeing initr=
d memory: 918k
freed<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>NET: Register=
ed protocol
family 16<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: bus typ=
e pci
registered<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: PCI BIOS=
 revision 2.10
entry at 0xfb3b0, last bus=3D2<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: Using co=
nfiguration
type 1<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Setting up st=
andard PCI
resources<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: Interpr=
eter enabled<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: Using P=
IC for
interrupt routing<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: <DEFANG=
ED_st1:place w:st=3D"on"><DEFANGED_st1:PlaceName
 w:st=3D"on">PCI</DEFANGED_st1:PlaceName> <DEFANGED_st1:PlaceName w:st=3D"o=
n">Root</DEFANGED_st1:PlaceName> <DEFANGED_st1:PlaceType
 w:st=3D"on">Bridge</DEFANGED_st1:PlaceType></DEFANGED_st1:place> [PCI0] (0=
000:00)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: Probing =
PCI hardware
(bus 00)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: Assume =
root bridge
[\_SB_.PCI0] bus is 0<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>* Found PM-Ti=
mer Bug on the
chipset. Due to workarounds for a bug,<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>* this clock =
source is slow.
Consider trying other clock sources<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI quirk: re=
gion 4000-403f
claimed by PIIX4 ACPI<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI quirk: re=
gion 5000-500f
claimed by PIIX4 SMB<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Boot video de=
vice is
0000:00:0f.0<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: PCI Int=
errupt Routing
Table [\_SB_.PCI0._PRT]<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: PCI Int=
errupt Link
[LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: PCI Int=
errupt Link
[LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *9<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: PCI Int=
errupt Link
[LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: PCI Int=
errupt Link
[LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Linux Plug an=
d Play Support
v0.97 (c) Adam Belay<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>pnp: PnP ACPI=
 init<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>pnp: PnP ACPI=
: found 13
devices<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>usbcore: regi=
stered new driver
usbfs<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>usbcore: regi=
stered new
driver hub<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: Using AC=
PI for IRQ
routing<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: If a dev=
ice doesn't
work, try &quot;pci=3Drouteirq&quot;.&nbsp; If it helps, post a report<o:p>=
</o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: Bridge: =
0000:00:01.0<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp; IO win=
dow: disabled.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp; MEM wi=
ndow: disabled.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp; PREFET=
CH window:
disabled.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: Bridge: =
0000:00:0d.0<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp; IO win=
dow: 9000-9fff<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp; MEM wi=
ndow:
d4000000-d5ffffff<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp; PREFET=
CH window:
30000000-300fffff<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>NET: Register=
ed protocol
family 2<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>IP route cach=
e hash table
entries: 32768 (order: 5, 131072 bytes)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>TCP establish=
ed hash table
entries: 131072 (order: 9, 2097152 bytes)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>TCP bind hash=
 table entries:
65536 (order: 8, 1310720 bytes)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>TCP: Hash tab=
les configured
(established 131072 bind 65536)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>TCP <DEFANGED=
_st1:City w:st=3D"on"><DEFANGED_st1:place
 w:st=3D"on">reno</DEFANGED_st1:place></DEFANGED_st1:City> registered<o:p><=
/o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>apm: BIOS ver=
sion 1.2 Flags
0x07 (Driver version 1.16ac)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>apm: overridd=
en by ACPI.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>audit: initia=
lizing netlink
socket (disabled)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>audit(1164826=
911.852:1):
initialized<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Total HugeTLB=
 memory
allocated, 0<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>VFS: Disk quo=
tas dquot_6.5.1<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Dquot-cache h=
ash table
entries: 1024 (order 0, 4096 bytes)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux:&nbsp=
; Registering
netfilter hooks<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Initializing =
Cryptographic
API<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ksign: Instal=
ling public key
data<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Loading keyri=
ng<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>- Added publi=
c key
481F17AAEB289250<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>- User ID: Re=
d Hat, Inc.
(Kernel Module GPG key)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>io scheduler =
noop registered<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>io scheduler =
anticipatory
registered<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>io scheduler =
deadline registered<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>io scheduler =
cfq registered
(default)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Limiting dire=
ct PCI/PCI
transfers.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>pci_hotplug: =
PCI Hot Plug
PCI Core version: 0.5<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: Fan [FA=
N0] (on)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: CPU0 (p=
ower states:
C1[C1] C2[C2])<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: Process=
or [CPU0]
(supports 2 throttling states)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>isapnp: Scann=
ing for PnP
cards...<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>isapnp: No Pl=
ug &amp; Play
device found<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Real Time Clo=
ck Driver
v1.12ac<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Non-volatile =
memory driver
v1.2<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Linux agpgart=
 interface
v0.101 (c) Dave Jones<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>agpgart: Dete=
cted an Intel
440BX Chipset.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>agpgart: AGP =
aperture is 64M
@ 0xd0000000<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Serial: 8250/=
16550 driver
$Revision: 1.90 $ 4 ports, IRQ sharing enabled<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>serial8250: t=
tyS0 at I/O
0x3f8 (irq =3D 4) is a 16550A<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>serial8250: t=
tyS1 at I/O
0x2f8 (irq =3D 3) is a 16550A<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>00:08: ttyS0 =
at I/O 0x3f8
(irq =3D 4) is a 16550A<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>00:09: ttyS1 =
at I/O 0x2f8
(irq =3D 3) is a 16550A<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>RAMDISK drive=
r initialized:
16 RAM disks of 16384K size 4096 blocksize<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Uniform Multi=
-Platform E-IDE
driver Revision: 7.00alpha2<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ide: Assuming=
 33MHz system
bus speed for PIO modes; override with idebus=3Dxx<o:p></o:p></span></font>=
</p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>PIIX4: IDE co=
ntroller at PCI
slot 0000:00:07.1<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>PIIX4: chipse=
t revision 1<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>PIIX4: not 10=
0% native mode:
will probe irqs later<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&=
nbsp; ide0:
BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio<o:p></o:p></span><=
/font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&=
nbsp; ide1:
BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio<o:p></o:p></span><=
/font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Probing IDE i=
nterface
ide0...<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>hda: SAMSUNG =
SP1213N, ATA
DISK drive<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ide0 at 0x1f0=
-0x1f7,0x3f6 on
irq 14<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Probing IDE i=
nterface
ide1...<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>hdc: DVDROM 1=
2X, ATAPI
CD/DVD-ROM drive<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ide1 at 0x170=
-0x177,0x376 on
irq 15<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>HPT374: IDE c=
ontroller at
PCI slot 0000:00:0b.0<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: PCI Int=
errupt Link
[LNKC] enabled at IRQ 5<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: setting =
IRQ 5 as
level-triggered<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: PCI Int=
errupt
0000:00:0b.0[A] -&gt; Link [LNKC] -&gt; GSI 5 (level, low) -&gt; IRQ 5<o:p>=
</o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>HPT374: chips=
et revision 7<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>HPT374: 100% =
native mode on
irq 5<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>HPT37X: using=
 33MHz PCI clock<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&=
nbsp; ide2:
BM-DMA at 0xb000-0xb007, BIOS settings: hde:pio, hdf:pio<o:p></o:p></span><=
/font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>HPT37X: using=
 33MHz PCI
clock<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&=
nbsp; ide3:
BM-DMA at 0xb008-0xb00f, BIOS settings: hdg:pio, hdh:pio<o:p></o:p></span><=
/font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: PCI Int=
errupt
0000:00:0b.1[A] -&gt; Link [LNKC] -&gt; GSI 5 (level, low) -&gt; IRQ 5<o:p>=
</o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>HPT37X: using=
 33MHz PCI
clock<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&=
nbsp; ide4:
BM-DMA at 0xc400-0xc407, BIOS settings: hdi:pio, hdj:pio<o:p></o:p></span><=
/font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>HPT37X: using=
 33MHz PCI
clock<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&=
nbsp; ide5:
BM-DMA at 0xc408-0xc40f, BIOS settings: hdk:pio, hdl:pio<o:p></o:p></span><=
/font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Probing IDE i=
nterface
ide2...<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Probing IDE i=
nterface
ide3...<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Probing IDE i=
nterface
ide4...<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Probing IDE i=
nterface
ide5...<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Probing IDE i=
nterface
ide2...<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Probing IDE i=
nterface
ide3...<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Probing IDE i=
nterface
ide4...<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Probing IDE i=
nterface
ide5...<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>hda: max requ=
est size:
512KiB<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>hda: 23449305=
6 sectors
(120060 MB) w/8192KiB Cache, CHS=3D16383/255/63, UDMA(33)<o:p></o:p></span>=
</font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>hda: cache fl=
ushes supported<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;hda: hd=
a1 hda2 hda3<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ide-floppy dr=
iver
0.99.newide<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>usbcore: regi=
stered new
driver libusual<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>usbcore: regi=
stered new
driver hiddev<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>usbcore: regi=
stered new
driver usbhid<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>drivers/usb/i=
nput/hid-core.c:
v2.6:USB HID core driver<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>PNP: PS/2 Con=
troller
[PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12<o:p></o:p></span></font><=
/p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>serio: i8042 =
AUX port at
0x60,0x64 irq 12<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>serio: i8042 =
KBD port at
0x60,0x64 irq 1<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>mice: PS/2 mo=
use device
common for all mice<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>md: md driver=
 0.90.3
MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>md: bitmap ve=
rsion 4.39<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>TCP bic regis=
tered<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Initializing =
IPsec netlink
socket<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>NET: Register=
ed protocol
family 1<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>NET: Register=
ed protocol
family 17<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Using IPI Sho=
rtcut mode<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Time: tsc clo=
cksource has
been installed.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: (suppor=
ts S0 S1 S4 S5)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Time: acpi_pm=
 clocksource
has been installed.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Freeing unuse=
d kernel
memory: 220k freed<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Write protect=
ing the kernel
read-only data: 377k<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>input: AT Tra=
nslated Set 2
keyboard as /class/input/input0<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>input: ImExPS=
/2 Generic
Explorer Mouse as /class/input/input1<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>EXT3-fs: INFO=
: recovery
required on readonly filesystem.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>EXT3-fs: writ=
e access will
be enabled during recovery.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>kjournald sta=
rting.&nbsp;
Commit interval 5 seconds<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>EXT3-fs: reco=
very complete.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>EXT3-fs: moun=
ted filesystem
with ordered data mode.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>security:&nbs=
p; 3 users, 6
roles, 1481 types, 152 bools, 1 sens, 256 cats<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>security:&nbs=
p; 58 classes,
43474 rules<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux:&nbsp=
; Completing
initialization.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux:&nbsp=
; Setting up
existing superblocks.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux: init=
ialized (dev
hda2, type ext3), uses xattr<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux: init=
ialized (dev
tmpfs, type tmpfs), uses transition SIDs<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux: init=
ialized (dev
debugfs, type debugfs), uses genfs_contexts<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux: init=
ialized (dev
selinuxfs, type selinuxfs), uses genfs_contexts<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux: init=
ialized (dev
mqueue, type mqueue), uses transition SIDs<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux: init=
ialized (dev
hugetlbfs, type hugetlbfs), uses genfs_contexts<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux: init=
ialized (dev
devpts, type devpts), uses transition SIDs<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux: init=
ialized (dev
eventpollfs, type eventpollfs), uses task SIDs<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux: init=
ialized (dev
inotifyfs, type inotifyfs), uses genfs_contexts<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux: init=
ialized (dev
tmpfs, type tmpfs), uses transition SIDs<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux: init=
ialized (dev
futexfs, type futexfs), uses genfs_contexts<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux: init=
ialized (dev
pipefs, type pipefs), uses task SIDs<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux: init=
ialized (dev
sockfs, type sockfs), uses task SIDs<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux: init=
ialized (dev
proc, type proc), uses genfs_contexts<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux: init=
ialized (dev
bdev, type bdev), uses genfs_contexts<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux: init=
ialized (dev
rootfs, type rootfs), uses genfs_contexts<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux: init=
ialized (dev
sysfs, type sysfs), uses genfs_contexts<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>audit(1164826=
922.708:2):
policy loaded auid=3D4294967295<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux: init=
ialized (dev
usbfs, type usbfs), uses genfs_contexts<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>hdc: ATAPI DV=
D-ROM drive,
512kB Cache, UDMA(33)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Uniform CD-RO=
M driver
Revision: 3.20<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>input: PC Spe=
aker as
/class/input/input2<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>piix4_smbus 0=
000:00:07.3:
Found 0000:00:07.3 device<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Linux Tulip d=
river version
1.1.13 (May 11, 2002)<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: PCI Int=
errupt Link
[LNKB] enabled at IRQ 11<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: setting =
IRQ 11 as
level-triggered<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: PCI Int=
errupt
0000:02:04.0[A] -&gt; Link [LNKB] -&gt; GSI 11 (level, low) -&gt; IRQ 11<o:=
p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>tulip0:&nbsp;=
 EEPROM default
media type Autosense.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>tulip0:&nbsp;=
 Index #0 -
Media 10baseT (#0) described by a 21140 non-MII (0) block.<o:p></o:p></span=
></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>tulip0:&nbsp;=
 Index #1 -
Media 100baseTx (#3) described by a 21140 non-MII (0) block.<o:p></o:p></sp=
an></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>tulip0:&nbsp;=
 Index #2 -
Media 10baseT-FDX (#4) described by a 21140 non-MII (0) block.<o:p></o:p></=
span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>tulip0:&nbsp;=
 Index #3 -
Media 100baseTx-FDX (#5) described by a 21140 non-MII (0) block.<o:p></o:p>=
</span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>eth0: Digital=
 DS21140 Tulip
rev 34 at e481a000, 00:00:BC:11:56:D7, IRQ 11.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: PCI Int=
errupt
0000:02:05.0[A] -&gt; Link [LNKC] -&gt; GSI 5 (level, low) -&gt; IRQ 5<o:p>=
</o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>tulip1:&nbsp;=
 EEPROM default
media type Autosense.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>tulip1:&nbsp;=
 Index #0 -
Media 10baseT (#0) described by a 21140 non-MII (0) block.<o:p></o:p></span=
></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>tulip1:&nbsp;=
 Index #1 -
Media 100baseTx (#3) described by a 21140 non-MII (0) block.<o:p></o:p></sp=
an></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>tulip1:&nbsp;=
 Index #2 -
Media 10baseT-FDX (#4) described by a 21140 non-MII (0) block.<o:p></o:p></=
span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>tulip1:&nbsp;=
 Index #3 -
Media 100baseTx-FDX (#5) described by a 21140 non-MII (0) block.<o:p></o:p>=
</span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>eth1: Digital=
 DS21140 Tulip
rev 34 at e483c000, 00:00:BC:11:56:D6, IRQ 5.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: PCI Int=
errupt Link
[LNKD] enabled at IRQ 10<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: setting =
IRQ 10 as
level-triggered<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: PCI Int=
errupt
0000:02:06.0[A] -&gt; Link [LNKD] -&gt; GSI 10 (level, low) -&gt; IRQ 10<o:=
p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>tulip2:&nbsp;=
 EEPROM default
media type Autosense.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>tulip2:&nbsp;=
 Index #0 -
Media 10baseT (#0) described by a 21140 non-MII (0) block.<o:p></o:p></span=
></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>tulip2:&nbsp;=
 Index #1 -
Media 100baseTx (#3) described by a 21140 non-MII (0) block.<o:p></o:p></sp=
an></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>tulip2:&nbsp;=
 Index #2 -
Media 10baseT-FDX (#4) described by a 21140 non-MII (0) block.<o:p></o:p></=
span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>tulip2:&nbsp;=
 Index #3 -
Media 100baseTx-FDX (#5) described by a 21140 non-MII (0) block.<o:p></o:p>=
</span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>eth2: Digital=
 DS21140 Tulip
rev 34 at e483e000, 00:00:BC:11:56:D5, IRQ 10.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: PCI Int=
errupt Link
[LNKA] enabled at IRQ 11<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: PCI Int=
errupt
0000:02:07.0[A] -&gt; Link [LNKA] -&gt; GSI 11 (level, low) -&gt; IRQ 11<o:=
p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>tulip3:&nbsp;=
 EEPROM default
media type Autosense.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>tulip3:&nbsp;=
 Index #0 -
Media 10baseT (#0) described by a 21140 non-MII (0) block.<o:p></o:p></span=
></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>tulip3:&nbsp;=
 Index #1 -
Media 100baseTx (#3) described by a 21140 non-MII (0) block.<o:p></o:p></sp=
an></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>tulip3:&nbsp;=
 Index #2 -
Media 10baseT-FDX (#4) described by a 21140 non-MII (0) block.<o:p></o:p></=
span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>tulip3:&nbsp;=
 Index #3 -
Media 100baseTx-FDX (#5) described by a 21140 non-MII (0) block.<o:p></o:p>=
</span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>eth3: Digital=
 DS21140 Tulip
rev 34 at e4840000, 00:00:BC:11:56:D4, IRQ 11.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Floppy drive(=
s): fd0 is
1.44M<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>USB Universal=
 Host
Controller Interface driver v3.0<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: PCI Int=
errupt
0000:00:07.2[D] -&gt; Link [LNKD] -&gt; GSI 10 (level, low) -&gt; IRQ 10<o:=
p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>uhci_hcd 0000=
:00:07.2: UHCI
Host Controller<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>uhci_hcd 0000=
:00:07.2: new
USB bus registered, assigned bus number 1<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>uhci_hcd 0000=
:00:07.2: irq
10, io base 0x0000c800<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>usb usb1: con=
figuration #1
chosen from 1 choice<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>hub 1-0:1.0: =
USB hub found<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>hub 1-0:1.0: =
2 ports
detected<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>FDC 0 is a po=
st-1991 82077<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>parport: PnPB=
IOS parport
detected.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>parport0: PC-=
style at 0x378,
irq 7 [PCSPP,TRISTATE]<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>lp0: using pa=
rport0
(interrupt-driven).<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>lp0: console =
ready<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: Power B=
utton (FF)
[PWRF]<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ACPI: Power B=
utton (CM)
[PWRB]<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ibm_acpi: ec =
object not
found<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>md: Autodetec=
ting RAID
arrays.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>md: autorun .=
..<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>md: ... autor=
un DONE.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>device-mapper=
: ioctl:
4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com<o:p></o:p></span>=
</font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>EXT3 FS on hd=
a2, internal
journal<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>kjournald sta=
rting.&nbsp;
Commit interval 5 seconds<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>EXT3 FS on hd=
a1, internal
journal<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>EXT3-fs: moun=
ted filesystem
with ordered data mode.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux: init=
ialized (dev
hda1, type ext3), uses xattr<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux: init=
ialized (dev
tmpfs, type tmpfs), uses transition SIDs<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Adding 112454=
0k swap on
/dev/hda3.&nbsp; Priority:-1 extents:1 across:1124540k<o:p></o:p></span></f=
ont></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux: init=
ialized (dev
binfmt_misc, type binfmt_misc), uses genfs_contexts<o:p></o:p></span></font=
></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>audit(1164844=
962.313:3): avc:&nbsp;
denied&nbsp; { append } for&nbsp; pid=3D1557 comm=3D&quot;syslogd&quot;
name=3D&quot;messages&quot; dev=3Dhda2 ino=3D163850
scontext=3Dsystem_u:system_r:syslogd_t:s0 tcontext=3Dsystem_u:object_r:root=
_t:s0
tclass=3Dfile<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>audit(1164844=
962.313:4):
avc:&nbsp; denied&nbsp; { ioctl } for&nbsp; pid=3D1557 comm=3D&quot;syslogd=
&quot; name=3D&quot;messages&quot;
dev=3Dhda2 ino=3D163850 scontext=3Dsystem_u:system_r:syslogd_t:s0
tcontext=3Dsystem_u:object_r:root_t:s0 tclass=3Dfile<o:p></o:p></span></fon=
t></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>NET: Register=
ed protocol
family 10<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>lo: Disabled =
Privacy
Extensions<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ADDRCONF(NETD=
EV_UP): eth2:
link is not ready<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>IPv6 over IPv=
4 tunneling
driver<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux: init=
ialized (dev
rpc_pipefs, type rpc_pipefs), uses genfs_contexts<o:p></o:p></span></font><=
/p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>SELinux: init=
ialized (dev
autofs, type autofs), uses genfs_contexts<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ip_tables: (C=
) 2000-2006
Netfilter Core Team<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>arp_tables: (=
C) 2002 David
S. Miller<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Ebtables v2.0=
 registered<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Netfilter mes=
sages via
NETLINK v0.30.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>ip_conntrack =
version 2.4
(4607 buckets, 36856 max) - 228 bytes per conntrack<o:p></o:p></span></font=
></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>Bridge firewa=
lling
registered<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>eth3: Promisc=
uous mode
enabled.<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>device eth3 e=
ntered
promiscuous mode<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>audit(1164844=
969.791:5):
dev=3Deth3 prom=3D256 old_prom=3D0 auid=3D4294967295<o:p></o:p></span></fon=
t></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>br0: port 1(e=
th3) entering
learning state<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>audit(1164844=
970.479:6):
avc:&nbsp; denied&nbsp; { append } for&nbsp; pid=3D1557 comm=3D&quot;syslog=
d&quot;
name=3D&quot;messages&quot; dev=3Dhda2 ino=3D163850 scontext=3Dsystem_u:sys=
tem_r:syslogd_t:s0
tcontext=3Dsystem_u:object_r:root_t:s0 tclass=3Dfile<o:p></o:p></span></fon=
t></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>audit(1164844=
973.658:7):
avc:&nbsp; denied&nbsp; { name_bind } for&nbsp; pid=3D2142 comm=3D&quot;htt=
pd&quot;
src=3D563 scontext=3Dsystem_u:system_r:httpd_t:s0
tcontext=3Dsystem_u:object_r:reserved_port_t:s0 tclass=3Dtcp_socket<o:p></o=
:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>audit(1164844=
973.660:8):
avc:&nbsp; denied&nbsp; { name_bind } for&nbsp; pid=3D2142 comm=3D&quot;htt=
pd&quot;
src=3D143 scontext=3Dsystem_u:system_r:httpd_t:s0
tcontext=3Dsystem_u:object_r:pop_port_t:s0 tclass=3Dtcp_socket<o:p></o:p></=
span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>eth3: no IPv6=
 routers
present<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>eth1: no IPv6=
 routers
present<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>eth0: no IPv6=
 routers
present<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>audit(1164844=
976.694:9):
avc:&nbsp; denied&nbsp; { write } for&nbsp; pid=3D2172 comm=3D&quot;smbd&qu=
ot;
name=3D&quot;krb5.conf&quot; dev=3Dhda2 ino=3D14877755
scontext=3Dsystem_u:system_r:smbd_t:s0 tcontext=3Droot:object_r:etc_t:s0
tclass=3Dfile<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>tun: Universa=
l TUN/TAP
device driver, 1.6<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>tun: (C) 1999=
-2004 Max
Krasnyansky &lt;maxk@qualcomm.com&gt;<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>br0: no IPv6 =
routers present<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>audit(1164844=
980.421:10):
avc:&nbsp; denied&nbsp; { append } for&nbsp; pid=3D1557 comm=3D&quot;syslog=
d&quot;
name=3D&quot;messages&quot; dev=3Dhda2 ino=3D163850
scontext=3Dsystem_u:system_r:syslogd_t:s0 tcontext=3Dsystem_u:object_r:root=
_t:s0
tclass=3Dfile<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>audit(1164844=
980.543:11):
avc:&nbsp; denied&nbsp; { write } for&nbsp; pid=3D2287 comm=3D&quot;ifconfi=
g&quot;
name=3D&quot;openvpn-status1.log&quot; dev=3Dhda2 ino=3D16089668
scontext=3Dsystem_u:system_r:ifconfig_t:s0 tcontext=3Droot:object_r:etc_t:s0
tclass=3Dfile<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>audit(1164844=
980.543:12):
avc:&nbsp; denied&nbsp; { read write } for&nbsp; pid=3D2287
comm=3D&quot;ifconfig&quot; name=3D&quot;[6565]&quot; dev=3Dsockfs ino=3D65=
65
scontext=3Dsystem_u:system_r:ifconfig_t:s0 tcontext=3Dsystem_u:system_r:ini=
trc_t:s0
tclass=3Dudp_socket<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>audit(1164844=
981.105:13):
avc:&nbsp; denied&nbsp; { read write } for&nbsp; pid=3D2333
comm=3D&quot;ifconfig&quot; name=3D&quot;[6688]&quot; dev=3Dsockfs ino=3D66=
88
scontext=3Dsystem_u:system_r:ifconfig_t:s0 tcontext=3Dsystem_u:system_r:ini=
trc_t:s0
tclass=3Dtcp_socket<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>br0: topology=
 change
detected, propagating<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>br0: port 1(e=
th3) entering
forwarding state<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'>audit(1164845=
166.512:14):
avc:&nbsp; denied&nbsp; { append } for&nbsp; pid=3D1557 comm=3D&quot;syslog=
d&quot;
name=3D&quot;messages&quot; dev=3Dhda2 ino=3D163850
scontext=3Dsystem_u:system_r:syslogd_t:s0 tcontext=3Dsystem_u:object_r:root=
_t:s0
tclass=3Dfile<o:p></o:p></span></font></p>

<p class=3D"MsoNormal" DEFANGED_style=3D"text-autospace:none"><font size=3D=
2 face=3D"Courier New"><span
DEFANGED_style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbsp;</=
o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span DEFANGED_style=3D"fo=
nt-size:10.0pt;
font-family:Arial"><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C71416.9220973E--
