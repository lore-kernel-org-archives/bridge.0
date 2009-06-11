MIME-Version: 1.0
In-Reply-To: <OFF985F65C.FBA8694B-ONC12575D1.00546CBF-C12575D1.0055565C@transmode.se>
References: <OF5294E054.E129AF46-ONC12575D1.0046722C-C12575D1.004A59BC@transmode.se>
	<20090610074542.39f713eb@nehalam>
	<OFF985F65C.FBA8694B-ONC12575D1.00546CBF-C12575D1.0055565C@transmode.se>
Date: Thu, 11 Jun 2009 13:51:06 -0600
Message-ID: <de7adc5e0906111251h563fe0b1ic28ae7004d8b3e7@mail.gmail.com>
From: Daniel Robbins <drobbins@funtoo.org>
Content-Type: multipart/alternative; boundary=0016e645b9bea5f647046c17e93e
Subject: Re: [Bridge] RFC: Simple Private VLAN impl.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org

--0016e645b9bea5f647046c17e93e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, Jun 10, 2009 at 9:32 AM, Joakim Tjernlund <
joakim.tjernlund@transmode.se> wrote:

> Stephen Hemminger <shemminger@vyatta.com> wrote on 10/06/2009 16:45:42:
> >
> > On Wed, 10 Jun 2009 15:32:06 +0200
> > Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> >
> > >
> > > Even though some folks on this list thinks ebtables should be used
> > > to deploy Private VLAN I find using ebtables a bit clumsy.
> > >
> >
> > I prefer ebtables be used to "patch" bridge to do these kind
> > of special case things.  Remember any code that is put in mainline
> > adds additional API's and long term support burden.
>
> I am not sure this is so special anymore. I know that this
> adds "support burden" but so does a lot of stuff in the kernel.
>
> Have anybody managed to do Private VLAN with several switches by
> just using ebtables? Seems like most people here thinks that
> ebtables is the right tool but none has provided any examples
> on how to do it so I am starting to think that noone is so the
> claim to just use ebtables might be false.
>
>  Jocke


Hi Jocke,

I have not yet done this with ebtables but I plan to in the next two weeks.
I am also interested in doing some testing for your patch, do see if it is
better or preferable to the ebtables approach.

I do think that having the bridge code do PVLANs could end up being better.
In particular, I think this could be *very* useful for virtualization, where
you are adding/removing interfaces from the bridge often. Why? Because it
eliminates the need to dynamically create/remove ebtables rules and keep
them in sync with the interfaces on the bridge.

Stephen, I think one needs to consider the complexity of the patch in terms
of maintenance -- but it's important to note that the bridge code in the
kernel is there to serve *us* and be useful to *us*. In other words, the
highest priority of the code is to be useful. While it is important for the
code to be maintainable, this should never be the highest priority. This is
a very small patch so rejecting it on the basis that it increases the
maintenance burden does not seem like a legitimate argument. And if this
approach is much simpler in practice then using ebtables, then I think
something like this should be added.

I do think that if the bridging code can take care of layer 2 PVLANs, and I
only have to worry about locking down layer 3 via iptables, then this could
be a superior solution to using ebtables.

Regards,

Daniel

--0016e645b9bea5f647046c17e93e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Wed, Jun 10, 2009 at 9:32 AM, Joakim Tjernlun=
d <span dir=3D"ltr">&lt;<a href=3D"mailto:joakim.tjernlund@transmode.se">jo=
akim.tjernlund@transmode.se</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex;">
Stephen Hemminger &lt;<a href=3D"mailto:shemminger@vyatta.com">shemminger@v=
yatta.com</a>&gt; wrote on 10/06/2009 16:45:42:<br>
<div class=3D"im">&gt;<br>
&gt; On Wed, 10 Jun 2009 15:32:06 +0200<br>
&gt; Joakim Tjernlund &lt;<a href=3D"mailto:joakim.tjernlund@transmode.se">=
joakim.tjernlund@transmode.se</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; Even though some folks on this list thinks ebtables should be use=
d<br>
&gt; &gt; to deploy Private VLAN I find using ebtables a bit clumsy.<br>
&gt; &gt;<br>
&gt;<br>
&gt; I prefer ebtables be used to &quot;patch&quot; bridge to do these kind=
<br>
&gt; of special case things. =C2=A0Remember any code that is put in mainlin=
e<br>
&gt; adds additional API&#39;s and long term support burden.<br>
<br>
</div>I am not sure this is so special anymore. I know that this<br>
adds &quot;support burden&quot; but so does a lot of stuff in the kernel.<b=
r>
<br>
Have anybody managed to do Private VLAN with several switches by<br>
just using ebtables? Seems like most people here thinks that<br>
ebtables is the right tool but none has provided any examples<br>
on how to do it so I am starting to think that noone is so the<br>
claim to just use ebtables might be false.<br>
<br>
=C2=A0Jocke</blockquote><div><br></div><div>Hi Jocke,</div><div><br></div><=
div>I have not yet done this with ebtables but I plan to in the next two we=
eks. I am also interested in doing some testing for your patch, do see if i=
t is better or preferable to the ebtables approach.</div>
<div><br></div><div>I do think that having the bridge code do PVLANs could =
end up being better. In particular, I think this could be *very* useful for=
 virtualization, where you are adding/removing interfaces from the bridge o=
ften. Why? Because it eliminates the need to dynamically create/remove ebta=
bles rules and keep them in sync with the interfaces on the bridge.</div>
<div><br></div><div>Stephen, I think one needs to consider the complexity o=
f the patch in terms of maintenance -- but it&#39;s important to note that =
the bridge code in the kernel is there to serve *us* and be useful to *us*.=
 In other words, the highest priority of the code is to be useful. While it=
 is important for the code to be maintainable, this should never be the hig=
hest priority. This is a very small patch so rejecting it on the basis that=
 it increases the maintenance burden does not seem like a legitimate argume=
nt. And if this approach is much simpler in practice then using ebtables, t=
hen I think something like this should be added.</div>
<div><br></div><div>I do think that if the bridging code can take care of l=
ayer 2 PVLANs, and I only have to worry about locking down layer 3 via ipta=
bles, then this could be a superior solution to using ebtables.</div><div>
<br></div><div>Regards,</div><div><br></div><div>Daniel</div><div>=C2=A0</d=
iv></div>

--0016e645b9bea5f647046c17e93e--
