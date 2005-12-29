Message-ID: <43B3B038.4000205@algoritmx.net>
Date: Thu, 29 Dec 2005 12:45:28 +0300
From: =?KOI8-R?Q?=EC=CF=C2=C1=CE=CF=D7_=F7=C1=CC=C5=D2=C9=CA?=
	<valery@algoritmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] daemons are dropped
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Linux Bridge - Discuss <bridge@lists.osdl.org>

I've wrote a small program (snmp agent), that starts at bootup in daemon 
mode (i use a 'daemon' function from unistd.h to run it in the 
background). Everything is ok, if i don't use bridge.

After i made a bridge, my daemon is dropped when bridge starts. My 
daemon starts, but i can't see it in 'ps' output.

I think this happens during this:

>device eth1 entered promiscuous mode
>
>device eth0 entered promiscuous mode
>
>br0: port 2(eth0) entering listening state
>
>br0: port 1(eth1) entering listening state
>
>br0: port 2(eth0) entering learning state
>
>br0: port 1(eth1) entering learning state
>
>br0: port 2(eth0) entering forwarding state
>
>br0: topology change detected, propagating
>
>br0: port 1(eth1) entering forwarding state
>
>br0: topology change detected, propagating
>  
>
Some other programs (not my) are dropped too, but some don't.

Any ideas?

Valery
