Message-ID: <40A72B0E.20104@gmx.net>
Date: Sun, 16 May 2004 10:49:18 +0200
From: Eicke Friedrich <tady@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] bridge latency
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi list,

we did an investigation of a firewalling Linux bridge in terms of 
latency and throughput using DAG 3.5E interfaces for precise 
timestamping of ip packets [1]. The overall results are very good but 
one fact we can't explain. The following URL points to an image of 
such an measuring where we push 60MBits/s TCP traffic through the 
bridge in one direction:
http://kea.informatik.uni-leipzig.de/ipp2p/delay/color_60e_plain_out.png

If you look at the image you'll see the max line showing regular (one 
per minute) spikes. I've absolutly no idea where these spikes may come 
from. So I want to ask you, if you could imagine a reason for these 
spikes? These are only few packets but for us it's important to find 
out why they get sometimes delayed this much longer.

Some background about the bridging box:
Hardware:
Pentium4 1.7GHz, 1.024MB RAM, 2 x 3Com 3c905 [Boomerang] being br0, 
3Com 3c905B as management interface.

Software:
vanilla Linux Kernel 2.6.3 with patched in CONNMARK extension, STP was 
disabled

Other:
The bridge was running in plain mode wich means no other modules like 
iptables, ebtables or packet scheduler were loaded. It was running in 
runlevel 3, multiuser networking without x-system.

For comparison only this link shows what happens if we push as much 
TCP traffic in one direction (~97.5 MBits/s) through the bridge having 
iptables loaded:
http://kea.informatik.uni-leipzig.de/ipp2p/delay/color_max_ipp2p_120c_delay-0.png

Thanks in advance for any comments or suggestions!

Cheers,
Eicke



[1] Endace Measurement Systems: http://www.endace.com/
