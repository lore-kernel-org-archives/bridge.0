From: Richard Gavenda <rgavenda@et.trz.cz>
Date: Mon, 9 Aug 2004 08:56:34 +0000 (UTC)
Message-ID: <loom.20040809T103648-672@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: news <news@sea.gmane.org>
Subject: [Bridge] Bridging between multiple VLANs
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hi,
I'm nearly amateur in Linux bridging. I have a bridge based on old Red Hat
distro. On this bridge i was able to build bridge from logical devices (eth0.2,
eth0.7, eth0.8, eth0.9) created using vconfig. Than I test, if packet comes
through eth0.2 device, from specified MAC source with defined MAC destination,
and such packet i let leave bridge through device eth0.7. All goes well, until i
try to make new bridge, based on Fedora Core 2 distro. There's a new version of
bridge, which makes building such bridge no longer possible.
And here comes a question: is there a way how to build a bridge with same
functionality as the old bridge has?

Thanks
Richard Gavenda

