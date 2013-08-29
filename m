Return-Path: <bernd.lentes@helmholtz-muenchen.de>
From: "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
Date: Thu, 29 Aug 2013 11:22:44 +0200
Message-ID: <15785B7E063D464C86DD482FCAE4EBA5018D1AD3DA16@XCH11.scidom.de>
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] br0: received packet on eth0 with own address as source
	address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Bridge ML (bridge@lists.linux-foundation.org)" <bridge@lists.linux-foundation.org>

Hi,

i have a lot of the following messages in my /var/log/messages:

Aug  7 10:31:42 pc60181 sshd[28126]: Set /proc/self/oom_score_adj to 0
Aug  7 10:31:42 pc60181 sshd[28126]: Connection from 146.107.135.80 port 30=
10
Aug  7 10:31:42 pc60181 sshd[28126]: Did not receive identification string =
from 146.107.135.80
Aug  7 10:33:55 pc60181 sshd[28526]: Set /proc/self/oom_score_adj to 0
Aug  7 10:33:55 pc60181 sshd[28526]: Connection from 146.107.135.80 port 32=
53
Aug  7 10:33:55 pc60181 sshd[28526]: Did not receive identification string =
from 146.107.135.80
Aug  7 10:36:08 pc60181 sshd[28911]: Set /proc/self/oom_score_adj to 0
Aug  7 10:36:08 pc60181 sshd[28911]: Connection from 146.107.135.80 port 36=
52
Aug  7 10:36:08 pc60181 sshd[28911]: Did not receive identification string =
from 146.107.135.80

Aug  7 10:37:32 pc60181 kernel: [2043056.982585] br0: received packet on et=
h0 with own address as source address
Aug  7 10:37:32 pc60181 kernel: [2043057.004204] br0: received packet on et=
h0 with own address as source address
Aug  7 10:37:32 pc60181 kernel: [2043057.035225] br0: received packet on et=
h0 with own address as source address
Aug  7 10:37:32 pc60181 kernel: [2043057.061130] br0: received packet on et=
h0 with own address as source address
Aug  7 10:37:32 pc60181 kernel: [2043057.094108] br0: received packet on et=
h0 with own address as source address
Aug  7 10:37:32 pc60181 kernel: [2043057.115045] br0: received packet on et=
h0 with own address as source address
Aug  7 10:37:32 pc60181 kernel: [2043057.140435] br0: received packet on et=
h0 with own address as source address
Aug  7 10:37:32 pc60181 kernel: [2043057.160983] br0: received packet on et=
h0 with own address as source address
Aug  7 10:37:32 pc60181 kernel: [2043057.187529] br0: received packet on et=
h0 with own address as source address
Aug  7 10:37:37 pc60181 kernel: [2043061.984737] net_ratelimit: 287 callbac=
ks suppressed
Aug  7 10:37:37 pc60181 kernel: [2043061.984741] br0: received packet on et=
h0 with own address as source address
Aug  7 10:37:37 pc60181 kernel: [2043061.995838] br0: received packet on et=
h0 with own address as source address
Aug  7 10:37:37 pc60181 kernel: [2043062.022750] br0: received packet on et=
h0 with own address as source address
Aug  7 10:37:37 pc60181 kernel: [2043062.040748] br0: received packet on et=
h0 with own address as source address
Aug  7 10:37:37 pc60181 kernel: [2043062.055235] br0: received packet on et=
h0 with own address as source address
Aug  7 10:37:37 pc60181 kernel: [2043062.072759] br0: received packet on et=
h0 with own address as source address
Aug  7 10:37:37 pc60181 kernel: [2043062.085984] br0: received packet on et=
h0 with own address as source address
Aug  7 10:37:37 pc60181 kernel: [2043062.100100] br0: received packet on et=
h0 with own address as source address
Aug  7 10:37:37 pc60181 kernel: [2043062.115720] br0: received packet on et=
h0 with own address as source address
Aug  7 10:37:37 pc60181 kernel: [2043062.128400] br0: received packet on et=
h0 with own address as source address
Aug  7 10:37:42 pc60181 kernel: [2043067.008973] net_ratelimit: 301 callbac=
ks suppressed
Aug  7 10:37:42 pc60181 kernel: [2043067.008977] br0: received packet on et=
h0 with own address as source address
Aug  7 10:37:42 pc60181 kernel: [2043067.030616] br0: received packet on et=
h0 with own address as source address
Aug  7 10:37:42 pc60181 kernel: [2043067.059869] br0: received packet on et=
h0 with own address as source address
[...]

Messages appear for about 90 minutes and suddenly stopped.

I have the following network configuration:

pc60181:~ # ifconfig
br0       Link encap:Ethernet  HWaddr 54:04:A6:94:F4:93
          inet addr:10.35.23.36  Bcast:10.35.23.0  Mask:255.255.255.0
          inet6 addr: fe80::5604:a6ff:fe94:f493/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:8087301 errors:0 dropped:196462 overruns:0 frame:0
          TX packets:1329744 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:480312835 (458.0 Mb)  TX bytes:1250573611 (1192.6 Mb)

eth0      Link encap:Ethernet  HWaddr 54:04:A6:94:F4:93
          inet6 addr: fe80::5604:a6ff:fe94:f493/64 Scope:Link
          UP BROADCAST RUNNING PROMISC MULTICAST  MTU:1500  Metric:1
          RX packets:424826060 errors:0 dropped:131484 overruns:0 frame:0
          TX packets:14092606 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:79356560631 (75680.3 Mb)  TX bytes:5338070565 (5090.7 Mb=
)
          Interrupt:58 Base address:0x6000

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:3773045 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3773045 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:3030507414 (2890.1 Mb)  TX bytes:3030507414 (2890.1 Mb)

vnet0     Link encap:Ethernet  HWaddr FE:54:00:37:92:A0
          inet6 addr: fe80::fc54:ff:fe37:92a0/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:81891 errors:0 dropped:0 overruns:0 frame:0
          TX packets:7394846 errors:0 dropped:0 overruns:6 carrier:0
          collisions:0 txqueuelen:500
          RX bytes:7477407 (7.1 Mb)  TX bytes:536978695 (512.1 Mb)

pc60181:~ # brctl show
bridge name     bridge id               STP enabled     interfaces
br0             8000.5404a694f493       no              eth0
                                                        vnet0

The bridge is used to connect a KVM VM network adapter to the one of the ho=
st.
Host is a SLES 11 SP2 64bit. Guest also.

What is the reason for this message ? I can't remember if i had a loss of c=
onnectivity for that host/vm, because i realised the message some days afte=
r the error appeared.

Any ideas ?

I have now tcpdump running to see the exact packets if the error reappears.


Bernd





--
Bernd Lentes

Systemadministration
Institut f=FCr Entwicklungsgenetik
Geb=E4ude 35.34 - Raum 208
HelmholtzZentrum m=FCnchen
bernd.lentes@helmholtz-muenchen.de
phone: +49 89 3187 1241
fax:   +49 89 3187 2294
http://www.helmholtz-muenchen.de/idg

Wie kann man etwas beherrschen ohne zu lernen ?
Wie kann man etwas lernen ohne Fehler zu machen ?

Helmholtz Zentrum M=FCnchen
Deutsches Forschungszentrum f=FCr Gesundheit und Umwelt (GmbH)
Ingolst=E4dter Landstr. 1
85764 Neuherberg
www.helmholtz-muenchen.de
Aufsichtsratsvorsitzende: MinDir=B4in B=E4rbel Brumme-Bothe
Gesch=E4ftsf=FChrer: Prof. Dr. G=FCnther Wess Dr. Nikolaus Blum Dr. Alfons =
Enhsen
Registergericht: Amtsgericht M=FCnchen HRB 6466
USt-IdNr: DE 129521671
