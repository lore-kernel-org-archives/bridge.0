Message-ID: <44C0B74B.7050204@atmark-techno.com>
Date: Fri, 21 Jul 2006 20:15:23 +0900
From: Chris McHarg <chris@atmark-techno.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] port priority bits
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hello.

I'm fairly (very) new to the kernel and networking in general, but I 
thought I'd give the following a shot here...

I was reading thought the STP chapter in Understanding Linux Network 
Internals and testing out the bridging configuration with brctl, and was 
surprised to find that setportprio would only have any effect for values 
0 to 63 (on 2.6.12.3 and using bridge-utils 0.9.6). It seems the port 
priority has been handled as 6 bits since this:

http://lists.osdl.org/mailman/htdig/bridge/2004-April/000274.html

On page 322 of the book, it describes it as originally 8 bits, then 
changed to 4bits with 802.1t (in 2001).

I'm not sure if there has there been any movement/talk on working on 
conformance with 802.1t, but I wonder if it would be good to go with one 
of the two standards. In 802.1t, it seems that the bridge priority was 
changed from 16 bits to 4 bits, with changes for port cost as well.

Chris

