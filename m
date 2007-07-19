DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed; d=gmail.com; s=beta;
	h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
	b=jZXfTX9BQdS1iIweWFPRAjbpJDcCPckLrKPTb8H9yTJ4IpXKWVh90uJgYTJD+UDeS7la83cs8ewCE74BZ8MJ0aa48YM1Zyi/gMPyLQE8CozOfj5mwpee+hRJCdHQAdh4XtEdwDU/csyxpw85Vbr2Wpet2dEGxSCIa+xLZ5AoOFI=
Message-ID: <228b46650707190519p5f5d7546ud5a4c45f7d5a8144@mail.gmail.com>
Date: Thu, 19 Jul 2007 17:49:50 +0530
From: "rajneesh rana" <rana.rajneesh@gmail.com>
Subject: Re: [Bridge] Reading and writing from tap device attacted to bridge
In-Reply-To: <20070718142729.10adca3e@oldman>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_64327_21523898.1184847590211"
References: <228b46650707180607v2d8e8abar99bb0e3af8548ab3@mail.gmail.com>
	<20070718142729.10adca3e@oldman>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org

------=_Part_64327_21523898.1184847590211
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanx for help
I m newbie to tun/tap programming so plz be patient with my limited
knowledge. I wanna to read packets from tap and ultimately wanna alow only
SMTP packets from specific recipients.
my confusion is at this point is
once you open a tap device
if ((tap_fd = open("/dev/net/tun", O_RDWR)) < 0) { ..........   }
and then read from
like
if ((len = read(tap_fd, buf, sizeof(buf))) <= 0)
{ .......... }
Now what to expect from read. Is it sk_buff, tun_struct or ethernet header
structure.



On 7/18/07, Stephen Hemminger <shemminger@linux-foundation.org> wrote:
>
> On Wed, 18 Jul 2007 18:37:38 +0530
> "rajneesh rana" <rana.rajneesh@gmail.com> wrote:
>
> > On 7/18/07, rajneesh rana <rana.rajneesh@gmail.com> wrote:
> > >
> > > I'm trying to trap ethernet frames from a user process over the wire,
> > > using the linux tap device. I see a lot of docs/threads about using
> tun
> > > device, but none for tap device.
>
> Use AF_PACKET, it is easier and faster. That is what tcpdump etc use.
>
> > > I am able to open Tap device and attach it to bridge but getting no
> clue
> > > how to read and write  data from tap device.
>
> Examples in http://vtun.sourceforge.net/tun/
>

------=_Part_64327_21523898.1184847590211
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanx for help<br>I m newbie to tun/tap programming so plz be patient with my limited knowledge. I wanna to read packets from tap and ultimately wanna alow only SMTP packets from specific recipients.<br>my confusion is at this point is
<br>once you open a tap device<br>if ((tap_fd = open(&quot;/dev/net/tun&quot;, O_RDWR)) &lt; 0) { .......... &nbsp; }<br>and then read from <br>like <br>if ((len = read(tap_fd, buf, sizeof(buf))) &lt;= 0) <br>{ .......... }<br>
Now what to expect from read. Is it sk_buff, tun_struct or ethernet header structure.<br><br><br><br><div><span class="gmail_quote">On 7/18/07, <b class="gmail_sendername">Stephen Hemminger</b> &lt;<a href="mailto:shemminger@linux-foundation.org">
shemminger@linux-foundation.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">On Wed, 18 Jul 2007 18:37:38 +0530<br>&quot;rajneesh rana&quot; &lt;
<a href="mailto:rana.rajneesh@gmail.com">rana.rajneesh@gmail.com</a>&gt; wrote:<br><br>&gt; On 7/18/07, rajneesh rana &lt;<a href="mailto:rana.rajneesh@gmail.com">rana.rajneesh@gmail.com</a>&gt; wrote:<br>&gt; &gt;<br>&gt; &gt; I&#39;m trying to trap ethernet frames from a user process over the wire,
<br>&gt; &gt; using the linux tap device. I see a lot of docs/threads about using tun<br>&gt; &gt; device, but none for tap device.<br><br>Use AF_PACKET, it is easier and faster. That is what tcpdump etc use.<br><br>&gt; &gt; I am able to open Tap device and attach it to bridge but getting no clue
<br>&gt; &gt; how to read and write&nbsp;&nbsp;data from tap device.<br><br>Examples in <a href="http://vtun.sourceforge.net/tun/">http://vtun.sourceforge.net/tun/</a><br></blockquote></div><br>

------=_Part_64327_21523898.1184847590211--
