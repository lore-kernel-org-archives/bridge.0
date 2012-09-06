Return-Path: <saurabh.agarwal@envisagemedia.in>
MIME-Version: 1.0
Sender: saurabh.agarwal@envisagemedia.in
In-Reply-To: <CAALjeQU+sjiZ5qUntoJv2WoxJ__58HefRQzAUXKcenOc14winw@mail.gmail.com>
References: <CAALjeQU+sjiZ5qUntoJv2WoxJ__58HefRQzAUXKcenOc14winw@mail.gmail.com>
From: Saurabh Agarwal <saurabh@becabo.com>
Date: Thu, 6 Sep 2012 15:38:32 +0530
Message-ID: <CAALjeQWhCOJBZ=vF85-isrnFjZqiSGOeGjVHB+2+=gQujFGOaQ@mail.gmail.com>
Content-Type: multipart/alternative; boundary=e0cb4e6ff0f5af65e404c905ad88
Subject: [Bridge] Bridge dropping fragmented ipsec frames.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--e0cb4e6ff0f5af65e404c905ad88
Content-Type: text/plain; charset=ISO-8859-1

Hi Team,

Scenerio:
I am using a squid proxy in inception(ebtables/Iptables rules are used) mode
for my small network.

Problem:
Whenever some tries to connect to cisco VPN over bridge the authentication
process goes through smoothly, but after that the status bar reads "Negotiation
security polices......." and after like 30 sec. the VPN disconnects.

When I bypass the bridging box the connection goes through smoothly without any
issues. I have checked that no IPTABLES OR EBTABLES rules are applied.

I tried changing the MTUs but no go. I am not sure what is this issue
regarding.

further to MTU changes I took a TCPdump of both my bridge interface. I noticed
that the ipsec ip fragmented packets are coming on the WAN port are getting
dropped. Similar to this
posthttp://lkml.indiana.edu/hypermail/linux/kernel/0604.0/0229.html

I also checked that the patch which is given here is also applied in my current
kernel version(2.6.38.12). I also updated the IGB drivers.

If any of you guys can suggest me something I would be highly obliged. I am up
for some coding changes that are required.

If any of you guys need any kind of logs or something to debug further kindly
let me know.

Looking forward to your reply.

Warm Regards
Saurabh

--e0cb4e6ff0f5af65e404c905ad88
Content-Type: text/html; charset=ISO-8859-1

<div class="gmail_quote"><br><pre style="width:50em;white-space:pre-wrap">Hi Team,

Scenerio:
I am using a squid proxy in inception(ebtables/Iptables rules are used) mode
for my small network.

Problem:
Whenever some tries to connect to cisco VPN over bridge the authentication
process goes through smoothly, but after that the status bar reads &quot;Negotiation
security polices.......&quot; and after like 30 sec. the VPN disconnects. 

When I bypass the bridging box the connection goes through smoothly without any
issues. I have checked that no IPTABLES OR EBTABLES rules are applied. 

I tried changing the MTUs but no go. I am not sure what is this issue
regarding.

further to MTU changes I took a TCPdump of both my bridge interface. I noticed
that the ipsec ip fragmented packets are coming on the WAN port are getting
dropped. Similar to this post
<a href="http://lkml.indiana.edu/hypermail/linux/kernel/0604.0/0229.html" style="color:rgb(102,51,102)" target="_blank">http://lkml.indiana.edu/hypermail/linux/kernel/0604.0/0229.html</a>

I also checked that the patch which is given here is also applied in my current
kernel version(2.6.38.12). I also updated the IGB drivers.  

If any of you guys can suggest me something I would be highly obliged. I am up
for some coding changes that are required. 

If any of you guys need any kind of logs or something to debug further kindly
let me know.

Looking forward to your reply. 

Warm Regards
Saurabh</pre>
</div><br>

--e0cb4e6ff0f5af65e404c905ad88--
