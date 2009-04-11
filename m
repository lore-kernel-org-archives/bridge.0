Message-ID: <49E03128.7080902@pacbell.net>
Date: Fri, 10 Apr 2009 22:56:56 -0700
From: Michael Boutte <maboutte@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Building a Raw Bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

I'm having trouble figuring out how to make a bridge that does not block 
forwarding of packets when there is no receive channel in the same 
bridge. The reason I want to do this is that the return path is via 
another circuit. The two directions are on two different radios. I would 
think this would be like the response given to someone in July 2007 
about setting a "hub" mode by setting the aging timer to 0. I tried that 
and it did not work.

I also tried a few schemes with ebtables without success either. Is 
there some relatively easy way to make the bridge forward everything and 
not cut off the transmit after a single packet?

/ Here is what one end of the link looks like.
//
//                   +-------------+
// ///      /// + eth0 +---+   bridge 1  +---+ wan0 ---> Transmit
//        |          +-------------+ 
//        |                          
//switch--+                          
//        |          +-------------+ 
//        + eth0 +---+   bridge 2  +---+ wan0 <--- Receive
//                   +-------------+
/
The WAN side uses a synchronous serial interface to the radios for 
satellite communications. The other end uses a single radio and bridge.

Mike Boutte

