content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Subject: RE: [Bridge] Packets go through the bridge one-way only
Date: Mon, 12 Jul 2004 12:00:24 -0500
Message-ID: <30F5491FC3F68047925F0F51C190BCD701571019@ACDFWMAIL1.acd.de.ittind.com>
From: "Saxer, John -ACDSD" <John.Saxer@itt.com>
Content-Transfer-Encoding: quoted-printable
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org



Thanks for the reply - I had read this part of the FAQ already, but I guess=
 I did not think this was the problem. I am still not sure. I guess if I wa=
s bridging wireless to wireless, I would know this, but it is wireless to w=
ired, and I am sure the wired interface allows me to spoof the source addre=
ss.

Perhaps I just still don't understand what is happening internally. I do ad=
mit that I had hoped to not have to learn the "deep, down, nitty gritty det=
ails" of bridging, and would just be able to use it, but I don't mind - kno=
wledge is good.

How can I determine that the failure is address spoofing? With TCPDUMP, I s=
hould be able to look at the entire packet that arrives from the wireless i=
nterface, and I guess I should be able to go somewhere on the other side of=
 the wired interface and look at it there. Would that show it?

I am guessing that what is supposed to happen is the packet arrives on inte=
rface A, with source address B, is passed to the bridge code, which changes=
 the source address to C, and passes it out interface D. Then, when the rep=
ly arrives on D (because of source address C), the bridge code changes it b=
ack to B and sends it back out A. Correct?

John Saxer


-----Original Message-----
From:	Stephen Hemminger [mailto:shemminger@osdl.org]
Sent:	Mon 7/12/2004 9:48 AM
To:	Saxer, John -ACDSD
Cc:	bridge@lists.osdl.org
Subject:	Re: [Bridge] Packets go through the bridge one-way only
On Mon, 12 Jul 2004 11:34:26 -0500
"Saxer, John -ACDSD" <John.Saxer@itt.com> wrote:

>
> Hello all,
>
> I am new to this list, and to bridging, and am having a problem. Perhaps =
I just don't understand something, am setting it up incorrectly, or just pl=
ain missed something, but I could use some help.
>
> I am using 2 Redhat 7.3 systems to work out the configuration issues for =
a bridge, before transferring all my accumulated knowledge to an embedded s=
ystem. One of the systems has only a wireless card, while the other has a w=
ireless card and a wired interface. The plan is to use the 2nd machine to a=
llow the first to access the wired world.
>
> I followed the directions in setting up a bridge on the 2nd machine, brid=
ging the wireless card and the wired interface. However, even something as =
simple as ping on the first card does not work. I run TCPDUMP on the 2nd ma=
chine, and it reports the "apr-whohas" packets arriving, but either they th=
en don't go out, or the responses get lost, or something.
>
> I can ping the 2nd machine from the first, using the bridge IP address, j=
ust fine. Even telnet works. But only addressing the 2nd machine - everythi=
ng else is a black hole.
>
> Any ideas? What did I do wrong?
>
> Thanks,
>
> John Saxer
> ITT Industries, San Diego

http://bridge.sourceforge.net/faq.html
It doesn't work with my Wireless card!
This is a known problem, and it is not caused by the bridge code. Many wire=
less cards don't allow spoofing of the source address. It is a firmware res=
triction with some chipsets. You might find some information in the bridge =
mailing list archives to help.
Has anyone found a way to get around Wavelan not allowing anything but its =
own MAC address?
(answer by Michael Renzmann (mrenzmann at compulan.de))

Well, for 99% of computer users there will never be a way to get rid of thi=
s. For this function a special firmware is needed. This firmware can be loa=
ded into the RAM of any WaveLAN card, so it could do its job with bridging.=
 But there is no documentation on the interface available to the public. Th=
e only way to achieve this is to have a full version of the hcf library whi=
ch controls every function of the card and also allows accessing the card=
=B4s RAM. To get this full version Lucent wants to know that it will be a f=
inancial win for them, also you have to sign an NDA. So be sure that you wo=
n=B4t most probably get access to this peace of software until Lucent does =
not change its mind in this (which I doubt never will happen).

If you urgently need to have a wireless LAN card which is able to bridge, y=
ou should use one of those having the prism chipset onboard (manufactured b=
y Harris Intersil). There are drivers for those cards available at www.linu=
x-wlan.com (which is the website from Absoval), and I found a mail that say=
s that there is the necessary firmware and an upload tool available for Lin=
ux to the public. If you need additional features of an access point you sh=
ould also talk to Absoval.

I still don't understand!!
(answer by Mark S. Mathews (mark at absoval.com))

Bridging Ethernet (v2 or 802.3) is predicated on the ability of a station t=
o transmit frames with a source address (SA) other than its own. This is po=
ssible because Ethernet uses a 'transmit and forget'/stateless transmission=
 model.

This isn't possible with 'normal' 802.11 station cards and software because=
 802.11 station mode doesn't allow the transmission of frames with 'someone=
 else's source address. The primary reason is that 802.11 is an acknowledge=
d protocol. If you transmit a frame with someone else's source address, the=
 ACK will never come back to you. The ACK will be sent to the station whose=
 source address you used.

There are ways to make it work (that's how I earn a living ;-), but it is n=
ot always straightforward and you probably won't get it right without a pre=
tty solid understanding of 802.11, it's modes, and the frame header format.









************************************
This email and any files transmitted with it are proprietary and intended s=
olely for the use of the individual or entity to whom they are addressed. I=
f you have received this email
in error please notify the sender. Please note that any views or opinions p=
resented in this email are solely those of the author and do not necessaril=
y represent those of ITT Industries, Inc.
The recipient should check this email and any attachments for the presence =
of viruses. ITT Industries accepts no liability for any damage caused by an=
y virus transmitted by this
email.
************************************

