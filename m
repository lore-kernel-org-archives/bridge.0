MIME-Version: 1.0
In-Reply-To: <49E03128.7080902@pacbell.net>
References: <49E03128.7080902@pacbell.net>
Date: Mon, 13 Apr 2009 12:59:10 -0500
Message-ID: <2e59e6970904131059k7721735fk670b41e50a91bda8@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: multipart/alternative; boundary=0015175ca7beab749204677378ac
Subject: Re: [Bridge] Building a Raw Bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Michael Boutte <maboutte@pacbell.net>
Cc: bridge@lists.linux-foundation.org

--0015175ca7beab749204677378ac
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

What you described is a different interface for tx and rx.  What you've
drawn is separate tx and rx radios which are melded in the driver and expose
a single interface "wan0".  Which is it?  (If the drawing is correct, I
don't think you have a problem at all, aside from trying to use two bridges
when you need only one)

On Sat, Apr 11, 2009 at 12:56 AM, Michael Boutte <maboutte@pacbell.net>wrote:

> I'm having trouble figuring out how to make a bridge that does not block
> forwarding of packets when there is no receive channel in the same
> bridge. The reason I want to do this is that the return path is via
> another circuit. The two directions are on two different radios. I would
> think this would be like the response given to someone in July 2007
> about setting a "hub" mode by setting the aging timer to 0. I tried that
> and it did not work.
>
> I also tried a few schemes with ebtables without success either. Is
> there some relatively easy way to make the bridge forward everything and
> not cut off the transmit after a single packet?
>
> / Here is what one end of the link looks like.
> //
> //                   +-------------+
> // ///      /// + eth0 +---+   bridge 1  +---+ wan0 ---> Transmit
> //        |          +-------------+
> //        |
> //switch--+
> //        |          +-------------+
> //        + eth0 +---+   bridge 2  +---+ wan0 <--- Receive
> //                   +-------------+
> /
> The WAN side uses a synchronous serial interface to the radios for
> satellite communications. The other end uses a single radio and bridge.
>
> Mike Boutte
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>

--0015175ca7beab749204677378ac
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

What you described is a different interface for tx and rx.=A0 What you&#39;=
ve drawn is separate tx and rx radios which are melded in the driver and ex=
pose a single interface &quot;wan0&quot;.=A0 Which is it?=A0 (If the drawin=
g is correct, I don&#39;t think you have a problem at all, aside from tryin=
g to use two bridges when you need only one)<br>
<br><div class=3D"gmail_quote">On Sat, Apr 11, 2009 at 12:56 AM, Michael Bo=
utte <span dir=3D"ltr">&lt;<a href=3D"mailto:maboutte@pacbell.net">maboutte=
@pacbell.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" sty=
le=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex;=
 padding-left: 1ex;">
I&#39;m having trouble figuring out how to make a bridge that does not bloc=
k<br>
forwarding of packets when there is no receive channel in the same<br>
bridge. The reason I want to do this is that the return path is via<br>
another circuit. The two directions are on two different radios. I would<br=
>
think this would be like the response given to someone in July 2007<br>
about setting a &quot;hub&quot; mode by setting the aging timer to 0. I tri=
ed that<br>
and it did not work.<br>
<br>
I also tried a few schemes with ebtables without success either. Is<br>
there some relatively easy way to make the bridge forward everything and<br=
>
not cut off the transmit after a single packet?<br>
<br>
/ Here is what one end of the link looks like.<br>
//<br>
// =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +-------------+<br>
// /// =A0 =A0 =A0/// + eth0 +---+ =A0 bridge 1 =A0+---+ wan0 ---&gt; Trans=
mit<br>
// =A0 =A0 =A0 =A0| =A0 =A0 =A0 =A0 =A0+-------------+<br>
// =A0 =A0 =A0 =A0|<br>
//switch--+<br>
// =A0 =A0 =A0 =A0| =A0 =A0 =A0 =A0 =A0+-------------+<br>
// =A0 =A0 =A0 =A0+ eth0 +---+ =A0 bridge 2 =A0+---+ wan0 &lt;--- Receive<b=
r>
// =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +-------------+<br>
/<br>
The WAN side uses a synchronous serial interface to the radios for<br>
satellite communications. The other end uses a single radio and bridge.<br>
<br>
Mike Boutte<br>
<br>
_______________________________________________<br>
Bridge mailing list<br>
<a href=3D"mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linux-fou=
ndation.org</a><br>
<a href=3D"https://lists.linux-foundation.org/mailman/listinfo/bridge" targ=
et=3D"_blank">https://lists.linux-foundation.org/mailman/listinfo/bridge</a=
><br>
</blockquote></div><br>

--0015175ca7beab749204677378ac--
