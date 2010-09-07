MIME-Version: 1.0
From: matan monitz <mmonitz@gmail.com>
Date: Tue, 7 Sep 2010 18:45:51 +0300
Message-ID: <AANLkTin4xM45K0t-sFsbC9B78EpfpyiJYFcHmMohURwx@mail.gmail.com>
Content-Type: multipart/alternative; boundary=000e0cd17216ec9af3048fad4bd5
Subject: [Bridge]  [patch net-next-2.6] bridge: allow hub-like behaviour
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--000e0cd17216ec9af3048fad4bd5
Content-Type: text/plain; charset=UTF-8

hello
very useful option i must say
i was looking for something like this for quiet a while and now i have a few
comments/question

1.after initially not being able to find this solution i started looking at
the code thinking that a small modification might do the trick
under br_input.c (kernel 2.6.18) around line 58 there is a section that
starts with
"if (br->dev->flags & IFF_PROMISC)
{
 ..
br_pass_frame_up(br,skb2));
..
}
"
to my understanding this should have then the job, all i needed to do was
set the bridge to promsicous mode
that didn't work,
did i get it wrong? what is the meaning of this piece of code

 2. why is this working? what is the logic behind it (ageing=0)
3. why isn't this documented?

finding this thread took a long time and along the way i read other people's
forum posts\mailing list questions,
too bad it's not in the man

--000e0cd17216ec9af3048fad4bd5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>hello</div>
<div>very useful option i must say</div>
<div>i was looking for something like this for quiet a while and now i have=
 a few comments/question</div>
<div>=C2=A0</div>
<div>1.after initially not being able to find this solution i started looki=
ng at the code thinking that a small modification might do the trick</div>
<div>under br_input.c (kernel 2.6.18) around line 58=C2=A0there is a sectio=
n that starts with </div>
<div>&quot;if (br-&gt;dev-&gt;flags &amp; IFF_PROMISC)</div>
<div>{</div>
<div>=C2=A0.. </div>
<div>br_pass_frame_up(br,skb2));</div>
<div>..</div>
<div>}</div>
<div>&quot;</div>
<div>to my understanding this should have then the job, all i needed to do =
was set the bridge to promsicous mode</div>
<div>that didn&#39;t work, </div>
<div>did i get it wrong? what is the meaning of this piece of code </div>
<div>=C2=A0</div>
<div>
<div>2. why is this working? what is the logic behind it (ageing=3D0)</div>
<div>3. why isn&#39;t this documented?</div></div>
<div>=C2=A0</div>
<div>finding this thread took a long time and along the way i read other pe=
ople&#39;s forum posts\mailing list questions, </div>
<div>too bad it&#39;s not in the man</div></div>

--000e0cd17216ec9af3048fad4bd5--
