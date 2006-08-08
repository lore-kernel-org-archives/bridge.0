Message-ID: <116823230608072305g1ef9f73la91213524d74b17c@mail.gmail.com>
Date: Tue, 8 Aug 2006 14:05:03 +0800
From: "He, Zhenjie" <hezhenjie@gmail.com>
In-Reply-To: <20060707114918.26b099ba@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_60645_13211780.1155017103776"
References: <449AA3EF.9080300@kingsley.co.za>
	<20060707114918.26b099ba@dxpl.pdx.osdl.net>
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

------=_Part_60645_13211780.1155017103776
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, Stephen/all,

The situation I meet is similar as this.

I want to capture BPDU packets go through the Linux bridge,

[internal bridge] --> (connected with a switch) --> [external bridge] -->
workstation,

[internal bridge]: br1 ip.addr == 192.168.1.2
[external bridge]: ifconfig br0 192.168.1.10 netmask 255.255.255.0 up
workstation: ip.addr == 192.168.1.222
enable the [internal bridge] with stp on,

My question is, could [internal bridge] generate BPDU packets, and pass the
[external bridge], finally captured on the outside workstation?

Best regards,

Jason,
email: hezhenjie@gmail.com

On 7/8/06, Stephen Hemminger <shemminger@osdl.org> wrote:
>
> On Thu, 22 Jun 2006 16:06:39 +0200
> Etienne Pretorius <etiennep@kingsley.co.za> wrote:
>
> > Hello all,
> >
> > I would like to know if it is possible to have 2 bridge instances
> > running - one for the internal network and the other for the external
> > network.
>
> Yes, you can have two separate bridge instances in the system.
>
> > What I need to explain is that I need the internal bridge to go though
> > the Linux Kernel and pass its packets to the external network bridge.
> > I am also hopeful that the internal network bridge will not need an IP
> > address as I am hoping to allocate the internal network clients a
> gateway
> > address beyond the external network bridge and so when I have 2 similar
> > machines running with both internal and external network bridges
> > that when one machine dies completely then the other will take over.
> > Sooooo what I need to know is will I require proxy-arp and/or
> ip_forwarding?
> >
> >
> > [internal NW] ---> [internal bridge port 1 of  2]----[external bridge
> > port 4 of 4] --->[GW router]----> www.google.com
>
> No, you can't bridge a bridge.
> This is done to prevent creating loops and causing deep stack nesting.
>
> > I would like to make it so that no request can obviously enter the
> > internal network via the external bridge without having been requested
> > from the
> > internal network --- something similar to tcp state marking but for all
> > protocals and/or ether types.
> >
>
>
> --
> Stephen Hemminger <shemminger@osdl.org>
> Quis custodiet ipsos custodes?
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge
>

------=_Part_60645_13211780.1155017103776
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, Stephen/all,<br><br>The situation I meet is similar as this.<br><br>I want to capture BPDU packets go through the Linux bridge, <br><br>[internal bridge] --&gt; (connected with a switch) --&gt; [external bridge] --&gt; workstation,
<br><br>[internal bridge]: br1 ip.addr == <a href="http://192.168.1.2">192.168.1.2</a><br>[external bridge]: ifconfig br0 <a href="http://192.168.1.10">192.168.1.10</a> netmask <a href="http://255.255.255.0">255.255.255.0
</a> up<br>workstation: ip.addr == <a href="http://192.168.1.222">192.168.1.222</a><br>enable the [internal bridge] with stp on,<br><br>My question is, could [internal bridge] generate BPDU packets, and pass the [external bridge], finally captured on the outside workstation?
<br><br>Best regards,<br><br>Jason,<br>email: <a href="mailto:hezhenjie@gmail.com">hezhenjie@gmail.com</a><br><br><div><span class="gmail_quote">On 7/8/06, <b class="gmail_sendername">Stephen Hemminger</b> &lt;<a href="mailto:shemminger@osdl.org">
shemminger@osdl.org</a>&gt; wrote:</span><blockquote class="gmail_quote" DEFANGED_style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">On Thu, 22 Jun 2006 16:06:39 +0200<br>Etienne Pretorius &lt;
<a href="mailto:etiennep@kingsley.co.za">etiennep@kingsley.co.za</a>&gt; wrote:<br><br>&gt; Hello all,<br>&gt;<br>&gt; I would like to know if it is possible to have 2 bridge instances<br>&gt; running - one for the internal network and the other for the external
<br>&gt; network.<br><br>Yes, you can have two separate bridge instances in the system.<br><br>&gt; What I need to explain is that I need the internal bridge to go though<br>&gt; the Linux Kernel and pass its packets to the external network bridge.
<br>&gt; I am also hopeful that the internal network bridge will not need an IP<br>&gt; address as I am hoping to allocate the internal network clients a gateway<br>&gt; address beyond the external network bridge and so when I have 2 similar
<br>&gt; machines running with both internal and external network bridges<br>&gt; that when one machine dies completely then the other will take over.<br>&gt; Sooooo what I need to know is will I require proxy-arp and/or ip_forwarding?
<br>&gt;<br>&gt;<br>&gt; [internal NW] ---&gt; [internal bridge port 1 of&nbsp;&nbsp;2]----[external bridge<br>&gt; port 4 of 4] ---&gt;[GW router]----&gt; <a href="http://www.google.com">www.google.com</a><br><br>No, you can't bridge a bridge.
<br>This is done to prevent creating loops and causing deep stack nesting.<br><br>&gt; I would like to make it so that no request can obviously enter the<br>&gt; internal network via the external bridge without having been requested
<br>&gt; from the<br>&gt; internal network --- something similar to tcp state marking but for all<br>&gt; protocals and/or ether types.<br>&gt;<br><br><br>--<br>Stephen Hemminger &lt;<a href="mailto:shemminger@osdl.org">shemminger@osdl.org
</a>&gt;<br>Quis custodiet ipsos custodes?<br>_______________________________________________<br>Bridge mailing list<br><a href="mailto:Bridge@lists.osdl.org">Bridge@lists.osdl.org</a><br><a href="https://lists.osdl.org/mailman/listinfo/bridge">
https://lists.osdl.org/mailman/listinfo/bridge</a><br></blockquote></div><br>

------=_Part_60645_13211780.1155017103776--
