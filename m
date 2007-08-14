Message-ID: <46C1AF5A.5000602@mpexnet.de>
Date: Tue, 14 Aug 2007 15:34:18 +0200
From: Lars Braeuer <lb@mpexnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Reset of setpathcost after link comes back up
Reply-To: lb@mpexnet.de
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bridge@lists.linux-foundation.org

In a redundant setup (2 bridges), I usally set the path cost of external ports
to 1 und internal ports to 100. So that the external port of the backup bridge
is in forwarding and the internal port in blocking state.

But, when the physical link goes down and comes back up (i.e. link failure or
cable unplug and replug) the path cost of the links automatically reset to
values like 4 and 19.

Is this a desired behaviour, shouldn't the path cost remain at the values specified?


I'm using bridge support in Kernel 2.6.19. As I can't test a new Kernel yet, I'm
just asking if this might be a bug and maybe someone knows if this has been
fixed lately?

Thanks in advance.

Best,

Lars
