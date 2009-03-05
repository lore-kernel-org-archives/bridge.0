From: Dirk Gouders <gouders@et.bocholt.fh-gelsenkirchen.de>
Date: Thu, 05 Mar 2009 15:20:33 +0100
Message-ID: <giab80caq6.fsf@karga.hank.lab>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bridge] IP address on bridged interface
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello,

I am currently playing with bridging to learn about various
possibilities to setup a bridge to enable networking for KVM guests.

I learned that I cannot use an IP address on one of the bridged
interfaces but have to assign that IP address to the bridge interface if
I want to use it to reach the bridge itself.

The documentation I found does not say much about this subject and I am
wondering whether there are situations when I can use IP addresses on
bridged interfaces or if it absolutely makes no sense to have an IP
address assigned to a bridged interface.

Any explanation or pointers are very welcome.

Dirk
