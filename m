Date: Mon, 17 Nov 2008 16:15:56 +0530 (IST)
From: rahul bhardwaj <rahul_bhardwaj36in@yahoo.co.in>
In-Reply-To: <49213FC5.4040001@sysnetsistemi.it>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1814697707-1226918756=:97611"
Message-ID: <258261.97611.qm@web8808.mail.in.yahoo.com>
Subject: Re: [Bridge] Bridge ports needlessly going through learning stage
	when STP is disabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Francesco Dolcini <fdolcini@sysnetsistemi.it>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org

--0-1814697707-1226918756=:97611
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

But STP is disabled on the bridge interface, then also "setfd to zero" it w=
ill work? Or should I enable the STP first?

With Regards=20

Rahul Bhardwaj=20

=C2=A0

--- On Mon, 17/11/08, Francesco Dolcini <fdolcini@sysnetsistemi.it> wrote:
From: Francesco Dolcini <fdolcini@sysnetsistemi.it>
Subject: Re: [Bridge] Bridge ports needlessly going through learning stage =
when STP is disabled
To: "rahul bhardwaj" <rahul_bhardwaj36in@yahoo.co.in>
Cc: "Stephen Hemminger" <shemminger@vyatta.com>, bridge@lists.linux-foundat=
ion.org
Date: Monday, 17 November, 2008, 1:56 AM

rahul bhardwaj wrote:
> Is this the right behavior ? The 15 to 30 second delay before the=20
> port moves to Forwarding state can be frustrating, as you don't
> expect it, and for that period of time, start to think there is
> something else wrong in the network's configuration. Is there any
> place in the code where I do some change to resolve this issue.

At the moment the normal way to handle this is "brctl setfd $BR_DEV
0"

-Francesco
_______________________________________________
Bridge mailing list
Bridge@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/bridge
=0A=0A=0A      Add more friends to your messenger and enjoy! Go to http://m=
essenger.yahoo.com/invite/
--0-1814697707-1226918756=:97611
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">But STP is disabled on the bridge interface, =
then also "setfd to zero" it will work? Or should I enable the STP first?<b=
r><br><div><em>With Regards <br><br>Rahul Bhardwaj <br></em></div><br><div>=
<em>&nbsp;</em></div><br><br>--- On <b>Mon, 17/11/08, Francesco Dolcini <i>=
&lt;fdolcini@sysnetsistemi.it&gt;</i></b> wrote:<br><blockquote style=3D"bo=
rder-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;=
">From: Francesco Dolcini &lt;fdolcini@sysnetsistemi.it&gt;<br>Subject: Re:=
 [Bridge] Bridge ports needlessly going through learning stage when STP is =
disabled<br>To: "rahul bhardwaj" &lt;rahul_bhardwaj36in@yahoo.co.in&gt;<br>=
Cc: "Stephen Hemminger" &lt;shemminger@vyatta.com&gt;, bridge@lists.linux-f=
oundation.org<br>Date: Monday, 17 November, 2008, 1:56 AM<br><br><pre>rahul=
 bhardwaj wrote:<br>&gt; Is this the right behavior ? The 15 to 30 second d=
elay
 before the <br>&gt; port moves to Forwarding state can be frustrating, as =
you don't<br>&gt; expect it, and for that period of time, start to think th=
ere is<br>&gt; something else wrong in the network's configuration. Is ther=
e any<br>&gt; place in the code where I do some change to resolve this issu=
e.<br><br>At the moment the normal way to handle this is "brctl setfd $BR_D=
EV<br>0"<br><br>-Francesco<br>_____________________________________________=
__<br>Bridge mailing list<br>Bridge@lists.linux-foundation.org<br>https://l=
ists.linux-foundation.org/mailman/listinfo/bridge<br></pre></blockquote></t=
d></tr></table><br>=0A      <!--6--><hr size=3D1></hr> Add more friends to =
your messenger and enjoy! <a href=3D"http://in.rd.yahoo.com/tagline_messeng=
er_6/*http://messenger.yahoo.com/invite/"> Invite them now.</a>
--0-1814697707-1226918756=:97611--
