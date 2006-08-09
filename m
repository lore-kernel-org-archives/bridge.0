Message-ID: <116823230608081853q4ee25c78hef3ae9c23976264f@mail.gmail.com>
Date: Wed, 9 Aug 2006 09:53:36 +0800
From: "He, Zhenjie" <hezhenjie@gmail.com>
In-Reply-To: <20060808113025.6dc41308@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_79355_25242231.1155088416545"
References: <449AA3EF.9080300@kingsley.co.za>
	<20060707114918.26b099ba@dxpl.pdx.osdl.net>
	<116823230608072305g1ef9f73la91213524d74b17c@mail.gmail.com>
	<20060808113025.6dc41308@localhost.localdomain>
Subject: Re: [Bridge] Network seperation and ethernet bridge...
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------=_Part_79355_25242231.1155088416545
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thank you for your reply.
Please see the following comments.
On 8/9/06, Stephen Hemminger <shemminger@osdl.org> wrote:
>
> On Tue, 8 Aug 2006 14:05:03 +0800
> "He, Zhenjie" <hezhenjie@gmail.com> wrote:
>
> > Hi, Stephen/all,
> >
> > The situation I meet is similar as this.
> >
> > I want to capture BPDU packets go through the Linux bridge,
>
> Simpler just to use something like AF_PACKET, or tools like pcapture?


I intend to use a Linux bridge with stp enable in the internal to generate
BPDU packets, and use ethereal or tcpdump to capture packets in the other
side.
Is there other ways to generate BPDU?

>
> > [internal bridge] --> (connected with a switch) --> [external bridge]
> -->
> > workstation,
> >
> > [internal bridge]: br1 ip.addr == 192.168.1.2
> > [external bridge]: ifconfig br0 192.168.1.10 netmask 255.255.255.0 up
> > workstation: ip.addr == 192.168.1.222
> > enable the [internal bridge] with stp on,
> >
> > My question is, could [internal bridge] generate BPDU packets, and pass
> the
> > [external bridge], finally captured on the outside workstation?
> >
> > Best regards,
>
> Nested bridges are not supported because of possible stack depth and
> recursion
> issues.
>

Then, how to deploy the network topology in order to test a Linux bridge
that could pass/block BPDU packets?
Any suggestions, many thanks,

Jason

------=_Part_79355_25242231.1155088416545
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thank you for your reply. <br>Please see the following comments.<br>On 8/9/06, <b class="gmail_sendername">Stephen Hemminger</b> &lt;<a href="mailto:shemminger@osdl.org">shemminger@osdl.org</a>&gt; wrote:<div><span class="gmail_quote">
</span><blockquote class="gmail_quote" DEFANGED_style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">On Tue, 8 Aug 2006 14:05:03 +0800<br>&quot;He, Zhenjie&quot; &lt;<a href="mailto:hezhenjie@gmail.com">
hezhenjie@gmail.com</a>&gt; wrote:<br><br>&gt; Hi, Stephen/all,<br>&gt;<br>&gt; The situation I meet is similar as this.<br>&gt;<br>&gt; I want to capture BPDU packets go through the Linux bridge,<br><br>Simpler just to use something like AF_PACKET, or tools like pcapture?
</blockquote><div>&nbsp;<br>I intend to use a Linux bridge with stp enable in the internal to generate BPDU packets, and use ethereal or tcpdump to capture packets in the other side.<br>Is there other ways to generate BPDU?<br>
 </div><br><blockquote class="gmail_quote" DEFANGED_style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt;<br>&gt; [internal bridge] --&gt; (connected with a switch) --&gt; [external bridge] --&gt;
<br>&gt; workstation,<br>&gt;<br>&gt; [internal bridge]: br1 ip.addr == <a href="http://192.168.1.2">192.168.1.2</a><br>&gt; [external bridge]: ifconfig br0 <a href="http://192.168.1.10">192.168.1.10</a> netmask <a href="http://255.255.255.0">
255.255.255.0</a> up<br>&gt; workstation: ip.addr == <a href="http://192.168.1.222">192.168.1.222</a><br>&gt; enable the [internal bridge] with stp on,<br>&gt;<br>&gt; My question is, could [internal bridge] generate BPDU packets, and pass the
<br>&gt; [external bridge], finally captured on the outside workstation?<br>&gt;<br>&gt; Best regards,<br><br>Nested bridges are not supported because of possible stack depth and recursion<br>issues.<br></blockquote></div>
<br>Then, how to deploy the network topology in order to test a Linux bridge that could pass/block BPDU packets?<br>Any suggestions, many thanks,<br><br>Jason<br>

------=_Part_79355_25242231.1155088416545--
