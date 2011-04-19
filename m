Message-ID: <4DAD2FD5.9090205@ericsson.com>
Date: Tue, 19 Apr 2011 08:46:45 +0200
From: Zoltan Bibo <Zoltan.Bibo@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] no packets seen on bridge after upgrading intel driver
 ixgbe from 2.1.4 to 3.2.1
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

Hi

I'am using SUSe linux kernel version 2.6.33.2. Using in-built 
bridge-utils version 1.2.
I'm having a bridge of 4x10Gb ports (using 2x2port  Intel X520-2 dual 
server adapter) and 4x1Gb UTP ports on a 1Gb quad Port IntelPro1000.
Till now I had ixgbe driver version 2.1.4 working fine with the bridge, 
but  for othe reasons recently
I upgraded to ixgbe version 3.2.1. Suddenly I can see no packets from the
10Gb cards, however ethtool's statistics report them as up and running, 
no packet loss
or other error is encountered.
Dou you have any idea, what the problem is?

Thank you
Zoltan
