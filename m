MIME-Version: 1.0
In-Reply-To: <45a1b53e0905050908w3b4b1522i29b4af14b6673e88@mail.gmail.com>
References: <45a1b53e0905040747p48466d3aye289314499c01a2e@mail.gmail.com>
	<2e59e6970905041640q55c60531j7355e9522dff773a@mail.gmail.com>
	<45a1b53e0905050908w3b4b1522i29b4af14b6673e88@mail.gmail.com>
Date: Tue, 5 May 2009 13:02:21 -0500
Message-ID: <2e59e6970905051102k9d0255dhaf522ebb6fdcd72c@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: multipart/alternative; boundary=001485f629a49794e704692e144e
Subject: Re: [Bridge] /dev/tap on uClinux and bridging
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Wade Maxfield <wmaxfield@gmail.com>
Cc: Bridge@lists.linux-foundation.org

--001485f629a49794e704692e144e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Tue, May 5, 2009 at 11:08 AM, Wade Maxfield <wmaxfield@gmail.com> wrote:

>   That is an interesting proposition.  I'll investigate.
>
>   I don't know anything about libpcap, so I have a few questions for the
> expert <grin>.
>
>    Will it handle all Etherent frames? As a bridge, that is what I need.


It wouldn't be much use for packet capture (e.g. Ethereal) if it didn't.


>
>    Will it allow me to gracefully drop stuff on the floor? I'm assuming the
> Ethernet bridge code in the kernel will do that, I'm not sure of the effect
> in libpcap.


You always have the option of not sending stuff over your data link.


>
>
>    I'm also assuming that I could not use IPchains if I do libpcap.  That
> might be worth a tradeoff.


I don't know whether libpcap operates before or after iptables.  It may
operate before, in which case iptables would filter outgoing traffic sent
from your raw socket, but not incoming.

Something like this might help (it passes iptables-selected packets to
user-mode)
http://eatingsecurity.blogspot.com/2007/09/transparent-bridging-mmap-pcap-and.html

Just replace snort in that discussion with your communication application
and you should be good.



>
>
>    Finally, just for curiosity sake, what Major, Minor numbers should the
> /dev/tap entries be?  I have not yet had anyone be able to answer that
> question, and it puzzles me.


Sorry I don't know that.  I'm not sure if it's necessarily the same across
systems.


>
>
> thanks,
> Wade
>
>

--001485f629a49794e704692e144e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Tue, May 5, 2009 at 11:08 AM, Wade Ma=
xfield <span dir=3D"ltr">&lt;<a href=3D"mailto:wmaxfield@gmail.com">wmaxfie=
ld@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" sty=
le=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex;=
 padding-left: 1ex;">
=A0 That is an interesting proposition.=A0 I&#39;ll investigate.<br><br>=A0=
 I don&#39;t know anything about libpcap, so I have a few questions for the=
 expert &lt;grin&gt;.<br><br>=A0=A0 Will it handle all Etherent frames? As =
a bridge, that is what I need.</blockquote>
<div><br>It wouldn&#39;t be much use for packet capture (e.g. Ethereal) if =
it didn&#39;t.<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"borde=
r-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-le=
ft: 1ex;">
<br>
=A0=A0 Will it allow me to gracefully drop stuff on the floor? I&#39;m assu=
ming the Ethernet bridge code in the kernel will do that, I&#39;m not sure =
of the effect in libpcap.</blockquote><div><br>You always have the option o=
f not sending stuff over your data link.<br>
=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br><br>=
=A0=A0 I&#39;m also assuming that I could not use IPchains if I do libpcap.=
=A0 That might be worth a tradeoff.</blockquote>
<div><br>I don&#39;t know whether libpcap operates before or after iptables=
.=A0 It may operate before, in which case iptables would filter outgoing tr=
affic sent from your raw socket, but not incoming.<br><br>Something like th=
is might help (it passes iptables-selected packets to user-mode)<br>
<a href=3D"http://eatingsecurity.blogspot.com/2007/09/transparent-bridging-=
mmap-pcap-and.html">http://eatingsecurity.blogspot.com/2007/09/transparent-=
bridging-mmap-pcap-and.html</a><br><br>Just replace snort in that discussio=
n with your communication application and you should be good.<br>
<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px so=
lid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<br>=A0=A0 Finally, just for curiosity sake, what Major, Minor numbers shou=
ld the /dev/tap entries be?=A0 I have not yet had anyone be able to answer =
that question, and it puzzles me.</blockquote><div><br>Sorry I don&#39;t kn=
ow that.=A0 I&#39;m not sure if it&#39;s necessarily the same across system=
s.<br>
=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br><br>=
thanks,<br>Wade<div><div></div><br></div></blockquote></div>

--001485f629a49794e704692e144e--
