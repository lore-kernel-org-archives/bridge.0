Message-ID: <441D6E5D.50905@artcom.pl>
Date: Sun, 19 Mar 2006 15:44:45 +0100
From: =?UTF-8?B?UGF3ZcWCIFN0YXN6ZXdza2k=?= <pstaszewski@artcom.pl>
MIME-Version: 1.0
References: <200603162000.k2GK06Db004082@smtp.osdl.org>
In-Reply-To: <200603162000.k2GK06Db004082@smtp.osdl.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Re: Bridge Digest, Vol 31, Issue 6
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org, fermin.galan@cttc.es

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
>
>
>------------------------------
>
>_______________________________________________
>Bridge mailing list
>Bridge@lists.osdl.org
>https://lists.osdl.org/mailman/listinfo/bridge
>
>
>End of Bridge Digest, Vol 31, Issue 6
>*************************************
>  
>
>------------------------------------------------------------------------
>
>Spam detection software, running on the system "fire-2.osdl.org", has
>identified this incoming email as possible spam.  The original message
>has been attached to this so you can view it (if it isn't spam) or block
>similar future email.  If you have any questions, see
>the administrator of that system for details.
>
>Content preview:  Send Bridge mailing list submissions to
>  bridge@lists.osdl.org To subscribe or unsubscribe via the World Wide
>  Web, visit https://lists.osdl.org/mailman/listinfo/bridge or, via
>  email, send a message with subject or body 'help' to
>  bridge-request@lists.osdl.org [...] 
>
>Content analysis details:   (6.3 points, 5.0 required)
>
> pts rule name              description
>---- ---------------------- --------------------------------------------------
> 1.5 DATE_MISSING           Missing Date: header
> 1.1 NO_REAL_NAME           From: does not include a real name
> 3.7 MSGID_FROM_MTA_SHORT   Message-Id was added by a relay
>
>
>  
>

