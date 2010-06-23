Message-ID: <4C223084.4080101@ll.mit.edu>
Date: Wed, 23 Jun 2010 12:04:20 -0400
From: Jeff Mitchell <jmitchell@ll.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Discrepancy in setageing
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

The documentation for Bridge at 
http://www.linuxfoundation.org/collaborate/workgroups/networking/bridge 
says the following of setageing:

====

The aging time is the number of seconds a MAC address will be
kept in the forwarding database after having received a packet
from this MAC address.
The entries in the forwarding database are periodically timed out
to ensure they won't stay around forever.
Normally there should be no need to modify this parameter,
but it can be changed with (time is in seconds).

   # brctl setageing bridgename time

Setting ageing time to zero makes all entries permanent.

====

However, according to my testing, this parameter actually turns MAC 
learning off; setting it to zero simply means that entries are never 
added to the table.

Searching around the web reveals people with similar experiences.

Is the documentation incorrect, or am I missing something?

Thanks,
Jeff
