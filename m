Return-Path: <giometti@enneenne.com>
Date: Fri, 12 Oct 2012 11:37:00 +0200
From: Rodolfo Giometti <giometti@enneenne.com>
Sender: giometti@enneenne.com
Message-ID: <20121012093659.GB14293@enneenne.com>
References: <20121009142337.GO28136@enneenne.com>
	<201210091842.36717.vitas@nppfactor.kiev.ua>
	<20121009155800.GR28136@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20121009155800.GR28136@enneenne.com>
Subject: Re: [Bridge] MSTPd in RSTP mode is sometimes slow...
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vitalii Demianets <vitas@nppfactor.kiev.ua>
Cc: bridge@lists.linux-foundation.org

On Tue, Oct 09, 2012 at 05:58:01PM +0200, Rodolfo Giometti wrote:
> On Tue, Oct 09, 2012 at 06:42:36PM +0300, Vitalii Demianets wrote:
> > Hello, Rodolfo!
> >=20
> > Please, describe your setup: how many devices do you have and how exact=
ly are=20
> > they connected?=20
>=20
> ASCII Art:
>=20
>   +------------+
>   | my machine |----+
>   +------------+    |
>     |             +------------+
>     |             |            |
>     |             +------------+
>   +------------+    |
>   |    root    |----+ <----[A]
>   +------------+
>=20
> The "Event" is: the ring is opened in [A]

Here another useful packets dump!

As you can see, when the Event occours, I see:

11:10:32.775132 STP 802.1w, Rapid STP, Flags [Proposal], bridge-id 8000.00:=
0a:dc:5a:f6:80.800d, length 43
		message-age 0.00s, max-age 20.00s, hello-time 2.00s, forwarding-delay 16.=
00s
		root-id 8000.00:0a:dc:5a:f6:80, root-pathcost 0, port-role Designated
		0x0000:  0180 c200 0000 000a dc5a f68d 0027 4242  .........Z...'BB
		0x0010:  0300 0002 020e 8000 000a dc5a f680 0000  ...........Z....
		0x0020:  0000 8000 000a dc5a f680 800d 0000 1400  .......Z........
		0x0030:  0200 1000 0031 3030 4e43 2d52            .....100NC-R

Here the other bridge says to my machine: =ABEhi! Something happens. Can
I be the new root?=BB

11:10:34.107952 STP 802.1w, Rapid STP, Flags [Proposal], bridge-id 8000.00:=
02:3e:99:f5:01.8001, length 43
		message-age 1.00s, max-age 20.00s, hello-time 2.00s, forwarding-delay 16.=
00s
		root-id 5000.00:0a:dc:5a:e5:20, root-pathcost 200000, port-role Designated
		0x0000:  0180 c200 0000 0002 3e99 f501 0027 4242  ........>....'BB
		0x0010:  0300 0002 020e 5000 000a dc5a e520 0003  ......P....Z....
		0x0020:  0d40 8000 0002 3e99 f501 8001 0100 1400  .@....>.........
		0x0030:  0200 1000 0000 0000 0000 0000            ............

But my machine answers after ~1.3s! :'(

__This__ is a very loooong delay...

Here the internal state machine evolution:

1038910509.154586: MSTP_IN_rx_bpdu: br0:mrvl4 received RST BPDU
1038910509.186205: PISM_to_RECEIVE: br0:mrvl4:0=20
1038910509.190962: PISM_to_SUPERIOR_DESIGNATED: br0:mrvl4:0=20
1038910509.195441: PISM_to_CURRENT: br0:mrvl4:0=20
1038910509.290554: bridge_bpdu_rcv: ifindex 7, len 60
1038910509.293467: MSTP_IN_rx_bpdu: br0:mrvl5 received RST BPDU
1038910509.325087: PISM_to_UPDATE: br0:mrvl4:0=20
1038910509.329836: PISM_to_CURRENT: br0:mrvl4:0=20
1038910509.334226: PISM_to_RECEIVE: br0:mrvl5:0=20
1038910509.338713: PISM_to_SUPERIOR_DESIGNATED: br0:mrvl5:0=20
1038910509.343204: PISM_to_CURRENT: br0:mrvl5:0=20
1038910509.484400: PISM_to_UPDATE: br0:mrvl4:0=20
1038910509.489145: PISM_to_CURRENT: br0:mrvl4:0=20
1038910510.479677: MSTP_OUT_tx_bpdu: br0:mrvl4 sending RST BPDU
1038910510.504499: MSTP_OUT_set_state: br0:mrvl4:0 entering learning state
1038910510.512247: set_port_role: port mrvl4 role 3
1038910510.525581: bridge_bpdu_rcv: ifindex 6, len 60
1038910510.530389: MSTP_IN_rx_bpdu: br0:mrvl4 received RST BPDU
1038910510.564881: PISM_to_RECEIVE: br0:mrvl4:0=20
1038910510.569636: PISM_to_NOT_DESIGNATED: br0:mrvl4:0=20
1038910510.574111: PISM_to_CURRENT: br0:mrvl4:0=20
1038910510.593195: MSTP_OUT_set_state: br0:mrvl4:0 entering forwarding state

As you can see we receive the first BPDU at 1038910509.154586 and only
after ~1.3s we send our reply at 1038910510.479677

Why we need all this state transitions?

1038910509.154586: MSTP_IN_rx_bpdu: br0:mrvl4 received RST BPDU
1038910509.186205: PISM_to_RECEIVE: br0:mrvl4:0
1038910509.190962: PISM_to_SUPERIOR_DESIGNATED: br0:mrvl4:0
1038910509.195441: PISM_to_CURRENT: br0:mrvl4:0
1038910509.325087: PISM_to_UPDATE: br0:mrvl4:0
1038910509.329836: PISM_to_CURRENT: br0:mrvl4:0
1038910509.484400: PISM_to_UPDATE: br0:mrvl4:0
1038910509.489145: PISM_to_CURRENT: br0:mrvl4:0
1038910510.479677: MSTP_OUT_tx_bpdu: br0:mrvl4 sending RST BPDU

Thanks in advance,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
