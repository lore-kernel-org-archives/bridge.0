Message-ID: <6f6192b30810020638q72016966pccfc0e7b9acb3db5@mail.gmail.com>
Date: Thu, 2 Oct 2008 09:38:20 -0400
From: "M T" <m.t.linuxbridge@gmail.com>
In-Reply-To: <fed120860810011401i33a7d752qd5abf1490b3900f4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_106938_14646118.1222954700160"
References: <6f6192b30810010757j408cbcb7jd5ee33b8da832cbe@mail.gmail.com>
	<20081001173246.5ee6696e@speedy>
	<fed120860810011401i33a7d752qd5abf1490b3900f4@mail.gmail.com>
Subject: Re: [Bridge] RSTP location and GPL info
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

------=_Part_106938_14646118.1222954700160
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks a lot for the response.

Can you please tell me how far is the original RSTP implementation from
802.1D-2004? The only reason I ask is to understand if the original library
can be modified to suit my purposes.

Thanks,
MT

On Wed, Oct 1, 2008 at 5:01 PM, Srinivas M.A. <srinivas.aji@gmail.com>wrote:

> MT,
>
> The rstplib/ directory in Stephen's git repo is the RSTPLIB library
> also available at sourceforge (http://rstplib.sourceforge.net/), but
> with some small modifications for our purposes.
> RSTPLIB itself is under LGPL, and if you intend to use it, it may be
> better to start with the original version from sourceforge.
>
> I wrote another RSTP library to replace RSTPLIB and be compliant with
> 802.1D-2004. I have not hosted that anywhere yet. That library is
> licensed, together with the rest of my RSTP work, as GPL v >= 2.
>
> I will email that to you separately to avoid the attachment on the mailing
> list.
>
> On Wed, Oct 1, 2008 at 9:02 PM, Stephen Hemminger <shemminger@vyatta.com>
> wrote:
> > On Wed, 1 Oct 2008 10:57:42 -0400
> > "M T" <m.t.linuxbridge@gmail.com> wrote:
> >
> >> I am currently working on a project for work where I need to implement
> RSTP
> >> on non-Linux platforms (possibly ThreadX). I saw that there was a form
> by
> >> Mr. Srinivas Aji that implemented RSTP on Linux Bridge. Can someone
> please
> >> tell me if that fork is somewhere on the kernel.org git repository?
> >>
> >> I would like to use this work (without changing any code). I don't
> >> understand the intricacies of GPL.
> >>
> >> * Can someone please point me to resources that say what I can and
> cannot
> >> use in my project?
> >> * I cannot open source my project but I am willing to contribute back
> any
> >> changes I make to portions of linux bridge. I don't mind testing it on
> linux
> >> before submitting changes. Is this alright?
> >> * Also, I just need to use portions of the project. For example, I only
> care
> >> about the state machines and not the interaction with the Linux OS. Can
> I
> >> just use bits and pieces of the linux bridge project?
> >>
> >> Thanks,
> >> MT
> >
> > Did you look at
> > git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/rstp.git
> >
> > It is GPL v2.
> > _______________________________________________
> > Bridge mailing list
> > Bridge@lists.linux-foundation.org
> > https://lists.linux-foundation.org/mailman/listinfo/bridge
> >
>

------=_Part_106938_14646118.1222954700160
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Thanks a lot for the response. <br><br>Can you please tell me how far is the original RSTP implementation from 802.1D-2004? The only reason I ask is to understand if the original library can be modified to suit my purposes.<br>
<br>Thanks,<br>MT<br><br><div class="gmail_quote">On Wed, Oct 1, 2008 at 5:01 PM, Srinivas M.A. <span dir="ltr">&lt;<a href="mailto:srinivas.aji@gmail.com">srinivas.aji@gmail.com</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
MT,<br>
<br>
The rstplib/ directory in Stephen&#39;s git repo is the RSTPLIB library<br>
also available at sourceforge (<a href="http://rstplib.sourceforge.net/" target="_blank">http://rstplib.sourceforge.net/</a>), but<br>
with some small modifications for our purposes.<br>
RSTPLIB itself is under LGPL, and if you intend to use it, it may be<br>
better to start with the original version from sourceforge.<br>
<br>
I wrote another RSTP library to replace RSTPLIB and be compliant with<br>
802.1D-2004. I have not hosted that anywhere yet. That library is<br>
licensed, together with the rest of my RSTP work, as GPL v &gt;= 2.<br>
<br>
I will email that to you separately to avoid the attachment on the mailing list.<br>
<div><div></div><div class="Wj3C7c"><br>
On Wed, Oct 1, 2008 at 9:02 PM, Stephen Hemminger &lt;<a href="mailto:shemminger@vyatta.com">shemminger@vyatta.com</a>&gt; wrote:<br>
&gt; On Wed, 1 Oct 2008 10:57:42 -0400<br>
&gt; &quot;M T&quot; &lt;<a href="mailto:m.t.linuxbridge@gmail.com">m.t.linuxbridge@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; I am currently working on a project for work where I need to implement RSTP<br>
&gt;&gt; on non-Linux platforms (possibly ThreadX). I saw that there was a form by<br>
&gt;&gt; Mr. Srinivas Aji that implemented RSTP on Linux Bridge. Can someone please<br>
&gt;&gt; tell me if that fork is somewhere on the <a href="http://kernel.org" target="_blank">kernel.org</a> git repository?<br>
&gt;&gt;<br>
&gt;&gt; I would like to use this work (without changing any code). I don&#39;t<br>
&gt;&gt; understand the intricacies of GPL.<br>
&gt;&gt;<br>
&gt;&gt; * Can someone please point me to resources that say what I can and cannot<br>
&gt;&gt; use in my project?<br>
&gt;&gt; * I cannot open source my project but I am willing to contribute back any<br>
&gt;&gt; changes I make to portions of linux bridge. I don&#39;t mind testing it on linux<br>
&gt;&gt; before submitting changes. Is this alright?<br>
&gt;&gt; * Also, I just need to use portions of the project. For example, I only care<br>
&gt;&gt; about the state machines and not the interaction with the Linux OS. Can I<br>
&gt;&gt; just use bits and pieces of the linux bridge project?<br>
&gt;&gt;<br>
&gt;&gt; Thanks,<br>
&gt;&gt; MT<br>
&gt;<br>
&gt; Did you look at<br>
&gt; git://<a href="http://git.kernel.org/pub/scm/linux/kernel/git/shemminger/rstp.git" target="_blank">git.kernel.org/pub/scm/linux/kernel/git/shemminger/rstp.git</a><br>
&gt;<br>
&gt; It is GPL v2.<br>
</div></div>&gt; _______________________________________________<br>
&gt; Bridge mailing list<br>
&gt; <a href="mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linux-foundation.org</a><br>
&gt; <a href="https://lists.linux-foundation.org/mailman/listinfo/bridge" target="_blank">https://lists.linux-foundation.org/mailman/listinfo/bridge</a><br>
&gt;<br>
</blockquote></div><br></div>

------=_Part_106938_14646118.1222954700160--
