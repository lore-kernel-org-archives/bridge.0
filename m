Message-ID: <574385790811111227p6437caefyec268fda34631e7@mail.gmail.com>
Date: Tue, 11 Nov 2008 12:27:10 -0800
From: "Alex Malinovich" <alexmalinovich@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Bridge] Terrible performance between two bridges
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

I recently set up a couple of bridges to use with Xen virtualized
machines and we're experiencing some terrible performance in certain
cases.

We have two host machines (host1 and host2) and multiple guests on
each. Each host has two bridges. An "eth0" bridge tied to the physical
eth0 (peth0) and providing access to the outside world for all guests.
The second bridge is called "xenint" and is tied to the physical eth2.

peth0 is connected to a 100 Mb switch which goes to the outside world.
eth2 is connected to a gigabit switch which is a private network
connecting the two hosts together. Now, for the strangeness.

Communicating between host1 and host2 directly works just fine. I can
get ~ 50 MB/sec consistently over that connection. I can also get ~ 50
MB/sec when communicating between a guest on host1 (using a virtual
interface tied to xenint) and host2. However, if I try communicating
between a guest on host1 and a guest on host2, I get ~ 120 KB/sec.
I've tried both enabling and disabling STP on both of the bridges to
no avail. (Though I have to admit that I only have a basic
understanding of STP, so turning it on and off was not at all an
"educated" decision.)

To further complicate matters, if I use two guests and have them
communicate over their primary interfaces, tied to the eth0 bridge, I
get ~ 13 MB/sec as expected. But these are publicly accessible IP's
which is what I'm trying to avoid.

Really not sure where to go from here. This has been driving me nuts
for days and I haven't been able to get any further insight into the
problem. Thanks in advance for any help.
