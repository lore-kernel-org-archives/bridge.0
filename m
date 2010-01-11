MIME-Version: 1.0
In-Reply-To: <20100111101848.38fad04f@nehalam>
References: <0B4BAD7651DDBF4CB463FDBCA36C673F108C64BE@EXCHANGE.claremont.globaldial.com>
	<20100111101848.38fad04f@nehalam>
Date: Mon, 11 Jan 2010 11:42:36 -0700
Message-ID: <c5b98f841001111042v60fc788nf98e184ae7aea7b5@mail.gmail.com>
From: Robert LeBlanc <robert@leblancnet.us>
Content-Type: multipart/alternative; boundary=0016367b6b06b25f7d047ce7e60f
Subject: Re: [Bridge] MAC intermittently being learnt on wrong port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Ryan King <ryank@staff.globaldial.com>

--0016367b6b06b25f7d047ce7e60f
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Jan 11, 2010 at 11:18 AM, Stephen Hemminger <
shemminger@linux-foundation.org> wrote:

> On Fri, 8 Jan 2010 03:25:10 +0000
> Ryan King <ryank@staff.globaldial.com> wrote:
>
> > Hi,
> >
> > I am seeing a strange issue with a fairly simple bridge I have setup (for
> openvpn in bridge mode).
> >
> > eth0 ---  [ openvpn machine  (tap0) ] --- eth1
> >
> > The bridge is between tap0 and eth1 on a debian machine running on ESX 4.
>  (tap0 being the openvpn tunnel interface).  Intermittently, I see openvpn
> client MAC addresses on port 2 (eth1).  When this happens, their vpn link
> stops working, since arp replies are being sent back via the wrong
> interface.  But after a random amount of time, it will change back to port 1
> (tap0) and start working again.  Sometimes this is quick, sometimes it
> doesn't happen for hours.
> >
> > Anyone else had these issues?  I've searched the archives, and come
> across several people who seem to have had similar problems - but haven't
> found one that has a solution yet.
> >
> > I'd appreciate any suggestions on where I should start looking to find
> out why/how these MAC's are being learnt on the wrong interface...
> >
>
> By default the address of the bridge interface is the minimum of all the
> interfaces,
> and the tap one is generated randomly; that might be your problem.
> So either:
>   1. force a specific MAC address on the tap interface
> or 2. force the the MAC address of the bridge interface to be that of eth
>
>
I'm seeing the same problem on a static bridge (no tap) with the MAC address
set to locally administrated MACs. I sent the e-mail to the list on Friday.
This is a good thought, but I don't believe it is the issue.

Robert LeBlanc
Life Sciences & Undergraduate Education Computer Support
Brigham Young University

--0016367b6b06b25f7d047ce7e60f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 11, 2010 at 11:18 AM, Stephen Hemminger <span dir=3D"ltr">&lt;<=
a href=3D"mailto:shemminger@linux-foundation.org">shemminger@linux-foundati=
on.org</a>&gt;</span> wrote:<br><div class=3D"gmail_quote"><blockquote clas=
s=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margi=
n: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Fri, 8 Jan 2010 03:25:10 +0000<br>
<div class=3D"im">Ryan King &lt;<a href=3D"mailto:ryank@staff.globaldial.co=
m">ryank@staff.globaldial.com</a>&gt; wrote:<br>
<br>
</div><div class=3D"im">&gt; Hi,<br>
&gt;<br>
&gt; I am seeing a strange issue with a fairly simple bridge I have setup (=
for openvpn in bridge mode).<br>
&gt;<br>
&gt; eth0 --- =A0[ openvpn machine =A0(tap0) ] --- eth1<br>
&gt;<br>
&gt; The bridge is between tap0 and eth1 on a debian machine running on ESX=
 4. =A0(tap0 being the openvpn tunnel interface). =A0Intermittently, I see =
openvpn client MAC addresses on port 2 (eth1). =A0When this happens, their =
vpn link stops working, since arp replies are being sent back via the wrong=
 interface. =A0But after a random amount of time, it will change back to po=
rt 1 (tap0) and start working again. =A0Sometimes this is quick, sometimes =
it doesn&#39;t happen for hours.<br>

&gt;<br>
&gt; Anyone else had these issues? =A0I&#39;ve searched the archives, and c=
ome across several people who seem to have had similar problems - but haven=
&#39;t found one that has a solution yet.<br>
&gt;<br>
&gt; I&#39;d appreciate any suggestions on where I should start looking to =
find out why/how these MAC&#39;s are being learnt on the wrong interface...=
<br>
&gt;<br>
<br>
</div>By default the address of the bridge interface is the minimum of all =
the interfaces,<br>
and the tap one is generated randomly; that might be your problem.<br>
So either:<br>
 =A0 1. force a specific MAC address on the tap interface<br>
or 2. force the the MAC address of the bridge interface to be that of eth<b=
r>
<br></blockquote><div><br>I&#39;m seeing the same problem on a static bridg=
e (no tap) with the MAC address set to locally administrated MACs. I sent t=
he e-mail to the list on Friday. This is a good thought, but I don&#39;t be=
lieve it is the issue.<br clear=3D"all">
<br>Robert LeBlanc<br>Life Sciences &amp; Undergraduate Education Computer =
Support<br>Brigham Young University<br>=A0
<br></div></div><br>

--0016367b6b06b25f7d047ce7e60f--
