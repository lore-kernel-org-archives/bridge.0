MIME-Version: 1.0
In-Reply-To: <2e59e6970905041640q55c60531j7355e9522dff773a@mail.gmail.com>
References: <45a1b53e0905040747p48466d3aye289314499c01a2e@mail.gmail.com>
	<2e59e6970905041640q55c60531j7355e9522dff773a@mail.gmail.com>
Date: Tue, 5 May 2009 11:08:49 -0500
Message-ID: <45a1b53e0905050908w3b4b1522i29b4af14b6673e88@mail.gmail.com>
From: Wade Maxfield <wmaxfield@gmail.com>
Content-Type: multipart/alternative; boundary=00163628513c8c68a904692c7ed1
Subject: Re: [Bridge] /dev/tap on uClinux and bridging
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Cc: Bridge@lists.linux-foundation.org

--00163628513c8c68a904692c7ed1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

  That is an interesting proposition.  I'll investigate.

  I don't know anything about libpcap, so I have a few questions for the
expert <grin>.

   Will it handle all Etherent frames? As a bridge, that is what I need.
   Will it allow me to gracefully drop stuff on the floor? I'm assuming the
Ethernet bridge code in the kernel will do that, I'm not sure of the effect
in libpcap.

   I'm also assuming that I could not use IPchains if I do libpcap.  That
might be worth a tradeoff.

   Finally, just for curiosity sake, what Major, Minor numbers should the
/dev/tap entries be?  I have not yet had anyone be able to answer that
question, and it puzzles me.

thanks,
Wade

On Mon, May 4, 2009 at 6:40 PM, richardvoigt@gmail.com <
richardvoigt@gmail.com> wrote:

> You should probably just use libpcap to receive all packets from each
> interface, and SOCK_RAW to send.  This should be a more efficient of getting
> packets to usermode than using bridging.
>
> On Mon, May 4, 2009 at 9:47 AM, Wade Maxfield <wmaxfield@gmail.com> wrote:
>
>>
>>   I'm trying to use bridging and TUN/TAP on uClinux on Nios processor, on
>> an Altera fpga.
>>
>>   I downloaded the source for tunctl and it compiled and runs just fine.
>>
>>   It says it created tap0, tap1, tap2, etc., but they don't show up in the
>> /dev directory.
>>
>>    I'm assuming because there is no demon to create these entries.
>>
>>    I looked at Ubuntu, and saw the /dev/tapx entries are major, minor
>> 36,16.
>>
>>   However, the /dev/net/tun in the uClinux is 200,10.
>>
>>    My question is this: If I create /dev/tap0 in the /dev directory, which
>> Major,Minor number should I give it?
>>
>>    I'm a little fuzzy on this.  I'm assuming if the Major/Minor numbers
>> are wrong, the brctl program won't be able to use the tap0 interface.
>>
>>    I want to do this, ultimately:
>>
>>   [ethernet]----[kernel bridge]---[tap]---(user program)------data
>> link------(user program)---[tap]---[kernel bridge]--[ethernet]
>>
>>   The data link is non standard and proprietary.  The goal is to bridge
>> the two ethernets.
>>
>>   Can someone give me some heads up?  Any pointers would be appreciated!!!
>>
>> thanks,
>> Wade
>>
>>
>>
>> _______________________________________________
>> Bridge mailing list
>> Bridge@lists.linux-foundation.org
>> https://lists.linux-foundation.org/mailman/listinfo/bridge
>>
>
>


-- 
------------------------------------------------------
CTI - Hostile Environment Development
6040 Camp Bowie Blvd
Suite 24
Fort Worth, TX 76116
office 817-737-7100 ext. 4#
cell    817-965-2920
http://www.ctelcom.net
------------------------------------------------------

--00163628513c8c68a904692c7ed1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

=A0 That is an interesting proposition.=A0 I&#39;ll investigate.<br><br>=A0=
 I don&#39;t know anything about libpcap, so I have a few questions for the=
 expert &lt;grin&gt;.<br><br>=A0=A0 Will it handle all Etherent frames? As =
a bridge, that is what I need.<br>
=A0=A0 Will it allow me to gracefully drop stuff on the floor? I&#39;m assu=
ming the Ethernet bridge code in the kernel will do that, I&#39;m not sure =
of the effect in libpcap.<br><br>=A0=A0 I&#39;m also assuming that I could =
not use IPchains if I do libpcap.=A0 That might be worth a tradeoff.<br>
<br>=A0=A0 Finally, just for curiosity sake, what Major, Minor numbers shou=
ld the /dev/tap entries be?=A0 I have not yet had anyone be able to answer =
that question, and it puzzles me.<br><br>thanks,<br>Wade<br><br><div class=
=3D"gmail_quote">
On Mon, May 4, 2009 at 6:40 PM, <a href=3D"mailto:richardvoigt@gmail.com">r=
ichardvoigt@gmail.com</a> <span dir=3D"ltr">&lt;<a href=3D"mailto:richardvo=
igt@gmail.com">richardvoigt@gmail.com</a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); m=
argin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
You should probably just use libpcap to receive all packets from each inter=
face, and SOCK_RAW to send.=A0 This should be a more efficient of getting p=
ackets to usermode than using bridging.<br><br><div class=3D"gmail_quote"><=
div>
<div></div><div class=3D"h5">On Mon, May 4, 2009 at 9:47 AM, Wade Maxfield =
<span dir=3D"ltr">&lt;<a href=3D"mailto:wmaxfield@gmail.com" target=3D"_bla=
nk">wmaxfield@gmail.com</a>&gt;</span> wrote:<br>
</div></div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px sol=
id rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div>=
<div></div><div class=3D"h5"><br>=A0 I&#39;m trying to use bridging and TUN=
/TAP on uClinux on Nios processor, on an Altera fpga.<br>

<br>=A0 I downloaded the source for tunctl and it compiled and runs just fi=
ne.=A0 <br><br>=A0 It says it created tap0, tap1, tap2, etc., but they don&=
#39;t show up in the /dev directory.<br>
<br>=A0=A0 I&#39;m assuming because there is no demon to create these entri=
es.<br><br>=A0=A0 I looked at Ubuntu, and saw the /dev/tapx entries are maj=
or, minor 36,16.=A0 <br><br>=A0 However, the /dev/net/tun in the uClinux is=
 200,10.<br>


<br>=A0=A0 My question is this: If I create /dev/tap0 in the /dev directory=
, which Major,Minor number should I give it?<br><br>=A0=A0 I&#39;m a little=
 fuzzy on this.=A0 I&#39;m assuming if the Major/Minor numbers are wrong, t=
he brctl program won&#39;t be able to use the tap0 interface.<br>


<br>=A0=A0 I want to do this, ultimately:<br><br>=A0 [ethernet]----[kernel =
bridge]---[tap]---(user program)------data link------(user program)---[tap]=
---[kernel bridge]--[ethernet]<br><br>=A0 The data link is non standard and=
 proprietary.=A0 The goal is to bridge the two ethernets.<br>


<br>=A0 Can someone give me some heads up?=A0 Any pointers would be appreci=
ated!!!<br><br>thanks,<br><font color=3D"#888888">Wade<br><br>=A0 <br>
</font><br></div></div>_______________________________________________<br>
Bridge mailing list<br>
<a href=3D"mailto:Bridge@lists.linux-foundation.org" target=3D"_blank">Brid=
ge@lists.linux-foundation.org</a><br>
<a href=3D"https://lists.linux-foundation.org/mailman/listinfo/bridge" targ=
et=3D"_blank">https://lists.linux-foundation.org/mailman/listinfo/bridge</a=
><br></blockquote></div><br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>-----------------------=
-------------------------------<br>CTI - Hostile Environment Development<br=
>6040 Camp Bowie Blvd<br>Suite 24<br>Fort Worth, TX 76116<br>office 817-737=
-7100 ext. 4#<br>
cell =A0 =A0817-965-2920<br><a href=3D"http://www.ctelcom.net">http://www.c=
telcom.net</a><br>------------------------------------------------------<br=
>

--00163628513c8c68a904692c7ed1--
