From: Sebastian Niehaus <niehaus@nospam.arcornews.de>
Date: Sat, 23 Jan 2010 11:38:45 +0100
Message-ID: <87r5phumve.fsf@crystalline.worst-case.no-ip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
Subject: [Bridge] Linux Ethernet bridge and UPNP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

Hi, 

I have a linux box (Debian Lenny) with a bridged ethernet
interface. The box is running mediatomb[1], an UPNP media server.


If I run gupnp-universal-cp (a tool to discover UPNP-Devices in the
network) on this computer I only see the mediatomb server on the same
maschine but no other UPNP-Devices.


If I run gupnp-universal-cp on another computer in the network
(without ethernet bridge) I see other UPNP-Devices in the network but
not the media server.


All boxes are in the same subnet and networking gererally works
fine. The media server's web interface can be reached from any
computer in the network but UPNP discovery does not work.


Are there know issues with ethernet bridging and
UPNP/(multicast?)-traffic? Is there hint how I might resolve my
problem that mediatomb is not "UPNP-visible" in the network?



Thanks in advance,

Sebastian 



[1] http://mediatomb.cc/

[2] http://www.gupnp.org/

