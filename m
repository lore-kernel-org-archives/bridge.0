From: "Adam Hewgill" <ahewgill@hotmail.com>
Date: Wed, 30 Jun 2004 11:30:30 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY19-F11htXQxNnGvI000dbb71@hotmail.com>
Subject: [Bridge] Bringing up bridge at boot (properly)
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org


Currently my ethernet bridge has 2 intel 100mps NIC's that are
both part of a bridge. ( I followed the sample setup on the bridge.sf.net
page.)

In addition to this I would like to access the internet from within the
ethernet bridge and when using the sample instructions I have no
gateway setup and no default route (0.0.0.0).  I know this data has
to be attached to the bridge device and not to an ethX card but I
don't know how to do this.

Also I would like the bridge to come up and the ethX cards to be
added and the bridge configured at boot.  I don't like the idea
of using a rc.local script and would like to use /etc/sysconfig/network
if this is possible.   Is there a setup doc that describes this somewhere?

Thanks for the help

Adam :o)


