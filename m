Message-ID: <34d8b2fe0703010109r2f881419wbae1f2c8869e6252@mail.gmail.com>
Date: Thu, 1 Mar 2007 10:09:56 +0100
From: "Louis Croisez" <louis.croisez@gmail.com>
In-Reply-To: <45E5C2BE.3070808@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_57764_28230689.1172740196919"
References: <34d8b2fe0702270811h5098894aia299857618e8dde@mail.gmail.com>
	<34d8b2fe0702280625y1d1184f2h2f1f0792ac105977@mail.gmail.com>
	<45E5C2BE.3070808@candelatech.com>
Subject: Re: [Bridge] About support of 802.1p standard into 2.6 linux Bridge
	code
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Ben Greear <greearb@candelatech.com>
Cc: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------=_Part_57764_28230689.1172740196919
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ok, thx.
Is there any netfilter patch or code available to be able to filter frames
on base of such QoS parameter?

On 2/28/07, Ben Greear <greearb@candelatech.com> wrote:
>
> Louis Croisez wrote:
> > Hello,
> > i would like to know if the 802.1p (QoS for Ethernet frames) standard
> > is implemented into last 2.6 kernel Bridging code?
> > Cheers,
> > Louis.
> It's implemented in the VLAN code, at least as far as being able to map
> a socket priority to a vlan priority.  There
> is no special queue handling based on the priority bits at this time, at
> least in vlan code.
>
> Ben
>
> > ------------------------------------------------------------------------
> >
> > _______________________________________________
> > Bridge mailing list
> > Bridge@lists.osdl.org
> > https://lists.osdl.org/mailman/listinfo/bridge
> >
>
>
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>
>
>

------=_Part_57764_28230689.1172740196919
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ok, thx.<br>Is there any netfilter patch or code available to be able to filter frames on base of such QoS parameter?<br><br><div><span class="gmail_quote">On 2/28/07, <b class="gmail_sendername">Ben Greear</b> &lt;<a href="mailto:greearb@candelatech.com">
greearb@candelatech.com</a>&gt; wrote:</span><blockquote class="gmail_quote" DEFANGED_style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Louis Croisez wrote:<br>&gt; Hello,<br>&gt; i would like to know if the 
802.1p (QoS for Ethernet frames) standard<br>&gt; is implemented into last 2.6 kernel Bridging code?<br>&gt; Cheers,<br>&gt; Louis.<br>It&#39;s implemented in the VLAN code, at least as far as being able to map<br>a socket priority to a vlan priority.&nbsp;&nbsp;There
<br>is no special queue handling based on the priority bits at this time, at<br>least in vlan code.<br><br>Ben<br><br>&gt; ------------------------------------------------------------------------<br>&gt;<br>&gt; _______________________________________________
<br>&gt; Bridge mailing list<br>&gt; <a href="mailto:Bridge@lists.osdl.org">Bridge@lists.osdl.org</a><br>&gt; <a href="https://lists.osdl.org/mailman/listinfo/bridge">https://lists.osdl.org/mailman/listinfo/bridge</a><br>
&gt;<br><br><br>--<br>Ben Greear &lt;<a href="mailto:greearb@candelatech.com">greearb@candelatech.com</a>&gt;<br>Candela Technologies Inc&nbsp;&nbsp;<a href="http://www.candelatech.com">http://www.candelatech.com</a><br><br><br></blockquote>
</div><br>

------=_Part_57764_28230689.1172740196919--
