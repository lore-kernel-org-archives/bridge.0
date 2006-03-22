From: =?utf-8?Q?Ferm=C3=ADn_Gal=C3=A1n_M=C3=A1rquez?= <fermin.galan@cttc.es>
Date: Wed, 22 Mar 2006 09:50:23 +0100
Message-ID: <HIEIIOOHBDMEDPLIJKEFGELACAAA.fermin.galan@cttc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <441D6E5D.50905@artcom.pl>
Content-Transfer-Encoding: 8bit
Subject: [Bridge] RE: Bridge Digest, Vol 31, Issue 6
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Pawel Staszewski <pstaszewski@artcom.pl>, bridge@lists.osdl.org

Dear Pawel,

We have been discussing the issue recently in the VLAN mailing list (http://www.lanforge.com/pipermail/vlan/2006-March/000618.html) and, finally, the problem seemed related with hardware VLAN acceleration in the network card driver (e1000).

Anyway, thanks for your interest! :)

Best regards,

--------------------
Fermn Gal n Mrquez
CTTC - Centre Tecnol gic de Telecomunicacions de Catalunya
Parc Mediterrani de la Tecnologia, Av. del Canal Olmpic s/n, 08860 Castelldefels, Spain
Room 1.02
Tel : +34 93 645 29 12 
Fax : +34 93 645 29 01
Email address: fermin.galan@cttc.es 

-----Mensaje original-----
De: Pawel Staszewski [mailto:pstaszewski@artcom.pl]
Enviado el: domingo, 19 de marzo de 2006 15:45
Para: bridge@lists.osdl.org; fermin.galan@cttc.es
Asunto: Re: Bridge Digest, Vol 31, Issue 6


Hello


You must add first:

vlan (tagged) to eth2

eth2 interface is not tagged by default and not know vlan-s .
It is like a cisco if you have 24 ports in cisco by default all ports 
are in vlan1. if you want to do trunk (with vlans) you myst add (vlans) 
to this ports (tagged or untagged)


So you can compare that all interfaces in linux by default are in one 
vlan(but not tagged). (only for compare)


So :

ifconfig eth2 up
vconfig  add eth2  <vlan_id>

brctl addbr br0
brctl addif br0 eth2.<vlan_id>
brctl addif br0 <another interface>




bridge-request@lists.osdl.org wrote:

>Send Bridge mailing list submissions to
>	bridge@lists.osdl.org
>
>To subscribe or unsubscribe via the World Wide Web, visit
>	https://lists.osdl.org/mailman/listinfo/bridge
>or, via email, send a message with subject or body 'help' to
>	bridge-request@lists.osdl.org
>
>You can reach the person managing the list at
>	bridge-owner@lists.osdl.org
>
>When replying, please edit your Subject line so it is more specific
>than "Re: Contents of Bridge digest..."
>
>
>Today's Topics:
>
>   1. swithing trunk (tagged 802.1q traffic) with brctl
>      (Fermín Galán Márquez)
>
>
>----------------------------------------------------------------------
>
>Message: 1
>Date: Thu, 16 Mar 2006 19:39:40 +0100
>From: Fermín Galán Márquez <fermin.galan@cttc.es>
>Subject: [Bridge] swithing trunk (tagged 802.1q traffic) with brctl
>To: <bridge@lists.osdl.org>
>Message-ID: <HIEIIOOHBDMEDPLIJKEFGEKHCAAA.fermin.galan@cttc.es>
>Content-Type: text/plain;	charset="iso-8859-1"
>
>Hello,
>
>My name is Fermín Galán and I work as Research Engineer at CTTC, Spain. I'm
>trying to configure a bridge with brctl to switch VLAN tagged traffic
>(802.1q), but I'm getting some problems.
>
>In particular, I've a physical interface (eth2) connected to a Cisco trunk
>port (so, the traffic to/from eth2 is tagged). I've added eth2 to a bridge
>('brctl addif somebrige eth2'), but it seems not being working for incoming
>traffic ('tcpdump -i eth2' doesn't shows incoming tagged traffic, but the
>traffic is being sent from the Cisco -I've checked it with port mirroring in
>the Cisco).
>
>I've performed some tests and the behaviour of VLAN in Linux seems to be as
>follows: when a tagged packet arrives to the interface, the kernel checks if
>there is some matching subinterface (for example, if the packet is tagged
>with VLANID=200, a eth2.200 is looked for). In that case, the packet is
>deliver (untagged) to that interface, otherwise the packet is discarted (so,
>it is never arrives to the bridge).
>
>Is that right? (I've asked this question also in the VLAN support list) Is
>there some way to change this behaviour (so unmatched tagged packages would
>be delivered to the bridge)?
>
>Any information or experience on the topic is very welcome. Thanks in
>advance!
>
>Best regards,
>
>--------------------
>Fermín Galán Márquez
>CTTC - Centre Tecnològic de Telecomunicacions de Catalunya
>Parc Mediterrani de la Tecnologia, Av. del Canal Olímpic s/n, 08860
>Castelldefels, Spain
>Room 1.02
>Tel : +34 93 645 29 12
>Fax : +34 93 645 29 01
>Email address: fermin.galan@cttc.es


