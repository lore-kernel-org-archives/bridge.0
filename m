Message-ID: <481597F3.6060400@sneakemail.com>
Date: Mon, 28 Apr 2008 11:25:07 +0200
From: =?ISO-8859-1?Q?=22Peter_Valdemar_M=F8rch_=28Lists=29=22?=
	<4ux6as402@sneakemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Ethernet+Wireless Bridge?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,

Sorry for posting again, but I must have been asking the wrong question.

How do I get a bridge with an ethernet and a wireless interface to work?

I see many HOWTOs on the internet using brctl and ifconfig doing what I=20
would do with two ethernet interfaces, but I simply have not been
successful using my wireless interface with the ipw3945 driver. Is that=20
because of the hardware+driver or is there some magic I'm missing (apart=20
from parprouted or iptables, which does work but is not what I want) ?

http://www.linux-foundation.org/en/Net:Bridge#It_doesn.27t_work_with_my_Wir=
eless_card.21
tells me to expect this.

It says:
> FAQ 7.16: It doesn't work with my Wireless card!
>=20
> This is a known problem, and it is not caused by the bridge code.
> Many wireless cards don't allow spoofing of the source address. It is
> a firmware restriction with some chipsets. You might find some
> information in the bridge mailing list archives to help.

... HELP! Are the HOWTOs wrong, or is the above FAQ info wrong?

What cards can I buy that are not part of "many wireless cards"? I=20
prefer USB hardware but I don't know what to buy.

I got two responses to my last post:
https://lists.linux-foundation.org/pipermail/bridge/2008-April/005797.html
One to use brctl (which doesn't work for me!) and one to run my linux=20
bridge under VMware on a windows host (which is not what I want).

I'm wondering about the lack of answers. Am I asking a stupid question?=20
Is there any obvious reading I haven't done? Even an answer like "Forget=20
it. You'll never get a ethernet/wireless bridge to work under Linux. The=20
FAQ should be changed from 'many' to 'all'." would also be helpful, as I=20
would stop trying and stop posting! :D

Peter
--=20
Peter Valdemar M=F8rch
http://www.morch.com
