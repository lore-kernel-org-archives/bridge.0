Message-ID: <2327.91.89.6.59.1209015008.squirrel@postamt.eit.uni-kl.de>
Date: Thu, 24 Apr 2008 07:30:08 +0200 (CEST)
From: "Faruk Keskin" <faruk@eit.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Access the bridge through the userspace (Rx/Tx)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello everybody,

I'm trying to implement Layer 2 packet processing, where I need  to
transfer packets arriving at the Linux Bridge to a dedicated userspace
application. So my very basic question would be whether you could
recommend a strategy to achieve this.

Can I use TUN/TAP or do I need to implement specific code around a socket?

Thanks in advance,
Faruk



