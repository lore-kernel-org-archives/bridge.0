Message-ID: <a9a0929d0511301808t69b4605ci@mail.gmail.com>
Date: Thu, 1 Dec 2005 12:38:07 +1030
From: Mark Zipp <mark.r.zipp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Bridge ports needlessly going through learning stage when
	STP disabled ?
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hi,

I've recently noticed that on my ubunto box, running 2.6.10-5-386,
that even when I have STP disabled on a bridge (which I think is the
default), when you add a new interface to the bridge, it still goes
through at least some of the port states, as well as listing messages
in the brctl STP state display such as "flags                 
TOPOLOGY_CHANGE TOPOLOGY_CHANGE_DETECTED".

Is this the right behaviour ? The 15 to 30 second delay before the
port moves to Forwarding state can be frustrating, as you don't expect
it, and for that period of time, start to think there is something
else wrong in the network's configuration.

Thanks,
Mark.

P.S., please CC me on any replies as I'm not subscribed to the list.

