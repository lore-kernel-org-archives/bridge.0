MIME-Version: 1.0
In-Reply-To: <49F8C4C3.9020504@gmail.com>
References: <20090428124009.GA26387@kallisti.us> <49F73E9A.7090706@gmail.com>
	<2e59e6970904281200u44e3ebbfga0f074dfaa78c1ab@mail.gmail.com>
	<49F77248.1050800@gmail.com>
	<2e59e6970904281600u42142392vb8e0eb45c4ede15c@mail.gmail.com>
	<49F87D4E.4060705@gmail.com> <20090429162651.GA9455@kallisti.us>
	<49F882F9.4010100@gmail.com> <20090429165329.GA9893@kallisti.us>
	<49F8C4C3.9020504@gmail.com>
Date: Thu, 30 Apr 2009 04:18:04 +0000
Message-ID: <2e59e6970904292118u71ff441ft19448f753c1b6dd9@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: multipart/alternative; boundary=0015175cdd90856bfc0468bdfb49
Subject: Re: [Bridge] Ubuntu: network bridging between wireless and wired
	connection fails
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
Cc: bridge@lists.linux-foundation.org

--0015175cdd90856bfc0468bdfb49
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Wed, Apr 29, 2009 at 9:21 PM, Jochen Hebbrecht <jochenhebbrecht@gmail.com
> wrote:

>  Ross Vandegrift schreef:
>
> On Wed, Apr 29, 2009 at 06:40:25PM +0200, Jochen Hebbrecht wrote:
>
>
>  Yes, it is plugged in ( Ubuntu says: link is ready ).
> I also tried statically, but no improvements :-( ...
>
>
>  Is your wireless access point also bridging between the wired and the
> wireless?  If so, then you have two bridges circulating packets
> between the wired and wireless networks.
>
>
>  What do you mean with "wireless access point"? My eth1? I think the bridge
> is ok. In one of my previous mails, you see the sniffer logging DHCP
> discovers on eth0 AND eth1
>


That's at the IP stack.  At the firmware level, most wireless cards will
refuse to transmit/receive packets with other MAC addresses, making them
useless for AP or bridging.  Yours is apparently not one of those since
bridging works in Windows (or else the Windows bridge code does transparent
routing w/MAC address replacement, rather like NAT or PAT but working at
layer 2 instead of 3).

That's why I suggested testing for the DHCP discover on a different wireless
node.


>
>  You should either turn on STP so loops can be detected and prevented
> or unplug eth0 to simulate that scenario.
>
>  If I unplug eth0, the situation stays the same. Bridge is ok. But no IP
> received  ...
>

--0015175cdd90856bfc0468bdfb49
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Apr 29, 2009 at 9:21 PM, Jochen =
Hebbrecht <span dir=3D"ltr">&lt;<a href=3D"mailto:jochenhebbrecht@gmail.com=
">jochenhebbrecht@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt=
 0pt 0pt 0.8ex; padding-left: 1ex;">



 =20

<div bgcolor=3D"#ffffff" text=3D"#000000">
Ross Vandegrift schreef:
<div class=3D"im"><blockquote type=3D"cite">
  <pre>On Wed, Apr 29, 2009 at 06:40:25PM +0200, Jochen Hebbrecht wrote:
  </pre>
  <blockquote type=3D"cite">
    <pre>Yes, it is plugged in ( Ubuntu says: link is ready ).
I also tried statically, but no improvements :-( ...
    </pre>
  </blockquote>
  <pre>Is your wireless access point also bridging between the wired and th=
e
wireless?  If so, then you have two bridges circulating packets
between the wired and wireless networks.
  </pre>
</blockquote></div>
What do you mean with &quot;wireless access point&quot;? My eth1? I think t=
he
bridge is ok. In one of my previous mails, you see the sniffer logging
DHCP discovers on eth0 AND eth1</div></blockquote><div><br><br>That&#39;s a=
t the IP stack.=A0 At the firmware level, most wireless cards will refuse t=
o transmit/receive packets with other MAC addresses, making them useless fo=
r AP or bridging.=A0 Yours is apparently not one of those since bridging wo=
rks in Windows (or else the Windows bridge code does transparent routing w/=
MAC address replacement, rather like NAT or PAT but working at layer 2 inst=
ead of 3).<br>
<br>That&#39;s why I suggested testing for the DHCP discover on a different=
 wireless node.<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"bord=
er-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-l=
eft: 1ex;">
<div bgcolor=3D"#ffffff" text=3D"#000000"><div class=3D"im"><br>
<blockquote type=3D"cite">
  <blockquote style=3D"border-left: 2px solid rgb(0, 0, 255); padding-left:=
 5px; margin-left: 5px; margin-right: 0px;">You
should either turn on STP so loops can be detected and prevented<br>
or unplug eth0 to simulate that scenario.</blockquote>
</blockquote></div>
If I unplug eth0, the situation stays the same. Bridge is ok. But no IP
received=A0 ...
</div>

</blockquote></div><br>

--0015175cdd90856bfc0468bdfb49--
