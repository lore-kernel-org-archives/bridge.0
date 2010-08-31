MIME-Version: 1.0
In-Reply-To: <20100830092013.5ee4142c@nehalam>
References: <AANLkTi=h888Pn9qtK7SuF-xbEY3KDynMjKXm38wEEbiw@mail.gmail.com>
	<20100830092013.5ee4142c@nehalam>
Date: Tue, 31 Aug 2010 11:24:28 +0530
Message-ID: <AANLkTi=UVhyMAApa_y5-sNxof22ABJ+0LN4u2oVw0tWA@mail.gmail.com>
From: debasis das <fordebasis@gmail.com>
Content-Type: multipart/alternative; boundary=000e0cd6ace0d66a25048f183658
Subject: Re: [Bridge] help needed regarding crash while adding interface to
 a bridge using brctl utility
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org

--000e0cd6ace0d66a25048f183658
Content-Type: text/plain; charset=ISO-8859-1

Hi Stephen,
                 Thanks a lot for your response.
                  Lennert Buytenhek helped me to finding the official patch
for this issue.
                  I have patched the diff available at:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=7816a0a862d851d0b05710e7d94bfe390f3180e2;hp=75a241f959a65ec9bde237d1af1a34ef794f0c9c
                  It is working fine.
                  Thanking you again.
Best regards.
Debasis


On Mon, Aug 30, 2010 at 9:50 PM, Stephen Hemminger <
shemminger@linux-foundation.org> wrote:

> On Mon, 30 Aug 2010 16:29:43 +0530
> debasis das <fordebasis@gmail.com> wrote:
>
> > Hi,
> >     I am getting a crash while adding an interface to a bridge using the
> > "brctl" utility.
> >     The crash dump is as below:
> >
> > #vconfig add eth0 5
> > #brctl addbr br0
> > #brctl addif br0 eth0.5
> > Oops: sig: 11 [#1]
> >
> > a00: 908240ed d47c9bd0 ffffffa1 d47c9bf0 000000c0 d4a5db40 00000003
> 0000000c
> > a08: 00000000 d47c9db0 d4b36000 000089a2 3fff0d58 d47c9e40 0000000e
> 3fff0f64
> > pc: d082d300, ps: 00060f10, depc: 00000018, excvaddr: 00000000
> > lbeg: d082fc4c, lend: d082fc57 lcount: 00000000, sar: 00000014
> >
> > Stack: 00060600 03938702 d063c73c d0638c78 90824a19 d47c9c40 fffffff4
> > d4649000
> >        00000001 00000000 00000000 00000000 00000000 00000000 00000000
> > 00000000
> >        00000000 00000000 00000000 d078a510 00000000 fffffffe 00060d00
> > d4a5da80
> > Call Trace:
> >  [<d082460e>] br_add_if+0xfa/0x23c
> >  [<d0824a19>] add_del_if+0x31/0x5c
> >  [<d0824f52>] br_dev_ioctl+0x50e/0x514
> >  [<d0780eac>] dev_ifsioc+0x31c/0x330
> >  [<d0781902>] dev_ioctl+0x616/0x6b4
> >  [<d0774676>] sock_ioctl+0x1b6/0x1c0
> >  [<d065aa64>] vfs_ioctl+0x14/0x3c
> >  [<d065b284>] do_vfs_ioctl+0x4a4/0x4c4
> >  [<d065b2c4>] sys_ioctl+0x20/0x34
> >  [<d0612470>] system_call+0x40/0x50
> >  [<d0611b65>] _user_exception+0x10f/0x130
> >
> > Please do let me know whether this is a known issue and whether there is
> any
> > official patch available for the same.
> > Thanking in advance.
>
> I do not see this on x86 with current kernel. It might depend on the device
> used for eth0.  When interface is added to bridge, the bridge code queries
> the device (via ethtool) to get the speed. It could be a bug in either
> the vlan device driver or the underlying driver that is causing the
> problem.
> --
>

--000e0cd6ace0d66a25048f183658
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Stephen,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Thanks a lo=
t for your response.<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 Lennert Buytenhek helped me to finding the official patch for this issue.<=
br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 I have patched the d=
iff available at:<br>=A0<a href=3D"http://git.kernel.org/?p=3Dlinux/kernel/=
git/torvalds/linux-2.6.git;a=3Dcommitdiff;h=3D7816a0a862d851d0b05710e7d94bf=
e390f3180e2;hp=3D75a241f959a65ec9bde237d1af1a34ef794f0c9c">http://git.kerne=
l.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcommitdiff;h=3D7816a=
0a862d851d0b05710e7d94bfe390f3180e2;hp=3D75a241f959a65ec9bde237d1af1a34ef79=
4f0c9c</a><br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 It is working fine.<br>=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Thanking you again.<br>=
Best regards.<br>Debasis<br><br><br><div class=3D"gmail_quote">On Mon, Aug =
30, 2010 at 9:50 PM, Stephen Hemminger <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:shemminger@linux-foundation.org">shemminger@linux-foundation.org</a>&gt=
;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><=
div class=3D"h5">On Mon, 30 Aug 2010 16:29:43 +0530<br>
debasis das &lt;<a href=3D"mailto:fordebasis@gmail.com">fordebasis@gmail.co=
m</a>&gt; wrote:<br>
<br>
&gt; Hi,<br>
&gt; =A0 =A0 I am getting a crash while adding an interface to a bridge usi=
ng the<br>
&gt; &quot;brctl&quot; utility.<br>
&gt; =A0 =A0 The crash dump is as below:<br>
&gt;<br>
&gt; #vconfig add eth0 5<br>
&gt; #brctl addbr br0<br>
&gt; #brctl addif br0 eth0.5<br>
&gt; Oops: sig: 11 [#1]<br>
&gt;<br>
&gt; a00: 908240ed d47c9bd0 ffffffa1 d47c9bf0 000000c0 d4a5db40 00000003 00=
00000c<br>
&gt; a08: 00000000 d47c9db0 d4b36000 000089a2 3fff0d58 d47c9e40 0000000e 3f=
ff0f64<br>
&gt; pc: d082d300, ps: 00060f10, depc: 00000018, excvaddr: 00000000<br>
&gt; lbeg: d082fc4c, lend: d082fc57 lcount: 00000000, sar: 00000014<br>
&gt;<br>
&gt; Stack: 00060600 03938702 d063c73c d0638c78 90824a19 d47c9c40 fffffff4<=
br>
&gt; d4649000<br>
&gt; =A0 =A0 =A0 =A000000001 00000000 00000000 00000000 00000000 00000000 0=
0000000<br>
&gt; 00000000<br>
&gt; =A0 =A0 =A0 =A000000000 00000000 00000000 d078a510 00000000 fffffffe 0=
0060d00<br>
&gt; d4a5da80<br>
&gt; Call Trace:<br>
&gt; =A0[&lt;d082460e&gt;] br_add_if+0xfa/0x23c<br>
&gt; =A0[&lt;d0824a19&gt;] add_del_if+0x31/0x5c<br>
&gt; =A0[&lt;d0824f52&gt;] br_dev_ioctl+0x50e/0x514<br>
&gt; =A0[&lt;d0780eac&gt;] dev_ifsioc+0x31c/0x330<br>
&gt; =A0[&lt;d0781902&gt;] dev_ioctl+0x616/0x6b4<br>
&gt; =A0[&lt;d0774676&gt;] sock_ioctl+0x1b6/0x1c0<br>
&gt; =A0[&lt;d065aa64&gt;] vfs_ioctl+0x14/0x3c<br>
&gt; =A0[&lt;d065b284&gt;] do_vfs_ioctl+0x4a4/0x4c4<br>
&gt; =A0[&lt;d065b2c4&gt;] sys_ioctl+0x20/0x34<br>
&gt; =A0[&lt;d0612470&gt;] system_call+0x40/0x50<br>
&gt; =A0[&lt;d0611b65&gt;] _user_exception+0x10f/0x130<br>
&gt;<br>
&gt; Please do let me know whether this is a known issue and whether there =
is any<br>
&gt; official patch available for the same.<br>
&gt; Thanking in advance.<br>
<br>
</div></div>I do not see this on x86 with current kernel. It might depend o=
n the device<br>
used for eth0. =A0When interface is added to bridge, the bridge code querie=
s<br>
the device (via ethtool) to get the speed. It could be a bug in either<br>
the vlan device driver or the underlying driver that is causing the<br>
problem.<br>
<font color=3D"#888888">--<br>
</font></blockquote></div><br>

--000e0cd6ace0d66a25048f183658--
