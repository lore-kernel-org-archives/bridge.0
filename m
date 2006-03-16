From: =?iso-8859-1?Q?Ferm=EDn_Gal=E1n_M=E1rquez?= <fermin.galan@cttc.es>
Date: Thu, 16 Mar 2006 19:39:40 +0100
Message-ID: <HIEIIOOHBDMEDPLIJKEFGEKHCAAA.fermin.galan@cttc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] swithing trunk (tagged 802.1q traffic) with brctl
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hello,

My name is Ferm=EDn Gal=E1n and I work as Research Engineer at CTTC, Spain.=
 I'm
trying to configure a bridge with brctl to switch VLAN tagged traffic
(802.1q), but I'm getting some problems.

In particular, I've a physical interface (eth2) connected to a Cisco trunk
port (so, the traffic to/from eth2 is tagged). I've added eth2 to a bridge
('brctl addif somebrige eth2'), but it seems not being working for incoming
traffic ('tcpdump -i eth2' doesn't shows incoming tagged traffic, but the
traffic is being sent from the Cisco -I've checked it with port mirroring in
the Cisco).

I've performed some tests and the behaviour of VLAN in Linux seems to be as
follows: when a tagged packet arrives to the interface, the kernel checks if
there is some matching subinterface (for example, if the packet is tagged
with VLANID=3D200, a eth2.200 is looked for). In that case, the packet is
deliver (untagged) to that interface, otherwise the packet is discarted (so,
it is never arrives to the bridge).

Is that right? (I've asked this question also in the VLAN support list) Is
there some way to change this behaviour (so unmatched tagged packages would
be delivered to the bridge)?

Any information or experience on the topic is very welcome. Thanks in
advance!

Best regards,

--------------------
Ferm=EDn Gal=E1n M=E1rquez
CTTC - Centre Tecnol=F2gic de Telecomunicacions de Catalunya
Parc Mediterrani de la Tecnologia, Av. del Canal Ol=EDmpic s/n, 08860
Castelldefels, Spain
Room 1.02
Tel : +34 93 645 29 12
Fax : +34 93 645 29 01
Email address: fermin.galan@cttc.es

