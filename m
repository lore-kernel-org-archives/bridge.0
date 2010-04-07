MIME-Version: 1.0
In-Reply-To: <n2hc5b98f841004062001ie80b2130ma08829633315c3c@mail.gmail.com>
References: <q2x1803dfd21004061402h67b2a920m4b9b1ac2dc66bb2f@mail.gmail.com>
	<l2sc5b98f841004061617s1bb85838k7c1cc7a887646b53@mail.gmail.com>
	<000001cad5e4$fcc81030$f6583090$@com>
	<g2wc5b98f841004061808gc8817c6fj62d89fe4f6810396@mail.gmail.com>
	<p2m1803dfd21004061941zfc89ca1fve66f35ec099e8ea6@mail.gmail.com>
	<n2hc5b98f841004062001ie80b2130ma08829633315c3c@mail.gmail.com>
Date: Wed, 7 Apr 2010 09:08:56 -0400
Message-ID: <q2s1803dfd21004070608w1caaa12bh7721c76fe1991c21@mail.gmail.com>
From: Ryan Whelan <ryan.whelan@tbamerica.com>
Content-Type: multipart/alternative; boundary=001485e7c950c015840483a54314
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

--001485e7c950c015840483a54314
Content-Type: text/plain; charset=ISO-8859-1

it seems the fix for this would be for vmware to do a better job 'fencing'
the secondary pNIC when in an active/passive setup

im really disappointed to find out this isn't an issue i can work around
(without compromising redundancy, or replacing the vSwitch etc)

On Tue, Apr 6, 2010 at 11:01 PM, Robert LeBlanc <robert@leblancnet.us>wrote:

> On Tue, Apr 6, 2010 at 8:41 PM, Ryan Whelan <ryan.whelan@tbamerica.com>
> wrote:
> > oh good- glad to find out im not crazy. we do have 2 pNICs in the
> external
> > facing vSwitch.  Even when setting them as active/passive, its still an
> > issue.
> >
> > so its a confirmed issue with vmware- do they have any intention on
> > correcting it? do we know?
> >
>
> Yes as long as the pNIC is attached, even if in standby mode it causes
> a problem.
>
> It is an issue, but they won't fix it for two reasons. 1. They will
> never create a bridge between two vSwitches/VLANs, and 2. a fix would
> introduce more overhead and reduce flexibility and since they adhere
> to #1, it doesn't make sense. The flexibility they lose is multiple
> pNICs to one or more switches without having to have any trunking
> protocols.
>
> You can get around the problem by buying the Cisco Nexus virtual
> switch, it's a real layer 3 switch, but it's a pricy option.
>
> If you want a bridge in a VM, then only pNIC per switch (no
> redundancy). The other option, try to make the bridge a router
> instead. For us we wanted a transparent firewall, so it was easy to
> change the configuration to proxyarp for a transparent router instead.
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

--001485e7c950c015840483a54314
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

it seems the fix for this would be for vmware to do a better job &#39;fenci=
ng&#39; the=A0secondary pNIC when in an active/passive setup<div><br></div>=
<div>im really=A0disappointed=A0to find out this isn&#39;t an issue i can w=
ork around (without compromising redundancy, or replacing the vSwitch etc)<=
br>
<br><div class=3D"gmail_quote">On Tue, Apr 6, 2010 at 11:01 PM, Robert LeBl=
anc <span dir=3D"ltr">&lt;<a href=3D"mailto:robert@leblancnet.us">robert@le=
blancnet.us</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im">On Tue, Apr 6, 2010 at 8:41 PM, Ryan Whelan &lt;<a href=
=3D"mailto:ryan.whelan@tbamerica.com">ryan.whelan@tbamerica.com</a>&gt; wro=
te:<br>
&gt; oh good- glad to find out im not crazy. we do have 2 pNICs in the exte=
rnal<br>
&gt; facing vSwitch.=A0 Even when setting them as active/passive, its still=
 an<br>
&gt; issue.<br>
&gt;<br>
&gt; so its a confirmed issue with vmware- do they have any intention on<br=
>
&gt; correcting it? do we know?<br>
&gt;<br>
<br>
</div>Yes as long as the pNIC is attached, even if in standby mode it cause=
s<br>
a problem.<br>
<br>
It is an issue, but they won&#39;t fix it for two reasons. 1. They will<br>
never create a bridge between two vSwitches/VLANs, and 2. a fix would<br>
introduce more overhead and reduce flexibility and since they adhere<br>
to #1, it doesn&#39;t make sense. The flexibility they lose is multiple<br>
pNICs to one or more switches without having to have any trunking<br>
protocols.<br>
<br>
You can get around the problem by buying the Cisco Nexus virtual<br>
switch, it&#39;s a real layer 3 switch, but it&#39;s a pricy option.<br>
<br>
If you want a bridge in a VM, then only pNIC per switch (no<br>
redundancy). The other option, try to make the bridge a router<br>
instead. For us we wanted a transparent firewall, so it was easy to<br>
change the configuration to proxyarp for a transparent router instead.<br>
<div><div></div><div class=3D"h5"><br>
Robert LeBlanc<br>
Life Sciences &amp; Undergraduate Education Computer Support<br>
Brigham Young University<br>
<br>
<br>
_____________________________________<br>
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
</div></div></blockquote></div><br></div>

--001485e7c950c015840483a54314--
