Message-ID: <b53e36d60610042158g3a347f6do88309f32902c8532@mail.gmail.com>
Date: Thu, 5 Oct 2006 10:28:11 +0530
From: "Jothis T.V" <jothistv@gmail.com>
In-Reply-To: <4c9f8dc30610042120o3089cbf6yaaa00728b271953f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_137916_31712951.1160024291571"
References: <4c9f8dc30610042120o3089cbf6yaaa00728b271953f@mail.gmail.com>
Subject: Re: [Bridge] Bridge Woes...
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Chris U <chris.uyehara@gmail.com>
Cc: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------=_Part_137916_31712951.1160024291571
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Chris,

Just wanted to ensure some basic points here.

1. Can the laptop ping the router OR any other machine in the subnet
128.171.103.0/24?
2. Also, hope that you have set the gateway of the laptop as 128.171.103.1.

regards,
Jothis


On 10/5/06, Chris U <chris.uyehara@gmail.com> wrote:
>
> Hi List,
>
> I have setup a bridge labeled br0. br0 has an ip address assigned to it.
> My network looks something similar to this...
>
> |--------------------|         |--------------------|
> |------------------|
> |      laptop        |         |      bridge        |               |
> router       | | 128.171.103.10/24  |->(eth1) | 128.171.103.11/24
> |(eth0)  ---->  | 128.171.103.1/24 | | statically assignd |         |
> statically assignd |               | tested / working |
> |--------------------|         |--------------------|
> |------------------|
>
> Now for the PROBLEM! The bridge can access IP's outside of the subnet via
> eth0 of the bridge, ie - pinging 128.171.1.1, 128.171.3.13, 64.233.167.99.
> The laptop cannot ping the previously listed IPs. The only thing the laptop
> can ping is 128.171.103.11. It's very odd... I tried running tcpdump on
> the bridge. From the bridge I could see the laptop pinging the bridge but I
> couldn't see the laptop pinging any other IPs. So basically I have a bridge
> that's not really working but the bridge utils show that its working... any
> help would be greatly appreciated!
>
> (The laptop works when taken off the bridge and connected to the router,
> the iptables default policy is ACCEPT and the rules are FLUSHED.)
>
> Thanks for taking time to read this!
>
> ###brctl show br0
> bridge name     bridge id               STP enabled     interfaces
> br0             8000.001372fc8436       no              eth0
>                                                         eth1
>
> ###brctl showstp br0
> br0
>  bridge id              8000.001372fc8436
>  designated root        8000.001372fc8436
>  root port                 0                    path cost
> 0
>  max age                  19.99                 bridge max age
> 19.99
>  hello time                1.99                 bridge hello time
> 1.99
>  forward delay            14.99                 bridge forward delay
> 14.99
>  ageing time             299.95
>  hello timer               0.03                 tcn timer
> 0.00
>  topology change timer     0.00                 gc timer
> 7.97
>  flags
>
>
> eth0 (1)
>  port id                8001                    state
> forwarding
>  designated root        8000.001372fc8436       path cost
> 100
>  designated bridge      8000.001372fc8436       message age timer
> 0.00
>  designated port        8001                    forward delay timer
> 0.00
>  designated cost           0                    hold timer
> 0.00
>  flags
>
> eth1 (2)
>  port id                8002                    state
> forwarding
>  designated root        8000.001372fc8436       path cost
> 100
>  designated bridge      8000.001372fc8436       message age timer
> 0.00
>  designated port        8002                    forward delay timer
> 0.00
>  designated cost           0                    hold timer
> 0.00
>  flags
>
>
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge
>
>
>

------=_Part_137916_31712951.1160024291571
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Chris,</div>
<div>&nbsp;</div>
<div>Just wanted to ensure some basic points here.</div>
<div>&nbsp;</div>
<div>1. Can the laptop ping the router OR any other machine in the subnet <a href="http://128.171.103.0/24">128.171.103.0/24</a>?</div>
<div>2. Also, hope that you have set the gateway of the laptop as <a href="http://128.171.103.1">128.171.103.1</a>.</div>
<div>&nbsp;</div>
<div>regards,</div>
<div>Jothis<br><br>&nbsp;</div>
<div><span class="gmail_quote">On 10/5/06, <b class="gmail_sendername">Chris U</b> &lt;<a href="mailto:chris.uyehara@gmail.com">chris.uyehara@gmail.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" DEFANGED_style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><span DEFANGED_style="FONT-FAMILY: courier new,monospace">Hi List,<br><br>I have setup a bridge labeled br0. br0 has an ip address assigned to it. My network looks something similar to this...
<br><br>|--------------------|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span DEFANGED_style="FONT-FAMILY: courier new,monospace">|--------------------|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |------------------|</span><br><span DEFANGED_style="FONT-FAMILY: courier new,monospace">|&nbsp; &nbsp;&nbsp;&nbsp; laptop&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bridge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp; router&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | | 
<a DEFANGED_onclick="return top.js.OpenExtLink(window,event,this)" href="http://128.171.103.10/24" target="_blank">128.171.103.10/24</a>&nbsp; |-&gt;(eth1) | <a DEFANGED_onclick="return top.js.OpenExtLink(window,event,this)" href="http://128.171.103.11/24" target="_blank">
128.171.103.11/24</a>&nbsp; |(eth0)&nbsp; ----&gt;&nbsp; | <a DEFANGED_onclick="return top.js.OpenExtLink(window,event,this)" href="http://128.171.103.1/24" target="_blank">128.171.103.1/24</a> | | statically assignd |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | statically assignd |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | tested / working |
<br>|</span><span DEFANGED_style="FONT-FAMILY: courier new,monospace">--------------------|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |--------------------|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |------------------| <br><br>Now for the PROBLEM! The bridge can access IP's outside of the subnet via eth0 of the bridge, ie - pinging 
<a DEFANGED_onclick="return top.js.OpenExtLink(window,event,this)" href="http://128.171.1.1/" target="_blank">128.171.1.1</a>, <a DEFANGED_onclick="return top.js.OpenExtLink(window,event,this)" href="http://128.171.3.13/" target="_blank">128.171.3.13
</a>, <a DEFANGED_onclick="return top.js.OpenExtLink(window,event,this)" href="http://64.233.167.99/" target="_blank">64.233.167.99</a>. The laptop cannot ping the previously listed IPs. The only thing the laptop can ping is <a DEFANGED_onclick="return top.js.OpenExtLink(window,event,this)" href="http://128.171.103.11/" target="_blank">
128.171.103.11</a>. It's very odd... I tried running tcpdump on the bridge. From the bridge I could see the laptop pinging the bridge but I couldn't see the laptop pinging any other IPs. So basically I have a bridge that's not really working but the bridge utils show that its working... any help would be greatly appreciated! 
<br><br>(The laptop works when taken off the bridge and connected to the router, the iptables default policy is ACCEPT and the rules are FLUSHED.)<br><br>Thanks for taking time to read this!<br></span><span DEFANGED_style="FONT-FAMILY: courier new,monospace">
<br>###brctl show br0<br>bridge name&nbsp;&nbsp;&nbsp;&nbsp; bridge id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; STP enabled&nbsp;&nbsp;&nbsp;&nbsp; interfaces<br>br0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.001372fc8436&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; no&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;eth0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;eth1<br>
<br>###brctl showstp br0<br>br0<br>&nbsp;bridge id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.001372fc8436<br>&nbsp;designated root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.001372fc8436<br>&nbsp;root port&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; path cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>&nbsp;max age&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
19.99&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bridge max age&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19.99<br>&nbsp;hello time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.99&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bridge hello time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.99<br>&nbsp;forward delay&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14.99&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bridge forward delay&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14.99<br>
&nbsp;ageing time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 299.95<br>&nbsp;hello timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.03&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tcn timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.00<br>&nbsp;topology change timer&nbsp;&nbsp;&nbsp;&nbsp; 0.00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7.97<br>&nbsp;flags<br><br><br>eth0 (1) 
<br>&nbsp;port id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8001&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; forwarding<br>&nbsp;designated root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.001372fc8436&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; path cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 100<br>&nbsp;designated bridge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.001372fc8436&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; message age timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
0.00<br>&nbsp;designated port&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8001&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; forward delay timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.00<br>&nbsp;designated cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hold timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.00<br>&nbsp;flags<br><br>eth1 (2)<br>&nbsp;port id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8002&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; forwarding 
<br>&nbsp;designated root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.001372fc8436&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; path cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 100<br>&nbsp;designated bridge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000.001372fc8436&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; message age timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.00<br>&nbsp;designated port&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8002&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; forward delay timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
0.00<br>&nbsp;designated cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hold timer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.00<br>&nbsp;flags<br><br><br DEFANGED_style="FONT-FAMILY: courier new,monospace"></span><br>_______________________________________________<br>Bridge mailing list
<br><a DEFANGED_onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Bridge@lists.osdl.org">Bridge@lists.osdl.org</a><br><a DEFANGED_onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.osdl.org/mailman/listinfo/bridge" target="_blank">
https://lists.osdl.org/mailman/listinfo/bridge</a><br><br><br></blockquote></div><br>

------=_Part_137916_31712951.1160024291571--
