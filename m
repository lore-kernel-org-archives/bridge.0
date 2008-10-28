Message-ID: <490762EE.9000605@kth.se>
Date: Tue, 28 Oct 2008 20:07:26 +0100
From: Mattias Kjellsson <mkje@kth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Bridge with a tweak...
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

Hi list,

I have a question regarding bridges in general, and my bridge in 
particular. I want to take all the packages flowing one way over the 
bridge (say eth0->eth1) and pack them in my own packet- structure (extra 
headers added, and the content modulated for further wireless 
transportation), and all the packages flowing in the other direction 
(say eth1->eth0) needs to be "de- packed" (stripped of my custom 
headers, and demodulated).

What I'm basically doing is trying to make my software radio (connected 
to one of the network- devices) work as a wireless network adapter, but 
with my own signaling- scheme, but I don't want to use the same computer 
for the radio, as for "browsing the web", since the radio- part is a bit 
on the heavy side to the processor.

Is there an easy way to do this? Where would you start? I have been 
looking at the code for the kernel- module, but haven't really got any 
really useful clues from it.

Any pointers towards where to start looking, poking and dragging would 
be greatly appreciated.

BR
Mattias Kjellsson
