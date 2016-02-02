Return-Path: <gsavix@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=WSD1Bv1dG6v4DS+iNWi7/NqrvY0nyvkweg4XdFVY/+M=;
	b=SNUB1A192q41HZz9DZ3EtKKO43PqZBvZ2POsPpmxxMpSEoOSyn9sa/TIRRxbWF3QNr
	2A+JjM+PmiT91AqhGSQbUdHIRmEaz76qPlsciGfutCjbNmj2AEW6OkV/veSMhKf3gnCE
	Um/XGSlljwsgu7afBSJZOgBzdAnJK6gEDdcabDVh0duEz90EW1/2u56nQGdPGj33XK1t
	SuPDEkwOTiko/oMD9KjqjSosuj2Yw2Sa9/T9K6PxY5ti6KB/aBPDPMiEzcahWQTkfRGl
	+SclhVlsZfurmjdI+/vc0KEGaQP21dweuqw9vKIq434hgovguRuuDig85ocNcrjRDJfd
	KV9Q==
MIME-Version: 1.0
Date: Tue, 2 Feb 2016 21:33:48 -0200
Message-ID: <CAP9G-NKzk7QwFtD=YjqyFpt7sS+J=JYzCTPLjNAGoCTv_cxEMQ@mail.gmail.com>
From: gilberto dos santos alves <gsavix@gmail.com>
Content-Type: multipart/alternative; boundary=001a11425a16e522d2052ad1eecd
Subject: [Bridge] Help with Ubuntu + bridge + tap + qemu + Windows
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--001a11425a16e522d2052ad1eecd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi, imho is more stable using ubuntu 14.04 LTS, yes we need see dmesg,
syslog, network messages, you could put your txt files on pastebin.com and
especify url for us. if necessary we access these files. keep special
attention to syslog or network messages, and show how you start your qemu,
what windows, service pack etc you choose, ipv4 or ipv6. lets see first
infra-structure, networks, tap, bridge, memory, disk, hardware setup.

yes we can.




2016-02-02 2:48 GMT-02:00 <bridge-request@lists.linux-foundation.org>:

> Send Bridge mailing list submissions to
>         bridge@lists.linux-foundation.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         https://lists.linuxfoundation.org/mailman/listinfo/bridge
> or, via email, send a message with subject or body 'help' to
>         bridge-request@lists.linux-foundation.org
>
> You can reach the person managing the list at
>         bridge-owner@lists.linux-foundation.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Bridge digest..."
>
> Today's Topics:
>
>    1. Help with Ubuntu + bridge + tap + qemu + Windows (David Logan)
>    2. Re: Help with Ubuntu + bridge + tap + qemu + Windows (David Logan)
>    3. [PATCH RESEND] bridge:Fix concurrent access issue in the
>       function brnf_get_logical_dev (Nicholas Krause)
>    4. Re: Help with Ubuntu + bridge + tap + qemu + Windows
>       (Stephen Hemminger)
>    5. Re: Help with Ubuntu + bridge + tap + qemu + Windows (David Logan)
>
>
> ---------- Mensagem encaminhada ----------
> From: David Logan <djlogan2.dl@gmail.com>
> To: bridge@lists.linux-foundation.org
> Cc:
> Date: Mon, 1 Feb 2016 12:51:20 -0700
> Subject: [Bridge] Help with Ubuntu + bridge + tap + qemu + Windows
> Hi guys
>
> I have been researching this problem for weeks, and I have tried
> everything every web page has even remotely suggested, and nothing works.=
 I
> am at my wits end, and I simply *must* get my issue resolved.
>
> Basically, when I bring up one or more VMs using tap# on a br# on an eth#=
,
> the network interface will work for a random amount of time, but inevitab=
ly
> something will die, and the =E2=80=9CTX packets=E2=80=9D stops incrementi=
ng, and the =E2=80=9CTX
> packets dropped=E2=80=9D takes over. At that point, I can shut down and s=
tart up my
> VM, and go through the cycle again with a different random time and packe=
ts
> transmitted.
>
> tap2      Link encap:Ethernet  HWaddr 8a:21:a8:cb:f5:98
>           inet6 addr: fe80::8821:a8ff:fecb:f598/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:51870 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:741595 errors:0 dropped:5702 overruns:0 carrier:0
>           collisions:0 txqueuelen:500
>           RX bytes:3220139 (3.2 MB)  TX bytes:1113177111 (1.1 GB)
>
> I could obviously post every shred of information I have, ethtool,
> iptables, netstat, brctl, etc. but I hate to create a 10K email with most=
ly
> unnecessary outputs. If anyone has a specific set of questions they need
> answered, I am more than happy to provide. I=E2=80=99m running the latest=
 Ubuntu
> and get updates daily. The uname -a as of this morning is:
>
> Darwin Carolyns-MacBook-Air.local 15.3.0 Darwin Kernel Version 15.3.0: Th=
u
> Dec 10 18:40:58 PST 2015; root:xnu-3248.30.4~1/RELEASE_X86_64 x86_64
>
> What in the world am I doing wrong, or where is this failing, how do I
> find it, and most importantly, how do I fix it? :)
>
> Thank you,
> David Logan
>
>
>
> ---------- Mensagem encaminhada ----------
> From: David Logan <djlogan2.dl@gmail.com>
> To: bridge@lists.linux-foundation.org
> Cc:
> Date: Mon, 1 Feb 2016 13:04:48 -0700
> Subject: Re: [Bridge] Help with Ubuntu + bridge + tap + qemu + Windows
> oops. Wrong machine. The uname -a really is
>
> Linux server2 3.16.0-59-generic #79~14.04.1-Ubuntu SMP Mon Jan 18 15:41:2=
7
> UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
>
> David Logan
>
>
>
>
> ---------- Mensagem encaminhada ----------
> From: Nicholas Krause <xerofoify@gmail.com>
> To: pablo@netfilter.org
> Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
> linux-kernel@vger.kernel.org, kaber@trash.net, coreteam@netfilter.org,
> netfilter-devel@vger.kernel.org, kadlec@blackhole.kfki.hu,
> davem@davemloft.net
> Date: Mon, 1 Feb 2016 22:19:33 -0500
> Subject: [Bridge] [PATCH RESEND] bridge:Fix concurrent access issue in th=
e
> function brnf_get_logical_dev
> This fixes a concurrent access issue in the function brnf_get_logical_dev
> by properly locking with the function rcu_read_lock before calling the
> function vlan_find_dev_deep_rcu and unlocking after this function call
> as all callers of this function are required to do this in order to
> improve issues with concurrent access by other threads executing
> on this data structures simultaneously.
>
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  net/bridge/br_netfilter_hooks.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/bridge/br_netfilter_hooks.c
> b/net/bridge/br_netfilter_hooks.c
> index c8b9bcf..73c84a8 100644
> --- a/net/bridge/br_netfilter_hooks.c
> +++ b/net/bridge/br_netfilter_hooks.c
> @@ -428,9 +428,10 @@ static struct net_device *brnf_get_logical_dev(struc=
t
> sk_buff *skb, const struct
>         if (brnf_pass_vlan_indev =3D=3D 0 || !skb_vlan_tag_present(skb))
>                 return br;
>
> +       rcu_read_lock();
>         vlan =3D __vlan_find_dev_deep_rcu(br, skb->vlan_proto,
>                                     skb_vlan_tag_get(skb) & VLAN_VID_MASK=
);
> -
> +       rcu_read_unlock();
>         return vlan ? vlan : br;
>  }
>
> --
> 2.1.4
>
>
>
>
> ---------- Mensagem encaminhada ----------
> From: Stephen Hemminger <stephen@networkplumber.org>
> To: David Logan <djlogan2.dl@gmail.com>
> Cc: bridge@lists.linux-foundation.org
> Date: Tue, 2 Feb 2016 14:27:08 +1100
> Subject: Re: [Bridge] Help with Ubuntu + bridge + tap + qemu + Windows
> On Mon, 1 Feb 2016 13:04:48 -0700
> David Logan <djlogan2.dl@gmail.com> wrote:
>
> > oops. Wrong machine. The uname -a really is
> >
> > Linux server2 3.16.0-59-generic #79~14.04.1-Ubuntu SMP Mon Jan 18
> 15:41:27 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
> >
> > David Logan
> >
> >
>
> I suspect you have a loop and STP is detecting that the STP packets being
> sent
> out one of the ports on the bridge are showing back up on another port on
> the bridge.
>
> The way bridging works you need to make each port on the bridge is a
> separate L2 domain;
> otherwise you create a loop.
>
>
>
> ---------- Mensagem encaminhada ----------
> From: David Logan <djlogan2.dl@gmail.com>
> To: Stephen Hemminger <stephen@networkplumber.org>
> Cc: bridge@lists.linux-foundation.org
> Date: Mon, 1 Feb 2016 21:48:51 -0700
> Subject: Re: [Bridge] Help with Ubuntu + bridge + tap + qemu + Windows
> That was a bit above my head. Can you elaborate or point me towards a web
> site that explains the terminology? Sorry, I=E2=80=99m reasonable at netw=
orking, I
> know what levels are, I have an idea of what the various fields and stuff
> are, but I am no means an expert :)
>
> Also: While I have STP enabled at the moment as the recommendation of one
> web site, most of the time STP has been disabled in the bridge. I can tur=
n
> it off and/or reboot and replicate the problem in minutes. Does that alte=
r
> your suggestion?
>
> David Logan
>
>
> On Feb 1, 2016, at 8:27 PM, Stephen Hemminger <stephen@networkplumber.org=
>
> wrote:
>
> On Mon, 1 Feb 2016 13:04:48 -0700
> David Logan <djlogan2.dl@gmail.com> wrote:
>
> oops. Wrong machine. The uname -a really is
>
> Linux server2 3.16.0-59-generic #79~14.04.1-Ubuntu SMP Mon Jan 18 15:41:2=
7
> UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
>
> David Logan
>
>
>
> I suspect you have a loop and STP is detecting that the STP packets being
> sent
> out one of the ports on the bridge are showing back up on another port on
> the bridge.
>
> The way bridging works you need to make each port on the bridge is a
> separate L2 domain;
> otherwise you create a loop.
>
>
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/bridge
>



--=20
gilberto dos santos alves
+55(11)9-8646-5049
sao paulo - sp - brasil

--001a11425a16e522d2052ad1eecd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:large">Hi,=
 imho is more stable using ubuntu 14.04 LTS, yes we need see dmesg, syslog,=
 network messages, you could put your txt files on <a href=3D"http://pasteb=
in.com">pastebin.com</a> and especify url for us. if necessary we access th=
ese files. keep special attention to syslog or network messages, and show h=
ow you start your qemu, what windows, service pack etc you choose, ipv4 or =
ipv6. lets see first infra-structure, networks, tap, bridge, memory, disk, =
hardware setup.</div><div class=3D"gmail_default" style=3D"font-size:large"=
><br></div><div class=3D"gmail_default" style=3D"font-size:large">yes we ca=
n.</div><div class=3D"gmail_default" style=3D"font-size:large"><br></div><d=
iv class=3D"gmail_default" style=3D"font-size:large"><br></div><div class=
=3D"gmail_default" style=3D"font-size:large"><br></div><div class=3D"gmail_=
extra"><br><div class=3D"gmail_quote">2016-02-02 2:48 GMT-02:00  <span dir=
=3D"ltr">&lt;<a href=3D"mailto:bridge-request@lists.linux-foundation.org" t=
arget=3D"_blank">bridge-request@lists.linux-foundation.org</a>&gt;</span>:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">Send Bridge mailing list submissions to<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:bridge@lists.linux-foundation=
.org">bridge@lists.linux-foundation.org</a><br>
<br>
To subscribe or unsubscribe via the World Wide Web, visit<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://lists.linuxfoundation.org/ma=
ilman/listinfo/bridge" rel=3D"noreferrer" target=3D"_blank">https://lists.l=
inuxfoundation.org/mailman/listinfo/bridge</a><br>
or, via email, send a message with subject or body &#39;help&#39; to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:bridge-request@lists.linux-fo=
undation.org">bridge-request@lists.linux-foundation.org</a><br>
<br>
You can reach the person managing the list at<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:bridge-owner@lists.linux-foun=
dation.org">bridge-owner@lists.linux-foundation.org</a><br>
<br>
When replying, please edit your Subject line so it is more specific<br>
than &quot;Re: Contents of Bridge digest...&quot;<br>
<br>Today&#39;s Topics:<br>
<br>
=C2=A0 =C2=A01. Help with Ubuntu + bridge + tap + qemu + Windows (David Log=
an)<br>
=C2=A0 =C2=A02. Re: Help with Ubuntu + bridge + tap + qemu + Windows (David=
 Logan)<br>
=C2=A0 =C2=A03. [PATCH RESEND] bridge:Fix concurrent access issue in the<br=
>
=C2=A0 =C2=A0 =C2=A0 function brnf_get_logical_dev (Nicholas Krause)<br>
=C2=A0 =C2=A04. Re: Help with Ubuntu + bridge + tap + qemu + Windows<br>
=C2=A0 =C2=A0 =C2=A0 (Stephen Hemminger)<br>
=C2=A0 =C2=A05. Re: Help with Ubuntu + bridge + tap + qemu + Windows (David=
 Logan)<br>
<br><br>---------- Mensagem encaminhada ----------<br>From:=C2=A0David Loga=
n &lt;<a href=3D"mailto:djlogan2.dl@gmail.com">djlogan2.dl@gmail.com</a>&gt=
;<br>To:=C2=A0<a href=3D"mailto:bridge@lists.linux-foundation.org">bridge@l=
ists.linux-foundation.org</a><br>Cc:=C2=A0<br>Date:=C2=A0Mon, 1 Feb 2016 12=
:51:20 -0700<br>Subject:=C2=A0[Bridge] Help with Ubuntu + bridge + tap + qe=
mu + Windows<br><div style=3D"word-wrap:break-word">Hi guys<div><br></div><=
div>I have been researching this problem for weeks, and I have tried everyt=
hing every web page has even remotely suggested, and nothing works. I am at=
 my wits end, and I simply *must* get my issue resolved.</div><div><br></di=
v><div>Basically, when I bring up one or more VMs using tap# on a br# on an=
 eth#, the network interface will work for a random amount of time, but ine=
vitably something will die, and the =E2=80=9CTX packets=E2=80=9D stops incr=
ementing, and the =E2=80=9CTX packets dropped=E2=80=9D takes over. At that =
point, I can shut down and start up my VM, and go through the cycle again w=
ith a different random time and packets transmitted.</div><div><br></div><d=
iv><div style=3D"margin:0px;font-size:11px;line-height:normal;font-family:M=
enlo">tap2=C2=A0 =C2=A0 =C2=A0 Link encap:Ethernet=C2=A0 HWaddr 8a:21:a8:cb=
:f5:98 =C2=A0</div><div style=3D"margin:0px;font-size:11px;line-height:norm=
al;font-family:Menlo">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 inet6 addr: fe80::=
8821:a8ff:fecb:f598/64 Scope:Link</div><div style=3D"margin:0px;font-size:1=
1px;line-height:normal;font-family:Menlo">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 UP BROADCAST RUNNING MULTICAST=C2=A0 MTU:1500=C2=A0 Metric:1</div><div =
style=3D"margin:0px;font-size:11px;line-height:normal;font-family:Menlo">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RX packets:51870 errors:0 dropped:0 over=
runs:0 frame:0</div><div style=3D"margin:0px;font-size:11px;line-height:nor=
mal;font-family:Menlo">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TX packets:741595=
 errors:0 dropped:5702 overruns:0 carrier:0</div><div style=3D"margin:0px;f=
ont-size:11px;line-height:normal;font-family:Menlo">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 collisions:0 txqueuelen:500=C2=A0</div><div style=3D"margin:0=
px;font-size:11px;line-height:normal;font-family:Menlo">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 RX bytes:3220139 (3.2 MB)=C2=A0 TX bytes:1113177111 (1.1 =
GB)</div><div style=3D"margin:0px;font-size:11px;line-height:normal;font-fa=
mily:Menlo"><br></div><div>I could obviously post every shred of informatio=
n I have, ethtool, iptables, netstat, brctl, etc. but I hate to create a 10=
K email with mostly unnecessary outputs. If anyone has a specific set of qu=
estions they need answered, I am more than happy to provide. I=E2=80=99m ru=
nning the latest Ubuntu and get updates daily. The uname -a as of this morn=
ing is:</div><div><br></div><div><div style=3D"margin:0px;font-size:11px;li=
ne-height:normal;font-family:Menlo">Darwin Carolyns-MacBook-Air.local 15.3.=
0 Darwin Kernel Version 15.3.0: Thu Dec 10 18:40:58 PST 2015; root:xnu-3248=
.30.4~1/RELEASE_X86_64 x86_64</div></div><div style=3D"margin:0px;font-size=
:11px;line-height:normal;font-family:Menlo"><br></div><div>What in the worl=
d am I doing wrong, or where is this failing, how do I find it, and most im=
portantly, how do I fix it? :)</div><div><br></div><div>Thank you,</div><di=
v>
<span style=3D"border-collapse:separate;line-height:normal;border-spacing:0=
px">David Logan<br><br></span></div></div></div><br><br>---------- Mensagem=
 encaminhada ----------<br>From:=C2=A0David Logan &lt;<a href=3D"mailto:djl=
ogan2.dl@gmail.com">djlogan2.dl@gmail.com</a>&gt;<br>To:=C2=A0<a href=3D"ma=
ilto:bridge@lists.linux-foundation.org">bridge@lists.linux-foundation.org</=
a><br>Cc:=C2=A0<br>Date:=C2=A0Mon, 1 Feb 2016 13:04:48 -0700<br>Subject:=C2=
=A0Re: [Bridge] Help with Ubuntu + bridge + tap + qemu + Windows<br><div st=
yle=3D"word-wrap:break-word">oops. Wrong machine. The uname -a really is<di=
v><br></div><div><div style=3D"margin:0px;font-size:11px;line-height:normal=
;font-family:Menlo">Linux server2 3.16.0-59-generic #79~14.04.1-Ubuntu SMP =
Mon Jan 18 15:41:27 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux</div><div style=
=3D"margin:0px;font-size:11px;line-height:normal;font-family:Menlo"><br></d=
iv><div>
<span style=3D"border-collapse:separate;line-height:normal;border-spacing:0=
px">David Logan<br><br></span>

</div>
<br></div></div><br><br>---------- Mensagem encaminhada ----------<br>From:=
=C2=A0Nicholas Krause &lt;<a href=3D"mailto:xerofoify@gmail.com">xerofoify@=
gmail.com</a>&gt;<br>To:=C2=A0<a href=3D"mailto:pablo@netfilter.org">pablo@=
netfilter.org</a><br>Cc:=C2=A0<a href=3D"mailto:netdev@vger.kernel.org">net=
dev@vger.kernel.org</a>, <a href=3D"mailto:bridge@lists.linux-foundation.or=
g">bridge@lists.linux-foundation.org</a>, <a href=3D"mailto:linux-kernel@vg=
er.kernel.org">linux-kernel@vger.kernel.org</a>, <a href=3D"mailto:kaber@tr=
ash.net">kaber@trash.net</a>, <a href=3D"mailto:coreteam@netfilter.org">cor=
eteam@netfilter.org</a>, <a href=3D"mailto:netfilter-devel@vger.kernel.org"=
>netfilter-devel@vger.kernel.org</a>, <a href=3D"mailto:kadlec@blackhole.kf=
ki.hu">kadlec@blackhole.kfki.hu</a>, <a href=3D"mailto:davem@davemloft.net"=
>davem@davemloft.net</a><br>Date:=C2=A0Mon,  1 Feb 2016 22:19:33 -0500<br>S=
ubject:=C2=A0[Bridge] [PATCH RESEND] bridge:Fix concurrent access issue in =
the function brnf_get_logical_dev<br>This fixes a concurrent access issue i=
n the function brnf_get_logical_dev<br>
by properly locking with the function rcu_read_lock before calling the<br>
function vlan_find_dev_deep_rcu and unlocking after this function call<br>
as all callers of this function are required to do this in order to<br>
improve issues with concurrent access by other threads executing<br>
on this data structures simultaneously.<br>
<br>
Signed-off-by: Nicholas Krause &lt;<a href=3D"mailto:xerofoify@gmail.com">x=
erofoify@gmail.com</a>&gt;<br>
---<br>
=C2=A0net/bridge/br_netfilter_hooks.c | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hook=
s.c<br>
index c8b9bcf..73c84a8 100644<br>
--- a/net/bridge/br_netfilter_hooks.c<br>
+++ b/net/bridge/br_netfilter_hooks.c<br>
@@ -428,9 +428,10 @@ static struct net_device *brnf_get_logical_dev(struct =
sk_buff *skb, const struct<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (brnf_pass_vlan_indev =3D=3D 0 || !skb_vlan_=
tag_present(skb))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return br;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_lock();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vlan =3D __vlan_find_dev_deep_rcu(br, skb-&gt;v=
lan_proto,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skb_vlan_tag_get(skb) =
&amp; VLAN_VID_MASK);<br>
-<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_unlock();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return vlan ? vlan : br;<br>
=C2=A0}<br>
<br>
--<br>
2.1.4<br>
<br>
<br>
<br><br>---------- Mensagem encaminhada ----------<br>From:=C2=A0Stephen He=
mminger &lt;<a href=3D"mailto:stephen@networkplumber.org">stephen@networkpl=
umber.org</a>&gt;<br>To:=C2=A0David Logan &lt;<a href=3D"mailto:djlogan2.dl=
@gmail.com">djlogan2.dl@gmail.com</a>&gt;<br>Cc:=C2=A0<a href=3D"mailto:bri=
dge@lists.linux-foundation.org">bridge@lists.linux-foundation.org</a><br>Da=
te:=C2=A0Tue, 2 Feb 2016 14:27:08 +1100<br>Subject:=C2=A0Re: [Bridge] Help =
with Ubuntu + bridge + tap + qemu + Windows<br>On Mon, 1 Feb 2016 13:04:48 =
-0700<br>
David Logan &lt;<a href=3D"mailto:djlogan2.dl@gmail.com">djlogan2.dl@gmail.=
com</a>&gt; wrote:<br>
<br>
&gt; oops. Wrong machine. The uname -a really is<br>
&gt;<br>
&gt; Linux server2 3.16.0-59-generic #79~14.04.1-Ubuntu SMP Mon Jan 18 15:4=
1:27 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux<br>
&gt;<br>
&gt; David Logan<br>
&gt;<br>
&gt;<br>
<br>
I suspect you have a loop and STP is detecting that the STP packets being s=
ent<br>
out one of the ports on the bridge are showing back up on another port on t=
he bridge.<br>
<br>
The way bridging works you need to make each port on the bridge is a separa=
te L2 domain;<br>
otherwise you create a loop.<br>
<br>
<br><br>---------- Mensagem encaminhada ----------<br>From:=C2=A0David Loga=
n &lt;<a href=3D"mailto:djlogan2.dl@gmail.com">djlogan2.dl@gmail.com</a>&gt=
;<br>To:=C2=A0Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumbe=
r.org">stephen@networkplumber.org</a>&gt;<br>Cc:=C2=A0<a href=3D"mailto:bri=
dge@lists.linux-foundation.org">bridge@lists.linux-foundation.org</a><br>Da=
te:=C2=A0Mon, 1 Feb 2016 21:48:51 -0700<br>Subject:=C2=A0Re: [Bridge] Help =
with Ubuntu + bridge + tap + qemu + Windows<br><div style=3D"word-wrap:brea=
k-word">That was a bit above my head. Can you elaborate or point me towards=
 a web site that explains the terminology? Sorry, I=E2=80=99m reasonable at=
 networking, I know what levels are, I have an idea of what the various fie=
lds and stuff are, but I am no means an expert :)<div><br></div><div>Also: =
While I have STP enabled at the moment as the recommendation of one web sit=
e, most of the time STP has been disabled in the bridge. I can turn it off =
and/or reboot and replicate the problem in minutes. Does that alter your su=
ggestion?</div><div><br><div>
<span style=3D"border-collapse:separate;color:rgb(0,0,0);font-family:Helvet=
ica;font-style:normal;font-variant:normal;font-weight:normal;letter-spacing=
:normal;line-height:normal;text-align:-webkit-auto;text-indent:0px;text-tra=
nsform:none;white-space:normal;word-spacing:0px">David Logan<br><br></span>

</div>
<br><div><blockquote type=3D"cite"><div>On Feb 1, 2016, at 8:27 PM, Stephen=
 Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.org" target=3D"_bla=
nk">stephen@networkplumber.org</a>&gt; wrote:</div><br><div><div>On Mon, 1 =
Feb 2016 13:04:48 -0700<br>David Logan &lt;<a href=3D"mailto:djlogan2.dl@gm=
ail.com" target=3D"_blank">djlogan2.dl@gmail.com</a>&gt; wrote:<br><br><blo=
ckquote type=3D"cite">oops. Wrong machine. The uname -a really is<br><br>Li=
nux server2 3.16.0-59-generic #79~14.04.1-Ubuntu SMP Mon Jan 18 15:41:27 UT=
C 2016 x86_64 x86_64 x86_64 GNU/Linux<br><br>David Logan<br><br><br></block=
quote><br>I suspect you have a loop and STP is detecting that the STP packe=
ts being sent<br>out one of the ports on the bridge are showing back up on =
another port on the bridge.<br><br>The way bridging works you need to make =
each port on the bridge is a separate L2 domain;<br>otherwise you create a =
loop.<br></div></div></blockquote></div><br></div></div><br>_______________=
________________________________<br>
Bridge mailing list<br>
<a href=3D"mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linux-fou=
ndation.org</a><br>
<a href=3D"https://lists.linuxfoundation.org/mailman/listinfo/bridge" rel=
=3D"noreferrer" target=3D"_blank">https://lists.linuxfoundation.org/mailman=
/listinfo/bridge</a><br></blockquote></div><br><br clear=3D"all"><div><br><=
/div>-- <br><div class=3D"gmail_signature"><div dir=3D"ltr"><div>gilberto d=
os santos alves<br>+55(11)9-8646-5049<br>sao paulo - sp - brasil<br><br><br=
><br><br></div></div></div>
</div></div>

--001a11425a16e522d2052ad1eecd--
