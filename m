From: Friedrich Dominicus <frido@q-software-solutions.de>
Date: Tue, 24 Jun 2008 16:11:36 +0200
Message-ID: <87skv27wiv.fsf@q-software-solutions.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Bridge troubles
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

I'm sorry to bother you but I'm stuck

I can not make a bridge work for me.=20
My current configuration is:
eth0      Link encap:Ethernet  Hardware Adresse 00:1d:7d:d1:06:bd=20=20
          inet Adresse:192.168.1.1  Bcast:192.168.1.255  Maske:255.255.255.0
          inet6-Adresse: fe80::21d:7dff:fed1:6bd/64
G=FCltigkeitsbereich:V

according to all what I could find in the net. The following should do
to build a bridge=20
ifconfig eth0 down
# brctl addbr br0
# addif br0 eth0
# ifconfig eth0 0.0.0.0 up
# ifconfig  br0 192.168.1.1 up

Ok now let's see


 brctl show
bridge name	bridge id		STP enabled	interfaces
br0		8000.001d7dd106bd	no		eth0

looks fine to me

then=20
 ifconfig br0=20
br0       Link encap:Ethernet  Hardware Adresse 00:1d:7d:d1:06:bd=20=20
          inet Adresse:192.168.1.1  Bcast:192.168.1.255  Maske:255.255.255.0
          inet6-Adresse: fe80::21d:7dff:fed1:6bd/64 G=FCltigkeitsbereich:Ve=
rbindung
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metrik:1
          RX packets:1 errors:0 dropped:0 overruns:0 frame:0
          TX packets:23 errors:0 dropped:0 overruns:0 carrier:0
          Kollisionen:0 Sendewarteschlangenl=E4nge:0=20
          RX bytes:192 (192.0 B)  TX bytes:4420 (4.3 KiB)
looks also fine to me

but then:
 ping 192.168.1.10
PING 192.168.1.10 (192.168.1.10) 56(84) bytes of data.
ping: sendmsg: Operation not permitted
ping: sendmsg: Operation not permitted
ping: sendmsg: Operation not permitted

I can not make any sens why ping can fail.
so either I misread all the docs or something is foul.

Do you have any suggestions?

System Intel Dual Core=20

uname -a
Linux fvl 2.6.22=20

Debian Unstable

 cat cpuinfo=20
processor       : 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 15
model name	: Intel(R) Core(TM)2 Duo CPU     E6550  @ 2.33GHz
stepping	: 11
cpu MHz		: 2333.332
cache size	: 4096 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall nx lm constant_ts=
c pni monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr lahf_lm
bogomips	: 4669.83
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 15
model name	: Intel(R) Core(TM)2 Duo CPU     E6550  @ 2.33GHz
stepping	: 11
cpu MHz		: 2333.332
cache size	: 4096 KB
physical id	: 0
siblings	: 2
core id		: 1
cpu cores	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall nx lm constant_ts=
c pni monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr lahf_lm
bogomips	: 4666.76
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

 lsmod | grep bridge
bridge                 62248  0=20


I can not see anything obviously wrong with this simple tries, but
still it won't work....

Any hints are very welcome

Regards
Friedrich
