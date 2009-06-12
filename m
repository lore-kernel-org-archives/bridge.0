MIME-Version: 1.0
In-Reply-To: <20090611235845.GB3432@kallisti.us>
References: <OF5294E054.E129AF46-ONC12575D1.0046722C-C12575D1.004A59BC@transmode.se>
	<20090610074542.39f713eb@nehalam>
	<OFF985F65C.FBA8694B-ONC12575D1.00546CBF-C12575D1.0055565C@transmode.se>
	<de7adc5e0906111251h563fe0b1ic28ae7004d8b3e7@mail.gmail.com>
	<20090611235845.GB3432@kallisti.us>
Date: Thu, 11 Jun 2009 18:15:46 -0600
Message-ID: <de7adc5e0906111715s56f13ad0o760840dfadba797@mail.gmail.com>
From: Daniel Robbins <drobbins@funtoo.org>
Content-Type: multipart/alternative; boundary=0016e645b9be2254b9046c1b9cb4
Subject: Re: [Bridge] RFC: Simple Private VLAN impl.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ross Vandegrift <ross@kallisti.us>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org, Joakim Tjernlund <joakim.tjernlund@transmode.se>

--0016e645b9be2254b9046c1b9cb4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, Jun 11, 2009 at 5:58 PM, Ross Vandegrift <ross@kallisti.us> wrote:

> 2) Many VEs in many communities spread across many hosts.  For
> example, it might get bad if you had 5 communities across 100 hosts,
> with each community having 100 VEs.  This would mean each host needs
> a full set of 10000 MAC rules for each community - 50000 ebtables
> rules.  In this case, I'd again prefer a routed design (well, any case
> actually...) and if a common "community" LAN was a software
> requirement, I'd use multipoint GRE or L2TP.
>
> But for one node with a bunch of unrelated VEs, this is very little
> work to maintain.
>

In my particular configuration, there are no communities - each VE is an
island, and will only be able to communicate with the network gateway (which
is non-local, ie. not on the linux bridge itself.) That should lock down
layer 2. With OpenVZ, each VE's MAC will have a common SWSoft 00:18:51
prefix.

After I get that working, I need to lock down layer 3 with iptables, so the
PVLAN functionality can't be bypassed.

If you have any configuration examples for ebtables, especially simple ones,
I would welcome them :)

Thanks,

Daniel

--0016e645b9be2254b9046c1b9cb4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Thu, Jun 11, 2009 at 5:58 PM, Ross Vandegrift=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:ross@kallisti.us">ross@kallisti.us=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im">2) Many VEs in many communities spread across many hosts.=
 =C2=A0For</div>
example, it might get bad if you had 5 communities across 100 hosts,<br>
with each community having 100 VEs. =C2=A0This would mean each host needs<b=
r>
a full set of 10000 MAC rules for each community - 50000 ebtables<br>
rules. =C2=A0In this case, I&#39;d again prefer a routed design (well, any =
case<br>
actually...) and if a common &quot;community&quot; LAN was a software<br>
requirement, I&#39;d use multipoint GRE or L2TP.<br>
<br>
But for one node with a bunch of unrelated VEs, this is very little<br>
work to maintain.<br><font class=3D"Apple-style-span" color=3D"#888888"></f=
ont></blockquote><div><br></div><div>In my particular configuration, there =
are no communities - each VE is an island, and will only be able to communi=
cate with the network gateway (which is non-local, ie. not on the linux bri=
dge itself.) That should lock down layer 2. With OpenVZ, each VE&#39;s MAC =
will have a common SWSoft 00:18:51 prefix.</div>
<div><br></div><div>After I get that working, I need to lock down layer 3 w=
ith iptables, so the PVLAN functionality can&#39;t be bypassed.</div><div><=
br></div><div>If you have any configuration examples for ebtables, especial=
ly simple ones, I would welcome them :)</div>
<div><br></div><div>Thanks,</div><div><br></div><div>Daniel</div></div>

--0016e645b9be2254b9046c1b9cb4--
