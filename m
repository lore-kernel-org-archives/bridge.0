Date: Sun, 8 Mar 2009 09:40:29 -0700
From: Ray Van Dolson <rayvd@bludgeon.org>
Message-ID: <20090308164029.GA10137@bludgeon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] Bridging via vtun...
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi all;

I'm trying to set up a bridge between two networks using vtun on Linux.
It's almost working, but I'm running into an issue...

  - Client A lives on Network A 10.27/16
  - Server B lives on Network B 10.49/16
  - Server B has vtun running in server mode
  - Client A connects to Server B via vtun and a TAP interface is set
    up on both of them.
  - Server B adds this TAP interface to interface br0 which also
    contains eth0 on Network B:

      Server B (10.49/16)
        - br0 (10.49.x.x)
            eth0
            tap0

      Client A (10.27/16)
        - eth0 (10.27.x.x)
            route add -host <Server B> gw <10.27.gateway>
        - tap0

I have ip_forward enabled on both hosts.

Now, if I add a 10.49/16 IP to Client A's tap0 and start tcpdump'ing on
tap0 I can see lots of ARP traffic and broadcast traffic from 10.49/16.

If I run an arping:

  arping -I tap0 <Server B IP>

I get a response and a tcpdump on Server B's br0 interface shows the
traffic going back and forth.

However, when I try to reach anything else on the 10.49/16 network from
Client A, I fail.  So, for example:

  - Client A pings 10.49.6.46
    - I observe ARP who-has requests going out over tap0
  - On Server B I observe ARP who-has requests passing through br0
  - On 10.49.6.46 I observe ARP who-has requests coming in and ARP
    responses going back to what appears to be the correct MAC address.
  - On Server B I do not see any of these ARP responses
  - On Client A I do not see any of these ARP responses

I can't figure out why this is.  I don't have ebtables or anything
running.... I've tried messing around with proxy ARP thinking maybe
Client A's tap0 MAC wasn't getting sent out correctly... 

Some notes of interest:

  - Server A is a VMware Guest
  - We have catalyst switches backing everything

I'm wondering if Client A's tap0 MAC address is not getting advertised
somehow into the Catalyst Switch on 10.49/16's MAC table?

Anyone have any suggestions as to what I should try next?  I guess
worst case I'll try and simplify the setup and remove vtun from the
equation, but maybe someone here has some advice. :-)

Thanks,
Ray
