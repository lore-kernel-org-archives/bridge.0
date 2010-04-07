MIME-Version: 1.0
In-Reply-To: <g2wc5b98f841004061808gc8817c6fj62d89fe4f6810396@mail.gmail.com>
References: <q2x1803dfd21004061402h67b2a920m4b9b1ac2dc66bb2f@mail.gmail.com>
	<l2sc5b98f841004061617s1bb85838k7c1cc7a887646b53@mail.gmail.com>
	<000001cad5e4$fcc81030$f6583090$@com>
	<g2wc5b98f841004061808gc8817c6fj62d89fe4f6810396@mail.gmail.com>
Date: Tue, 6 Apr 2010 22:41:39 -0400
Message-ID: <p2m1803dfd21004061941zfc89ca1fve66f35ec099e8ea6@mail.gmail.com>
From: Ryan Whelan <ryan.whelan@tbamerica.com>
Content-Type: multipart/alternative; boundary=001636c5bc31694e2604839c80b9
Subject: Re: [Bridge] Bridging vSwitches in VMwares ESXi
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--001636c5bc31694e2604839c80b9
Content-Type: text/plain; charset=ISO-8859-1

oh good- glad to find out im not crazy. we do have 2 pNICs in the external
facing vSwitch.  Even when setting them as active/passive, its still an
issue.

so its a confirmed issue with vmware- do they have any intention on
correcting it? do we know?

On Tue, Apr 6, 2010 at 9:08 PM, Robert LeBlanc <robert@leblancnet.us> wrote:

> On Tue, Apr 6, 2010 at 5:57 PM, Ryan King <ryank@globaldial.com> wrote:
>
> > I've also had the exact same issues.  However, if I move one of the vNICs
> to
> > a vSwitch using a different physical nic, then the issue seems to go
> away.
>
> In my experience, as long as you only have on pNIC per vSwitch, it
> works just fine. As soon as you add a second pNIC to the vSwitch, it
> creates a loop and confuses the linux bridge (you can watch the MAC
> bounce between ports if you do a standard ping from one machine and a
> broadcast ping from another machine). We were using Broadcom NICs.
>
>
> Robert LeBlanc
> Life Sciences & Undergraduate Education Computer Support
> Brigham Young University
>
>
> _____________________________________
> This e-mail and any attachments from Toyota Boshoku America
> (TBA), TrimMasters Inc. (TMI), or other affiliated companies may
> contain confidential and privileged information.
>
> If you are not the intended recipient, please notify the sender
> immediately by return e-mail, delete this e-mail and destroy any
> copies.
>
> Any dissemination or use of this information by a person other
> than the intended recipient is unauthorized and may be illegal.
>

--001636c5bc31694e2604839c80b9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

oh good- glad to find out im not crazy. we do have 2 pNICs in the external =
facing vSwitch.=A0 Even when setting them as active/passive, its still an i=
ssue.<br><br>so its a confirmed issue with vmware- do they have any intenti=
on on correcting it? do we know?<br>
<br><div class=3D"gmail_quote">On Tue, Apr 6, 2010 at 9:08 PM, Robert LeBla=
nc <span dir=3D"ltr">&lt;<a href=3D"mailto:robert@leblancnet.us">robert@leb=
lancnet.us</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
<div class=3D"im">On Tue, Apr 6, 2010 at 5:57 PM, Ryan King &lt;<a href=3D"=
mailto:ryank@globaldial.com">ryank@globaldial.com</a>&gt; wrote:<br>
<br>
&gt; I&#39;ve also had the exact same issues. =A0However, if I move one of =
the vNICs to<br>
&gt; a vSwitch using a different physical nic, then the issue seems to go a=
way.<br>
<br>
</div>In my experience, as long as you only have on pNIC per vSwitch, it<br=
>
works just fine. As soon as you add a second pNIC to the vSwitch, it<br>
creates a loop and confuses the linux bridge (you can watch the MAC<br>
bounce between ports if you do a standard ping from one machine and a<br>
broadcast ping from another machine). We were using Broadcom NICs.<br>
<div class=3D"im"><br>
<br>
Robert LeBlanc<br>
Life Sciences &amp; Undergraduate Education Computer Support<br>
Brigham Young University<br>
<br>
<br>
</div><div><div></div><div class=3D"h5">___________________________________=
__<br>
This e-mail and any attachments from Toyota Boshoku America<br>
(TBA), TrimMasters Inc. (TMI), or other affiliated companies may<br>
contain confidential and privileged information.<br>
<br>
If you are not the intended recipient, please notify the sender<br>
immediately by return e-mail, delete this e-mail and destroy any<br>
copies.<br>
<br>
Any dissemination or use of this information by a person other<br>
than the intended recipient is unauthorized and may be illegal.<br>
</div></div></blockquote></div><br>

--001636c5bc31694e2604839c80b9--
