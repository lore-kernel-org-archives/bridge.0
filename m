Message-ID: <F163413C9250D211A55C0060979D52807D3F8C@HERTZ>
From: Marc Cozzi <cozzi@nd.edu>
Date: Thu, 25 Aug 2005 17:26:59 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Bridge] bridge running slow
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "'bridge@lists.osdl.org'" <bridge@lists.osdl.org>

Dell something-er-another ~667MHz 256MB with two
3com 3C905 something-er-another NICs.
Fedora Core 3 with the latest user interface bridge-utils.
This test bridge is plugged into a mirrored switch port
that is seeing traffic around 500Kb/sec as seen with
Ethercap. The output of the bridge is plugged into
another switch with it's port mirrored. When I use
Ethercap on that mirrored port, I only see around 240Kb/sec.
Seems as though the bridge is dropping packets/frames?

Anyone else see this or have any ideas?

Thanks,

  --marc
