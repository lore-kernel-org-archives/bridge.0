Message-ID: <49E0BD2D.9030908@pacbell.net>
Date: Sat, 11 Apr 2009 08:54:21 -0700
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

Hi All,
I think the little diagram of the circuit became a mess when 
transmitted. How about this attempt? This is the hub of a hub and spoke 
topology and there is normally only one transmit and multiple receivers

Here is what one end of the link looks like.

                   +-------------+

        + eth0 +---+   bridge 1  +---+ wan0 ---> Transmit

        |          +-------------+ 
        |                          
switch--+                          
        |          +-------------+ 
        + eth0 +---+   bridge 2  +---+ wan0 <--- Receive

                   +-------------+


Mike Boutte
