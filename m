MIME-Version: 1.0
In-Reply-To: <fed120860905051311x7b5d239bma1fd1820c27d1e3a@mail.gmail.com>
References: <45a1b53e0905040747p48466d3aye289314499c01a2e@mail.gmail.com>
	<fed120860905051311x7b5d239bma1fd1820c27d1e3a@mail.gmail.com>
Date: Tue, 5 May 2009 16:03:20 -0500
Message-ID: <45a1b53e0905051403o10090cbdw757237456b8d18a6@mail.gmail.com>
From: Wade Maxfield <wmaxfield@gmail.com>
Content-Type: multipart/alternative; boundary=0016e645b9a8d0fe770469309b60
Subject: Re: [Bridge] /dev/tap on uClinux and bridging
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Srinivas M.A." <srinivas.aji@gmail.com>
Cc: Bridge@lists.linux-foundation.org

--0016e645b9a8d0fe770469309b60
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

  Thanks!  That is exactly what I needed to know!

wade

On Tue, May 5, 2009 at 3:11 PM, Srinivas M.A. <srinivas.aji@gmail.com>wrote:

> Network interfaces don't show up in /dev in Linux anyway. When tap0,
> tap1, etc are created, they will show up in "ifconfig -a" and you can
> add them to bridges at that point. /dev/net/tun should be the only
> thing you need in /dev.
>
> I think /dev/tapX is an older interface.
>
> If your user program is trying to use the /dev/tapX devices, you could
> modify it to use /dev/net/tun and connect to the right device using
> the ioctl as described in Documentation/tuntap.txt in the Linux
> source.
>
> On Mon, May 4, 2009 at 2:47 PM, Wade Maxfield <wmaxfield@gmail.com> wrote:
> >
> >   I'm trying to use bridging and TUN/TAP on uClinux on Nios processor, on
> an
> > Altera fpga.
> >
> >   I downloaded the source for tunctl and it compiled and runs just fine.
> >
> >   It says it created tap0, tap1, tap2, etc., but they don't show up in
> the
> > /dev directory.
> >
> >    I'm assuming because there is no demon to create these entries.
> >
> >    I looked at Ubuntu, and saw the /dev/tapx entries are major, minor
> > 36,16.
> >
> >   However, the /dev/net/tun in the uClinux is 200,10.
> >
> >    My question is this: If I create /dev/tap0 in the /dev directory,
> which
> > Major,Minor number should I give it?
> >
> >    I'm a little fuzzy on this.  I'm assuming if the Major/Minor numbers
> are
> > wrong, the brctl program won't be able to use the tap0 interface.
> >
> >    I want to do this, ultimately:
> >
> >   [ethernet]----[kernel bridge]---[tap]---(user program)------data
> > link------(user program)---[tap]---[kernel bridge]--[ethernet]
> >
> >   The data link is non standard and proprietary.  The goal is to bridge
> the
> > two ethernets.
> >
> >   Can someone give me some heads up?  Any pointers would be
> appreciated!!!
> >
> > thanks,
> > Wade
> >
> >
> >
> > _______________________________________________
> > Bridge mailing list
> > Bridge@lists.linux-foundation.org
> > https://lists.linux-foundation.org/mailman/listinfo/bridge
> >
>

--0016e645b9a8d0fe770469309b60
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

=A0 Thanks!=A0 That is exactly what I needed to know!<br><br>wade<br><br><d=
iv class=3D"gmail_quote">On Tue, May 5, 2009 at 3:11 PM, Srinivas M.A. <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:srinivas.aji@gmail.com">srinivas.aji@gm=
ail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Network interface=
s don&#39;t show up in /dev in Linux anyway. When tap0,<br>
tap1, etc are created, they will show up in &quot;ifconfig -a&quot; and you=
 can<br>
add them to bridges at that point. /dev/net/tun should be the only<br>
thing you need in /dev.<br>
<br>
I think /dev/tapX is an older interface.<br>
<br>
If your user program is trying to use the /dev/tapX devices, you could<br>
modify it to use /dev/net/tun and connect to the right device using<br>
the ioctl as described in Documentation/tuntap.txt in the Linux<br>
source.<br>
<div><div></div><div class=3D"h5"><br>
On Mon, May 4, 2009 at 2:47 PM, Wade Maxfield &lt;<a href=3D"mailto:wmaxfie=
ld@gmail.com">wmaxfield@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; =A0 I&#39;m trying to use bridging and TUN/TAP on uClinux on Nios proc=
essor, on an<br>
&gt; Altera fpga.<br>
&gt;<br>
&gt; =A0 I downloaded the source for tunctl and it compiled and runs just f=
ine.<br>
&gt;<br>
&gt; =A0 It says it created tap0, tap1, tap2, etc., but they don&#39;t show=
 up in the<br>
&gt; /dev directory.<br>
&gt;<br>
&gt; =A0=A0 I&#39;m assuming because there is no demon to create these entr=
ies.<br>
&gt;<br>
&gt; =A0=A0 I looked at Ubuntu, and saw the /dev/tapx entries are major, mi=
nor<br>
&gt; 36,16.<br>
&gt;<br>
&gt; =A0 However, the /dev/net/tun in the uClinux is 200,10.<br>
&gt;<br>
&gt; =A0=A0 My question is this: If I create /dev/tap0 in the /dev director=
y, which<br>
&gt; Major,Minor number should I give it?<br>
&gt;<br>
&gt; =A0=A0 I&#39;m a little fuzzy on this.=A0 I&#39;m assuming if the Majo=
r/Minor numbers are<br>
&gt; wrong, the brctl program won&#39;t be able to use the tap0 interface.<=
br>
&gt;<br>
&gt; =A0=A0 I want to do this, ultimately:<br>
&gt;<br>
&gt; =A0 [ethernet]----[kernel bridge]---[tap]---(user program)------data<b=
r>
&gt; link------(user program)---[tap]---[kernel bridge]--[ethernet]<br>
&gt;<br>
&gt; =A0 The data link is non standard and proprietary.=A0 The goal is to b=
ridge the<br>
&gt; two ethernets.<br>
&gt;<br>
&gt; =A0 Can someone give me some heads up?=A0 Any pointers would be apprec=
iated!!!<br>
&gt;<br>
&gt; thanks,<br>
&gt; Wade<br>
&gt;<br>
&gt;<br>
&gt;<br>
</div></div><div><div></div><div class=3D"h5">&gt; ________________________=
_______________________<br>
&gt; Bridge mailing list<br>
&gt; <a href=3D"mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linu=
x-foundation.org</a><br>
&gt; <a href=3D"https://lists.linux-foundation.org/mailman/listinfo/bridge"=
 target=3D"_blank">https://lists.linux-foundation.org/mailman/listinfo/brid=
ge</a><br>
&gt;<br>
</div></div></blockquote></div><br><br>

--0016e645b9a8d0fe770469309b60--
