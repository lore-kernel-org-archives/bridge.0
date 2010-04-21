MIME-Version: 1.0
In-Reply-To: <20100419090023.6c6d34a1@nehalam>
References: <i2xe5da85b41004190235t447ea22exa046c63fc3373971@mail.gmail.com>
	<20100419090023.6c6d34a1@nehalam>
Date: Wed, 21 Apr 2010 13:40:02 +0530
Message-ID: <k2ue5da85b41004210110gcc43804ag41987d5efde7dcae@mail.gmail.com>
From: voxner <voxner.dev@gmail.com>
Content-Type: multipart/alternative; boundary=0016e68cc510a1697f0484bab867
Subject: Re: [Bridge] RSTP-Linux Bridge (2.6 Kernel) query
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

--0016e68cc510a1697f0484bab867
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Apr 19, 2010 at 9:30 PM, Stephen Hemminger <
shemminger@linux-foundation.org> wrote:

> On Mon, 19 Apr 2010 15:05:35 +0530
> voxner <voxner.dev@gmail.com> wrote:
>
> Did you look at RSTP user space daemon? or is this a new one.
>       git clone git.kernel.org:
> /pub/scm/linux/kernel/git/shemminger/rstp.git
>
> I already have five alternatives for RSTP, and none of them is fully
> integrated!  3 user space daemons (1 on rstplib, 1 from EMC, and
> another). 2 kernel implementations based on old 2.4 code.
>
> Somewhere down the road, there needs to be one and only one solution
> and it has to just work out of the box.  If I had infinite time, or
> a major Vyatta customer demanded it, I would just integrate one of
> the 2.4 implementations and be done.
>

It's a new RSTP implementation in user space. I saw a 2.4 RSTP
implementation that is integrated into kernel but was not part of the
mainline kernel. Which one of the two 2.4 implementations you mentioned is
more easier to port to 2.6?

--0016e68cc510a1697f0484bab867
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Apr 19, 2010 at 9:30 PM, Stephen=
 Hemminger <span dir=3D"ltr">&lt;<a href=3D"mailto:shemminger@linux-foundat=
ion.org">shemminger@linux-foundation.org</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex;">
<div class=3D"im">On Mon, 19 Apr 2010 15:05:35 +0530<br>
voxner &lt;<a href=3D"mailto:voxner.dev@gmail.com">voxner.dev@gmail.com</a>=
&gt; wrote:<br>
<br>
</div>Did you look at RSTP user space daemon? or is this a new one.<br>
 =A0 =A0 =A0 git clone git.kernel.org:/pub/scm/linux/kernel/git/shemminger/=
rstp.git<br>
<br>
I already have five alternatives for RSTP, and none of them is fully<br>
integrated! =A03 user space daemons (1 on rstplib, 1 from EMC, and<br>
another). 2 kernel implementations based on old 2.4 code.<br>
<br>
Somewhere down the road, there needs to be one and only one solution<br>
and it has to just work out of the box. =A0If I had infinite time, or<br>
a major Vyatta customer demanded it, I would just integrate one of<br>
the 2.4 implementations and be done.<br>
</blockquote></div><div><br></div><div>It&#39;s a new RSTP implementation i=
n user space. I saw a 2.4 RSTP implementation that is integrated into kerne=
l but was not part of the mainline kernel. Which one of the two 2.4 impleme=
ntations you mentioned is more easier to port to 2.6?=A0<br>
</div>

--0016e68cc510a1697f0484bab867--
