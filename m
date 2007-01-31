Date: Wed, 31 Jan 2007 11:39:44 +1100
From: "Leigh Sharpe" <lsharpe@pacificwireless.com.au>
Message-ID: <H000006900128c81.1170203983.mail.pacificwireless.net.au@MHS>
In-Reply-To: <221D807539D4EF408B4C2A4F3277D76533A7A9@EVS-BOS.campus.unn.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Multiple bridges in one box
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge <bridge@lists.osdl.org>, "udu.ogah" <udu.ogah@unn.ac.uk>

For the first part, yes it is.

Brctl addbr br0
Brctl addif br0 eth0
Brctl addif br0 eth1

Brctl addbr br1
Brctl addif br1 eth2
Brctl addif br1 eth3

Brctl addbr br2
Brctl addif br2 eth4
Brctl addif br2 eth5=20

Etc. etc.=20
Ifconfig br0 up
Ifconfig br1 up
Ifconfig br2 up=20

Etc. etc.=20

Can=92t comment on tun devices, though.
=20


Regards,
             Leigh
=20
Leigh Sharpe
Network Systems Engineer
Pacific Wireless
Ph +61 3 9584 8966
Mob 0408 009 502
email lsharpe@pacificwireless.com.au
web www.pacificwireless.com.au

-----Original Message-----
From: udu.ogah [mailto:udu.ogah@unn.ac.uk]=20
Sent: Wednesday, January 31, 2007 12:37 AM
To: bridge@lists.osdl.org
Subject: [Bridge] Multiple bridges in one box

Hi,

I'm looking at building a box like this and I'm wondering if it's doable.

My box has 13 NiCS made up of 1 onboard NIC and 3 4-port NiCs.
I want to make  bridges consisting say br0(bridging eth0 and eth1),
br1(briding eth2 and eth3), br2(briding eth4 and eth5), and so on.

Secondly can I bridge a tun device with a physical device, say tun0 and eth0
bridged to form br0.


Thanks,


Philologus...


=3D=3D=3D=3D
This e-mail is intended solely for the addressee. It may contain private and
confidential information. If you are not the intended addressee, please take
no action based on it nor show a copy to anyone. Please reply to this e-mail
to highlight the error. You should also be aware that all electronic mail
from, to, or within Northumbria University may be the subject of a request
under the Freedom of Information Act 2000 and related legislation, and
therefore may be required to be disclosed to third parties.
This e-mail and attachments have been scanned for viruses prior to leaving
Northumbria University. Northumbria University will not be liable for any
losses as a result of any viruses being passed on.

_______________________________________________
Bridge mailing list
Bridge@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/bridge


