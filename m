DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed; d=gmail.com; s=beta;
	h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
	b=trIXR9gpBSAjLHdhVML72cMSSDJEUN3Hik2VEYyeO5jYOpyaVeUIrEY6TS9Uvi58FvlekzqL4S7avK3k7icf9dhqnapAtD8u2gxYvXD2m5YcVXvJqzJfsX056XvslGfItZ1/p8rc1hgVylMe3In2CAK27RjCHFVA7s/pdZMQGSA=
Message-ID: <2e59e6970707052153v3a9a554cl98e1f40c89e11135@mail.gmail.com>
Date: Thu, 5 Jul 2007 23:53:37 -0500
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Subject: Re: [Bridge] jumpstart stp port to forwarding state
In-Reply-To: <H0000069001d36e5.1183693579.mail.pacificwireless.net.au@MHS>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_147341_33190459.1183697617108"
References: <2e59e6970707051702x7d264db4te7a34f7b6db0a5ee@mail.gmail.com>
	<H0000069001d36e5.1183693579.mail.pacificwireless.net.au@MHS>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Leigh Sharpe <lsharpe@pacificwireless.com.au>
Cc: bridge <bridge@lists.linux-foundation.org>

------=_Part_147341_33190459.1183697617108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 7/5/07, Leigh Sharpe <lsharpe@pacificwireless.com.au> wrote:
>
>  brctl setfd br0 0
>
> Sets the forwarding delay on the bridge to 0, making it forward
> immediately, instead of going into 'learning' mode. This affects the entire
> bridge, not just a single port.
>


Thanks for the suggestions.  I already reduced it to 1, but was wary of
trying 0.

Would that make spanning tree flap?  Or is there still some hysteresis loop
allowing it to stabilize?

We have a transparent traffic shaper which sometimes locks up.  The port to
the bandwidth shaper I know will always need to be in forwarding mode.  When
spanning tree detects that the traffic shaper is no longer passing traffic,
the other port will need to start forwarding in order to bypass it and reach
the routers beyond.


Regards,
>              Leigh
>
> Leigh Sharpe
> Network Systems Engineer
> Pacific Wireless
> Ph +61 3 9584 8966
> Mob 0408 009 502
> Helpdesk 1300 300 616
> email lsharpe@pacificwireless.com.au
> web www.pacificwireless.com.au
>
>
>  ------------------------------
>    *From:* richardvoigt@gmail.com [mailto:richardvoigt@gmail.com]
> *Sent:* Friday, July 06, 2007 10:03 AM
> *To:* bridge@lists.linux-foundation.org
> *Subject:* [Bridge] jumpstart stp port to forwarding state
>
>  Sorry if this is a dupe, but the mailing list join email got delayed by
> 10 or 12 hours and so I think this message wasn't accepted:
>
> ----------------
>
> I've googled for this, but since there are so many pages talking about
> linux boxes connected to CIsco equipment, I can't find anything relevant.
>
> Does linux bridging support anything like cisco's portfast (port starts in
> forwarding state)?  Is there a way (sysfs, ioctl) to at least change a port
> to forwarding immediately?  Even bridges with stp disabled take some time
> bringing ports up after a topology change.  If the delay can't be
> eliminated, can I wait for it somehow in my startup scripts to avoid initial
> connection failures?
>
> My preference would be to have something like:
>
> brctl portfast br0 bond0.10 on
>
> or
>
> brctl initialstate br0 bond0.10 forwarding
>
>
>
> Also, can stp disable all ports in the same bridge?  I would assume not, a
> minimum spanning tree needs at least one port forwarding (could that port
> somehow be a different interface on the same box, not a member of the
> bridge?).  If at least one port is always forwarding, could the minimum cost
> port be set to forwarding by default when the bridge is brought up (ip link
> set br0 up) irrespective of any portfast-alike setting?
>
> I'm trying to minimize startup time on a firewall.
>
> Thanks for any information you can provide.
>
> Ben Voigt
>

------=_Part_147341_33190459.1183697617108
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 7/5/07, <b class="gmail_sendername">Leigh Sharpe</b> &lt;<a href="mailto:lsharpe@pacificwireless.com.au">lsharpe@pacificwireless.com.au</a>&gt; wrote:<div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">




<div>
<div dir="ltr" align="left"><span><font face="Arial" size="2">brctl setfd br0 0</font></span>
</div>
<div dir="ltr" align="left"><span><font face="Arial" size="2"></font></span>&nbsp;
</div>
<div dir="ltr" align="left"><span><font face="Arial" size="2">Sets the forwarding delay on the bridge to 0, making it forward 
immediately, instead of going into &#39;learning&#39; mode. This affects the entire 
bridge, not just a single port.</font></span></div></div></blockquote><div><br><br>Thanks for the suggestions.&nbsp; I already reduced it to 1, but was wary of trying 0. <br></div><div><br>Would that make spanning tree flap?&nbsp; Or is there still some hysteresis loop allowing it to stabilize?
<br><br>We have a transparent traffic shaper which sometimes locks up.&nbsp; The port to the bandwidth shaper I know will always need to be in forwarding mode.&nbsp; When spanning tree detects that the traffic shaper is no longer passing traffic, the other port will need to start forwarding in order to bypass it and reach the routers beyond.
<br>&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div align="left"><div align="left"><font face="Arial" size="2">Regards,
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
Leigh</font>
</div>
<div>&nbsp;
</div>
<div><font face="Arial" size="2">Leigh Sharpe<br>
Network Systems Engineer<br>
Pacific 
Wireless<br>
Ph +61 3 9584 8966<br>
Mob 0408 009 502</font>
</div>
<div><font face="Arial" size="2">Helpdesk 1300 300 616<br>
email <a title="mailto:lsharpe@pacificwireless.com.au">lsharpe@pacificwireless.com.au</a><br>
web 
<a title="http://www.pacificwireless.com.au/">www.pacificwireless.com.au</a></font>
</div></div>
<div>&nbsp;
</div><br>

<div dir="ltr" align="left" lang="en-us">
<hr>&nbsp;&nbsp;


<font face="Tahoma" size="2"><b>From:</b> <a href="mailto:richardvoigt@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">richardvoigt@gmail.com</a> 
[mailto:<a href="mailto:richardvoigt@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">richardvoigt@gmail.com</a>] <br>
<b>Sent:</b> Friday, July 06, 2007 10:03 
AM<br>
<b>To:</b> <a href="mailto:bridge@lists.linux-foundation.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">bridge@lists.linux-foundation.org</a><br>
<b>Subject:</b> [Bridge] 
jumpstart stp port to forwarding state<br>
</font><br>

</div><div><span class="e" id="q_11399a2b8e7fa108_1">
<div></div><span class="gmail_quote">
<p>Sorry if this is a dupe, but the mailing list join email got delayed by 10 or 
12 hours and so I think this message wasn&#39;t 
accepted:<br>
<br>
----------------<br>
<br>
</p></span>I&#39;ve googled for this, but since 
there are so many pages talking about linux boxes connected to CIsco equipment, 
I can&#39;t find anything relevant. <br>
<br>
Does linux bridging support anything 
like cisco&#39;s portfast (port starts in forwarding state)?&nbsp; Is there a way 
(sysfs, ioctl) to at least change a port to forwarding immediately?&nbsp; Even 
bridges with stp disabled take some time bringing ports up after a topology 
change.&nbsp; If the delay can&#39;t be eliminated, can I wait for it somehow in my 
startup scripts to avoid initial connection failures? <br>
<br>
My preference 
would be to have something like:<br>
<br>
brctl portfast br0 bond0.10 
on<br>
<br>
or<br>
<br>
brctl initialstate br0 bond0.10 
forwarding<br>
<br>
<br>
<br>
Also, can stp disable all ports in the same 
bridge?&nbsp; I would assume not, a minimum spanning tree needs at least one 
port forwarding (could that port somehow be a different interface on the same 
box, not a member of the bridge?).&nbsp; If at least one port is always 
forwarding, could the minimum cost port be set to forwarding by default when the 
bridge is brought up (ip link set br0 up) irrespective of any portfast-alike 
setting? <br>
<br>
I&#39;m trying to minimize startup time on a 
firewall.<br>
<br>
Thanks for any information you can provide.<br>
<br>
Ben 
Voigt<br>


</span></div></div></blockquote></div><br>

------=_Part_147341_33190459.1183697617108--
