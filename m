MIME-Version: 1.0
In-Reply-To: <20090825084730.0f8d50df@nehalam>
References: <f05d3b1c0908250051p29b1c440mfd0e90bf31679249@mail.gmail.com>
	<20090825084730.0f8d50df@nehalam>
Date: Thu, 27 Aug 2009 10:48:17 +0200
Message-ID: <f05d3b1c0908270148q5955604co1d0ee9a00f76caeb@mail.gmail.com>
From: LucaMt <lucamt74@gmail.com>
Content-Type: multipart/alternative; boundary=0015174c1770009c7504721ba101
Subject: Re: [Bridge] bridge through code
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

--0015174c1770009c7504721ba101
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,
looking in the internet I have found several functions to manage bridge.
These functions are: br_add_bridge, br_del_bridge etc. These functions are
in user space or kernel space ? Developing an application (bridgeConf.so)
during loading phase of the application the undefined reference error
related to the previus functions is generated.
While in the kernel space is not defined the libbridge.h.
Are the br_*_bridge function the correct way to manage bridge through code
in user space ?
For our needs something in kernel space is useful too.

Thanks

Best Regards

Luca

2009/8/25 Stephen Hemminger <shemminger@linux-foundation.org>

> On Tue, 25 Aug 2009 09:51:50 +0200
> LucaMt <lucamt74@gmail.com> wrote:
>
> > Hi,
> > I want to ask if exist a way allowing bridge control through c/c++ code.
> > Where I can found API to develop an user interface to manage the bridge.
> >
> > Thanks
> >
> > Best regards
> >
> > Luca
>
> Look at existing bridge utilities (brctl) and RSTP source code.
>
>       git://
> git.kernel.org/pub/scm/linux/kernel/git/shemminger/bridge-utils.git
>       git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/rstp.git
> --
>

--0015174c1770009c7504721ba101
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br>looking in the internet I have found several functions to manage bri=
dge.<br>These functions are: br_add_bridge, br_del_bridge etc. These functi=
ons are in user space or kernel space ? Developing an application (bridgeCo=
nf.so) during loading phase of the application the undefined reference erro=
r related to the previus functions is generated.<br>
While in the kernel space is not defined the libbridge.h.<br>Are the br_*_b=
ridge function the correct way to manage bridge through code in user space =
?<br>For our needs something in kernel space is useful too.<br><br>Thanks<b=
r>
<br>Best Regards<br><br>Luca<br><br><div class=3D"gmail_quote">2009/8/25 St=
ephen Hemminger <span dir=3D"ltr">&lt;<a href=3D"mailto:shemminger@linux-fo=
undation.org">shemminger@linux-foundation.org</a>&gt;</span><br><blockquote=
 class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); =
margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class=3D"h5">On Tue, 25 Aug 2009 09:51:50 +0200<br>
LucaMt &lt;<a href=3D"mailto:lucamt74@gmail.com">lucamt74@gmail.com</a>&gt;=
 wrote:<br>
<br>
&gt; Hi,<br>
&gt; I want to ask if exist a way allowing bridge control through c/c++ cod=
e.<br>
&gt; Where I can found API to develop an user interface to manage the bridg=
e.<br>
&gt;<br>
&gt; Thanks<br>
&gt;<br>
&gt; Best regards<br>
&gt;<br>
&gt; Luca<br>
<br>
</div></div>Look at existing bridge utilities (brctl) and RSTP source code.=
<br>
<br>
 =A0 =A0 =A0 git://<a href=3D"http://git.kernel.org/pub/scm/linux/kernel/gi=
t/shemminger/bridge-utils.git" target=3D"_blank">git.kernel.org/pub/scm/lin=
ux/kernel/git/shemminger/bridge-utils.git</a><br>
 =A0 =A0 =A0 git://<a href=3D"http://git.kernel.org/pub/scm/linux/kernel/gi=
t/shemminger/rstp.git" target=3D"_blank">git.kernel.org/pub/scm/linux/kerne=
l/git/shemminger/rstp.git</a><br>
<font color=3D"#888888">--<br>
</font></blockquote></div><br>

--0015174c1770009c7504721ba101--
