Return-Path: <jogesh.panda@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=ZWOdqDJGq2H7Rdt5bLgUr48Puk8FTezL/BprKq9z+/o=;
	b=BWBZBVnkKb2S/KHwFx5p7yVdpQf+wl8VSnb8SvmkXuHhQw7hugFSbOxhN+2HKg2P/u
	+mXb+tVGa+5Av0yB7eRgRKg5a+XU2x2CIavrD14AMHt3omfehdBI4m8qcR4a94pAKPgO
	32qqvin2uQzmJReK3v59pB/rvvsueYUT+aVgIIC1ac+KSREePGSoYM/pOL8wm4aJuBk8
	WBZ3k9ioQh38zQjs27/ORhzQiLMvju4RghkbHXSNRrPG6buHM8Nku5/zGnSgNFghqoIY
	Fuhi48hV02cHpnFnH5k0lb4PtH9C+S6Kr/tt2+ypAZgim49S33vsGjGqvhtjZnd4ysIn
	FWog==
MIME-Version: 1.0
In-Reply-To: <20141125151308.3ede216c@urahara>
References: <CAHD0KLkXTH5fOMuxc7r6RQQ5f6J4vEOiGqjj1NsOSANq0=p0ZQ@mail.gmail.com>
	<20141125151308.3ede216c@urahara>
Date: Tue, 25 Nov 2014 17:07:12 -0800
Message-ID: <CAHD0KLk1PGUbSB+e8LQF7cj3rqUZ_E2hNa2otvRWcQ6-xOn=ug@mail.gmail.com>
From: jogesh panda <jogesh.panda@gmail.com>
Content-Type: multipart/alternative; boundary=089e013d2024cb1ac20508b8a583
Subject: Re: [Bridge] Bridge Consuming LACP PDUs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: bridge@lists.linux-foundation.org

--089e013d2024cb1ac20508b8a583
Content-Type: text/plain; charset=ISO-8859-1

Hello

Thanks for the reply. This still does not solve my problem for forwarding
LACP PDU (  01-80-C2-00-00-02 ).

It throws the following error,

echo 2 > /sys/class/net/brx/bridge/group_fwd_mask

bash: echo: write error: Invalid argument,

I suppose this error is from this piece of code  in file
net/bridge/br_sysfs_br.c function group_fwd_mask_store

 if (val & BR_GROUPFWD_RESTRICTED)

  return -EINVAL;


Is there anyway I can bypass this check .


Jogesh

On Tue, Nov 25, 2014 at 3:13 PM, Stephen Hemminger <
stephen@networkplumber.org> wrote:

> On Tue, 25 Nov 2014 10:12:02 -0800
> jogesh panda <jogesh.panda@gmail.com> wrote:
>
> > Hi
> >
> > I have two virtual machine. In side each VM, there is a Switch emulation.
> > Two create connection between emulated switches, I have create Tutap
> > Interfaces in the host which are seen as Virtual Interfaces inside the
> VMs.
> > The tuntap Interfaces are connected by brctl bridge.
> >
> > I am having problem with the LACP PDUs, which needs to be forwarded by
> the
> > bridge.  Stp is disabled on the bridge. Bridge is consuming the LACP PDUs
> >
> > I have programmed the ebtables as following
> >
> >
> > $ sudo ebtables -L
> > Bridge table: filter
> >
> > Bridge chain: INPUT, entries: 2, policy: ACCEPT
> > -p 0x8809 -j ACCEPT
> > -p 0x8809 -j ACCEPT
> >
> > Bridge chain: FORWARD, entries: 2, policy: ACCEPT
> > -p 0x8809 -j ACCEPT
> > -p 0x8809 -j ACCEPT
> >
> > Bridge chain: OUTPUT, entries: 1, policy: ACCEPT
> > -p 0x8809 -j ACCEPT
> >
> > I am using Linux
> >  uname -a
> > Linux Nile 3.5.0-45-generic #68~precise1-Ubuntu SMP Wed Dec 4 16:18:46
> UTC
> > 2013 x86_64 x86_64 x86_64 GNU/Linux
> >
> > Any help is much appreciated.
> >
> > Thanks in advance.
> > Jogesh
>
>
> Link local packets are not meant to be forwarded.
> There is a special forwarding mask in current version of bridge.
>
> commit 515853ccecc6987dfb8ed809dd8bf8900286f29e
> Author: stephen hemminger <shemminger@vyatta.com>
> Date:   Mon Oct 3 18:14:46 2011 +0000
>
>     bridge: allow forwarding some link local frames
>
>     This is based on an earlier patch by Nick Carter with comments
>     by David Lamparter but with some refinements. Thanks for their patience
>     this is a confusing area with overlap of standards, user requirements,
>     and compatibility with earlier releases.
>
>     It adds a new sysfs attribute
>        /sys/class/net/brX/bridge/group_fwd_mask
>     that controls forwarding of frames with address of: 01-80-C2-00-00-0X
>     The default setting has no forwarding to retain compatibility.
>
>     One change from earlier releases is that forwarding of group
>     addresses is not dependent on STP being enabled or disabled. This
>     choice was made based on interpretation of tie 802.1 standards.
>     I expect complaints will arise because of this, but better to follow
>     the standard than continue acting incorrectly by default.
>
>     The filtering mask is writeable, but only values that don't forward
>     known control frames are allowed. It intentionally blocks attempts
>     to filter control protocols. For example: writing a 8 allows
>     forwarding 802.1X PAE addresses which is the most common request.
>
>     Reported-by: David Lamparter <equinox@diac24.net>
>     Original-patch-by: Nick Carter <ncarter100@gmail.com>
>     Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
>     Tested-by: Benjamin Poirier <benjamin.poirier@gmail.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>

--089e013d2024cb1ac20508b8a583
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello=A0<div><br></div><div>Thanks for the reply. This sti=
ll does not solve my problem for forwarding LACP PDU (=A0<span style=3D"fon=
t-family:arial,sans-serif;font-size:13px">=A0</span><span style=3D"font-fam=
ily:arial,sans-serif;font-size:13px">01-80-C2-00-00-02 ). =A0</span></div><=
div><span style=3D"font-family:arial,sans-serif;font-size:13px"><br></span>=
</div><div><span style=3D"font-family:arial,sans-serif;font-size:13px">It t=
hrows the following error,=A0</span></div><div>







<p class=3D""><span class=3D"">echo 2 &gt; /sys/class/net/brx/bridge/group_=
fwd_mask=A0</span></p>
<p class=3D""><span class=3D"">bash: echo: write error: Invalid argument,=
=A0</span></p><p class=3D"">I suppose this error is from this piece of code=
 =A0in file net/bridge/br_sysfs_br.c function group_fwd_mask_store</p>















<p class=3D""><span class=3D"">=A0</span><span class=3D"">if</span><span cl=
ass=3D""> (val &amp; BR_GROUPFWD_RESTRICTED)</span></p><p class=3D"">








</p><p class=3D""><span class=3D"">=A0=A0</span><span class=3D"">return</sp=
an><span class=3D""> -</span><span class=3D"">EINVAL</span><span class=3D""=
>;</span></p><p class=3D""><span class=3D""><br></span></p><p class=3D""><s=
pan class=3D"">Is there anyway I can bypass this check .=A0</span></p><p cl=
ass=3D""><span class=3D""><br></span></p><p class=3D""><span class=3D"">Jog=
esh</span></p></div></div><div class=3D"gmail_extra"><br><div class=3D"gmai=
l_quote">On Tue, Nov 25, 2014 at 3:13 PM, Stephen Hemminger <span dir=3D"lt=
r">&lt;<a href=3D"mailto:stephen@networkplumber.org" target=3D"_blank">step=
hen@networkplumber.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><div class=3D"HOEnZb"><div class=3D"h5">On Tue, 25 Nov 2014 10:12:02 -0=
800<br>
jogesh panda &lt;<a href=3D"mailto:jogesh.panda@gmail.com">jogesh.panda@gma=
il.com</a>&gt; wrote:<br>
<br>
&gt; Hi<br>
&gt;<br>
&gt; I have two virtual machine. In side each VM, there is a Switch emulati=
on.<br>
&gt; Two create connection between emulated switches, I have create Tutap<b=
r>
&gt; Interfaces in the host which are seen as Virtual Interfaces inside the=
 VMs.<br>
&gt; The tuntap Interfaces are connected by brctl bridge.<br>
&gt;<br>
&gt; I am having problem with the LACP PDUs, which needs to be forwarded by=
 the<br>
&gt; bridge.=A0 Stp is disabled on the bridge. Bridge is consuming the LACP=
 PDUs<br>
&gt;<br>
&gt; I have programmed the ebtables as following<br>
&gt;<br>
&gt;<br>
&gt; $ sudo ebtables -L<br>
&gt; Bridge table: filter<br>
&gt;<br>
&gt; Bridge chain: INPUT, entries: 2, policy: ACCEPT<br>
&gt; -p 0x8809 -j ACCEPT<br>
&gt; -p 0x8809 -j ACCEPT<br>
&gt;<br>
&gt; Bridge chain: FORWARD, entries: 2, policy: ACCEPT<br>
&gt; -p 0x8809 -j ACCEPT<br>
&gt; -p 0x8809 -j ACCEPT<br>
&gt;<br>
&gt; Bridge chain: OUTPUT, entries: 1, policy: ACCEPT<br>
&gt; -p 0x8809 -j ACCEPT<br>
&gt;<br>
&gt; I am using Linux<br>
&gt;=A0 uname -a<br>
&gt; Linux Nile 3.5.0-45-generic #68~precise1-Ubuntu SMP Wed Dec 4 16:18:46=
 UTC<br>
&gt; 2013 x86_64 x86_64 x86_64 GNU/Linux<br>
&gt;<br>
&gt; Any help is much appreciated.<br>
&gt;<br>
&gt; Thanks in advance.<br>
&gt; Jogesh<br>
<br>
<br>
</div></div>Link local packets are not meant to be forwarded.<br>
There is a special forwarding mask in current version of bridge.<br>
<br>
commit 515853ccecc6987dfb8ed809dd8bf8900286f29e<br>
Author: stephen hemminger &lt;<a href=3D"mailto:shemminger@vyatta.com">shem=
minger@vyatta.com</a>&gt;<br>
Date:=A0 =A0Mon Oct 3 18:14:46 2011 +0000<br>
<br>
=A0 =A0 bridge: allow forwarding some link local frames<br>
<br>
=A0 =A0 This is based on an earlier patch by Nick Carter with comments<br>
=A0 =A0 by David Lamparter but with some refinements. Thanks for their pati=
ence<br>
=A0 =A0 this is a confusing area with overlap of standards, user requiremen=
ts,<br>
=A0 =A0 and compatibility with earlier releases.<br>
<br>
=A0 =A0 It adds a new sysfs attribute<br>
=A0 =A0 =A0 =A0/sys/class/net/brX/bridge/group_fwd_mask<br>
=A0 =A0 that controls forwarding of frames with address of: 01-80-C2-00-00-=
0X<br>
=A0 =A0 The default setting has no forwarding to retain compatibility.<br>
<br>
=A0 =A0 One change from earlier releases is that forwarding of group<br>
=A0 =A0 addresses is not dependent on STP being enabled or disabled. This<b=
r>
=A0 =A0 choice was made based on interpretation of tie 802.1 standards.<br>
=A0 =A0 I expect complaints will arise because of this, but better to follo=
w<br>
=A0 =A0 the standard than continue acting incorrectly by default.<br>
<br>
=A0 =A0 The filtering mask is writeable, but only values that don&#39;t for=
ward<br>
=A0 =A0 known control frames are allowed. It intentionally blocks attempts<=
br>
=A0 =A0 to filter control protocols. For example: writing a 8 allows<br>
=A0 =A0 forwarding 802.1X PAE addresses which is the most common request.<b=
r>
<br>
=A0 =A0 Reported-by: David Lamparter &lt;<a href=3D"mailto:equinox@diac24.n=
et">equinox@diac24.net</a>&gt;<br>
=A0 =A0 Original-patch-by: Nick Carter &lt;<a href=3D"mailto:ncarter100@gma=
il.com">ncarter100@gmail.com</a>&gt;<br>
=A0 =A0 Signed-off-by: Stephen Hemminger &lt;<a href=3D"mailto:shemminger@v=
yatta.com">shemminger@vyatta.com</a>&gt;<br>
=A0 =A0 Tested-by: Benjamin Poirier &lt;<a href=3D"mailto:benjamin.poirier@=
gmail.com">benjamin.poirier@gmail.com</a>&gt;<br>
=A0 =A0 Signed-off-by: David S. Miller &lt;<a href=3D"mailto:davem@davemlof=
t.net">davem@davemloft.net</a>&gt;<br>
</blockquote></div><br></div>

--089e013d2024cb1ac20508b8a583--
