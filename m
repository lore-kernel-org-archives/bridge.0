Message-ID: <4c9f8dc30610051243p288ea9bq1e8ee16a91ed8207@mail.gmail.com>
Date: Thu, 5 Oct 2006 09:43:17 -1000
From: "Chris U" <chris.uyehara@gmail.com>
In-Reply-To: <20061005073953.4a8bdd6b@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_26397_5476239.1160077397710"
References: <4c9f8dc30610042120o3089cbf6yaaa00728b271953f@mail.gmail.com>
	<20061005073953.4a8bdd6b@localhost.localdomain>
Subject: Re: [Bridge] Bridge Woes...
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

------=_Part_26397_5476239.1160077397710
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Alright list... good news and bad news.

Good news - the bridge works!

Bad news - one of the cat5 cables went "bad" sometime between posting to the
list and now; or maybe someone changed the cables on me w/o my knowledge.

In any case it works! =)

Thanks list for helping me out!

On 10/5/06, Stephen Hemminger <shemminger@osdl.org> wrote:
>
> On Wed, 4 Oct 2006 18:20:43 -1000
> "Chris U" <chris.uyehara@gmail.com> wrote:
>
> > Hi List,
> >
> > I have setup a bridge labeled br0. br0 has an ip address assigned to it.
> My
> > network looks something similar to this...
> >
> > |--------------------|                |--------------------|
> > |------------------|
> > |      laptop        |                |      bridge        |
> > |     router       |
> > | 128.171.103.10/24  |  ----->  (eth1)| 128.171.103.11/24
>   |(eth0)  ----->
> > | 128.171.103.1/24 |
> > | statically assignd |                | statically assignd |
> > | tested / working |
> > |--------------------|                |--------------------|
> > |------------------|
> >
> > Now for the PROBLEM! The bridge can access IP's outside of the subnet
> via
> > eth0 of the bridge, ie - pinging 128.171.1.1, 128.171.3.13,
> 64.233.167.99.
> > The laptop cannot ping the previously listed IPs. The only thing the
> laptop
> > can ping is 128.171.103.11. It's very odd... I tried running tcpdump on
> the
> > bridge. From the bridge I could see the laptop pinging the bridge but I
> > couldn't see the laptop pinging any other IPs. So basically I have a
> bridge
> > that's not really working but the bridge utils show that its working...
> any
> > help would be greatly appreciated!
> >
> > (The laptop works when taken off the bridge and connected to the router,
> the
> > iptables default policy is ACCEPT and the rules are FLUSHED.)
> >
> > Thanks for taking time to read this!
> >
> > ###brctl show br0
> > bridge name     bridge id               STP enabled     interfaces
> > br0             8000.001372fc8436       no              eth0
> >                                                         eth1
> >
> > ###brctl showstp br0
> > br0
> >  bridge id              8000.001372fc8436
> >  designated root        8000.001372fc8436
> >  root port                 0                    path
> cost                  0
> >  max age                  19.99                 bridge max age
> > 19.99
> >  hello time                1.99                 bridge hello time
> > 1.99
> >  forward delay            14.99                 bridge forward delay
> > 14.99
> >  ageing time             299.95
> >  hello timer               0.03                 tcn timer
> > 0.00
> >  topology change timer     0.00                 gc timer
> > 7.97
> >  flags
> >
> >
> > eth0 (1)
> >  port id                8001                    state
> > forwarding
> >  designated root        8000.001372fc8436       path
> cost                100
> >  designated bridge      8000.001372fc8436       message age timer
> > 0.00
> >  designated port        8001                    forward delay timer
> > 0.00
> >  designated cost           0                    hold timer
> > 0.00
> >  flags
> >
> > eth1 (2)
> >  port id                8002                    state
> > forwarding
> >  designated root        8000.001372fc8436       path
> cost                100
> >  designated bridge      8000.001372fc8436       message age timer
> > 0.00
> >  designated port        8002                    forward delay timer
> > 0.00
> >  designated cost           0                    hold timer
> > 0.00
> >  flags
>
>
> How are you setting IP addresses on the bridge.
> You need to NOT assign IP addresses to eth0, eth1 and assign
> an IP address to bridge pseudo device.
>
> What kernel version?
> What hardware is being used for eth0 and eth1? Are either one
> of these wireless (802.11) devices?
>

------=_Part_26397_5476239.1160077397710
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Alright list... good news and bad news.<br><br>Good news - the bridge works!<br><br>Bad news - one of the cat5 cables went &quot;bad&quot; sometime between posting to the list and now; or maybe someone changed the cables on me w/o my knowledge. 
<br><br>In any case it works! =)<br><br>Thanks list for helping me out!<br><br><div><span class="gmail_quote">On 10/5/06, <b class="gmail_sendername">Stephen Hemminger</b> &lt;<a href="mailto:shemminger@osdl.org">shemminger@osdl.org
</a>&gt; wrote:</span><blockquote class="gmail_quote" DEFANGED_style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">On Wed, 4 Oct 2006 18:20:43 -1000<br>&quot;Chris U&quot; &lt;<a href="mailto:chris.uyehara@gmail.com">
chris.uyehara@gmail.com</a>&gt; wrote:<br><br>&gt; Hi List,<br>&gt;<br>&gt; I have setup a bridge labeled br0. br0 has an ip address assigned to it. My<br>&gt; network looks something similar to this...<br>&gt;<br>&gt; |--------------------|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|--------------------|
<br>&gt; |------------------|<br>&gt; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;laptop&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bridge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br>&gt; |&nbsp;&nbsp;&nbsp;&nbsp; router&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>&gt; | <a href="http://128.171.103.10/24">128.171.103.10/24</a>&nbsp;&nbsp;|&nbsp;&nbsp;-----&gt;&nbsp;&nbsp;(eth1)| <a href="http://128.171.103.11/24">
128.171.103.11/24</a>&nbsp;&nbsp;|(eth0)&nbsp;&nbsp;-----&gt;<br>&gt; | <a href="http://128.171.103.1/24">128.171.103.1/24</a> |<br>&gt; | statically assignd |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| statically assignd |<br>&gt; | tested / working |<br>&gt; |--------------------|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|--------------------|
<br>&gt; |------------------|<br>&gt;<br>&gt; Now for the PROBLEM! The bridge can access IP's outside of the subnet via<br>&gt; eth0 of the bridge, ie - pinging <a href="http://128.171.1.1">128.171.1.1</a>, <a href="http://128.171.3.13">
128.171.3.13</a>, <a href="http://64.233.167.99">64.233.167.99</a>.<br>&gt; The laptop cannot ping the previously listed IPs. The only thing the laptop<br>&gt; can ping is <a href="http://128.171.103.11">128.171.103.11</a>
. It's very odd... I tried running tcpdump on the<br>&gt; bridge. From the bridge I could see the laptop pinging the bridge but I<br>&gt; couldn't see the laptop pinging any other IPs. So basically I have a bridge<br>&gt; that's not really working but the bridge utils show that its working... any
<br>&gt; help would be greatly appreciated!<br>&gt;<br>&gt; (The laptop works when taken off the bridge and connected to the router, the<br>&gt; iptables default policy is ACCEPT and the rules are FLUSHED.)<br>&gt;<br>&gt; Thanks for taking time to read this!
<br>&gt;<br>&gt; ###brctl show br0<br>&gt; bridge name&nbsp;&nbsp;&nbsp;&nbsp; bridge id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; STP enabled&nbsp;&nbsp;&nbsp;&nbsp; interfaces<br>&gt; br0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.001372fc8436&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;eth0<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth1
<br>&gt;<br>&gt; ###brctl showstp br0<br>&gt; br0<br>&gt;&nbsp;&nbsp;bridge id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8000.001372fc8436<br>&gt;&nbsp;&nbsp;designated root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8000.001372fc8436<br>&gt;&nbsp;&nbsp;root port&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;path cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0
<br>&gt;&nbsp;&nbsp;max age&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;19.99&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bridge max age<br>&gt; 19.99<br>&gt;&nbsp;&nbsp;hello time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.99&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bridge hello time<br>&gt; 1.99<br>&gt;&nbsp;&nbsp;forward delay&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;14.99&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bridge forward delay
<br>&gt; 14.99<br>&gt;&nbsp;&nbsp;ageing time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 299.95<br>&gt;&nbsp;&nbsp;hello timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.03&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tcn timer<br>&gt; 0.00<br>&gt;&nbsp;&nbsp;topology change timer&nbsp;&nbsp;&nbsp;&nbsp; 0.00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc timer<br>&gt; 7.97<br>&gt;&nbsp;&nbsp;flags
<br>&gt;<br>&gt;<br>&gt; eth0 (1)<br>&gt;&nbsp;&nbsp;port id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8001&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;state<br>&gt; forwarding<br>&gt;&nbsp;&nbsp;designated root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8000.001372fc8436&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; path cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;100<br>&gt;&nbsp;&nbsp;designated bridge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
8000.001372fc8436&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; message age timer<br>&gt; 0.00<br>&gt;&nbsp;&nbsp;designated port&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8001&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;forward delay timer<br>&gt; 0.00<br>&gt;&nbsp;&nbsp;designated cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hold timer<br>&gt; 0.00
<br>&gt;&nbsp;&nbsp;flags<br>&gt;<br>&gt; eth1 (2)<br>&gt;&nbsp;&nbsp;port id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8002&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;state<br>&gt; forwarding<br>&gt;&nbsp;&nbsp;designated root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8000.001372fc8436&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; path cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;100<br>&gt;&nbsp;&nbsp;designated bridge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
8000.001372fc8436&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; message age timer<br>&gt; 0.00<br>&gt;&nbsp;&nbsp;designated port&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8002&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;forward delay timer<br>&gt; 0.00<br>&gt;&nbsp;&nbsp;designated cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hold timer<br>&gt; 0.00
<br>&gt;&nbsp;&nbsp;flags<br><br><br>How are you setting IP addresses on the bridge.<br>You need to NOT assign IP addresses to eth0, eth1 and assign<br>an IP address to bridge pseudo device.<br><br>What kernel version?<br>What hardware is being used for eth0 and eth1? Are either one
<br>of these wireless (802.11) devices?<br></blockquote></div><br>

------=_Part_26397_5476239.1160077397710--
