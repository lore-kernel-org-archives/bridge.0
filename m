From: Nuutti Kotivuori <naked@iki.fi>
Date: Mon, 29 Nov 2004 16:01:57 +0200
Message-ID: <87d5xw4uui.fsf@aka.i.naked.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
Subject: [Bridge] bridge in 'hub' mode possible?
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Is it somehow possible to configure a bridge in 'hub' mode. So that
every packet sent from a 'port' (eg. an interface) is delivered to
every other 'port' on the bridge.

That is, effectively to just turn off MAC address learning and treat
all packets on the bridge level effectively as broadcasts.

Or could this be done with some ebtables hack?

Suggestions appreciated,
-- Naked


